param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,                # PSD 경로 또는 PsdAnalysisData v2 JSON 경로

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,               # 결과 저장 폴더

    [Parameter(Mandatory = $false)]
    [ValidateSet('png','jpg')]
    [string]$Format = 'png',           # png | jpg

    [Parameter(Mandatory = $false)]
    [string]$LayerName,                # 특정 레이어명만 추출(옵션)

    [Parameter(Mandatory = $false)]
    [ValidateRange(0,6)]
    [int]$ExtractionMethod = 6,        # 추출 방법: 0=자동폴백(기본), 1=기본저장, 2=타입최적화, 3=강화픽셀, 4=기본픽셀, 5=합성크롭, 6=픽셀직접처리

    [switch]$Silent,                   # true면 콘솔에 JSON 경로만 출력
    [switch]$ResultJsonOnly,           # true면 이미지 저장 없이 JSON만 생성
    [switch]$VerboseErrors,            # 상세한 오류 정보 출력
    [switch]$Overwrite                 # 기존 파일이 있어도 덮어쓰기
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ===== Aspose.PSD 로더 (공통 함수 사용) =====
. "$PSScriptRoot\Load-AsposePSD.ps1"

# ===== 유틸 =====
function Should-IgnoreLayer { param($Layer)
    try {
        $hasNoImage = ($Layer.Bounds.Width -le 0) -or ($Layer.Bounds.Height -le 0)
        return (-not $Layer.IsVisible) -or ($Layer.Opacity -eq 0) -or $hasNoImage
    } catch { return $false }
}
function Sanitize-FileName { param([string]$Name)
    if ([string]::IsNullOrWhiteSpace($Name)) { return "_empty_" }
    
    # 줄바꿈 문자와 탭 문자 제거
    $Name = $Name -replace "`r`n|`r|`n", "_" -replace "`t", "_"
    
    # 연속된 공백을 하나로 변경
    $Name = $Name -replace "\s+", "_"
    
    # 파일명에서 사용할 수 없는 문자들 제거/변경
    $invalid = [System.IO.Path]::GetInvalidFileNameChars()
    foreach ($char in $invalid) {
        $Name = $Name.Replace($char, "_")
    }
    
    # 연속된 언더스코어를 하나로 변경
    $Name = $Name -replace "_+", "_"
    
    # 앞뒤 언더스코어 제거
    $Name = $Name.Trim('_')
    
    # 파일명이 너무 길면 자르기 (Windows 파일명 제한 고려)
    if ($Name.Length -gt 100) {
        $Name = $Name.Substring(0, 100)
    }
    
    if ([string]::IsNullOrWhiteSpace($Name)) { return "_invalid_" }
    return $Name
}
function Get-CleanErrorMessage { param($ErrorRecord, [switch]$DebugMode)
    $ex = $ErrorRecord.Exception
    $msg = if ($ex -and $ex.InnerException -and $ex.InnerException.Message) { $ex.InnerException.Message }
           elseif ($ex -and $ex.Message) { $ex.Message }
           else { "$ErrorRecord" }
    
    if ($DebugMode) {
        # 디버그 모드에서는 전체 오류 정보 반환
        $fullMsg = "Exception: $($ex.GetType().Name)"
        if ($ex.Message) { $fullMsg += " - $($ex.Message)" }
        if ($ex.InnerException) { $fullMsg += " | Inner: $($ex.InnerException.Message)" }
        if ($ErrorRecord.ScriptStackTrace) { $fullMsg += " | Stack: $($ErrorRecord.ScriptStackTrace.Split([Environment]::NewLine)[0])" }
        return $fullMsg
    }
    
    $msg = $msg -replace '^Exception calling .*?:\s*"', '' -replace '"$', '' -replace '\r?\n',' '
    $msg = $msg.Trim()
    if ($msg -match 'Image saving failed') { $msg = 'Image saving failed' }
    return $msg
}

# === 추출 방법들 ===

# Method 6: 픽셀 데이터 직접 처리 (새로운 기본 방법)
function Save-LayerByPixelDirectProcessing {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format,
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
                            
                            $croppedImg.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
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

# 폴백 1: 레이어 픽셀 데이터 추출 후 저장 (기존 Method 4)
function Save-LayerByPixelData {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) { Write-Host "    Trying pixel data extraction method..." }
        
        # 레이어 바운드 확인
        $bounds = $Layer.Bounds
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            if ($DebugMode) { Write-Host "    Invalid layer bounds" }
            return $false
        }
        
        # 레이어에서 픽셀 데이터 추출 시도
        try {
            $pixels = $Layer.LoadArgb32Pixels($bounds)
            if ($pixels -and $pixels.Length -gt 0) {
                # 새 래스터 이미지 생성
                $img = New-Object Aspose.PSD.Image($bounds.Width, $bounds.Height)
                $rasterImg = [Aspose.PSD.RasterImage]$img
                $rasterImg.SaveArgb32Pixels($rasterImg.Bounds, $pixels)
                $rasterImg.Save($OutFile, $Options)
                $img.Dispose()
                if ($DebugMode) { Write-Host "    Success with pixel data method" }
                return $true
            }
        } catch {
            if ($DebugMode) { Write-Host "    Pixel data extraction failed: $($_.Exception.Message)" }
        }
        
        return $false
    } catch {
        if ($DebugMode) { Write-Host "    Pixel data method failed: $($_.Exception.Message)" }
        return $false
    }
}

# 폴백 2: 합성 저장 + System.Drawing 크롭 (Method 5)
function Save-LayerByCompositeAndCrop {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format,
        [switch]$DebugMode
    )

    # 현재 가시성 상태 백업
    $vis = @()
    for ($k=0; $k -lt $Psd.Layers.Length; $k++) { $vis += $Psd.Layers[$k].IsVisible }

    $tempFull = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($OutFile), ("__temp_full_{0:yyyyMMdd_HHmmss_fff}.{1}" -f (Get-Date), $Format))

    try {
        if ($DebugMode) { Write-Host "    Trying composite and crop method..." }
        
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
                $cropped.Save($OutFile)
                if ($DebugMode) { Write-Host "    Successfully saved cropped image" }
            } finally {
                $cropped.Dispose()
            }
        } finally {
            $bmp.Dispose()
        }

        return $true
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
}

# 폴백 3: 레이어 타입별 최적화 처리 (Method 2)
function Save-LayerByTypeOptimized {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) { 
            Write-Host "    Trying type-optimized method for layer type: $($Layer.GetType().Name)..." 
        }
        
        $bounds = $Layer.Bounds
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            if ($DebugMode) { Write-Host "    Invalid bounds for type-optimized export" }
            return $false
        }
        
        # 출력 디렉토리 확인 및 생성
        $outDir = [System.IO.Path]::GetDirectoryName($OutFile)
        if (-not (Test-Path $outDir)) {
            New-Item -ItemType Directory -Path $outDir -Force | Out-Null
        }
        
        # 레이어 타입별 최적화 처리
        $layerType = $Layer.GetType().Name
        
        # 1. 기본 Layer.Save 시도 (마지막 수단)
        try {
            if ($DebugMode) { Write-Host "    Trying basic Layer.Save..." }
            $Layer.Save($OutFile, $Options)
            
            if (Test-Path $OutFile) {
                if ($DebugMode) { Write-Host "    Success with basic Layer.Save method" }
                return $true
            }
        } catch {
            if ($DebugMode) { Write-Host "    Basic Layer.Save failed: $($_.Exception.Message)" }
        }
        
        return $false
    } catch {
        if ($DebugMode) { Write-Host "    Type-optimized method failed: $($_.Exception.Message)" }
        return $false
    }
}

# 폴백 4: 강화된 픽셀 데이터 추출 (Method 3)
function Save-LayerByEnhancedPixelData {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) { Write-Host "    Trying enhanced pixel data extraction..." }
        
        $bounds = $Layer.Bounds
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            if ($DebugMode) { Write-Host "    Invalid bounds for pixel data extraction" }
            return $false
        }
        
        # 출력 디렉토리 확인 및 생성
        $outDir = [System.IO.Path]::GetDirectoryName($OutFile)
        if (-not (Test-Path $outDir)) {
            New-Item -ItemType Directory -Path $outDir -Force | Out-Null
        }
        
        # System.Drawing을 사용한 직접 비트맵 생성
        Add-Type -AssemblyName System.Drawing
        $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        
        try {
            # 비트맵 데이터 잠금
            $bmpData = $bitmap.LockBits(
                (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
            )
            
            try {
                # 레이어에서 픽셀 데이터 추출 시도
                $pixels = $Layer.LoadArgb32Pixels($bounds)
                if ($pixels -and $pixels.Length -gt 0) {
                    $expectedPixels = $bounds.Width * $bounds.Height
                    if ($pixels.Length -ge $expectedPixels) {
                        # 정확한 메모리 크기 계산
                        $bytesPerPixel = 4  # ARGB = 4 bytes
                        $totalBytes = $expectedPixels * $bytesPerPixel
                        
                        try {
                            [System.Runtime.InteropServices.Marshal]::Copy($pixels, 0, $bmpData.Scan0, $totalBytes)
                        } catch {
                            # Marshal.Copy 실패시 대안 사용
                            if ($DebugMode) { Write-Host "    Marshal.Copy failed: $($_.Exception.Message)" }
                            return $false
                        }
                    }
                }
            } finally {
                if ($bmpData) { $bitmap.UnlockBits($bmpData) }
            }
        } finally {
            $bitmap.Dispose()
        }
        
        return $false
    } catch {
        if ($DebugMode) { Write-Host "    Enhanced pixel data method failed: $($_.Exception.Message)" }
        return $false
    }
}

# 통합 레이어 저장 함수 (선택적 방법 또는 다중 폴백 적용)
function Save-LayerWithMultipleFallbacks {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [string]$OutFile,
        $Options,
        [ValidateSet('png','jpg')] [string]$Format,
        [int]$Method = 0,
        [switch]$DebugMode
    )
    
    if ($DebugMode) {
        Write-Host "  Attempting to save layer '$($Layer.Name)' (Type: $($Layer.GetType().Name))"
        Write-Host "  Bounds: $($Layer.Bounds.Left),$($Layer.Bounds.Top) - $($Layer.Bounds.Width)x$($Layer.Bounds.Height)"
        Write-Host "  Visible: $($Layer.IsVisible), Opacity: $($Layer.Opacity)"
        
        if ($Method -eq 0) {
            Write-Host "  Using automatic fallback method (trying all methods, starting with Method 6)"
        } else {
            $methodNames = @("", "기본 Aspose 저장", "레이어 타입별 최적화", "강화된 픽셀 데이터 추출", "기본 픽셀 데이터 추출", "합성 + 크롭", "픽셀 직접 처리")
            Write-Host "  Using specified method $Method`: $($methodNames[$Method])"
        }
    }
    
    # 특정 방법 지정시 해당 방법만 사용
    if ($Method -gt 0) {
        switch ($Method) {
            1 { # 방법 1: 기본 Aspose 저장
                try {
                    if ($DebugMode) { Write-Host "    Trying method 1: default Layer.Save... $OutFile" }
                    $Layer.Save($OutFile, $Options)
                    if (Test-Path $OutFile) {
                        if ($DebugMode) { Write-Host "    Success with method 1" }
                        return $true
                    }
                } catch {
                    if ($DebugMode) { Write-Host "    Method 1 failed: $(Get-CleanErrorMessage $_ -DebugMode:$DebugMode)" }
                }
                return $false
            }
            2 { # 방법 2: 레이어 타입별 최적화
                return Save-LayerByTypeOptimized -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode
            }
            3 { # 방법 3: 강화된 픽셀 데이터 추출
                return Save-LayerByEnhancedPixelData -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode
            }
            4 { # 방법 4: 기본 픽셀 데이터 추출
                return Save-LayerByPixelData -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode
            }
            5 { # 방법 5: 합성 + 크롭
                return Save-LayerByCompositeAndCrop -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode
            }
            6 { # 방법 6: 픽셀 직접 처리 (새로운 기본 방법)
                return Save-LayerByPixelDirectProcessing -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode
            }
        }
    }
    
    # Method = 0 (기본값): 자동 폴백 시스템 사용 (Method 6부터 시작)
    
    # 방법 6: 픽셀 직접 처리 (새로운 우선순위 1)
    if (Save-LayerByPixelDirectProcessing -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    # 방법 5: 합성 + 크롭
    if (Save-LayerByCompositeAndCrop -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    # 방법 1: 기본 Aspose 저장
    try {
        if ($DebugMode) { Write-Host "    Trying method 1: default Layer.Save... $OutFile" }
        $Layer.Save($OutFile, $Options)
        if (Test-Path $OutFile) {
            if ($DebugMode) { Write-Host "    Success with method 1" }
            return $true
        }
    } catch {
        if ($DebugMode) { Write-Host "    Method 1 failed: $(Get-CleanErrorMessage $_ -DebugMode:$DebugMode)" }
    }
    
    # 방법 2: 레이어 타입별 최적화
    if (Save-LayerByTypeOptimized -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    # 방법 4: 기본 픽셀 데이터 추출 (호환성을 위해 유지)
    if (Save-LayerByPixelData -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    # 방법 3: 강화된 픽셀 데이터 추출
    if (Save-LayerByEnhancedPixelData -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    if ($DebugMode) { Write-Host "  All fallback methods failed for layer '$($Layer.Name)'" }
    return $false
}

# ===== 메인 =====
$startTime = Get-Date
Write-Host "Starting PSD layer extraction at $startTime"

# print pwd
Write-Host "Current directory: $(Get-Location)"

# 추출 방법 표시
if ($ExtractionMethod -eq 0) {
    Write-Host "Extraction method: Automatic fallback (starts with Method 6 - Pixel Direct Processing)"
} else {
    $methodNames = @("", "기본 Aspose 저장", "레이어 타입별 최적화", "강화된 픽셀 데이터 추출", "기본 픽셀 데이터 추출", "합성 + 크롭", "픽셀 직접 처리")
    Write-Host "Extraction method: $ExtractionMethod ($($methodNames[$ExtractionMethod]))"
}

if ($Overwrite) {
    Write-Host "Overwrite mode: ON (existing files will be replaced)"
} else {
    Write-Host "Overwrite mode: OFF (existing files will be skipped)"
}

if (-not (Test-Path $InputFile)) { Write-Error "Input file not found: $InputFile"; exit 1 }

# OutputPath가 상대 경로인 경우 현재 작업 디렉토리 기준으로 변환
if (-not [System.IO.Path]::IsPathRooted($OutputPath)) {
    $OutputPath = Join-Path (Get-Location).Path $OutputPath
}

if (-not (Test-Path $OutputPath)) { Write-Host "Creating output directory: $OutputPath"; New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null }

if (-not (Load-AsposePSD)) { Write-Error "Aspose.PSD libraries load failed."; exit 1 }

# JSON(v2) 입력 지원
$isJsonInput = $InputFile.EndsWith(".json", [System.StringComparison]::OrdinalIgnoreCase)
if ($isJsonInput) {
    try {
        $json = Get-Content -LiteralPath $InputFile -Raw -Encoding UTF8 | ConvertFrom-Json
        if (-not $json) { throw "Failed to parse JSON." }
        if (-not $json.Version -or $json.Version -ne "v2") { Write-Warning "Input JSON version is not v2." }
        $jsonDir = Split-Path -Parent (Resolve-Path -LiteralPath $InputFile).Path
        $psdRel  = $json.Filename
        if ([string]::IsNullOrWhiteSpace($psdRel)) { throw "JSON에 Filename이 없습니다." }
        $psdPath = Join-Path $jsonDir $psdRel
        if (-not (Test-Path $psdPath)) { throw "Referenced PSD not found: $psdPath" }
        $InputFile = $psdPath
    } catch { Write-Error "Error processing JSON file: $_"; exit 1 }
}

# 효과/스타일까지 로드 (정확한 네임스페이스)
$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

$result = [ordered]@{
    InputFile       = (Resolve-Path -LiteralPath $InputFile).Path
    OutputPath      = (Resolve-Path -LiteralPath $OutputPath).Path
    Format          = $Format
    StartTime       = $startTime.ToString("o")
    EndTime         = $null
    Duration        = $null
    TotalLayers     = 0
    ExtractedCount  = 0
    SkippedCount    = 0
    EmptyCount      = 0
    FailedCount     = 0
    ExtractedLayers = @()
    FailedLayers    = @()
    SkippedLayers   = @()
    EmptyLayers     = @()
}

try {
    $img = [Aspose.PSD.Image]::Load($result.InputFile, $loadOptions)
    $psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    $layers = $psd.Layers
    $result.TotalLayers = $layers.Length
    Write-Host "PSD loaded. Total layers: $($layers.Length)"
    
    $options = if ($Format -eq 'jpg') { New-Object Aspose.PSD.ImageOptions.JpegOptions } else { New-Object Aspose.PSD.ImageOptions.PngOptions }

    if ($LayerName) {
        $target = $layers | Where-Object { $_.Name -eq $LayerName } | Select-Object -First 1
        if (-not $target) {
            Write-Error "Layer not found: $LayerName"
            $psd.Dispose(); throw "Layer not found"
        }
        $san = Sanitize-FileName -Name $LayerName
        $outFile = (Resolve-Path -Path (Join-Path $OutputPath "$san.$Format") -ErrorAction SilentlyContinue).Path
        if (-not $outFile) {
            $outFile = [System.IO.Path]::GetFullPath((Join-Path $OutputPath "$san.$Format"))
        }

        if ((Test-Path $outFile) -and (-not $Overwrite)) {
            $result.SkippedLayers += "Layer '$LayerName' - file already exists"; $result.SkippedCount = 1
        } else {
            if (-not $ResultJsonOnly) {
                if (Save-LayerWithMultipleFallbacks -Psd $psd -Layer $target -OutFile $outFile -Options $options -Format $Format -Method $ExtractionMethod -DebugMode:$VerboseErrors) {
                    $result.ExtractedLayers += [ordered]@{
                        Name=$target.Name; FilePath=$outFile; LayerIndex=[array]::IndexOf($layers,$target)
                        Bounds=[ordered]@{Left=$target.Bounds.Left;Top=$target.Bounds.Top;Right=$target.Bounds.Right;Bottom=$target.Bounds.Bottom}
                    }; $result.ExtractedCount++
                } else {
                    $errorMsg = if ($ExtractionMethod -gt 0) { "Layer '$LayerName' - Method $ExtractionMethod failed" } else { "Layer '$LayerName' - All extraction methods failed" }
                    $result.FailedLayers += $errorMsg; $result.FailedCount++
                    if ($VerboseErrors) { Write-Host "ERROR: $errorMsg" }
                }
            }
        }
    } else {
        Write-Host "Extracting all layers..."
        for ($i=0; $i -lt $layers.Length; $i++) {
            $layer = $layers[$i]

            if ($layer.GetType().FullName -like "*LayerGroup*") {
                $result.SkippedLayers += "Layer $i '$($layer.Name)' - layer group (no image extraction needed)"; $result.SkippedCount++; continue
            }

            $name = if ([string]::IsNullOrWhiteSpace($layer.Name)) { "<empty_layer_$i>" } else { $layer.Name }

            if (Should-IgnoreLayer $layer) {
                $reason = if (-not $layer.IsVisible) {"layer is not visible"} elseif ($layer.Opacity -eq 0) {"layer opacity is 0"} else {"empty bounds (Width: $($layer.Bounds.Width), Height: $($layer.Bounds.Height))"}
                $result.EmptyLayers += "Layer $i '$name' - $reason"; $result.EmptyCount++; continue
            }

            $san = Sanitize-FileName -Name $name
            $file = Join-Path $OutputPath ("layer_{0:D3}_{1}.{2}" -f $i, $san, $Format)
            # 절대 경로로 변환
            $file = (Resolve-Path -Path $file -ErrorAction SilentlyContinue).Path
            if (-not $file) {
                $file = [System.IO.Path]::GetFullPath((Join-Path $OutputPath ("layer_{0:D3}_{1}.{2}" -f $i, $san, $Format)))
            }
            
            if ((Test-Path $file) -and (-not $Overwrite)) { 
                $result.SkippedLayers += "Layer $i '$name' - file already exists"; $result.SkippedCount++; continue 
            }

            if (-not $ResultJsonOnly) {
                if (Save-LayerWithMultipleFallbacks -Psd $psd -Layer $layer -OutFile $file -Options $options -Format $Format -Method $ExtractionMethod -DebugMode:$VerboseErrors) {
                    $result.ExtractedLayers += [ordered]@{
                        Name=$layer.Name; FilePath=$file; LayerIndex=$i
                        Bounds=[ordered]@{Left=$layer.Bounds.Left;Top=$layer.Bounds.Top;Right=$layer.Bounds.Right;Bottom=$layer.Bounds.Bottom}
                    }
                    $result.ExtractedCount++
                } else {
                    $errorMsg = if ($ExtractionMethod -gt 0) { "Layer $i '$name' - Method $ExtractionMethod failed" } else { "Layer $i '$name' - All extraction methods failed" }
                    $result.FailedLayers += $errorMsg; $result.FailedCount++
                    if ($VerboseErrors) { Write-Host "ERROR: $errorMsg" }
                    continue
                }
            } else {
                # ResultJsonOnly 모드에서도 성공한 것으로 간주
                $result.ExtractedLayers += [ordered]@{
                    Name=$layer.Name; FilePath=$file; LayerIndex=$i
                    Bounds=[ordered]@{Left=$layer.Bounds.Left;Top=$layer.Bounds.Top;Right=$layer.Bounds.Right;Bottom=$layer.Bounds.Bottom}
                }
                $result.ExtractedCount++
            }
            
            # 메모리 관리: 매 10개 레이어마다 가비지 컬렉션 수행
            if (($i + 1) % 10 -eq 0) {
                [System.GC]::Collect()
                [System.GC]::WaitForPendingFinalizers()
                if ($VerboseErrors) { Write-Host "  Memory cleanup performed (processed $($i + 1) layers)" }
            }
        }
    }

    $end = Get-Date
    $result.EndTime  = $end.ToString("o")
    $result.Duration = ($end - $startTime).ToString()

    $inputName = [System.IO.Path]::GetFileNameWithoutExtension($result.InputFile)
    $ts = (Get-Date $startTime).ToString("yyyyMMdd_HHmmss")
    $jsonName = "extraction_result_{0}_{1}.json" -f $inputName, $ts
    $jsonPath = Join-Path $OutputPath $jsonName
    ($result | ConvertTo-Json -Depth 8) | Set-Content -LiteralPath $jsonPath -Encoding UTF8
    Write-Host "Extraction result saved to: $jsonPath"

    if ($Silent) { Write-Output $jsonPath } else { Write-Output (Get-Content $jsonPath -Raw -Encoding UTF8) }
    $psd.Dispose()
}
catch {
    $errorMsg = if ($VerboseErrors) { Get-CleanErrorMessage $_ -DebugMode } else { Get-CleanErrorMessage $_ }
    Write-Error "Error processing PSD file: $errorMsg"
    exit 1
}