param(
    [Parameter(Mandatory = $true)]
    [string]$AssetJson,                 # Path to the asset JSON file from extract-psd

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,                # Output path for the composed PSD file (optional)

    [Parameter(Mandatory = $false)]
    [int]$BatchSize = 10,                # Number of layers to process before garbage collection

    [switch]$Silent,                    # Silent mode - only output result JSON file path
    
    [switch]$LowMemoryMode,             # Enable aggressive memory optimization
    
    [switch]$DebugMode                      # Enable debug mode with stack traces
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
        # CodePages 인코딩 등록
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

function Write-DebugInfo {
    param(
        [string]$Message,
        [System.Management.Automation.ErrorRecord]$ErrorRecord
    )
    
    if ($Script:Debug -or -not $Script:Silent) {
        Write-Host "DEBUG: $Message" -ForegroundColor Yellow
        
        if ($ErrorRecord) {
            Write-Host "  Exception Type: $($ErrorRecord.Exception.GetType().FullName)" -ForegroundColor Yellow
            Write-Host "  Exception Message: $($ErrorRecord.Exception.Message)" -ForegroundColor Yellow
            
            if ($ErrorRecord.Exception.InnerException) {
                Write-Host "  Inner Exception: $($ErrorRecord.Exception.InnerException.Message)" -ForegroundColor Yellow
            }
            
            if ($Script:Debug) {
                Write-Host "  Stack Trace:" -ForegroundColor Yellow
                Write-Host $ErrorRecord.Exception.StackTrace -ForegroundColor DarkYellow
            }
        }
    }
}

function Create-LayerFromPNG-Method1 {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            Write-Warning "PNG file not found: $PngFilePath"
            return $null
        }
        
        if ($Script:Debug -or -not $Script:Silent) { 
            Write-Host "  Method 1: Stream-based layer creation..." 
        }
        
        # 방법 1: 공식 문서 방식 - Stream을 사용한 Layer 생성
        $stream = $null
        try {
            $stream = [System.IO.File]::OpenRead($PngFilePath)
            $layer = [Aspose.PSD.FileFormats.Psd.Layers.Layer]::new($stream)
            $layer.Name = $LayerName
            $layer.DisplayName = $LayerName
            
            if ($Bounds) {
                $layer.Left = $Bounds.Left
                $layer.Top = $Bounds.Top
                $layer.Right = $Bounds.Right
                $layer.Bottom = $Bounds.Bottom
            }
            
            if ($Script:Debug -or -not $Script:Silent) { 
                Write-Host "    ✓ Layer created successfully" -ForegroundColor Green
            }
            
            return $layer
            
        } finally {
            if ($stream) {
                $stream.Close()
                $stream.Dispose()
            }
        }
        
    } catch {
        Write-DebugInfo "Method 1 failed" $_
        return $null
    }
}

function Create-LayerFromPNG-Method2 {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds,
        [int]$CanvasWidth,
        [int]$CanvasHeight
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            Write-Warning "PNG file not found: $PngFilePath"
            return $null
        }
        
        if ($Script:Debug -or -not $Script:Silent) { 
            Write-Host "  Method 2: PSD conversion approach..." 
        }
        
        # 방법 2: PNG를 먼저 PSD로 변환 후 레이어 추출
        $tempPsdPath = [System.IO.Path]::GetTempFileName() + ".psd"
        
        try {
            # PNG 로드
            $pngImage = [Aspose.PSD.Image]::Load($PngFilePath)
            
            # PSD로 변환
            $psdOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
            $psdOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
            $psdOptions.ChannelBitsCount = 8
            $psdOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
            
            $pngImage.Save($tempPsdPath, $psdOptions)
            $pngImage.Dispose()
            
            # 변환된 PSD 로드
            $tempPsd = [Aspose.PSD.FileFormats.Psd.PsdImage]([Aspose.PSD.Image]::Load($tempPsdPath))
            
            if ($tempPsd.Layers.Length -gt 0) {
                # 원본 레이어 참조
                $sourceLayer = $tempPsd.Layers[0]
                
                # ShallowCopy 사용 (더 안전한 방법)
                $newLayer = $sourceLayer.ShallowCopy()
                $newLayer.Name = $LayerName
                $newLayer.DisplayName = $LayerName
                
                if ($Bounds) {
                    $newLayer.Left = $Bounds.Left
                    $newLayer.Top = $Bounds.Top
                    $newLayer.Right = $Bounds.Right
                    $newLayer.Bottom = $Bounds.Bottom
                }
                
                $tempPsd.Dispose()
                
                if ($Script:Debug -or -not $Script:Silent) { 
                    Write-Host "    ✓ Layer created via PSD conversion" -ForegroundColor Green
                }
                
                return $newLayer
            }
            
            $tempPsd.Dispose()
            return $null
            
        } finally {
            if (Test-Path $tempPsdPath) {
                Remove-Item $tempPsdPath -Force -ErrorAction SilentlyContinue
            }
        }
        
    } catch {
        Write-DebugInfo "Method 2 failed" $_
        return $null
    }
}

function Create-LayerFromPNG-Method3 {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            Write-Warning "PNG file not found: $PngFilePath"
            return $null
        }
        
        if ($Script:Debug -or -not $Script:Silent) { 
            Write-Host "  Method 3: Direct RasterImage approach..." 
        }
        
        # 방법 3: RasterImage로 로드 후 레이어 생성
        $pngImage = [Aspose.PSD.Image]::Load($PngFilePath)
        
        if ($pngImage -is [Aspose.PSD.RasterImage]) {
            $rasterImage = [Aspose.PSD.RasterImage]$pngImage
            
            # Layer 생성자에 RasterImage 직접 전달
            $layer = [Aspose.PSD.FileFormats.Psd.Layers.Layer]::new($rasterImage)
            $layer.Name = $LayerName
            $layer.DisplayName = $LayerName
            
            if ($Bounds) {
                $layer.Left = $Bounds.Left
                $layer.Top = $Bounds.Top
                $layer.Right = $Bounds.Right
                $layer.Bottom = $Bounds.Bottom
            }
            
            $pngImage.Dispose()
            
            if ($Script:Debug -or -not $Script:Silent) { 
                Write-Host "    ✓ Layer created via RasterImage" -ForegroundColor Green
            }
            
            return $layer
        }
        
        $pngImage.Dispose()
        return $null
        
    } catch {
        Write-DebugInfo "Method 3 failed" $_
        return $null
    }
}

# ===== Main =====
$Script:Debug = $DebugMode
$Script:Silent = $Silent
$startTime = Get-Date

if (-not $Silent) {
    Write-Host "Starting PSD composition at $startTime"
    Write-Host "Current directory: $(Get-Location)"
    if ($LowMemoryMode) {
        Write-Host "Low Memory Mode: ENABLED"
    }
    if ($DebugMode) {
        Write-Host "Debug Mode: ENABLED (Stack traces will be shown)"
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
    
    # 추출된 레이어 확인
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
    $canvasWidth = 1920
    $canvasHeight = 1080
    
    if ($assetData.PSObject.Properties.Name -contains "CanvasWidth" -and $assetData.CanvasWidth -gt 0) {
        $canvasWidth = $assetData.CanvasWidth
    }
    if ($assetData.PSObject.Properties.Name -contains "CanvasHeight" -and $assetData.CanvasHeight -gt 0) {
        $canvasHeight = $assetData.CanvasHeight
    }
    
    # 레이어 바운드 확인
    if ($assetData.ExtractedLayers.Count -gt 0) {
        $maxRight = ($assetData.ExtractedLayers | ForEach-Object { $_.Bounds.Right } | Measure-Object -Maximum).Maximum
        $maxBottom = ($assetData.ExtractedLayers | ForEach-Object { $_.Bounds.Bottom } | Measure-Object -Maximum).Maximum
        
        if ($maxRight -gt $canvasWidth) { $canvasWidth = $maxRight }
        if ($maxBottom -gt $canvasHeight) { $canvasHeight = $maxBottom }
    }
    
    # 캔버스 크기 제한 (8000x8000으로 더 보수적으로 설정)
    $maxSafeSize = 8000
    $needsScaling = $false
    $scale = 1.0
    
    if ($canvasWidth -gt $maxSafeSize -or $canvasHeight -gt $maxSafeSize) {
        Write-Warning "Canvas size ($canvasWidth x $canvasHeight) exceeds safe limit ($maxSafeSize x $maxSafeSize)"
        
        $scale = [Math]::Min($maxSafeSize / $canvasWidth, $maxSafeSize / $canvasHeight)
        $originalWidth = $canvasWidth
        $originalHeight = $canvasHeight
        $canvasWidth = [Math]::Floor($canvasWidth * $scale)
        $canvasHeight = [Math]::Floor($canvasHeight * $scale)
        $needsScaling = $true
        
        Write-Warning "Canvas will be resized to: $canvasWidth x $canvasHeight (scale: $scale)"
    }
    
    if (-not $Silent) {
        Write-Host "Total extracted assets: $($assetData.ExtractedLayers.Count)"
        Write-Host "Canvas dimensions: ${canvasWidth}x${canvasHeight}"
    }
    
    # PSD 생성
    $composedImage = $null
    $createdLayers = @()  # 생성된 레이어 추적
    
    try {
        if (-not $Silent) {
            Write-Host "Creating new PSD canvas..."
        }
        
        $composedImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::new($canvasWidth, $canvasHeight)
        
        if (-not $Silent) {
            Write-Host "  ✓ PSD canvas created successfully"
            Write-Host ""
        }
        
        $processedCount = 0
        
        # PNG 파일들을 레이어로 변환
        foreach ($extractedLayer in $assetData.ExtractedLayers) {
            try {
                # 파일 경로 확인
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
                    Write-Host "Processing: $($extractedLayer.Name)"
                }
                
                # 스케일링이 필요한 경우 Bounds 조정
                $adjustedBounds = $null
                if ($needsScaling -and $extractedLayer.Bounds) {
                    $adjustedBounds = @{
                        Left = [Math]::Floor($extractedLayer.Bounds.Left * $scale)
                        Top = [Math]::Floor($extractedLayer.Bounds.Top * $scale)
                        Right = [Math]::Floor($extractedLayer.Bounds.Right * $scale)
                        Bottom = [Math]::Floor($extractedLayer.Bounds.Bottom * $scale)
                    }
                } else {
                    $adjustedBounds = $extractedLayer.Bounds
                }
                
                # 3가지 방법으로 레이어 생성 시도
                $newLayer = $null
                
                # Method 1: Stream
                $newLayer = Create-LayerFromPNG-Method1 `
                    -PngFilePath $assetFilePath `
                    -LayerName $extractedLayer.Name `
                    -Bounds $adjustedBounds
                
                # Method 2: PSD Conversion
                if (-not $newLayer) {
                    $newLayer = Create-LayerFromPNG-Method2 `
                        -PngFilePath $assetFilePath `
                        -LayerName $extractedLayer.Name `
                        -Bounds $adjustedBounds `
                        -CanvasWidth $canvasWidth `
                        -CanvasHeight $canvasHeight
                }
                
                # Method 3: RasterImage
                if (-not $newLayer) {
                    $newLayer = Create-LayerFromPNG-Method3 `
                        -PngFilePath $assetFilePath `
                        -LayerName $extractedLayer.Name `
                        -Bounds $adjustedBounds
                }
                
                if ($newLayer) {
                    $composedImage.AddLayer($newLayer)
                    $createdLayers += $newLayer
                    
                    $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - added"
                    $result.SuccessfulCompositions++
                    $processedCount++
                    
                    if (-not $Silent) {
                        Write-Host "  ✓ Layer added successfully" -ForegroundColor Green
                    }
                    
                    # 메모리 정리
                    if ($processedCount % $BatchSize -eq 0) {
                        if (-not $Silent) { 
                            Write-Host "  [Memory cleanup after $processedCount layers]" -ForegroundColor Cyan
                        }
                        Clear-Memory -Force:$LowMemoryMode
                    }
                    
                } else {
                    if (-not $Silent) {
                        Write-Warning "  Failed to create layer: $($extractedLayer.Name)"
                    }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - creation failed"
                    $result.FailedCompositions++
                }
                
            } catch {
                Write-DebugInfo "Failed to process asset '$($extractedLayer.Name)'" $_
                $result.FailedAssets += "Asset '$($extractedLayer.Name)' - $($_.Exception.Message)"
                $result.FailedCompositions++
            }
            
            if ($LowMemoryMode) {
                Clear-Memory
            }
        }
        
        # 저장 전 메모리 정리
        if (-not $Silent) {
            Write-Host ""
            Write-Host "Preparing to save PSD file..."
        }
        Clear-Memory -Force
        
        # PSD 저장
        if (-not $Silent) {
            Write-Host "Saving to: $outputFilePath"
        }
        
        if (Test-Path $outputFilePath) {
            Remove-Item -Path $outputFilePath -Force -ErrorAction SilentlyContinue
        }
        
        $saved = $false
        
        # Save Attempt 1: Simple save
        try {
            if (-not $Silent) { Write-Host "  Attempting simple save..." }
            
            $composedImage.Save($outputFilePath)
            $saved = $true
            
            if (-not $Silent) { 
                Write-Host "  ✓ Save successful" -ForegroundColor Green
            }
            
        } catch {
            Write-DebugInfo "Simple save failed" $_
            
            # Save Attempt 2: With specific options
            try {
                if (-not $Silent) { Write-Host "  Attempting save with PSD options..." }
                
                $saveOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
                $saveOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
                $saveOptions.ChannelBitsCount = 8
                $saveOptions.ChannelsCount = 3
                $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
                $saveOptions.Version = 6
                $saveOptions.RefreshImagePreviewData = $false
                
                $composedImage.Save($outputFilePath, $saveOptions)
                $saved = $true
                
                if (-not $Silent) { 
                    Write-Host "  ✓ Save successful with options" -ForegroundColor Green
                }
                
            } catch {
                Write-DebugInfo "PSD options save failed" $_
                
                # Save Attempt 3: Recreate and save
                try {
                    if (-not $Silent) { Write-Host "  Attempting to recreate and save..." }
                    
                    # 새 PSD 생성하고 레이어 복사
                    $newPsd = [Aspose.PSD.FileFormats.Psd.PsdImage]::new($canvasWidth, $canvasHeight)
                    
                    foreach ($layer in $createdLayers) {
                        try {
                            # AddRegularLayer 메서드로 빈 레이어 생성
                            $newLayer = $newPsd.AddRegularLayer()
                            $newLayer.Name = $layer.Name
                            $newLayer.DisplayName = $layer.DisplayName
                            $newLayer.Left = $layer.Left
                            $newLayer.Top = $layer.Top
                            $newLayer.Right = $layer.Right
                            $newLayer.Bottom = $layer.Bottom
                            
                            # 픽셀 데이터 복사
                            try {
                                $sourceRect = [Aspose.PSD.Rectangle]::new(0, 0, $layer.Width, $layer.Height)
                                $pixels = $layer.LoadArgb32Pixels($sourceRect)
                                
                                $destRect = [Aspose.PSD.Rectangle]::new(0, 0, $layer.Width, $layer.Height)
                                $newLayer.SaveArgb32Pixels($destRect, $pixels)
                            } catch {
                                # 대체 방법: 픽셀 단위 복사
                                if ($DebugMode -or -not $Silent) {
                                    Write-Host "    Using alternative pixel copy for layer '$($layer.Name)'"
                                }
                                
                                for ($y = 0; $y -lt $layer.Height; $y++) {
                                    for ($x = 0; $x -lt $layer.Width; $x++) {
                                        $pixel = $layer.GetPixel($x, $y)
                                        $newLayer.SetPixel($x, $y, $pixel)
                                    }
                                }
                            }
                            
                            if ($DebugMode -or -not $Silent) {
                                Write-Host "    ✓ Copied layer: $($layer.Name)"
                            }
                        } catch {
                            Write-DebugInfo "Failed to copy layer '$($layer.Name)'" $_
                        }
                    }
                    
                    $newPsd.Save($outputFilePath)
                    $newPsd.Dispose()
                    $saved = $true
                    
                    if (-not $Silent) { 
                        Write-Host "  ✓ Save successful after recreation" -ForegroundColor Green
                    }
                    
                } catch {
                    Write-DebugInfo "Recreation save failed" $_
                    throw "All save attempts failed. Last error: $($_.Exception.Message)"
                }
            }
        }
        
        if ($saved -and (Test-Path $outputFilePath)) {
            $savedSize = (Get-Item $outputFilePath).Length
            if ($savedSize -gt 0) {
                if (-not $Silent) {
                    Write-Host ""
                    Write-Host "PSD file saved successfully!"
                    Write-Host "File size: $(Format-FileSize -Size $savedSize)"
                }
                $result.Status = "Success"
            } else {
                throw "Saved file is empty"
            }
        }
        
    } finally {
        if ($composedImage) {
            $composedImage.Dispose()
        }
    }
    
} catch {
    Write-DebugInfo "Composition error" $_
    $result.Status = "Failed"
    $result.FailedAssets += "Composition error: $($_.Exception.Message)"
} finally {
    # 완료 시간 기록
    $endTime = Get-Date
    $result.EndTime = $endTime.ToString("o")
    $result.Duration = ($endTime - $startTime).ToString()
    
    if (-not $Silent) {
        Write-Host ""
        Write-Host ("=" * 60)
        Write-Host "Composition Summary"
        Write-Host ("=" * 60)
        Write-Host "Completed at: $endTime"
        Write-Host "Duration: $($result.Duration)"
        Write-Host "Total PNG Assets: $($result.TotalAssetsProcessed)"
        Write-Host "Successfully Composed: $($result.SuccessfulCompositions)"
        Write-Host "Failed: $($result.FailedCompositions)"
        
        if ($result.FailedCompositions -gt 0) {
            Write-Host ""
            Write-Host "Failed assets:"
            foreach ($failedAsset in $result.FailedAssets) {
                Write-Host "  - $failedAsset"
            }
        }
        
        if ($result.Status -eq "Success") {
            Write-Host ""
            Write-Host "✓ Output: $($result.OutputFile)" -ForegroundColor Green
        }
    }
    
    # JSON 저장
    $jsonOutput = $result | ConvertTo-Json -Depth 8
    
    $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
    $jsonFileName = "composition_result_$timestamp.json"
    $jsonDir = if ($result.OutputFile) { Split-Path -Parent $result.OutputFile } else { Get-Location }
    $jsonFilePath = Join-Path $jsonDir $jsonFileName
    
    $jsonOutput | Set-Content -LiteralPath $jsonFilePath -Encoding UTF8
    
    if (-not $Silent) {
        Write-Host ""
        Write-Host "Result JSON: $jsonFilePath"
    }
    
    if ($Silent) {
        Write-Output $jsonFilePath
    } else {
        Write-Output $jsonOutput
    }
    
    Clear-Memory -Force
}