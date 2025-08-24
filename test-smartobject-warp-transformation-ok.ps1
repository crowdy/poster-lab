# Test Script #14: Smart Object Warp Transformation Demonstration using Aspose.PSD API
# This script demonstrates applying actual warp transformations to a smart object.

# . .\Load-AsposePSD.ps1

$psdImage = $null
try {
    Write-Host "=== Smart Object Warp Transformation Demonstration (Corrected v7) ===" -ForegroundColor Cyan
    
    # 준비물: 간단한 빈 PSD 파일
    $templatePsdPath = Join-Path ${pwd} "test/template.psd"
    if (-not (Test-Path -Path $templatePsdPath)) {
        throw "Template file not found: '$templatePsdPath'. Please create a simple PSD file."
    }

    # 템플릿 PSD 로드
    Write-Host "Loading template PSD to initialize Smart Object Provider..." -ForegroundColor Yellow
    $psdImage = [Aspose.PSD.Image]::Load($templatePsdPath)
    
    # 기존 레이어 정리 (배경만 남김)
    for ($i = $psdImage.Layers.Length - 1; $i -ge 1; $i--) {
        $psdImage.RemoveLayer($i)
    }
    $psdImage.Resize(1000, 800) # 캔버스 크기 조정
    
    Write-Host "Creating base content layer..." -ForegroundColor Green

    # === 1. Create Base Layer to be converted to Smart Object ===
    $baseLayer = $psdImage.AddRegularLayer()
    $baseLayer.DisplayName = "Base Content for Smart Object"
    $baseWidth = 200
    $baseHeight = 200
    $baseLayer.Left = 50
    $baseLayer.Top = 50
    $baseLayer.Right = $baseLayer.Left + $baseWidth
    $baseLayer.Bottom = $baseLayer.Top + $baseHeight
    
    # Create grid pattern
    $basePixels = New-Object 'int[]' ($baseWidth * $baseHeight)
    for ($y = 0; $y -lt $baseHeight; $y++) {
        for ($x = 0; $x -lt $baseWidth; $x++) {
            $index = $y * $baseWidth + $x
            $isGridLine = ($x % 20 -eq 0) -or ($y % 20 -eq 0)
            if ($isGridLine) {
                $basePixels[$index] = [Aspose.PSD.Color]::Gray.ToArgb()
            } else {
                $basePixels[$index] = [Aspose.PSD.Color]::White.ToArgb()
            }
        }
    }
    
    $baseRect = New-Object Aspose.PSD.Rectangle(0, 0, $baseWidth, $baseHeight)
    $baseLayer.SaveArgb32Pixels($baseRect, $basePixels)
    Write-Host "✓ Base content layer created." -ForegroundColor Green
    
    # === 2. Convert Base Layer to Smart Object ===
    Write-Host "Converting base layer to a Smart Object..." -ForegroundColor Yellow
    $smartObjectLayer = $psdImage.SmartObjectProvider.ConvertToSmartObject($psdImage.Layers.Length - 1)
    $smartObjectLayer.DisplayName = "Warpable Smart Object"
    Write-Host "✓ Layer converted to Smart Object." -ForegroundColor Green
    
    # === 3. Create Warped Instances by Copying the Smart Object ===
    Write-Host "Applying various warp transformations..." -ForegroundColor Yellow
    
    # [수정] 'Bend' 속성을 올바른 API 속성인 'Value'로 변경
    $warpStyles = @(
        @{ Style = [Aspose.PSD.FileFormats.Psd.Layers.Warp.WarpStyles]::Arc; Value = 50; Name = "Arc Warp"; X = 50; Y = 300 },
        @{ Style = [Aspose.PSD.FileFormats.Psd.Layers.Warp.WarpStyles]::Flag; Value = 60; Name = "Flag Warp"; X = 300; Y = 300 },
        @{ Style = [Aspose.PSD.FileFormats.Psd.Layers.Warp.WarpStyles]::Wave; Value = 40; Name = "Wave Warp"; X = 550; Y = 300 },
        @{ Style = [Aspose.PSD.FileFormats.Psd.Layers.Warp.WarpStyles]::Fish; Value = -70; Name = "Fish Warp"; X = 800; Y = 300 }
    )
    
    foreach ($warpInfo in $warpStyles) {
        Write-Host "  - Applying '$($warpInfo.Name)'..." -ForegroundColor White
        
        $warpedLayer = $smartObjectLayer.NewSmartObjectViaCopy()
        $warpedLayer.DisplayName = $warpInfo.Name
        
        $warpedLayer.Left = $warpInfo.X
        $warpedLayer.Top = $warpInfo.Y
        $warpedLayer.Right = $warpedLayer.Left + $warpedLayer.Width
        $warpedLayer.Bottom = $warpedLayer.Top + $warpedLayer.Height
        
        # 실제 Warp 속성 적용
        $warpSettings = $warpedLayer.WarpSettings
        $warpSettings.Style = $warpInfo.Style
        
        # [수정] .Bend 대신 .Value 사용
        $warpSettings.Value = $warpInfo.Value
        
        # [수정] 불필요한 UpdateWarp() 메서드 호출 제거
    }
    
    # 원본 스마트 오브젝트는 숨김 처리
    $smartObjectLayer.IsVisible = $false
    
    Write-Host "✓ All warp transformations applied." -ForegroundColor Green
    
    # Save as PSD
    $outputPsdPath = Join-Path ${pwd} "test/smartobject_warp_demo.psd"
    Write-Host "Saving PSD file: $outputPsdPath" -ForegroundColor Yellow
    $psdImage.Save($outputPsdPath)
    
    # Export as PNG for preview
    $outputPngPath = Join-Path ${pwd} "test/smartobject_warp_demo_preview.png"
    Write-Host "Exporting PNG preview: $outputPngPath" -ForegroundColor Yellow
    
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.AllowWarpRepaint = $true
    
    $imageForPng = [Aspose.PSD.Image]::Load($outputPsdPath, $loadOptions)
    try {
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        $imageForPng.Save($outputPngPath, $pngOptions)
        Write-Host "✓ PNG preview exported successfully." -ForegroundColor Green
    } finally {
        if ($imageForPng) { $imageForPng.Dispose() }
    }

    Write-Host ""
    Write-Host "=== Smart Object Warp Transformation Test Results ===" -ForegroundColor Cyan
    Write-Host "✓ Created a base smart object from a raster layer." -ForegroundColor Green
    Write-Host "✓ Applied 4 different warp styles using Aspose.PSD's WarpSettings API." -ForegroundColor Green

} catch {
    Write-Host ""
    Write-Host "Error during smart object warp transformation test: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
    exit 1
} finally {
    if ($psdImage) {
        $psdImage.Dispose()
    }
}

Write-Host ""
Write-Host "Script completed successfully!" -ForegroundColor Green  