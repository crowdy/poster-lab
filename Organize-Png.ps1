param(
    [string]$PosterDir = "d:\poster",
    [string]$JsonDir = "d:\poster-json", 
    [string]$OutputBaseDir = "d:\poster\machine",
    [switch]$VerboseErrors,
    [switch]$Overwrite
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

Write-Host "Machine Character/Icon Organizer Starting..." -ForegroundColor Green
Write-Host "PSD Directory: $PosterDir" -ForegroundColor Cyan
Write-Host "JSON Directory: $JsonDir" -ForegroundColor Cyan
Write-Host "Output Base Directory: $OutputBaseDir" -ForegroundColor Cyan

# ===== Aspose.PSD 로더 (공통 함수 사용) =====
. "$PSScriptRoot\Load-AsposePSD.ps1"

# ===== 유틸 함수들 =====
function Should-IgnoreLayer { param($Layer)
    try {
        $hasNoImage = ($Layer.Bounds.Width -le 0) -or ($Layer.Bounds.Height -le 0)
        return (-not $Layer.IsVisible) -or ($Layer.Opacity -eq 0) -or $hasNoImage
    } catch { return $false }
}

function Get-LayerCategory { param([string]$LayerName)
    $name = $LayerName.ToLower()
    if ($name -match "chara_(main|sub)") { return "characters" }
    if ($name -match "machine-icon|machine_icon") { return "icon" }  
    if ($name -match "machine_(main|frame)|machine-frame") { return "machine" }
    return $null
}

function Generate-UniqueId { param([string]$LayerName, [int]$LayerIndex)
    $hash = [System.Security.Cryptography.MD5]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes("$LayerName-$LayerIndex"))
    return [System.BitConverter]::ToString($hash).Replace("-","").Substring(0,8).ToLower()
}

# ===== Method 6: 픽셀 직접 처리 (Extract-PNGFromPSD.ps1의 최신 버전) =====
function Save-LayerByPixelDirectProcessing {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format = 'png',
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) { 
            Write-Host "    === Method 6: 픽셀 데이터 직접 처리 ===" 
            Write-Host "    레이어: '$($Layer.Name)'"
            Write-Host "    바운드: $($Layer.Bounds.Width)x$($Layer.Bounds.Height)"
        }
        
        $bounds = $Layer.Bounds
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            if ($DebugMode) { Write-Host "    실패: 유효하지 않은 바운드" }
            return $false
        }
        
        # 출력 디렉토리 확인
        $outDir = [System.IO.Path]::GetDirectoryName($OutFile)
        if (-not (Test-Path $outDir)) {
            New-Item -ItemType Directory -Path $outDir -Force | Out-Null
        }
        
        # 1단계: 원본 픽셀 데이터 로드
        if ($DebugMode) { Write-Host "    1단계: 픽셀 데이터 로드 중..." }
        $pixels = $Layer.LoadArgb32Pixels($bounds)
        
        if (-not $pixels -or $pixels.Length -eq 0) {
            if ($DebugMode) { Write-Host "    실패: 픽셀 데이터 없음" }
            return $false
        }
        
        if ($DebugMode) { Write-Host "    로드됨: $($pixels.Length)개 픽셀" }
        
        # 2단계: 픽셀 데이터 분석
        if ($DebugMode) { Write-Host "    2단계: 픽셀 데이터 분석 중..." }
        
        $sampleSize = [Math]::Min(1000, $pixels.Length)
        $hasNonBlackPixels = $false
        $blackPixelCount = 0
        $hasVisibleContent = $false
        
        for ($i = 0; $i -lt $sampleSize; $i++) {
            $pixel = $pixels[$i]
            $a = ($pixel -shr 24) -band 0xFF
            $r = ($pixel -shr 16) -band 0xFF
            $g = ($pixel -shr 8) -band 0xFF
            $b = $pixel -band 0xFF
            
            # 알파가 0이 아니면 보이는 콘텐츠가 있음
            if ($a -gt 0) {
                $hasVisibleContent = $true
            }
            
            if ($r -ne 0 -or $g -ne 0 -or $b -ne 0) {
                $hasNonBlackPixels = $true
                break
            } else {
                $blackPixelCount++
            }
        }
        
        $blackRatio = $blackPixelCount / $sampleSize * 100
        if ($DebugMode) { 
            Write-Host "    분석 결과: 검은색 픽셀 비율 $($blackRatio.ToString('F1'))%, 보이는 콘텐츠: $hasVisibleContent" 
        }
        
        # 3단계: 레이어가 순수 검은색이고 보이는 콘텐츠가 없는 경우 합성 방법 시도
        if (-not $hasNonBlackPixels -and -not $hasVisibleContent) {
            if ($DebugMode) { Write-Host "    3단계: 비어있는 레이어 감지 - 합성 방법 시도" }
            
            # 합성 방법: 전체 이미지에서 해당 레이어만 보이게 한 후 추출
            $originalVisibility = @()
            for ($i = 0; $i -lt $Psd.Layers.Length; $i++) {
                $originalVisibility += $Psd.Layers[$i].IsVisible
                $Psd.Layers[$i].IsVisible = $false
            }
            $Layer.IsVisible = $true
            
            try {
                # 임시 합성 이미지 생성
                $tempFile = [System.IO.Path]::ChangeExtension($OutFile, ".temp.png")
                $tempPngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
                $tempPngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
                $Psd.Save($tempFile, $tempPngOptions)
                
                if (Test-Path $tempFile) {
                    # System.Drawing으로 크롭
                    Add-Type -AssemblyName System.Drawing
                    $fullImg = [System.Drawing.Image]::FromFile($tempFile)
                    
                    try {
                        # 크롭 영역 계산 (캔버스 범위 내로 제한)
                        $cropX = [Math]::Max(0, $bounds.Left)
                        $cropY = [Math]::Max(0, $bounds.Top)
                        $cropW = [Math]::Min($bounds.Width, $fullImg.Width - $cropX)
                        $cropH = [Math]::Min($bounds.Height, $fullImg.Height - $cropY)
                        
                        if ($cropW -gt 0 -and $cropH -gt 0) {
                            $cropRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
                            $croppedImg = New-Object System.Drawing.Bitmap($cropW, $cropH)
                            $graphics = [System.Drawing.Graphics]::FromImage($croppedImg)
                            $graphics.DrawImage($fullImg, 0, 0, $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
                            $graphics.Dispose()
                            
                            # 포맷에 따라 저장
                            if ($Format -eq 'png') {
                                $croppedImg.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
                            } else {
                                $croppedImg.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
                            }
                            $croppedImg.Dispose()
                            
                            if (Test-Path $OutFile) {
                                if ($DebugMode) { Write-Host "    성공: 합성+크롭 방법" }
                                return $true
                            }
                        }
                    } finally {
                        $fullImg.Dispose()
                        Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
                    }
                }
            } finally {
                # 가시성 복구
                for ($i = 0; $i -lt $Psd.Layers.Length; $i++) {
                    $Psd.Layers[$i].IsVisible = $originalVisibility[$i]
                }
            }
        }
        
        # 4단계: 직접 픽셀 데이터로 이미지 생성
        if ($DebugMode) { Write-Host "    4단계: System.Drawing으로 이미지 생성" }
        
        Add-Type -AssemblyName System.Drawing
        $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        
        try {
            $bmpData = $bitmap.LockBits(
                (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
            )
            
            try {
                # 픽셀 데이터를 비트맵에 복사
                [System.Runtime.InteropServices.Marshal]::Copy($pixels, 0, $bmpData.Scan0, $pixels.Length)
            } finally {
                $bitmap.UnlockBits($bmpData)
            }
            
            # 포맷에 따라 저장
            if ($Format -eq 'png') {
                $bitmap.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
            } else {
                $bitmap.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
            }
            
            if (Test-Path $OutFile) {
                if ($DebugMode) { 
                    $fileSize = (Get-Item $OutFile).Length
                    Write-Host "    성공: 직접 픽셀 처리 ($fileSize bytes)" 
                }
                return $true
            }
        } finally {
            $bitmap.Dispose()
        }
        
        if ($DebugMode) { Write-Host "    실패: 모든 방법 실패" }
        return $false
        
    } catch {
        if ($DebugMode) { Write-Host "    예외 발생: $($_.Exception.Message)" }
        return $false
    }
}

# ===== 폴백 함수 (Method 6이 실패할 경우를 위한 백업) =====
function Save-LayerByCompositeAndCrop {
    param($Psd, $Layer, [string]$OutFile, $Options, [switch]$DebugMode)

    # 현재 가시성 상태 백업
    $vis = @()
    for ($k=0; $k -lt $Psd.Layers.Length; $k++) { $vis += $Psd.Layers[$k].IsVisible }

    $tempFull = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($OutFile), ("__temp_full_{0:yyyyMMdd_HHmmss_fff}.png" -f (Get-Date)))

    try {
        if ($DebugMode) { Write-Host "    Trying composite and crop fallback method..." }
        
        # 모든 레이어 숨기고 타깃만 보이게
        for ($k=0; $k -lt $Psd.Layers.Length; $k++) { $Psd.Layers[$k].IsVisible = $false }
        $Layer.IsVisible = $true

        # 문서 전체를 임시 저장
        $Psd.Save($tempFull, $Options)
        
        if (-not (Test-Path $tempFull)) {
            if ($DebugMode) { Write-Host "    Failed to create temp file: $tempFull" }
            return $false
        }

        # 레이어 바운즈를 캔버스와 교차해서 크롭
        $bx = $Layer.Bounds.Left
        $by = $Layer.Bounds.Top
        $bw = $Layer.Bounds.Width
        $bh = $Layer.Bounds.Height

        # Aspose의 Bounds가 좌표를 음수로 가질 수 있으므로 캔버스와 교차
        $canvasW = $Psd.Width
        $canvasH = $Psd.Height

        $x = [Math]::Max(0, $bx)
        $y = [Math]::Max(0, $by)
        $w = [Math]::Min($bw, $canvasW - $x)
        $h = [Math]::Min($bh, $canvasH - $y)

        if ($w -le 0 -or $h -le 0) { 
            if ($DebugMode) { Write-Host "    Invalid crop dimensions: w=$w, h=$h" }
            return $false 
        }

        # System.Drawing으로 크롭
        Add-Type -AssemblyName System.Drawing
        $bmp = [System.Drawing.Bitmap]::FromFile($tempFull)
        try {
            $rect = New-Object System.Drawing.Rectangle($x, $y, $w, $h)
            $cropped = $bmp.Clone($rect, $bmp.PixelFormat)
            try {
                $cropped.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
                if ($DebugMode) { Write-Host "    Successfully saved cropped image" }
                return $true
            } finally {
                $cropped.Dispose()
            }
        } finally {
            $bmp.Dispose()
        }

    } catch {
        if ($DebugMode) { Write-Host "    Composite and crop failed: $($_.Exception.Message)" }
        return $false
    } finally {
        # 임시 파일 정리 및 가시성 복구
        if (Test-Path $tempFull) { Remove-Item -LiteralPath $tempFull -Force -ErrorAction SilentlyContinue }
        for ($k=0; $k -lt $Psd.Layers.Length; $k++) { $Psd.Layers[$k].IsVisible = $vis[$k] }
        
        # 강제 가비지 컬렉션 (메모리 해제)
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }
    
    return $false
}

# ===== 통합 레이어 저장 함수 =====
function Save-LayerWithBestMethod {
    param($Psd, $Layer, [string]$OutFile, $Options, [switch]$DebugMode)
    
    # Method 6: 픽셀 직접 처리 (우선순위 1)
    if (Save-LayerByPixelDirectProcessing -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format 'png' -DebugMode:$DebugMode) {
        return $true
    }
    
    # Method 5: 합성+크롭 (폴백)
    if (Save-LayerByCompositeAndCrop -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -DebugMode:$DebugMode) {
        return $true
    }
    
    # 기본 방법 (최후 수단)
    try {
        if ($DebugMode) { Write-Host "    Trying basic Layer.Save as final fallback..." }
        $Layer.Save($OutFile, $Options)
        if (Test-Path $OutFile) {
            if ($DebugMode) { Write-Host "    Success with basic Layer.Save" }
            return $true
        }
    } catch {
        if ($DebugMode) { Write-Host "    Basic Layer.Save failed: $($_.Exception.Message)" }
    }
    
    return $false
}

# ===== 메인 처리 =====
Write-Host "Loading Aspose.PSD libraries..." -ForegroundColor Yellow
if (-not (Load-AsposePSD)) { Write-Error "Failed to load Aspose.PSD libraries"; exit 1 }

# 1단계: 단일 Machine JSON 파일 필터링
Write-Host "Analyzing JSON files for single machine PSDs..." -ForegroundColor Yellow
$singleMachineFiles = @()

Get-ChildItem "$JsonDir\*.json" | ForEach-Object {
    try {
        $json = Get-Content $_.FullName | ConvertFrom-Json
        if ($json.model_information -and $json.model_information.Count -eq 1) {
            $uuid = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
            $psdPath = Join-Path $PosterDir "$uuid.psd"
            
            if (Test-Path $psdPath) {
                $singleMachineFiles += @{
                    UUID = $uuid
                    PSDPath = $psdPath
                    MachineId = $json.model_information[0].machineId
                    MachineName = $json.model_information[0].machineName
                }
            }
        }
    } catch {
        Write-Warning "Error processing JSON $($_.Name): $_"
    }
}

Write-Host "Found $($singleMachineFiles.Count) single-machine PSD files" -ForegroundColor Green

# 2단계: 각 PSD 파일 처리
$processedCount = 0
$totalCount = $singleMachineFiles.Count
$successCount = 0
$failedCount = 0

foreach ($fileInfo in $singleMachineFiles) {
    $processedCount++
    Write-Progress -Activity "Processing PSD Files" -Status "File: $($fileInfo.UUID).psd" -PercentComplete (($processedCount / $totalCount) * 100)
    
    try {
        Write-Host "[$processedCount/$totalCount] Processing: $($fileInfo.UUID) (Machine: $($fileInfo.MachineId))" -ForegroundColor Cyan
        
        # PSD 로드
        $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
        $loadOptions.LoadEffectsResource = $true
        $loadOptions.UseDiskForLoadEffectsResource = $true
        
        $img = [Aspose.PSD.Image]::Load($fileInfo.PSDPath, $loadOptions)
        $psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
        $layers = $psd.Layers
        
        # PNG 옵션 (개선된 설정)
        $options = New-Object Aspose.PSD.ImageOptions.PngOptions
        $options.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        $options.CompressionLevel = 6
        
        # 레이어 분석 및 추출
        $layerSuccessCount = 0
        $layerFailedCount = 0
        
        for ($i = 0; $i -lt $layers.Length; $i++) {
            $layer = $layers[$i]
            
            # 그룹 레이어 건너뛰기
            if ($layer.GetType().FullName -like "*LayerGroup*") { continue }
            
            # 빈 레이어 건너뛰기
            if (Should-IgnoreLayer $layer) { continue }
            
            # 레이어 카테고리 확인
            $category = Get-LayerCategory $layer.Name
            if (-not $category) { continue }
            
            # 출력 경로 생성
            $machineDir = Join-Path $OutputBaseDir $fileInfo.MachineId
            $categoryDir = Join-Path $machineDir $category
            if (-not (Test-Path $categoryDir)) { New-Item -ItemType Directory -Path $categoryDir -Force | Out-Null }
            
            # 파일명 생성
            $uniqueId = Generate-UniqueId $layer.Name $i
            $fileName = "$($fileInfo.UUID)-$uniqueId.png"
            $outFile = Join-Path $categoryDir $fileName
            
            # 기존 파일 확인
            if ((Test-Path $outFile) -and (-not $Overwrite)) {
                Write-Host "  Skipped: $($layer.Name) (file exists)" -ForegroundColor Yellow
                continue
            }
            
            # Method 6 (픽셀 직접 처리)으로 이미지 추출
            if (Save-LayerWithBestMethod -Psd $psd -Layer $layer -OutFile $outFile -Options $options -DebugMode:$VerboseErrors) {
                Write-Host "  Extracted: $($layer.Name) -> $category/$fileName" -ForegroundColor Green
                $layerSuccessCount++
            } else {
                Write-Host "  Failed: $($layer.Name)" -ForegroundColor Red
                $layerFailedCount++
            }
        }
        
        $psd.Dispose()
        
        if ($layerSuccessCount -gt 0) {
            $successCount++
        }
        if ($layerFailedCount -gt 0) {
            $failedCount++
        }
        
        Write-Host "  Results: $layerSuccessCount extracted, $layerFailedCount failed" -ForegroundColor $(if ($layerSuccessCount -gt 0) { "Green" } else { "Yellow" })
        
    } catch {
        Write-Host "  Error processing $($fileInfo.UUID): $_" -ForegroundColor Red
        $failedCount++
    }
    
    # 메모리 관리
    if ($processedCount % 5 -eq 0) {
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        if ($VerboseErrors) { Write-Host "  Memory cleanup performed" -ForegroundColor DarkGray }
    }
}

Write-Progress -Activity "Processing PSD Files" -Completed

# 최종 결과 요약
Write-Host "`n=== Processing Summary ===" -ForegroundColor Yellow
Write-Host "Total PSD files processed: $processedCount" -ForegroundColor Cyan
Write-Host "Files with successful extractions: $successCount" -ForegroundColor Green
Write-Host "Files with failures: $failedCount" -ForegroundColor $(if ($failedCount -gt 0) { "Red" } else { "Green" })
Write-Host "Output directory: $OutputBaseDir" -ForegroundColor Cyan
Write-Host "Processing completed!" -ForegroundColor Green