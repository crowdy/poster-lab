param(
    [Parameter(Mandatory = $false)]
    [string]$InputPath = "*.psd",               # PSD 파일 경로 또는 와일드카드 패턴
    
    [Parameter(Mandatory = $false)]
    [string]$OutputPath,                       # 출력 디렉토리 (미지정시 입력 파일과 같은 디렉토리)
    
    [Parameter(Mandatory = $false)]
    [string]$LayerName = "background_g00 #1",  # 추출할 레이어명
    
    [switch]$Overwrite                         # 기존 파일 덮어쓰기
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ===== Aspose.PSD 로더 (공통 함수 사용) =====
# . "$PSScriptRoot\Load-AsposePSD.ps1"

# ===== 유틸리티 함수들 =====
function Write-VerboseMessage {
    param([string]$Message)
    Write-Verbose $Message
}

function Get-SafeFileName {
    param([string]$FileName)
    $invalid = [System.IO.Path]::GetInvalidFileNameChars()
    foreach ($char in $invalid) {
        $FileName = $FileName.Replace($char, "_")
    }
    return $FileName
}

function Extract-BackgroundLayer {
    param(
        [string]$PsdPath,
        [string]$OutputDir,
        [string]$TargetLayerName
    )
    
    Write-VerboseMessage "Processing PSD file: $PsdPath"
    
    # 파일명에서 확장자 제거
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($PsdPath)
    $outputFileName = "$baseName-bg.png"
    $outputPath = Join-Path $OutputDir $outputFileName
    
    # 이미 파일이 존재하고 덮어쓰기가 아닌 경우 스킵
    if ((Test-Path $outputPath) -and (-not $Overwrite)) {
        Write-Host "SKIPPED: $outputFileName (이미 존재함, -Overwrite 사용하여 덮어쓰기 가능)" -ForegroundColor Yellow
        return $false
    }
    
    $psdImage = $null
    try {
        # PSD 로드 옵션 설정
        Write-VerboseMessage "Loading PSD with effects resources..."
        $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
        $loadOptions.LoadEffectsResource = $true
        $loadOptions.UseDiskForLoadEffectsResource = $true
        
        # PSD 파일 로드
        $image = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
        $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$image
        
        Write-VerboseMessage "PSD loaded successfully. Total layers: $($psdImage.Layers.Length)"
        Write-VerboseMessage "Canvas size: $($psdImage.Width)x$($psdImage.Height)"
        
        # 대상 레이어 찾기
        $targetLayer = $null
        foreach ($layer in $psdImage.Layers) {
            Write-VerboseMessage "Checking layer: '$($layer.DisplayName)'"
            if ($layer.DisplayName -eq $TargetLayerName) {
                $targetLayer = $layer
                Write-VerboseMessage "Found target layer: '$($layer.DisplayName)'"
                break
            }
        }
        
        if (-not $targetLayer) {
            Write-Host "ERROR: Layer '$TargetLayerName' not found in $baseName" -ForegroundColor Red
            Write-VerboseMessage "Available layers:"
            foreach ($layer in $psdImage.Layers) {
                Write-VerboseMessage "  - '$($layer.DisplayName)'"
            }
            return $false
        }
        
        # 레이어 상태 확인
        Write-VerboseMessage "Layer bounds: Left=$($targetLayer.Left), Top=$($targetLayer.Top), Right=$($targetLayer.Right), Bottom=$($targetLayer.Bottom)"
        Write-VerboseMessage "Layer size: $($targetLayer.Width)x$($targetLayer.Height)"
        Write-VerboseMessage "Layer visible: $($targetLayer.IsVisible)"
        Write-VerboseMessage "Layer opacity: $($targetLayer.Opacity)"
        
        if ($targetLayer.Width -le 0 -or $targetLayer.Height -le 0) {
            Write-Host "ERROR: Layer '$TargetLayerName' has invalid dimensions in $baseName" -ForegroundColor Red
            return $false
        }
        
        # 출력 디렉토리 생성
        if (-not (Test-Path $OutputDir)) {
            Write-VerboseMessage "Creating output directory: $OutputDir"
            New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
        }
        
        # PNG 저장 옵션 설정
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        
        # 레이어를 PNG로 저장 시도 (여러 방법 사용)
        $success = $false
        
        # 방법 3: 픽셀 데이터 직접 처리 (먼저 시도)
        try {
            Write-VerboseMessage "Attempting method 3: Direct pixel processing..."
            
            $bounds = $targetLayer.Bounds
            $pixels = $targetLayer.LoadArgb32Pixels($bounds)
            
            if ($pixels -and $pixels.Length -gt 0) {
                Add-Type -AssemblyName System.Drawing
                $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
                
                try {
                    $bmpData = $bitmap.LockBits(
                        (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                        [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
                    )
                    
                    try {
                        [System.Runtime.InteropServices.Marshal]::Copy($pixels, 0, $bmpData.Scan0, $pixels.Length)
                    } finally {
                        $bitmap.UnlockBits($bmpData)
                    }
                    
                    $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
                    
                    if (Test-Path $outputPath) {
                        $success = $true
                        Write-VerboseMessage "Method 3 succeeded"
                    }
                } finally {
                    $bitmap.Dispose()
                }
            }
        } catch {
            Write-VerboseMessage "Method 3 failed: $($_.Exception.Message)"
        }
        
        # 방법 2: 합성 저장 후 크롭
        if (-not $success) {
            try {
                Write-VerboseMessage "Attempting method 2: Composite and crop..."
                
                # 모든 레이어 숨기고 대상 레이어만 표시
                $originalVisibility = @()
                for ($i = 0; $i -lt $psdImage.Layers.Length; $i++) {
                    $originalVisibility += $psdImage.Layers[$i].IsVisible
                    $psdImage.Layers[$i].IsVisible = $false
                }
                $targetLayer.IsVisible = $true
                
                # 임시 파일로 전체 이미지 저장
                $tempPath = [System.IO.Path]::ChangeExtension($outputPath, ".temp.png")
                $psdImage.Save($tempPath, $pngOptions)
                
                if (Test-Path $tempPath) {
                    # System.Drawing으로 크롭
                    Add-Type -AssemblyName System.Drawing
                    $fullImage = [System.Drawing.Image]::FromFile($tempPath)
                    
                    try {
                        # 크롭 영역 계산 (캔버스 범위로 제한)
                        $cropX = [Math]::Max(0, $targetLayer.Left)
                        $cropY = [Math]::Max(0, $targetLayer.Top)
                        $cropW = [Math]::Min($targetLayer.Width, $psdImage.Width - $cropX)
                        $cropH = [Math]::Min($targetLayer.Height, $psdImage.Height - $cropY)
                        
                        if ($cropW -gt 0 -and $cropH -gt 0) {
                            $cropRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
                            $croppedImage = New-Object System.Drawing.Bitmap($cropW, $cropH)
                            $graphics = [System.Drawing.Graphics]::FromImage($croppedImage)
                            
                            $graphics.DrawImage($fullImage, 0, 0, $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
                            $graphics.Dispose()
                            
                            $croppedImage.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
                            $croppedImage.Dispose()
                            
                            if (Test-Path $outputPath) {
                                $success = $true
                                Write-VerboseMessage "Method 2 succeeded"
                            }
                        }
                    } finally {
                        $fullImage.Dispose()
                        Remove-Item $tempPath -Force -ErrorAction SilentlyContinue
                    }
                }
                
                # 가시성 복구
                for ($i = 0; $i -lt $psdImage.Layers.Length; $i++) {
                    $psdImage.Layers[$i].IsVisible = $originalVisibility[$i]
                }
                
            } catch {
                Write-VerboseMessage "Method 2 failed: $($_.Exception.Message)"
            }
        }
        
        # 방법 1: 직접 레이어 저장 (마지막 시도)
        if (-not $success) {
            try {
                Write-VerboseMessage "Attempting method 1: Direct layer save..."
                $targetLayer.Save($outputPath, $pngOptions)
                if (Test-Path $outputPath) {
                    $success = $true
                    Write-VerboseMessage "Method 1 succeeded"
                }
            } catch {
                Write-VerboseMessage "Method 1 failed: $($_.Exception.Message)"
            }
        }
        
        if ($success) {
            $fileInfo = Get-Item $outputPath
            Write-Host "SUCCESS: $outputFileName ($($fileInfo.Length) bytes)" -ForegroundColor Green
            return $true
        } else {
            Write-Host "ERROR: Failed to extract layer '$TargetLayerName' from $baseName" -ForegroundColor Red
            return $false
        }
        
    } catch {
        Write-Host "ERROR: Failed to process $baseName - $($_.Exception.Message)" -ForegroundColor Red
        return $false
    } finally {
        if ($psdImage) {
            Write-VerboseMessage "Disposing PSD image resources..."
            $psdImage.Dispose()
        }
        
        # 메모리 정리
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }
}

# ===== 메인 실행 =====
$startTime = Get-Date
Write-Host "=== Background Layer Extraction Tool ===" -ForegroundColor Cyan
Write-Host "Started at: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
Write-Host ""

# 현재 디렉토리 표시
Write-Host "Current directory: $(Get-Location)" -ForegroundColor Gray

# Aspose.PSD 라이브러리 로드
Write-VerboseMessage "Loading Aspose.PSD library..."
if (-not (Load-AsposePSD)) {
    Write-Error "Failed to load Aspose.PSD library"
    exit 1
}

# 입력 경로 처리
$currentDir = Get-Location
if (-not [System.IO.Path]::IsPathRooted($InputPath)) {
    $InputPath = Join-Path $currentDir $InputPath
}

# 출력 디렉토리 설정
if (-not $OutputPath) {
    $OutputPath = $currentDir
} elseif (-not [System.IO.Path]::IsPathRooted($OutputPath)) {
    $OutputPath = Join-Path $currentDir $OutputPath
}

Write-Host "Input pattern: $InputPath" -ForegroundColor Gray
Write-Host "Output directory: $OutputPath" -ForegroundColor Gray
Write-Host "Target layer: $LayerName" -ForegroundColor Gray
Write-Host ""

# PSD 파일들 찾기
$psdFiles = @()
if ($InputPath.Contains("*") -or $InputPath.Contains("?")) {
    # 와일드카드 패턴 처리
    $psdFiles = Get-ChildItem -Path $InputPath -File | Where-Object { $_.Extension -eq ".psd" }
} else {
    # 단일 파일 또는 디렉토리 처리
    if (Test-Path $InputPath -PathType Container) {
        $psdFiles = Get-ChildItem -Path $InputPath -Filter "*.psd" -File
    } elseif (Test-Path $InputPath -PathType Leaf) {
        $psdFiles = @(Get-Item $InputPath)
    }
}

if ($psdFiles.Count -eq 0) {
    Write-Host "No PSD files found matching pattern: $InputPath" -ForegroundColor Red
    exit 1
}

Write-Host "Found $($psdFiles.Count) PSD file(s) to process:" -ForegroundColor Yellow
foreach ($file in $psdFiles) {
    Write-Host "  - $($file.Name)" -ForegroundColor White
}
Write-Host ""

# 각 PSD 파일 처리
$successCount = 0
$failCount = 0

foreach ($psdFile in $psdFiles) {
    Write-VerboseMessage "=" * 60
    if (Extract-BackgroundLayer -PsdPath $psdFile.FullName -OutputDir $OutputPath -TargetLayerName $LayerName) {
        $successCount++
    } else {
        $failCount++
    }
}

# 최종 결과 출력
$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host ""
Write-Host "=== Processing Complete ===" -ForegroundColor Cyan
Write-Host "Processed: $($psdFiles.Count) files" -ForegroundColor White
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor $(if ($failCount -gt 0) { "Red" } else { "White" })
Write-Host "Duration: $($duration.ToString('mm\:ss\.fff'))" -ForegroundColor Yellow
Write-Host "Ended at: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow

if ($failCount -gt 0) {
    Write-Host ""
    Write-Host "Some files failed to process. Use -Verbose for detailed error information." -ForegroundColor Yellow
}

exit $(if ($failCount -gt 0) { 1 } else { 0 })
