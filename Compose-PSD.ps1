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

function Create-LayerFromPNG-Stream {
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
        
        if ($DebugMode) { Write-Host "  Loading PNG (Stream method): $PngFilePath" }
        
        # Stream을 통한 레이어 생성 (메모리 효율적)
        $stream = $null
        $layer = $null
        
        try {
            $stream = [System.IO.File]::OpenRead($PngFilePath)
            $layer = New-Object Aspose.PSD.FileFormats.Psd.Layers.Layer($stream)
            $layer.Name = $LayerName
            $layer.DisplayName = $LayerName
            
            # 레이어 위치 설정
            if ($Bounds) {
                $layer.Left = $Bounds.Left
                $layer.Top = $Bounds.Top
                $layer.Right = $Bounds.Right
                $layer.Bottom = $Bounds.Bottom
                
                if ($DebugMode) { 
                    Write-Host "    Layer position: $($Bounds.Left),$($Bounds.Top) - $($Bounds.Right - $Bounds.Left)x$($Bounds.Bottom - $Bounds.Top)"
                }
            }
            
            if ($DebugMode) { Write-Host "    Successfully created layer from stream" }
            
            return $layer
            
        } finally {
            if ($stream) {
                $stream.Close()
                $stream.Dispose()
            }
        }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to create layer from PNG (stream) '$PngFilePath': $($_.Exception.Message)" }
        return $null
    }
}

function Create-LayerFromPNG-Optimized {
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
        
        if ($DebugMode) { Write-Host "  Loading PNG (Optimized): $PngFilePath" }
        
        $pngImage = $null
        $layer = $null
        $graphics = $null
        
        try {
            # LoadOptions를 사용하여 메모리 효율적으로 로드
            $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PngLoadOptions
            $loadOptions.ProgressEventHandler = $null  # Progress handler 비활성화로 메모리 절약
            
            $pngImage = [Aspose.PSD.Image]::Load($PngFilePath, $loadOptions)
            
            if ($DebugMode) { 
                Write-Host "    PNG size: $($pngImage.Width)x$($pngImage.Height)"
                if ($Bounds) {
                    Write-Host "    Target position: $($Bounds.Left),$($Bounds.Top)"
                }
            }
            
            # PSD에 빈 레이어 추가
            $layer = $TargetPsd.AddRegularLayer()
            $layer.Name = $LayerName
            $layer.DisplayName = $LayerName
            
            # 레이어 위치 설정
            if ($Bounds) {
                $layer.Left = $Bounds.Left
                $layer.Top = $Bounds.Top
                $layer.Right = $Bounds.Left + $pngImage.Width
                $layer.Bottom = $Bounds.Top + $pngImage.Height
            } else {
                $layer.Left = 0
                $layer.Top = 0
                $layer.Right = $pngImage.Width
                $layer.Bottom = $pngImage.Height
            }
            
            # RasterImage 체크 및 Graphics로 이미지 그리기
            if ($pngImage -is [Aspose.PSD.RasterImage]) {
                $graphics = New-Object Aspose.PSD.Graphics($layer)
                
                # 메모리 효율적인 DrawImage 사용
                $graphics.DrawImage($pngImage, 0, 0)
                
                if ($DebugMode) { Write-Host "    Successfully drew image to layer" }
            } else {
                if ($DebugMode) { Write-Warning "    PNG is not a RasterImage type" }
                return $null
            }
            
            return $layer
            
        } finally {
            # 즉시 리소스 해제
            if ($graphics) { 
                $graphics.Dispose() 
                $graphics = $null
            }
            if ($pngImage) { 
                $pngImage.Dispose() 
                $pngImage = $null
            }
        }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to create layer from PNG '$PngFilePath': $($_.Exception.Message)" }
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
    
    # Canvas 크기 결정 - 추출된 레이어들의 바운드를 기준으로 계산
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
    
    # .NET 배열 크기 제한 확인 (2GB 제한)
    $maxPixels = [int32]::MaxValue / 4  # ARGB = 4 bytes per pixel
    $totalPixels = $canvasWidth * $canvasHeight
    
    if ($totalPixels -gt $maxPixels) {
        Write-Warning "Canvas size ($canvasWidth x $canvasHeight = $($totalPixels.ToString('N0')) pixels) may exceed .NET array limits!"
        Write-Warning "Maximum safe size is approximately $($maxPixels.ToString('N0')) pixels"
        
        # 캔버스 크기 자동 조정 옵션
        $scaleFactor = [Math]::Sqrt($maxPixels / $totalPixels)
        $suggestedWidth = [Math]::Floor($canvasWidth * $scaleFactor)
        $suggestedHeight = [Math]::Floor($canvasHeight * $scaleFactor)
        
        Write-Warning "Suggested canvas size: $suggestedWidth x $suggestedHeight"
        Write-Host "Do you want to:"
        Write-Host "  1. Continue with original size (may fail)"
        Write-Host "  2. Use suggested smaller size"
        Write-Host "  3. Abort"
        
        if (-not $Silent) {
            $choice = Read-Host "Enter choice (1-3)"
            if ($choice -eq "2") {
                $canvasWidth = $suggestedWidth
                $canvasHeight = $suggestedHeight
                Write-Host "Canvas resized to: $canvasWidth x $canvasHeight"
            } elseif ($choice -eq "3") {
                Write-Error "Aborted by user due to canvas size limitations"
                exit 1
            }
        }
    }
    
    if (-not $Silent) {
        Write-Host "Total extracted assets to process: $($assetData.ExtractedLayers.Count)"
        Write-Host "Canvas dimensions: ${canvasWidth}x${canvasHeight}"
        Write-Host "Composition mode: Memory-optimized PNG processing"
    }
    
    # 새로운 PSD 이미지 생성 (메모리 최적화 옵션)
    if (-not $Silent) {
        Write-Host "Creating new PSD from PNG assets"
        Write-Host "  Using optimized settings for large canvas..."
    }
    
    # 대용량 캔버스를 위한 PSD 생성 옵션
    $createOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
    $createOptions.Source = New-Object Aspose.PSD.Sources.StreamSource([System.IO.Stream]::Null)
    $createOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
    $createOptions.ChannelBitsCount = 8
    $createOptions.ChannelsCount = 3
    $createOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
    
    # PSD 버전 설정 (큰 파일 지원)
    $createOptions.Version = 6  # Photoshop 7.0 이상 버전
    
    $composedImage = [Aspose.PSD.Image]::Create($createOptions, $canvasWidth, $canvasHeight) -as [Aspose.PSD.FileFormats.Psd.PsdImage]
    
    if (-not $composedImage) {
        # 대체 방법: 기본 생성자 사용
        if (-not $Silent) {
            Write-Host "  Falling back to standard PSD creation..."
        }
        $composedImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($canvasWidth, $canvasHeight)
    }
    
    try {
        $processedCount = 0
        
        # PNG 파일들을 레이어로 변환하여 PSD에 추가
        foreach ($extractedLayer in $assetData.ExtractedLayers) {
            try {
                # 에셋 파일 경로 확인 (상대 경로 처리)
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
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - file not found: $assetFilePath"
                    $result.FailedCompositions++
                    continue
                }
                
                if (-not $Silent) {
                    Write-Host "Processing PNG asset: $($extractedLayer.Name)"
                    Write-Host "  File: $assetFilePath"
                }
                
                # PNG 파일을 레이어로 변환 (메모리 최적화 우선순위)
                $newLayer = $null
                
                # 먼저 Stream 방법 시도 (가장 메모리 효율적)
                $newLayer = Create-LayerFromPNG-Stream -PngFilePath $assetFilePath -LayerName $extractedLayer.Name -Bounds $extractedLayer.Bounds -TargetPsd $composedImage -DebugMode:(-not $Silent)
                
                # Stream 방법 실패시 최적화된 방법 시도
                if (-not $newLayer) {
                    if (-not $Silent) { Write-Host "  Trying optimized method..." }
                    $newLayer = Create-LayerFromPNG-Optimized -PngFilePath $assetFilePath -LayerName $extractedLayer.Name -Bounds $extractedLayer.Bounds -TargetPsd $composedImage -DebugMode:(-not $Silent)
                }
                
                if ($newLayer) {
                    # Stream 방법으로 생성된 레이어는 수동으로 추가 필요
                    if ($newLayer.GetType().Name -eq "Layer" -and -not ($composedImage.Layers -contains $newLayer)) {
                        $composedImage.AddLayer($newLayer)
                    }
                    
                    $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - successfully added from PNG"
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
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - failed to create layer from PNG"
                    $result.FailedCompositions++
                }
                
            } catch {
                $errorMsg = $_.Exception.Message
                
                # OutOfMemoryException 처리
                if ($errorMsg -like "*OutOfMemoryException*") {
                    if (-not $Silent) {
                        Write-Warning "Memory issue detected. Performing cleanup..."
                    }
                    Clear-Memory -Force
                    
                    # 재시도 (Stream 방법만)
                    try {
                        $newLayer = Create-LayerFromPNG-Stream -PngFilePath $assetFilePath -LayerName $extractedLayer.Name -Bounds $extractedLayer.Bounds -TargetPsd $composedImage -DebugMode:(-not $Silent)
                        
                        if ($newLayer) {
                            $composedImage.AddLayer($newLayer)
                            $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - successfully added after memory cleanup"
                            $result.SuccessfulCompositions++
                            if (-not $Silent) {
                                Write-Host "  ✓ Successfully added layer after retry: $($extractedLayer.Name)"
                            }
                        } else {
                            throw
                        }
                    } catch {
                        if (-not $Silent) {
                            Write-Error "Failed to process PNG asset '$($extractedLayer.Name)' even after memory cleanup: $($_.Exception.Message)"
                        }
                        $result.FailedAssets += "Asset '$($extractedLayer.Name)' - $($_.Exception.Message)"
                        $result.FailedCompositions++
                    }
                } else {
                    if (-not $Silent) {
                        Write-Error "Failed to process PNG asset '$($extractedLayer.Name)': $errorMsg"
                    }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - $errorMsg"
                    $result.FailedCompositions++
                }
            }
            
            # Low Memory Mode에서는 매 레이어마다 정리
            if ($LowMemoryMode) {
                Clear-Memory
            }
        }
        
        # 최종 메모리 정리 후 저장
        if (-not $Silent) {
            Write-Host "Performing final memory cleanup before save..."
        }
        Clear-Memory -Force
        
        # 조합된 PSD 파일 저장
        if (-not $Silent) {
            Write-Host "Saving composed PSD to: $outputFilePath"
            Write-Host "  Checking output directory..."
        }
        
        # 출력 디렉토리 재확인
        $outputDir = Split-Path -Parent $outputFilePath
        if (-not [string]::IsNullOrEmpty($outputDir) -and -not (Test-Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
            if (-not $Silent) {
                Write-Host "  Created output directory: $outputDir"
            }
        }
        
        # 기존 파일이 있으면 삭제
        if (Test-Path $outputFilePath) {
            if (-not $Silent) {
                Write-Host "  Removing existing file: $outputFilePath"
            }
            Remove-Item -Path $outputFilePath -Force -ErrorAction SilentlyContinue
        }
        
        # 저장 시도 (여러 방법)
        $saved = $false
        $saveAttempts = 0
        $maxAttempts = 4
        
        while (-not $saved -and $saveAttempts -lt $maxAttempts) {
            $saveAttempts++
            
            try {
                if ($saveAttempts -eq 1) {
                    # 첫 번째 시도: 단순 저장 (레이어가 많을 때 더 안정적)
                    if (-not $Silent) { Write-Host "  Save attempt ${saveAttempts}: Simple save without options..." }
                    
                    $composedImage.Save($outputFilePath)
                    
                } elseif ($saveAttempts -eq 2) {
                    # 두 번째 시도: 기본 PSD 옵션
                    if (-not $Silent) { Write-Host "  Save attempt ${saveAttempts}: Using basic PSD options..." }
                    
                    Clear-Memory -Force
                    
                    $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
                    $composedImage.Save($outputFilePath, $saveOptions)
                    
                } elseif ($saveAttempts -eq 3) {
                    # 세 번째 시도: RLE 압축 (메모리 효율적)
                    if (-not $Silent) { Write-Host "  Save attempt ${saveAttempts}: Using RLE compression..." }
                    
                    Clear-Memory -Force
                    
                    $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
                    $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
                    $saveOptions.Version = 6  # Photoshop 7.0+
                    
                    $composedImage.Save($outputFilePath, $saveOptions)
                    
                } else {
                    # 네 번째 시도: 청크 단위 저장 (FileStream 사용)
                    if (-not $Silent) { Write-Host "  Save attempt ${saveAttempts}: Using FileStream with buffer..." }
                    
                    Clear-Memory -Force
                    
                    $fileStream = $null
                    try {
                        # 버퍼 크기를 조정하여 대용량 파일 처리
                        $bufferSize = 64 * 1024  # 64KB buffer
                        $fileStream = New-Object System.IO.FileStream($outputFilePath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None, $bufferSize, $true)
                        
                        $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
                        $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw  # 압축 없이
                        
                        $composedImage.Save($fileStream, $saveOptions)
                        $fileStream.Flush()
                        
                    } finally {
                        if ($fileStream) {
                            $fileStream.Close()
                            $fileStream.Dispose()
                        }
                    }
                }
                
                # 저장 성공 확인
                if (Test-Path $outputFilePath) {
                    $savedSize = (Get-Item $outputFilePath).Length
                    if ($savedSize -gt 0) {
                        $saved = $true
                        if (-not $Silent) { 
                            Write-Host "  ✓ Successfully saved PSD file ($(Format-FileSize -Size $savedSize))"
                        }
                    } else {
                        throw "Saved file is empty"
                    }
                } else {
                    throw "File was not created"
                }
                
            } catch {
                $saveError = $_.Exception.Message
                if (-not $Silent) { 
                    Write-Warning "  Save attempt ${saveAttempts} failed: $saveError"
                    
                    # 상세 에러 정보 출력
                    if ($saveError -like "*Source array*" -or $saveError -like "*sourceArray*") {
                        Write-Host "  Debugging array error:"
                        Write-Host "    - Canvas dimensions: $($composedImage.Width) x $($composedImage.Height)"
                        Write-Host "    - Bits per pixel: $($composedImage.BitsPerPixel)"
                        Write-Host "    - Bytes per row: $($composedImage.Width * 4)"
                        Write-Host "    - Total canvas bytes: $(($composedImage.Width * $composedImage.Height * 4).ToString('N0'))"
                        Write-Host "    - Number of layers: $($composedImage.Layers.Length)"
                        
                        # 각 레이어의 크기 확인
                        $totalLayerBytes = 0
                        $largestLayer = 0
                        foreach ($layer in $composedImage.Layers) {
                            $layerBytes = ($layer.Width * $layer.Height * 4)
                            $totalLayerBytes += $layerBytes
                            if ($layerBytes -gt $largestLayer) {
                                $largestLayer = $layerBytes
                            }
                        }
                        Write-Host "    - Total layer bytes: $($totalLayerBytes.ToString('N0'))"
                        Write-Host "    - Largest layer bytes: $($largestLayer.ToString('N0'))"
                        Write-Host "    - Estimated total bytes: $(($totalLayerBytes + ($composedImage.Width * $composedImage.Height * 4)).ToString('N0'))"
                        
                        # .NET 배열 크기 제한 확인
                        $maxArraySize = [int32]::MaxValue
                        Write-Host "    - .NET max array size: $($maxArraySize.ToString('N0')) elements"
                        Write-Host "    - Max bytes for int32 array: $(($maxArraySize * 4).ToString('N0'))"
                        
                        # 문제가 되는 크기 확인
                        $problematicSize = $composedImage.Width * $composedImage.Height
                        if ($problematicSize -gt $maxArraySize) {
                            Write-Warning "    ⚠ Canvas pixel count ($($problematicSize.ToString('N0'))) exceeds .NET array limit!"
                        }
                        
                        # 각 레이어별 문제 확인
                        $problemLayers = 0
                        foreach ($layer in $composedImage.Layers) {
                            $layerPixels = $layer.Width * $layer.Height
                            if ($layerPixels -gt $maxArraySize) {
                                $problemLayers++
                            }
                        }
                        if ($problemLayers -gt 0) {
                            Write-Warning "    ⚠ $problemLayers layer(s) exceed .NET array limit!"
                        }
                    }
                }
                
                if ($saveAttempts -eq $maxAttempts) {
                    # 마지막 시도: 작은 캔버스로 저장
                    try {
                        if (-not $Silent) { 
                            Write-Host "  Final attempt: Creating smaller canvas PSD..."
                            Write-Host "    Original canvas: $($composedImage.Width) x $($composedImage.Height)"
                        }
                        
                        # 실제 콘텐츠가 있는 영역 찾기
                        $minLeft = 999999
                        $minTop = 999999
                        $maxRight = 0
                        $maxBottom = 0
                        
                        foreach ($layer in $composedImage.Layers) {
                            if ($layer.Left -lt $minLeft) { $minLeft = $layer.Left }
                            if ($layer.Top -lt $minTop) { $minTop = $layer.Top }
                            if ($layer.Right -gt $maxRight) { $maxRight = $layer.Right }
                            if ($layer.Bottom -gt $maxBottom) { $maxBottom = $layer.Bottom }
                        }
                        
                        # 새 캔버스 크기 계산 (여백 추가)
                        $margin = 100
                        $newWidth = ($maxRight - $minLeft) + ($margin * 2)
                        $newHeight = ($maxBottom - $minTop) + ($margin * 2)
                        
                        # 크기가 여전히 크면 스케일 다운
                        $maxSafeSize = 10000  # 10000x10000 이하로 제한
                        if ($newWidth -gt $maxSafeSize -or $newHeight -gt $maxSafeSize) {
                            $scale = [Math]::Min($maxSafeSize / $newWidth, $maxSafeSize / $newHeight)
                            $newWidth = [Math]::Floor($newWidth * $scale)
                            $newHeight = [Math]::Floor($newHeight * $scale)
                            if (-not $Silent) { 
                                Write-Warning "    Scaling down to fit within ${maxSafeSize}x${maxSafeSize}"
                            }
                        }
                        
                        if (-not $Silent) { 
                            Write-Host "    New canvas: $newWidth x $newHeight"
                            Write-Host "    Content area: ($minLeft, $minTop) to ($maxRight, $maxBottom)"
                        }
                        
                        # 새로운 작은 PSD 생성
                        $smallPsd = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($newWidth, $newHeight)
                        
                        try {
                            # 레이어 복사 및 위치 조정
                            $copiedLayers = 0
                            foreach ($layer in $composedImage.Layers) {
                                try {
                                    # 새 레이어 생성
                                    $newLayer = $smallPsd.AddRegularLayer()
                                    $newLayer.Name = $layer.Name
                                    $newLayer.DisplayName = $layer.DisplayName
                                    
                                    # 위치 조정 (오프셋 적용)
                                    $newLayer.Left = $layer.Left - $minLeft + $margin
                                    $newLayer.Top = $layer.Top - $minTop + $margin
                                    $newLayer.Right = $layer.Right - $minLeft + $margin
                                    $newLayer.Bottom = $layer.Bottom - $minTop + $margin
                                    
                                    $copiedLayers++
                                    
                                    # 메모리 관리
                                    if ($copiedLayers % 10 -eq 0) {
                                        Clear-Memory
                                    }
                                    
                                } catch {
                                    if (-not $Silent) { 
                                        Write-Warning "    Could not copy layer '$($layer.Name)': $_"
                                    }
                                }
                            }
                            
                            if (-not $Silent) { 
                                Write-Host "    Copied $copiedLayers layers to new canvas"
                                Write-Host "    Attempting to save..."
                            }
                            
                            # 간단한 저장 시도
                            $smallPsd.Save($outputFilePath)
                            
                            if (Test-Path $outputFilePath) {
                                $savedSize = (Get-Item $outputFilePath).Length
                                if ($savedSize -gt 0) {
                                    $saved = $true
                                    if (-not $Silent) { 
                                        Write-Warning "  ⚠ Saved with reduced canvas size: $newWidth x $newHeight (was $($composedImage.Width) x $($composedImage.Height))"
                                        Write-Host "  ✓ File saved: $(Format-FileSize -Size $savedSize)"
                                    }
                                    $result.Status = "PartialSuccess"
                                    $result.FailedAssets += "Warning: Canvas was resized from $($composedImage.Width)x$($composedImage.Height) to ${newWidth}x${newHeight} due to size limitations"
                                }
                            }
                            
                        } finally {
                            if ($smallPsd) {
                                $smallPsd.Dispose()
                            }
                        }
                        
                    } catch {
                        $finalError = $_.Exception.Message
                        if (-not $Silent) { 
                            Write-Error "  All save attempts failed. Final error: $finalError"
                        }
                        
                        # 디버그 정보 출력
                        if (-not $Silent) {
                            Write-Host "  Debug information:"
                            Write-Host "    - Output path: $outputFilePath"
                            Write-Host "    - Canvas size: $($composedImage.Width) x $($composedImage.Height)"
                            Write-Host "    - Canvas pixels: $(($composedImage.Width * $composedImage.Height).ToString('N0'))"
                            Write-Host "    - Total layers: $($composedImage.Layers.Length)"
                            Write-Host "    - Available disk space: $(Get-PSDriveFreeSpace -FilePath $outputFilePath)"
                            Write-Host "    - Estimated file size: $(Format-FileSize -Size ($composedImage.Width * $composedImage.Height * 4 * $composedImage.Layers.Length))"
                        }
                        
                        throw "Failed to save PSD file after $maxAttempts attempts. Canvas may be too large ($($composedImage.Width)x$($composedImage.Height)) with $($composedImage.Layers.Length) layers. Last error: $finalError"
                    }
                }
            }
        }
        
        if (-not $Silent) {
            # 저장된 파일 크기 확인
            if (Test-Path $outputFilePath) {
                $composedFileSize = Get-FileSize -FilePath $outputFilePath
                Write-Host "Composed file size: $(Format-FileSize -Size $composedFileSize)"
            }
            Write-Host "PSD composition completed successfully"
            Write-Host "Layers created from PNG files: $($result.SuccessfulCompositions)"
        }
        
        $result.Status = "Success"
        
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
        
        # 실패한 에셋들 상세 정보 표시
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