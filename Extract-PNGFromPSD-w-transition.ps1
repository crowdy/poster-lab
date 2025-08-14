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
    [ValidateRange(1,5)]
    [int]$ExtractionMethod = 2,        # 추출 방법: 0=자동폴백(기본), 1=기본저장, 2=타입최적화, 3=강화픽셀, 4=기본픽셀, 5=합성크롭

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

# ===== 레이어 정보 추출 함수 =====
function Get-LayerExtendedInfo {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        $Layer,
        [int]$LayerIndex
    )
    
    $layerBounds = $Layer.Bounds
    $canvasWidth = $Psd.Width
    $canvasHeight = $Psd.Height
    
    # 변환 정보 추출 시도
    $scaleX = 1.0
    $scaleY = 1.0
    $rotation = 0.0
    $skewX = 0.0
    $skewY = 0.0
    
    try {
        # Smart Object나 Transform이 있는 레이어에서 변환 정보 추출
        if ($Layer.GetType().GetProperty("Transform")) {
            $transform = $Layer.Transform
            if ($transform) {
                if ($transform.GetType().GetProperty("ScaleX")) { $scaleX = $transform.ScaleX }
                if ($transform.GetType().GetProperty("ScaleY")) { $scaleY = $transform.ScaleY }
                if ($transform.GetType().GetProperty("Rotation")) { $rotation = $transform.Rotation }
                if ($transform.GetType().GetProperty("SkewX")) { $skewX = $transform.SkewX }
                if ($transform.GetType().GetProperty("SkewY")) { $skewY = $transform.SkewY }
            }
        }
        
        # Free Transform 정보가 있는 경우 추출
        if ($Layer.GetType().GetProperty("FreeTransform")) {
            $freeTransform = $Layer.FreeTransform
            if ($freeTransform) {
                if ($freeTransform.GetType().GetProperty("ScaleX")) { $scaleX = $freeTransform.ScaleX }
                if ($freeTransform.GetType().GetProperty("ScaleY")) { $scaleY = $freeTransform.ScaleY }
                if ($freeTransform.GetType().GetProperty("Rotation")) { $rotation = $freeTransform.Rotation }
            }
        }
    } catch {
        # 변환 정보 추출 실패시 기본값 사용
    }
    
    # 블렌드 모드 추출
    $blendMode = "Normal"
    try {
        if ($Layer.GetType().GetProperty("BlendModeKey")) {
            $blendModeKey = $Layer.BlendModeKey
            if ($blendModeKey) {
                $blendMode = $blendModeKey.ToString()
            }
        }
    } catch { }
    
    # 레이어 타입 정보
    $layerType = $Layer.GetType().Name
    $isTextLayer = $layerType -like "*Text*"
    $isSmartObject = $layerType -like "*Smart*"
    $isShapeLayer = $layerType -like "*Shape*"
    $isAdjustmentLayer = $layerType -like "*Adjustment*"
    
    # 효과 정보 추출 시도
    $hasEffects = $false
    $effects = @()
    try {
        if ($Layer.GetType().GetProperty("BlendingOptions")) {
            $blendingOptions = $Layer.BlendingOptions
            if ($blendingOptions -and $blendingOptions.Effects) {
                $hasEffects = $blendingOptions.Effects.Count -gt 0
                foreach ($effect in $blendingOptions.Effects) {
                    $effects += $effect.GetType().Name
                }
            }
        }
    } catch { }
    
    return [ordered]@{
        Canvas = [ordered]@{
            Width = $canvasWidth
            Height = $canvasHeight
        }
        
        Position = [ordered]@{
            X = $layerBounds.Left
            Y = $layerBounds.Top
        }
        
        Size = [ordered]@{
            Width = $layerBounds.Width
            Height = $layerBounds.Height
        }
        
        Bounds = [ordered]@{
            Left = $layerBounds.Left
            Top = $layerBounds.Top
            Right = $layerBounds.Right
            Bottom = $layerBounds.Bottom
        }
        
        Transform = [ordered]@{
            ScaleX = $scaleX
            ScaleY = $scaleY
            Rotation = $rotation
            SkewX = $skewX
            SkewY = $skewY
        }
        
        Properties = [ordered]@{
            Opacity = $Layer.Opacity
            BlendMode = $blendMode
            IsVisible = $Layer.IsVisible
            LayerType = $layerType
            IsTextLayer = $isTextLayer
            IsSmartObject = $isSmartObject
            IsShapeLayer = $isShapeLayer
            IsAdjustmentLayer = $isAdjustmentLayer
        }
        
        Effects = [ordered]@{
            HasEffects = $hasEffects
            EffectTypes = $effects
        }
    }
}

# === 다중 폴백 시스템 ===

# 폴백 1: 레이어 픽셀 데이터 추출 후 저장
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

# 폴백 2: 합성 저장 + System.Drawing 크롭 (개선된 버전)
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

# 폴백 3: 레이어 타입별 최적화 처리
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
        
        # 1. ToBitmap 메서드 시도 (간단한 직접 저장)
        try {
            if ($Layer.GetType().GetMethod("ToBitmap")) {
                $bitmap = $Layer.ToBitmap()
                if ($bitmap) {
                    # 직접 저장 시도 (System.Drawing.Bitmap으로 캐스팅)
                    # $sysBitmap = [System.Drawing.Bitmap]$bitmap
                    $bitmap.Save($OutFile)
                    $bitmap.Dispose()
                    if ($DebugMode) { Write-Host "    Success with direct ToBitmap method" }
                    return $true
                }
            }
        } catch {
            if ($DebugMode) { Write-Host "    ToBitmap method failed: $($_.Exception.Message)" }
        }
        
        # 2. 텍스트 레이어 특별 처리
        if ($layerType -like "*Text*") {
            try {
                if ($DebugMode) { Write-Host "    Applying text layer optimization..." }
                # 텍스트 레이어는 래스터화 후 처리
                if ($Layer.GetType().GetMethod("DrawToBitmap")) {
                    $bitmap = $Layer.DrawToBitmap($bounds.Width, $bounds.Height)
                    $bitmap.Save($OutFile, $Options)
                    $bitmap.Dispose()
                    if ($DebugMode) { Write-Host "    Success with text layer optimization" }
                    return $true
                }
            } catch {
                if ($DebugMode) { Write-Host "    Text layer optimization failed: $($_.Exception.Message)" }
            }
        }
        
        # 3. 스마트 오브젝트 특별 처리
        if ($layerType -like "*Smart*") {
            try {
                if ($DebugMode) { Write-Host "    Applying smart object optimization..." }
                # 스마트 오브젝트는 내용을 먼저 로드
                if ($Layer.GetType().GetMethod("LoadContents")) {
                    $Layer.LoadContents()
                }
            } catch {
                if ($DebugMode) { Write-Host "    Smart object optimization failed: $($_.Exception.Message)" }
            }
        }
        
        return $false
    } catch {
        if ($DebugMode) { Write-Host "    Type-optimized method failed: $($_.Exception.Message)" }
        return $false
    }
}

# 폴백 4: 강화된 픽셀 데이터 추출
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
            Write-Host "  Using automatic fallback method (trying all methods)"
        } else {
            $methodNames = @("", "기본 Aspose 저장", "레이어 타입별 최적화", "강화된 픽셀 데이터 추출", "기본 픽셀 데이터 추출", "합성 + 크롭")
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
        }
    }
    
    # Method = 0 (기본값): 자동 폴백 시스템 사용
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
    
    # 방법 3: 강화된 픽셀 데이터 추출
    if (Save-LayerByEnhancedPixelData -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    # 방법 4: 기본 픽셀 데이터 추출 (호환성을 위해 유지)
    if (Save-LayerByPixelData -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
        return $true
    }
    
    # 방법 5: 합성 + 크롭
    if (Save-LayerByCompositeAndCrop -Psd $Psd -Layer $Layer -OutFile $OutFile -Options $Options -Format $Format -DebugMode:$DebugMode) {
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
    Write-Host "Extraction method: Automatic fallback (tries all methods)"
} else {
    $methodNames = @("", "기본 Aspose 저장", "레이어 타입별 최적화", "강화된 픽셀 데이터 추출", "기본 픽셀 데이터 추출", "합성 + 크롭")
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
                    # 확장된 레이어 정보 추출
                    $layerInfo = Get-LayerExtendedInfo -Psd $psd -Layer $target -LayerIndex ([array]::IndexOf($layers, $target))
                    
                    $result.ExtractedLayers += ([ordered]@{
                        Name = $target.Name
                        FilePath = $outFile
                        LayerIndex = [array]::IndexOf($layers, $target)
                    } + $layerInfo)
                    $result.ExtractedCount++
                } else {
                    $errorMsg = if ($ExtractionMethod -gt 0) { "Layer '$LayerName' - Method $ExtractionMethod failed" } else { "Layer '$LayerName' - All extraction methods failed" }
                    $result.FailedLayers += $errorMsg; $result.FailedCount++
                    if ($VerboseErrors) { Write-Host "ERROR: $errorMsg" }
                }
            } else {
                # ResultJsonOnly 모드에서도 레이어 정보 수집
                $layerInfo = Get-LayerExtendedInfo -Psd $psd -Layer $target -LayerIndex ([array]::IndexOf($layers, $target))
                
                $result.ExtractedLayers += ([ordered]@{
                    Name = $target.Name
                    FilePath = $outFile
                    LayerIndex = [array]::IndexOf($layers, $target)
                } + $layerInfo)
                $result.ExtractedCount++
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
                    # 확장된 레이어 정보 추출
                    $layerInfo = Get-LayerExtendedInfo -Psd $psd -Layer $layer -LayerIndex $i
                    
                    $result.ExtractedLayers += ([ordered]@{
                        Name = $layer.Name
                        FilePath = $file
                        LayerIndex = $i
                    } + $layerInfo)
                    $result.ExtractedCount++
                } else {
                    $errorMsg = if ($ExtractionMethod -gt 0) { "Layer $i '$name' - Method $ExtractionMethod failed" } else { "Layer $i '$name' - All extraction methods failed" }
                    $result.FailedLayers += $errorMsg; $result.FailedCount++
                    if ($VerboseErrors) { Write-Host "ERROR: $errorMsg" }
                    continue
                }
            } else {
                # ResultJsonOnly 모드에서도 성공한 것으로 간주하고 레이어 정보 수집
                $layerInfo = Get-LayerExtendedInfo -Psd $psd -Layer $layer -LayerIndex $i
                
                $result.ExtractedLayers += ([ordered]@{
                    Name = $layer.Name
                    FilePath = $file
                    LayerIndex = $i
                } + $layerInfo)
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


