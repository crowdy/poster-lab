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

function Get-PSDriveFreeSpace {
    param([string]$FilePath)
    
    try {
        $outputDrive = (Get-Item $FilePath -ErrorAction SilentlyContinue).PSDrive.Name
        if (-not $outputDrive) { 
            $outputDrive = (Get-Location).Drive.Name 
        }
        
        $drive = Get-PSDrive -Name $outputDrive -ErrorAction SilentlyContinue
        if ($drive -and $drive.Free) {
            return Format-FileSize -Size $drive.Free
        }
        return "Unknown"
    } catch {
        return "Unknown"
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

function Create-LayerFromPNG-Direct {
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
        
        if ($DebugMode) { Write-Host "  Loading PNG (Direct method): $PngFilePath" }
        
        # PNG를 RasterImage로 로드
        $pngImage = $null
        $layer = $null
        
        try {
            # 메모리 효율적인 로드 옵션
            $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PngLoadOptions
            $loadOptions.ProgressEventHandler = $null
            
            # PNG 이미지 로드
            $pngImage = [Aspose.PSD.Image]::Load($PngFilePath, $loadOptions)
            
            if (-not ($pngImage -is [Aspose.PSD.RasterImage])) {
                if ($DebugMode) { Write-Warning "PNG is not a RasterImage" }
                return $null
            }
            
            $rasterImage = [Aspose.PSD.RasterImage]$pngImage
            
            if ($DebugMode) { 
                Write-Host "    PNG size: $($rasterImage.Width)x$($rasterImage.Height)"
            }
            
            # Layer 생성 (RasterImage에서 직접)
            $layer = New-Object Aspose.PSD.FileFormats.Psd.Layers.Layer($rasterImage)
            $layer.Name = $LayerName
            $layer.DisplayName = $LayerName
            
            # 레이어 위치 설정
            if ($Bounds) {
                $layer.Left = $Bounds.Left
                $layer.Top = $Bounds.Top
                $layer.Right = $Bounds.Right
                $layer.Bottom = $Bounds.Bottom
            } else {
                $layer.Left = 0
                $layer.Top = 0
                $layer.Right = $rasterImage.Width
                $layer.Bottom = $rasterImage.Height
            }
            
            if ($DebugMode) { Write-Host "    Successfully created layer" }
            
            return $layer
            
        } finally {
            if ($pngImage) { 
                $pngImage.Dispose() 
                $pngImage = $null
            }
        }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to create layer from PNG: $($_.Exception.Message)" }
        return $null
    }
}

function Create-LayerFromPNG-LowMemory {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds,
        [Aspose.PSD.FileFormats.Psd.PsdImage]$TargetPsd,
        [switch]$DebugMode
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            if ($DebugMode) { Write-Warning "PNG file not found: $PngFilePath" }
            return $null
        }
        
        if ($DebugMode) { Write-Host "  Loading PNG (Low Memory method): $PngFilePath" }
        
        # 임시 PSD 파일 생성 방식 (메모리 대신 디스크 사용)
        $tempPsdPath = [System.IO.Path]::GetTempFileName() + ".psd"
        
        try {
            # PNG를 임시 PSD로 변환
            $pngImage = [Aspose.PSD.Image]::Load($PngFilePath)
            
            if ($pngImage -is [Aspose.PSD.RasterImage]) {
                # 작은 임시 PSD 생성
                $tempPsd = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($pngImage.Width, $pngImage.Height)
                
                try {
                    # 레이어 추가
                    $tempLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.Layer([Aspose.PSD.RasterImage]$pngImage)
                    $tempLayer.Name = $LayerName
                    $tempLayer.DisplayName = $LayerName
                    
                    $tempPsd.AddLayer($tempLayer)
                    
                    # 임시 파일로 저장
                    $tempPsd.Save($tempPsdPath)
                    
                } finally {
                    $tempPsd.Dispose()
                }
                
                $pngImage.Dispose()
                $pngImage = $null
                
                # 임시 PSD에서 레이어 로드
                $tempPsdLoaded = [Aspose.PSD.Image]::Load($tempPsdPath)
                $tempPsdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$tempPsdLoaded
                
                try {
                    if ($tempPsdImage.Layers.Length -gt 0) {
                        $layer = $tempPsdImage.Layers[0]
                        
                        # 레이어 복사
                        $layerCopy = $layer.ShallowCopy()
                        $layerCopy.Name = $LayerName
                        $layerCopy.DisplayName = $LayerName
                        
                        # 위치 설정
                        if ($Bounds) {
                            $layerCopy.Left = $Bounds.Left
                            $layerCopy.Top = $Bounds.Top
                            $layerCopy.Right = $Bounds.Right
                            $layerCopy.Bottom = $Bounds.Bottom
                        }
                        
                        # 대상 PSD에 추가
                        $TargetPsd.AddLayer($layerCopy)
                        
                        if ($DebugMode) { Write-Host "    Successfully added layer via temp PSD" }
                        return $layerCopy
                    }
                    
                } finally {
                    $tempPsdImage.Dispose()
                }
                
            } else {
                $pngImage.Dispose()
                if ($DebugMode) { Write-Warning "PNG is not a RasterImage" }
                return $null
            }
            
        } finally {
            # 임시 파일 삭제
            if (Test-Path $tempPsdPath) {
                Remove-Item $tempPsdPath -Force -ErrorAction SilentlyContinue
            }
        }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to create layer (low memory): $($_.Exception.Message)" }
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
        # asset JSON과 같은 디렉토리에 저장
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
    
    # Asset JSON에서 원본 크기 정보가 있는지 확인
    if ($assetData.PSObject.Properties.Name -contains "CanvasWidth" -and $assetData.CanvasWidth -gt 0) {
        $canvasWidth = $assetData.CanvasWidth
    }
    if ($assetData.PSObject.Properties.Name -contains "CanvasHeight" -and $assetData.CanvasHeight -gt 0) {
        $canvasHeight = $assetData.CanvasHeight
    }
    
    # 추출된 레이어들의 최대 바운드로부터 캔버스 크기 추정
    if ($assetData.ExtractedLayers.Count -gt 0) {
        $maxRight = ($assetData.ExtractedLayers | ForEach-Object { $_.Bounds.Right } | Measure-Object -Maximum).Maximum
        $maxBottom = ($assetData.ExtractedLayers | ForEach-Object { $_.Bounds.Bottom } | Measure-Object -Maximum).Maximum
        
        if ($maxRight -gt $canvasWidth) { $canvasWidth = $maxRight }
        if ($maxBottom -gt $canvasHeight) { $canvasHeight = $maxBottom }
    }
    
    # 캔버스 크기 제한 (안전한 크기로)
    $maxSafeSize = 10000  # 10000x10000 픽셀로 제한
    if ($canvasWidth -gt $maxSafeSize -or $canvasHeight -gt $maxSafeSize) {
        Write-Warning "Canvas size ($canvasWidth x $canvasHeight) exceeds safe limit ($maxSafeSize x $maxSafeSize)"
        
        # 비율 유지하며 크기 조정
        $scale = [Math]::Min($maxSafeSize / $canvasWidth, $maxSafeSize / $canvasHeight)
        $canvasWidth = [Math]::Floor($canvasWidth * $scale)
        $canvasHeight = [Math]::Floor($canvasHeight * $scale)
        
        Write-Warning "Canvas resized to: $canvasWidth x $canvasHeight"
    }
    
    if (-not $Silent) {
        Write-Host "Total extracted assets to process: $($assetData.ExtractedLayers.Count)"
        Write-Host "Canvas dimensions: ${canvasWidth}x${canvasHeight}"
        Write-Host "Composition mode: Optimized PNG to PSD conversion"
    }
    
    # 새로운 PSD 이미지 생성 (최적화된 방식)
    if (-not $Silent) {
        Write-Host "Creating new PSD canvas..."
    }
    
    $composedImage = $null
    
    # 메모리 효율적인 PSD 생성
    try {
        # 방법 1: 기본 생성자 사용 (가장 단순하고 안정적)
        $composedImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($canvasWidth, $canvasHeight)
        
        if (-not $Silent) {
            Write-Host "  ✓ PSD canvas created successfully"
        }
        
    } catch {
        # 방법 2: ImageOptions 사용
        if (-not $Silent) {
            Write-Host "  Trying alternative PSD creation method..."
        }
        
        $createOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
        $createOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
        $createOptions.ChannelBitsCount = 8
        $createOptions.ChannelsCount = 3
        $createOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
        $createOptions.Version = 6
        
        $composedImage = [Aspose.PSD.Image]::Create($createOptions, $canvasWidth, $canvasHeight) -as [Aspose.PSD.FileFormats.Psd.PsdImage]
        
        if (-not $composedImage) {
            throw "Failed to create PSD canvas"
        }
    }
    
    try {
        $processedCount = 0
        $layers = New-Object System.Collections.ArrayList
        
        # PNG 파일들을 레이어로 변환
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
                
                # PNG를 레이어로 변환
                $newLayer = $null
                
                if ($LowMemoryMode) {
                    # Low Memory Mode: 임시 PSD 사용
                    $newLayer = Create-LayerFromPNG-LowMemory `
                        -PngFilePath $assetFilePath `
                        -LayerName $extractedLayer.Name `
                        -Bounds $extractedLayer.Bounds `
                        -TargetPsd $composedImage `
                        -DebugMode:(-not $Silent)
                } else {
                    # Normal Mode: 직접 변환
                    $newLayer = Create-LayerFromPNG-Direct `
                        -PngFilePath $assetFilePath `
                        -LayerName $extractedLayer.Name `
                        -Bounds $extractedLayer.Bounds `
                        -DebugMode:(-not $Silent)
                    
                    if ($newLayer) {
                        # PSD에 레이어 추가
                        $composedImage.AddLayer($newLayer)
                    }
                }
                
                if ($newLayer) {
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
        
        # 최종 메모리 정리
        if (-not $Silent) {
            Write-Host "Performing final memory cleanup before save..."
        }
        Clear-Memory -Force
        
        # PSD 파일 저장 (최적화된 방식)
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
        
        try {
            # 메모리 효율적인 저장 옵션
            $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
            $saveOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
            $saveOptions.ChannelBitsCount = 8
            $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
            $saveOptions.Version = 6
            
            # RefreshImagePreviewData를 false로 설정하여 메모리 사용 감소
            $saveOptions.RefreshImagePreviewData = $false
            
            # 파일 스트림으로 저장 (메모리 효율적)
            $fileStream = $null
            try {
                $fileStream = [System.IO.File]::Create($outputFilePath)
                $composedImage.Save($fileStream, $saveOptions)
                $fileStream.Flush()
                $saved = $true
                
            } finally {
                if ($fileStream) {
                    $fileStream.Close()
                    $fileStream.Dispose()
                }
            }
            
        } catch {
            $saveError = $_.Exception.Message
            
            # 대체 저장 방법: 단순 저장
            if (-not $Silent) {
                Write-Warning "Standard save failed, trying simple save: $saveError"
            }
            
            try {
                $composedImage.Save($outputFilePath)
                $saved = $true
            } catch {
                $saveError = $_.Exception.Message
                
                # 마지막 시도: 압축 없이 저장
                if (-not $Silent) {
                    Write-Warning "Simple save failed, trying uncompressed save: $saveError"
                }
                
                try {
                    $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
                    $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw
                    $composedImage.Save($outputFilePath, $saveOptions)
                    $saved = $true
                } catch {
                    $saveError = $_.Exception.Message
                    throw "All save attempts failed: $saveError"
                }
            }
        }
        
        if ($saved -and (Test-Path $outputFilePath)) {
            $savedSize = (Get-Item $outputFilePath).Length
            if ($savedSize -gt 0) {
                if (-not $Silent) {
                    Write-Host "  ✓ Successfully saved PSD file ($(Format-FileSize -Size $savedSize))"
                    Write-Host "PSD composition completed successfully"
                    Write-Host "Layers created: $($result.SuccessfulCompositions)"
                }
                $result.Status = "Success"
            } else {
                throw "Saved file is empty"
            }
        } else {
            throw "Failed to save PSD file"
        }
        
    } finally {
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
        Write-Host "Composition completed at $endTime. Duration: $($result.Duration)"
        Write-Host "Summary:"
        Write-Host "  - Total PNG Assets: $($result.TotalAssetsProcessed)"
        Write-Host "  - Successfully Composed: $($result.SuccessfulCompositions)"
        Write-Host "  - Failed: $($result.FailedCompositions)"
        
        # 실패한 에셋들 상세 정보
        if ($result.FailedCompositions -gt 0) {
            Write-Host "Failed assets details:"
            foreach ($failedAsset in $result.FailedAssets) {
                Write-Host "  - $failedAsset"
            }
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
        Write-Host "Composition result saved to: $jsonFilePath"
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