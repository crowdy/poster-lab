param(
    [Parameter(Mandatory = $true)]
    [string]$AssetJson,                 # Path to the asset JSON file from extract-psd

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,                # Output path for the composed PSD file (optional)

    [Parameter(Mandatory = $false)]
    [int]$BatchSize = 10,                # Number of layers to process before garbage collection

    [switch]$Silent,                    # Silent mode - only output result JSON file path
    
    [switch]$LowMemoryMode              # Enable aggressive memory optimization
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ===== Aspose.PSD 로더 =====
function Load-AsposePSD {
    $packageDir = "$PSScriptRoot/aspose-packages"
    if (-not (Test-Path $packageDir)) { New-Item -ItemType Directory -Path $packageDir -Force | Out-Null }

    $asposeDrawingDll = "$packageDir/Aspose.Drawing.dll"
    $asposePsdDll     = "$packageDir/Aspose.PSD.dll"

    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages for .NET 8.0..."
        $tempDir = "$PSScriptRoot/temp-packages"
        if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
        try {
            Set-Location $PSScriptRoot
            dotnet new console -n TempProject -o $tempDir --force | Out-Null
            Set-Location $tempDir
            dotnet add package Aspose.PSD --version 24.12.0 | Out-Null
            dotnet add package Aspose.Drawing --version 24.12.0 | Out-Null
            dotnet restore | Out-Null

            $packagesPath = "$env:USERPROFILE\.nuget\packages"
            (Get-ChildItem "$packagesPath/aspose.psd/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1).FullName | ForEach-Object { Copy-Item $_ "$packageDir/Aspose.PSD.dll" -Force }
            (Get-ChildItem "$packagesPath/aspose.drawing/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1).FullName | ForEach-Object { Copy-Item $_ "$packageDir/Aspose.Drawing.dll" -Force }

            foreach ($dep in @(
                "newtonsoft.json/*/lib/net6.0/*.dll",
                "system.drawing.common/*/lib/net8.0/*.dll",
                "system.text.encoding.codepages/*/lib/net8.0/*.dll"
            )) {
                $p = Get-ChildItem "$packagesPath/$dep" -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($p) { Copy-Item $p.FullName $packageDir -Force }
            }
        } catch {
            Write-Error "Failed to download packages: $_"
            Set-Location $PSScriptRoot
            return $false
        } finally {
            Set-Location $PSScriptRoot
            if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue }
        }
    }

    try {
        # CodePages 인코딩 등록 (텍스트/효과 렌더링 안정화)
        Add-Type -AssemblyName "System.Text.Encoding.CodePages" -ErrorAction SilentlyContinue
        [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)

        foreach ($dep in @("System.Text.Encoding.CodePages.dll","Newtonsoft.Json.dll","System.Drawing.Common.dll")) {
            $p = Join-Path $packageDir $dep
            if (Test-Path $p) { Add-Type -Path $p -ErrorAction SilentlyContinue }
        }
        Add-Type -Path $asposeDrawingDll
        Add-Type -Path $asposePsdDll
        return $true
    } catch {
        Write-Error "Error loading Aspose.PSD: $_"
        return $false
    }
}

# ===== Helper Functions =====
function Get-FileSize {
    param([string]$FilePath)
    
    if (Test-Path $FilePath) {
        $fileInfo = Get-Item $FilePath
        return $fileInfo.Length
    }
    return 0
}

function Format-FileSize {
    param([long]$Size)
    
    if ($Size -ge 1GB) {
        return "{0:N2} GB" -f ($Size / 1GB)
    } elseif ($Size -ge 1MB) {
        return "{0:N2} MB" -f ($Size / 1MB)
    } elseif ($Size -ge 1KB) {
        return "{0:N2} KB" -f ($Size / 1KB)
    } else {
        return "{0:N0} bytes" -f $Size
    }
}

function Clear-Memory {
    param([switch]$Force)
    
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    if ($Force) {
        [System.GC]::Collect(2, [System.GCCollectionMode]::Forced, $true, $true)
    }
}

function Create-LayerFromPNG-Stream {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds,
        [switch]$DebugMode
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            if ($DebugMode) { Write-Warning "PNG file not found: $PngFilePath" }
            return $null
        }
        
        if ($DebugMode) { Write-Host "  Loading PNG using Stream method: $PngFilePath" }
        
        $stream = $null
        $layer = $null
        
        try {
            # PNG 파일을 Stream으로 열기
            $stream = [System.IO.File]::OpenRead($PngFilePath)
            
            # Stream으로 Layer 생성 (공식 문서 방식)
            $layer = [Aspose.PSD.FileFormats.Psd.Layers.Layer]::new($stream)
            $layer.Name = $LayerName
            $layer.DisplayName = $LayerName
            
            # 레이어 위치 설정
            if ($Bounds) {
                $layer.Left = $Bounds.Left
                $layer.Top = $Bounds.Top
                $layer.Right = $Bounds.Right
                $layer.Bottom = $Bounds.Bottom
                
                if ($DebugMode) { 
                    Write-Host "    Layer position set: ($($Bounds.Left),$($Bounds.Top)) size: $($Bounds.Right - $Bounds.Left)x$($Bounds.Bottom - $Bounds.Top)"
                }
            }
            
            if ($DebugMode) { Write-Host "    ✓ Layer created successfully from stream" }
            
            return $layer
            
        } finally {
            if ($stream) {
                $stream.Close()
                $stream.Dispose()
            }
        }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to create layer from PNG stream: $($_.Exception.Message)" }
        return $null
    }
}

function Create-PSDFromPNG-Conversion {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds,
        [switch]$DebugMode
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            if ($DebugMode) { Write-Warning "PNG file not found: $PngFilePath" }
            return $null
        }
        
        if ($DebugMode) { Write-Host "  Converting PNG to PSD layer: $PngFilePath" }
        
        $pngImage = $null
        $tempPsdPath = [System.IO.Path]::GetTempFileName() + ".psd"
        
        try {
            # PNG 이미지 로드
            $pngImage = [Aspose.PSD.Image]::Load($PngFilePath)
            
            # PsdOptions로 변환 설정
            $psdOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
            $psdOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
            $psdOptions.ChannelBitsCount = 8
            $psdOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
            
            # 임시 PSD로 저장
            $pngImage.Save($tempPsdPath, $psdOptions)
            $pngImage.Dispose()
            $pngImage = $null
            
            # 임시 PSD 로드
            $tempPsd = [Aspose.PSD.FileFormats.Psd.PsdImage]([Aspose.PSD.Image]::Load($tempPsdPath))
            
            $layer = $null
            if ($tempPsd.Layers.Length -gt 0) {
                # 첫 번째 레이어 복사
                $layer = $tempPsd.Layers[0].ShallowCopy()
                $layer.Name = $LayerName
                $layer.DisplayName = $LayerName
                
                # 위치 설정
                if ($Bounds) {
                    $layer.Left = $Bounds.Left
                    $layer.Top = $Bounds.Top
                    $layer.Right = $Bounds.Right
                    $layer.Bottom = $Bounds.Bottom
                }
                
                if ($DebugMode) { Write-Host "    ✓ Layer created via PSD conversion" }
            }
            
            $tempPsd.Dispose()
            return $layer
            
        } finally {
            if ($pngImage) { $pngImage.Dispose() }
            if (Test-Path $tempPsdPath) {
                Remove-Item $tempPsdPath -Force -ErrorAction SilentlyContinue
            }
        }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to convert PNG to PSD layer: $($_.Exception.Message)" }
        return $null
    }
}

# ===== Main =====
$startTime = Get-Date

if (-not $Silent) {
    Write-Host "Starting PSD composition at $startTime"
    Write-Host "Current directory: $(Get-Location)"
    if ($LowMemoryMode) {
        Write-Host "Low Memory Mode: ENABLED"
        Write-Host "Batch Size: $BatchSize layers"
    }
}

# 입력 파일 검증
if (-not (Test-Path $AssetJson)) {
    Write-Error "Asset JSON file not found: $AssetJson"
    exit 1
}

# Aspose.PSD 로드
if (-not (Load-AsposePSD)) {
    Write-Error "Failed to load Aspose.PSD libraries"
    exit 1
}

# 결과 객체 초기화
$result = [ordered]@{
    InputAssetFile = (Resolve-Path -LiteralPath $AssetJson).Path
    OutputFile = ""
    StartTime = $startTime.ToString("o")
    EndTime = $null
    Duration = $null
    TotalAssetsProcessed = 0
    SuccessfulCompositions = 0
    FailedCompositions = 0
    ProcessedAssets = @()
    FailedAssets = @()
    Status = ""
    MemoryMode = if ($LowMemoryMode) { "Low Memory" } else { "Normal" }
}

try {
    # Asset JSON 파일 로드
    if (-not $Silent) {
        Write-Host "Loading asset data from: $AssetJson"
    }
    
    $assetContent = Get-Content -LiteralPath $AssetJson -Raw -Encoding UTF8
    $assetData = $assetContent | ConvertFrom-Json
    
    if (-not $assetData) {
        Write-Error "Failed to parse asset JSON file"
        exit 1
    }
    
    # 추출된 레이어가 있는지 확인
    if (-not $assetData.ExtractedLayers -or $assetData.ExtractedLayers.Count -eq 0) {
        Write-Error "No extracted layers found in asset JSON"
        exit 1
    }
    
    # 출력 파일 경로 결정
    if (-not [string]::IsNullOrEmpty($OutputPath)) {
        $outputFilePath = $OutputPath
    } else {
        $assetJsonDir = Split-Path -Parent $AssetJson
        if ([string]::IsNullOrEmpty($assetJsonDir)) {
            $assetJsonDir = Get-Location
        }
        $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($AssetJson)
        $outputFileName = "{0}_composed_{1}.psd" -f $baseName, $timestamp
        $outputFilePath = Join-Path $assetJsonDir $outputFileName
    }
    
    # 출력 디렉토리 생성
    $outputDir = Split-Path -Parent $outputFilePath
    if (-not [string]::IsNullOrEmpty($outputDir) -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        if (-not $Silent) {
            Write-Host "Created output directory: $outputDir"
        }
    }
    
    $result.OutputFile = [System.IO.Path]::GetFullPath($outputFilePath)
    $result.TotalAssetsProcessed = $assetData.ExtractedLayers.Count
    
    # Canvas 크기 결정
    $canvasWidth = 1920   # 기본값
    $canvasHeight = 1080  # 기본값
    
    # Asset JSON에서 원본 크기 정보 확인
    if ($assetData.PSObject.Properties.Name -contains "CanvasWidth" -and $assetData.CanvasWidth -gt 0) {
        $canvasWidth = $assetData.CanvasWidth
    }
    if ($assetData.PSObject.Properties.Name -contains "CanvasHeight" -and $assetData.CanvasHeight -gt 0) {
        $canvasHeight = $assetData.CanvasHeight
    }
    
    # 레이어들의 최대 바운드로부터 캔버스 크기 추정
    if ($assetData.ExtractedLayers.Count -gt 0) {
        $maxRight = ($assetData.ExtractedLayers | ForEach-Object { $_.Bounds.Right } | Measure-Object -Maximum).Maximum
        $maxBottom = ($assetData.ExtractedLayers | ForEach-Object { $_.Bounds.Bottom } | Measure-Object -Maximum).Maximum
        
        if ($maxRight -gt $canvasWidth) { $canvasWidth = $maxRight }
        if ($maxBottom -gt $canvasHeight) { $canvasHeight = $maxBottom }
    }
    
    # 캔버스 크기 안전 제한 (10000x10000)
    $maxSafeSize = 10000
    if ($canvasWidth -gt $maxSafeSize -or $canvasHeight -gt $maxSafeSize) {
        Write-Warning "Canvas size ($canvasWidth x $canvasHeight) exceeds safe limit ($maxSafeSize x $maxSafeSize)"
        
        $scale = [Math]::Min($maxSafeSize / $canvasWidth, $maxSafeSize / $canvasHeight)
        $canvasWidth = [Math]::Floor($canvasWidth * $scale)
        $canvasHeight = [Math]::Floor($canvasHeight * $scale)
        
        Write-Warning "Canvas resized to: $canvasWidth x $canvasHeight"
        
        # 레이어 위치도 스케일 조정
        foreach ($layer in $assetData.ExtractedLayers) {
            $layer.Bounds.Left = [Math]::Floor($layer.Bounds.Left * $scale)
            $layer.Bounds.Top = [Math]::Floor($layer.Bounds.Top * $scale)
            $layer.Bounds.Right = [Math]::Floor($layer.Bounds.Right * $scale)
            $layer.Bounds.Bottom = [Math]::Floor($layer.Bounds.Bottom * $scale)
        }
    }
    
    if (-not $Silent) {
        Write-Host "Total extracted assets to process: $($assetData.ExtractedLayers.Count)"
        Write-Host "Canvas dimensions: ${canvasWidth}x${canvasHeight}"
        Write-Host "Composition mode: Stream-based PNG to Layer conversion"
    }
    
    # 새로운 PSD 이미지 생성
    if (-not $Silent) {
        Write-Host "Creating new PSD canvas..."
    }
    
    $composedImage = $null
    
    try {
        # 기본 생성자로 PSD 생성
        $composedImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::new($canvasWidth, $canvasHeight)
        
        if (-not $Silent) {
            Write-Host "  ✓ PSD canvas created successfully"
        }
        
    } catch {
        Write-Error "Failed to create PSD canvas: $($_.Exception.Message)"
        throw
    }
    
    try {
        $processedCount = 0
        $addedLayers = New-Object System.Collections.ArrayList
        
        # PNG 파일들을 레이어로 변환하여 추가
        foreach ($extractedLayer in $assetData.ExtractedLayers) {
            try {
                # 에셋 파일 경로 확인
                $assetFilePath = $extractedLayer.FilePath
                if (-not [System.IO.Path]::IsPathRooted($assetFilePath)) {
                    $assetDir = Split-Path -Parent $AssetJson
                    if ([string]::IsNullOrEmpty($assetDir)) {
                        $assetDir = Get-Location
                    }
                    $assetFilePath = Join-Path $assetDir $assetFilePath
                }
                
                if (-not (Test-Path $assetFilePath)) {
                    if (-not $Silent) {
                        Write-Warning "Asset file not found: $assetFilePath"
                    }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - file not found"
                    $result.FailedCompositions++
                    continue
                }
                
                if (-not $Silent) {
                    Write-Host "Processing PNG asset: $($extractedLayer.Name)"
                }
                
                # PNG를 레이어로 변환 (Stream 방식 우선)
                $newLayer = $null
                
                # 방법 1: Stream 방식 (공식 문서 방식)
                $newLayer = Create-LayerFromPNG-Stream `
                    -PngFilePath $assetFilePath `
                    -LayerName $extractedLayer.Name `
                    -Bounds $extractedLayer.Bounds `
                    -DebugMode:(-not $Silent)
                
                # 방법 2: Stream 실패 시 PSD 변환 방식
                if (-not $newLayer) {
                    if (-not $Silent) { Write-Host "  Trying PSD conversion method..." }
                    
                    $newLayer = Create-PSDFromPNG-Conversion `
                        -PngFilePath $assetFilePath `
                        -LayerName $extractedLayer.Name `
                        -Bounds $extractedLayer.Bounds `
                        -DebugMode:(-not $Silent)
                }
                
                if ($newLayer) {
                    # PSD에 레이어 추가
                    $composedImage.AddLayer($newLayer)
                    $addedLayers.Add($newLayer) | Out-Null
                    
                    $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - successfully added"
                    $result.SuccessfulCompositions++
                    $processedCount++
                    
                    if (-not $Silent) {
                        Write-Host "  ✓ Successfully added layer: $($extractedLayer.Name)"
                    }
                    
                    # 배치 처리: 일정 개수마다 메모리 정리
                    if ($processedCount % $BatchSize -eq 0) {
                        if (-not $Silent) { Write-Host "  [Memory cleanup after $processedCount layers]" }
                        Clear-Memory -Force:$LowMemoryMode
                    }
                    
                } else {
                    if (-not $Silent) {
                        Write-Warning "Failed to create layer from PNG: $($extractedLayer.Name)"
                    }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - failed to create layer"
                    $result.FailedCompositions++
                }
                
            } catch {
                $errorMsg = $_.Exception.Message
                
                if (-not $Silent) {
                    Write-Error "Failed to process PNG asset '$($extractedLayer.Name)': $errorMsg"
                }
                $result.FailedAssets += "Asset '$($extractedLayer.Name)' - $errorMsg"
                $result.FailedCompositions++
            }
            
            # Low Memory Mode에서는 매 레이어마다 정리
            if ($LowMemoryMode) {
                Clear-Memory
            }
        }
        
        # 저장 전 최종 메모리 정리
        if (-not $Silent) {
            Write-Host "Performing final memory cleanup before save..."
        }
        Clear-Memory -Force
        
        # PSD 파일 저장
        if (-not $Silent) {
            Write-Host "Saving composed PSD to: $outputFilePath"
        }
        
        # 기존 파일 삭제
        if (Test-Path $outputFilePath) {
            Remove-Item -Path $outputFilePath -Force -ErrorAction SilentlyContinue
        }
        
        # 저장 시도
        $saved = $false
        $saveError = $null
        
        # 방법 1: 기본 저장 (가장 안정적)
        try {
            if (-not $Silent) { Write-Host "  Attempting standard save..." }
            
            $composedImage.Save($outputFilePath)
            $saved = $true
            
            if (-not $Silent) { Write-Host "  ✓ Save successful (standard method)" }
            
        } catch {
            $saveError = $_.Exception.Message
            if (-not $Silent) { Write-Warning "  Standard save failed: $saveError" }
            
            # 방법 2: PsdOptions를 사용한 저장
            try {
                if (-not $Silent) { Write-Host "  Attempting save with PsdOptions..." }
                
                $saveOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
                $saveOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
                $saveOptions.ChannelBitsCount = 8
                $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
                $saveOptions.RefreshImagePreviewData = $false
                
                $composedImage.Save($outputFilePath, $saveOptions)
                $saved = $true
                
                if (-not $Silent) { Write-Host "  ✓ Save successful (with PsdOptions)" }
                
            } catch {
                $saveError = $_.Exception.Message
                if (-not $Silent) { Write-Warning "  PsdOptions save failed: $saveError" }
                
                # 방법 3: 압축 없이 저장
                try {
                    if (-not $Silent) { Write-Host "  Attempting uncompressed save..." }
                    
                    $saveOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
                    $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw
                    $saveOptions.RefreshImagePreviewData = $false
                    
                    $composedImage.Save($outputFilePath, $saveOptions)
                    $saved = $true
                    
                    if (-not $Silent) { Write-Host "  ✓ Save successful (uncompressed)" }
                    
                } catch {
                    $saveError = $_.Exception.Message
                    throw "All save attempts failed. Last error: $saveError"
                }
            }
        }
        
        if ($saved -and (Test-Path $outputFilePath)) {
            $savedSize = (Get-Item $outputFilePath).Length
            if ($savedSize -gt 0) {
                if (-not $Silent) {
                    Write-Host "  ✓ PSD file saved successfully"
                    Write-Host "  File size: $(Format-FileSize -Size $savedSize)"
                    Write-Host ""
                    Write-Host "PSD composition completed successfully!"
                    Write-Host "Total layers created: $($result.SuccessfulCompositions)"
                }
                $result.Status = "Success"
            } else {
                throw "Saved file is empty"
            }
        } else {
            throw "Failed to save PSD file"
        }
        
    } finally {
        # 리소스 정리
        if ($composedImage) {
            $composedImage.Dispose()
            $composedImage = $null
        }
    }
    
} catch {
    $errorMsg = $_.Exception.Message
    Write-Error "Error during PSD composition: $errorMsg"
    $result.Status = "Failed"
    $result.FailedAssets += "Composition error: $errorMsg"
} finally {
    # 처리 완료 시간 기록
    $endTime = Get-Date
    $result.EndTime = $endTime.ToString("o")
    $result.Duration = ($endTime - $startTime).ToString()
    
    if (-not $Silent) {
        Write-Host ""
        Write-Host "=" * 60
        Write-Host "Composition Summary"
        Write-Host "=" * 60
        Write-Host "Completed at: $endTime"
        Write-Host "Duration: $($result.Duration)"
        Write-Host "Total PNG Assets: $($result.TotalAssetsProcessed)"
        Write-Host "Successfully Composed: $($result.SuccessfulCompositions)"
        Write-Host "Failed: $($result.FailedCompositions)"
        
        if ($result.FailedCompositions -gt 0) {
            Write-Host ""
            Write-Host "Failed assets details:"
            foreach ($failedAsset in $result.FailedAssets) {
                Write-Host "  - $failedAsset"
            }
        }
        
        if ($result.Status -eq "Success") {
            Write-Host ""
            Write-Host "✓ Output file: $($result.OutputFile)"
        }
    }
    
    # JSON 출력 생성
    $jsonOutput = $result | ConvertTo-Json -Depth 8
    
    # JSON 파일 저장
    $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
    $jsonFileName = "composition_result_$timestamp.json"
    $jsonDir = if ($result.OutputFile) { Split-Path -Parent $result.OutputFile } else { Get-Location }
    $jsonFilePath = Join-Path $jsonDir $jsonFileName
    
    $jsonOutput | Set-Content -LiteralPath $jsonFilePath -Encoding UTF8
    
    if (-not $Silent) {
        Write-Host ""
        Write-Host "Result JSON saved to: $jsonFilePath"
    }
    
    # 출력 모드에 따른 콘솔 출력
    if ($Silent) {
        Write-Output $jsonFilePath
    } else {
        Write-Output $jsonOutput
    }
    
    # 최종 메모리 정리
    Clear-Memory -Force
}