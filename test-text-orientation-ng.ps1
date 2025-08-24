# test-text-orientation.ps1
# Demonstrates text orientation and alignment features in Aspose.PSD
# Script #9 of 18 - Text Layers: Orientation and Alignment

# Load Aspose.PSD
# . ".\Load-AsposePSD.ps1"

try {
    Write-Host "=== Text Orientation and Alignment Demo ===" -ForegroundColor Cyan
    
    # Create a new PSD image
    $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
    $psdOptions.Source = New-Object Aspose.PSD.Sources.StreamSource((New-Object System.IO.MemoryStream))
    
    $width = 800
    $height = 600
    
    Write-Host "Creating new PSD image (${width}x${height})..." -ForegroundColor Yellow
    $psdImage = [Aspose.PSD.Image]::Create($psdOptions, $width, $height)
    
    # Cast to PsdImage for layer operations
    $image = [Aspose.PSD.FileFormats.Psd.PsdImage]$psdImage
    
    # Create white background
    $backgroundColor = [Aspose.PSD.Color]::White
    $graphics = New-Object Aspose.PSD.Graphics($image)
    $graphics.Clear($backgroundColor)
    
    Write-Host "Demonstrating text orientations and alignments..." -ForegroundColor Green
    
    # 1. Horizontal text with different alignments
    Write-Host "1. Creating horizontal text with different alignments..." -ForegroundColor White
    
    # Left aligned
    $leftRect = New-Object Aspose.PSD.Rectangle(50, 50, 200, 40)
    $leftText = "Left Aligned"
    $leftLayer = $image.AddTextLayer($leftText, $leftRect)
    $leftLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Left
    $leftLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Blue
    $leftLayer.TextData.UpdateLayerData()
    
    # Center aligned
    $centerRect = New-Object Aspose.PSD.Rectangle(300, 50, 200, 40)
    $centerText = "Center Aligned"
    $centerLayer = $image.AddTextLayer($centerText, $centerRect)
    $centerLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Center
    $centerLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Green
    $centerLayer.TextData.UpdateLayerData()
    
    # Right aligned
    $rightRect = New-Object Aspose.PSD.Rectangle(550, 50, 200, 40)
    $rightText = "Right Aligned"
    $rightLayer = $image.AddTextLayer($rightText, $rightRect)
    $rightLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Right
    $rightLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Red
    $rightLayer.TextData.UpdateLayerData()
    
    # 2. Vertical text simulation (rotated text)
    Write-Host "2. Creating vertical text simulation..." -ForegroundColor White
    
    # Create vertical text by using smaller rectangles for each character
    $verticalText = "VERTICAL"
    $startY = 120
    
    for ($i = 0; $i -lt $verticalText.Length; $i++) {
        $char = $verticalText[$i]
        $charRect = New-Object Aspose.PSD.Rectangle(100, $startY + ($i * 35), 30, 30)
        $charLayer = $image.AddTextLayer($char, $charRect)
        $charLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Center
        $charLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Purple
        $charLayer.TextData.Items[0].Style.FontSize = 24
        $charLayer.TextData.UpdateLayerData()
    }
    
    # 3. Multi-line text with different vertical alignments
    Write-Host "3. Creating multi-line text with vertical alignments..." -ForegroundColor White
    
    # Top aligned multi-line text
    $topMultiRect = New-Object Aspose.PSD.Rectangle(200, 150, 150, 100)
    $topMultiText = "Top`nAligned`nText"
    $topMultiLayer = $image.AddTextLayer($topMultiText, $topMultiRect)
    $topMultiLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Center
    $topMultiLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Orange
    $topMultiLayer.TextData.UpdateLayerData()
    
    # Bottom aligned multi-line text simulation
    $bottomMultiRect = New-Object Aspose.PSD.Rectangle(380, 200, 150, 100)
    $bottomMultiText = "Bottom`nAligned`nText"
    $bottomMultiLayer = $image.AddTextLayer($bottomMultiText, $bottomMultiRect)
    $bottomMultiLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Center
    $bottomMultiLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Brown
    $bottomMultiLayer.TextData.UpdateLayerData()
    
    # 4. Diagonal text simulation
    Write-Host "4. Creating diagonal text simulation..." -ForegroundColor White
    
    $diagonalText = "DIAGONAL"
    $diagStartX = 200
    $diagStartY = 350
    
    for ($i = 0; $i -lt $diagonalText.Length; $i++) {
        $char = $diagonalText[$i]
        $charRect = New-Object Aspose.PSD.Rectangle($diagStartX + ($i * 25), $diagStartY + ($i * 15), 30, 30)
        $charLayer = $image.AddTextLayer($char, $charRect)
        $charLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Center
        $charLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkBlue
        $charLayer.TextData.Items[0].Style.FontSize = 20
        $charLayer.TextData.UpdateLayerData()
    }
    
    # 5. Justified text simulation
    Write-Host "5. Creating justified text simulation..." -ForegroundColor White
    
    $justifiedRect = New-Object Aspose.PSD.Rectangle(50, 450, 400, 80)
    $justifiedText = "This is a longer text that demonstrates justified alignment by spacing words evenly across the available width."
    $justifiedLayer = $image.AddTextLayer($justifiedText, $justifiedRect)
    $justifiedLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Justify
    $justifiedLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkGreen
    $justifiedLayer.TextData.Items[0].Style.FontSize = 14
    $justifiedLayer.TextData.UpdateLayerData()
    
    # 6. Curved text simulation (arc effect)
    Write-Host "6. Creating curved text simulation..." -ForegroundColor White
    
    $curvedText = "CURVED TEXT"
    $centerX = 600
    $centerY = 400
    $radius = 80
    
    for ($i = 0; $i -lt $curvedText.Length; $i++) {
        $char = $curvedText[$i]
        $angle = ($i - ($curvedText.Length / 2)) * 0.3  # Spread characters in arc
        $x = $centerX + [Math]::Cos($angle) * $radius - 15
        $y = $centerY + [Math]::Sin($angle) * $radius - 15
        
        $charRect = New-Object Aspose.PSD.Rectangle([int]$x, [int]$y, 30, 30)
        $charLayer = $image.AddTextLayer($char, $charRect)
        $charLayer.TextData.Items[0].Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.Layers.Text.HorizontalAlignment]::Center
        $charLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Crimson
        $charLayer.TextData.Items[0].Style.FontSize = 18
        $charLayer.TextData.UpdateLayerData()
    }
    
    # 7. Text with baseline alignment demonstration
    Write-Host "7. Creating baseline alignment demonstration..." -ForegroundColor White
    
    # Different font sizes on same baseline
    $baseY = 550
    $smallRect = New-Object Aspose.PSD.Rectangle(50, $baseY - 12, 80, 25)
    $mediumRect = New-Object Aspose.PSD.Rectangle(140, $baseY - 18, 120, 35)
    $largeRect = New-Object Aspose.PSD.Rectangle(270, $baseY - 24, 160, 45)
    
    $smallLayer = $image.AddTextLayer("Small", $smallRect)
    $smallLayer.TextData.Items[0].Style.FontSize = 12
    $smallLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Black
    $smallLayer.TextData.UpdateLayerData()
    
    $mediumLayer = $image.AddTextLayer("Medium", $mediumRect)
    $mediumLayer.TextData.Items[0].Style.FontSize = 18
    $mediumLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Black
    $mediumLayer.TextData.UpdateLayerData()
    
    $largeLayer = $image.AddTextLayer("Large", $largeRect)
    $largeLayer.TextData.Items[0].Style.FontSize = 24
    $largeLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Black
    $largeLayer.TextData.UpdateLayerData()
    
    # Add reference line for baseline
    $lineRect = New-Object Aspose.PSD.Rectangle(50, $baseY, 380, 1)
    $linePixels = New-Object 'Aspose.PSD.Color[]' ($lineRect.Width)
    for ($i = 0; $i -lt $linePixels.Length; $i++) {
        $linePixels[$i] = [Aspose.PSD.Color]::Gray
    }
    $image.SaveArgb32Pixels($lineRect, $linePixels)
    
    Write-Host "Text orientations and alignments created successfully!" -ForegroundColor Green
    
    # Save as PSD
    $outputPsd = "test/text_orientation_output.psd"
    Write-Host "Saving PSD file: $outputPsd" -ForegroundColor Yellow
    $image.Save($outputPsd)
    
    # Save as PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $outputPng = "test/text_orientation_preview.png"
    Write-Host "Saving PNG preview: $outputPng" -ForegroundColor Yellow
    $image.Save($outputPng, $pngOptions)
    
    Write-Host "=== Text Orientation Demo Completed Successfully ===" -ForegroundColor Cyan
    Write-Host "Output files:" -ForegroundColor White
    Write-Host "- PSD: $outputPsd" -ForegroundColor Gray
    Write-Host "- PNG: $outputPng" -ForegroundColor Gray
    
    # Display summary
    Write-Host "`nDemonstrations included:" -ForegroundColor White
    Write-Host "1. Horizontal alignments (Left, Center, Right)" -ForegroundColor Gray
    Write-Host "2. Vertical text simulation" -ForegroundColor Gray
    Write-Host "3. Multi-line text positioning" -ForegroundColor Gray
    Write-Host "4. Diagonal text effect" -ForegroundColor Gray
    Write-Host "5. Justified text alignment" -ForegroundColor Gray
    Write-Host "6. Curved text arc effect" -ForegroundColor Gray
    Write-Host "7. Baseline alignment with different font sizes" -ForegroundColor Gray
    
} catch {
    Write-Host "Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($image) {
        $image.Dispose()
        Write-Host "Resources disposed." -ForegroundColor Gray
    }
}

Write-Host "`nScript completed." -ForegroundColor Cyan
