# Test Script #10: Creating Multiple Raster Layers with Patterns
# This script demonstrates creating a PSD file with several raster layers,
# each filled with a unique, programmatically generated pattern.

# . .\Load-AsposePSD.ps1

# 출력 디렉토리 확인 및 생성

$outputPsdPath = Join-Path ${pwd} "test/multi_pattern_layers.psd"
$outputPngPath = Join-Path ${pwd} "test/multi_pattern_layers_preview.png"
$psdImage = $null

try {
    Write-Host "=== Multiple Pattern Layers Demonstration ===" -ForegroundColor Cyan
    
    # Create a new PSD image
    $width = 800
    $height = 600
    Write-Host "Creating a new PSD image (${width}x${height})..." -ForegroundColor Yellow
    $psdImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    # 배경 레이어는 기본적으로 흰색으로 채워집니다.
    
    Write-Host "Creating pattern layers..." -ForegroundColor Green

    # === Layer #1: Geometric Pattern ===
    Write-Host "1. Creating geometric pattern layer..." -ForegroundColor White
    
    $geomLayer = $psdImage.AddRegularLayer()
    $geomLayer.DisplayName = "Geometric Pattern Layer"
    $geomLayer.Left = 50
    $geomLayer.Top = 50
    $geomLayer.Right = 250
    $geomLayer.Bottom = 250
    
    $patternWidth = $geomLayer.Width
    $patternHeight = $geomLayer.Height
    $patternPixels = New-Object 'int[]' ($patternWidth * $patternHeight)
    
    # Fill with geometric pattern
    for ($y = 0; $y -lt $patternHeight; $y++) {
        for ($x = 0; $x -lt $patternWidth; $x++) {
            $index = $y * $patternWidth + $x
            $checkSize = 25
            $checkX = [Math]::Floor($x / $checkSize)
            $checkY = [Math]::Floor($y / $checkSize)
            
            if (($checkX + $checkY) % 2 -eq 0) {
                $patternPixels[$index] = [Aspose.PSD.Color]::LightGray.ToArgb()
            } else {
                $patternPixels[$index] = [Aspose.PSD.Color]::DarkGray.ToArgb()
            }
        }
    }
    
    $geomRect = New-Object Aspose.PSD.Rectangle(0, 0, $patternWidth, $patternHeight)
    $geomLayer.SaveArgb32Pixels($geomRect, $patternPixels)
    
    # === Layer #2: Gradient Pattern ===
    Write-Host "2. Creating gradient pattern layer..." -ForegroundColor White
    
    $gradientLayer = $psdImage.AddRegularLayer()
    $gradientLayer.DisplayName = "Gradient Pattern Layer"
    $gradientLayer.Left = 300
    $gradientLayer.Top = 50
    $gradientLayer.Right = 500
    $gradientLayer.Bottom = 250
    
    $gradientWidth = $gradientLayer.Width
    $gradientHeight = $gradientLayer.Height
    $gradientPixels = New-Object 'int[]' ($gradientWidth * $gradientHeight)
    
    for ($y = 0; $y -lt $gradientHeight; $y++) {
        for ($x = 0; $x -lt $gradientWidth; $x++) {
            $index = $y * $gradientWidth + $x
            $ratio = $x / ($gradientWidth - 1)
            $r = [int](255 * $ratio)
            $g = 0
            $b = [int](255 * (1 - $ratio))
            $gradientPixels[$index] = [Aspose.PSD.Color]::FromArgb(255, $r, $g, $b).ToArgb() # Red to Blue gradient
        }
    }
    
    $gradientRect = New-Object Aspose.PSD.Rectangle(0, 0, $gradientWidth, $gradientHeight)
    $gradientLayer.SaveArgb32Pixels($gradientRect, $gradientPixels)
    
    # === Layer #3: Complex Wave Pattern ===
    Write-Host "3. Creating complex wave pattern layer..." -ForegroundColor White
    
    $complexLayer = $psdImage.AddRegularLayer()
    $complexLayer.DisplayName = "Complex Wave Pattern Layer"
    $complexLayer.Left = 150
    $complexLayer.Top = 300
    $complexLayer.Right = 650
    $complexLayer.Bottom = 550
    
    $complexWidth = $complexLayer.Width
    $complexHeight = $complexLayer.Height
    $complexPixels = New-Object 'int[]' ($complexWidth * $complexHeight)
    
    for ($y = 0; $y -lt $complexHeight; $y++) {
        for ($x = 0; $x -lt $complexWidth; $x++) {
            $index = $y * $complexWidth + $x
            $wave = [Math]::Sin(($x + $y) * 0.1)
            $intensity = [int](128 + $wave * 127)
            $complexPixels[$index] = [Aspose.PSD.Color]::FromArgb(255, $intensity, $intensity, 255).ToArgb() # Blueish wave
        }
    }
    
    $complexRect = New-Object Aspose.PSD.Rectangle(0, 0, $complexWidth, $complexHeight)
    $complexLayer.SaveArgb32Pixels($complexRect, $complexPixels)
    
    Write-Host "✓ All pattern layers created successfully." -ForegroundColor Green
    
    # Set layer properties for demonstration
    $gradientLayer.Opacity = 220
    $complexLayer.Opacity = 200
    
    # Save as PSD
    Write-Host "Saving PSD file: $outputPsdPath" -ForegroundColor Yellow
    $psdImage.Save($outputPsdPath)
    
    # Export as PNG for preview
    Write-Host "Exporting PNG preview: $outputPngPath" -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($outputPngPath, $pngOptions)
    
    Write-Host ""
    Write-Host "=== Multiple Pattern Layers Test Completed ===" -ForegroundColor Cyan
    Write-Host "Files created:" -ForegroundColor Yellow
    Write-Host "  - $outputPsdPath" -ForegroundColor White
    Write-Host "  - $outputPngPath" -ForegroundColor White

} catch {
    Write-Host ""
    Write-Host "Error during pattern layer creation: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
    exit 1
} finally {
    if ($psdImage) {
        $psdImage.Dispose()
    }
}

Write-Host ""
Write-Host "Script completed successfully!" -ForegroundColor Green