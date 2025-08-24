# Test script for text layer properties using Aspose.PSD
# Demonstrates accessing and modifying text layer properties like font, size, style

# Load Aspose.PSD assembly
# . .\Load-AsposePSD.ps1

# Input and output paths
$inputPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$outputPath = join-path ${pwd} "test_text-properties.psd"
$previewPath = join-path ${pwd} "test_text-properties_preview.png"

Write-Host "Starting text layer properties test..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::Load($inputPath, $loadOptions)
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # 1. Create text layer and examine default properties
    Write-Host "Creating text layer to examine properties..." -ForegroundColor Cyan
    
    $textRect1 = New-Object Aspose.PSD.Rectangle(50, 50, 400, 60)
    $textLayer1 = $psdImage.AddTextLayer("Sample Text for Property Analysis", $textRect1)
    $textLayer1.DisplayName = "Property Analysis Text"
    
    Write-Host "Created text layer for property analysis" -ForegroundColor Green
    
    # 2. Access and display basic text properties
    Write-Host "Examining basic text properties..." -ForegroundColor Cyan
    
    Write-Host "Text Layer Basic Properties:" -ForegroundColor White
    Write-Host "  Display Name: $($textLayer1.DisplayName)" -ForegroundColor Gray
    Write-Host "  Text Content: '$($textLayer1.Text)'" -ForegroundColor Gray
    Write-Host "  Layer Bounds: Left=$($textLayer1.Left), Top=$($textLayer1.Top), Width=$($textLayer1.Width), Height=$($textLayer1.Height)" -ForegroundColor Gray
    Write-Host "  Opacity: $($textLayer1.Opacity)" -ForegroundColor Gray
    Write-Host "  Visible: $($textLayer1.Visible)" -ForegroundColor Gray
    Write-Host "  Blend Mode: $($textLayer1.BlendModeKey)" -ForegroundColor Gray
    
    # 3. Access text data properties (font, size, etc.)
    Write-Host "Accessing advanced text properties through TextData..." -ForegroundColor Cyan
    
    try {
        if ($textLayer1.TextData) {
            $textData = $textLayer1.TextData
            Write-Host "TextData Properties:" -ForegroundColor White
            Write-Host "  Text: '$($textData.Text)'" -ForegroundColor Gray
            Write-Host "  Items Count: $($textData.Items.Count)" -ForegroundColor Gray
            
            # Examine text portions (style runs)
            if ($textData.Items -and $textData.Items.Count -gt 0) {
                for ($i = 0; $i -lt $textData.Items.Count; $i++) {
                    $item = $textData.Items[$i]
                    Write-Host "  Text Item $($i):" -ForegroundColor Yellow
                    Write-Host "    Text: '$($item.Text)'" -ForegroundColor Gray
                    
                    # Try to access style properties
                    try {
                        if ($item.Style) {
                            Write-Host "    Font Name: $($item.Style.FontName)" -ForegroundColor Gray
                            Write-Host "    Font Size: $($item.Style.FontSize)" -ForegroundColor Gray
                            Write-Host "    Leading: $($item.Style.Leading)" -ForegroundColor Gray
                            Write-Host "    Tracking: $($item.Style.Tracking)" -ForegroundColor Gray
                        }
                    } catch {
                        Write-Host "    Style properties not accessible for this item" -ForegroundColor Yellow
                    }
                }
            }
        } else {
            Write-Host "TextData not available for this layer" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error accessing TextData: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # 4. Create text layer with specific properties
    Write-Host "Creating text layer with custom properties..." -ForegroundColor Cyan
    
    $textRect2 = New-Object Aspose.PSD.Rectangle(50, 150, 500, 80)
    $textLayer2 = $psdImage.AddTextLayer("Text with Custom Properties", $textRect2)
    $textLayer2.DisplayName = "Custom Properties Text"
    
    # Modify basic layer properties
    $textLayer2.Opacity = 180  # ~70% opacity
    $textLayer2.BlendModeKey = [Aspose.PSD.FileFormats.Psd.BlendMode]::Multiply
    
    Write-Host "Created text layer with custom opacity and blend mode" -ForegroundColor Green
    
    # 5. Demonstrate text measurement and bounds
    Write-Host "Analyzing text measurement and bounds..." -ForegroundColor Cyan
    
    $measurementText = "Measurement Test Text"
    $measureRect = New-Object Aspose.PSD.Rectangle(50, 270, 400, 60)
    $textLayer3 = $psdImage.AddTextLayer($measurementText, $measureRect)
    $textLayer3.DisplayName = "Measurement Text"
    
    Write-Host "Text Measurement Properties:" -ForegroundColor White
    Write-Host "  Text Length: $($measurementText.Length) characters" -ForegroundColor Gray
    Write-Host "  Layer Width: $($textLayer3.Width) pixels" -ForegroundColor Gray
    Write-Host "  Layer Height: $($textLayer3.Height) pixels" -ForegroundColor Gray
    Write-Host "  Text Bounds: $($textLayer3.Bounds)" -ForegroundColor Gray
    
    # 6. Create text with different alignment properties
    Write-Host "Creating text layers with different alignment..." -ForegroundColor Cyan
    
    # Left-aligned text
    $leftAlignRect = New-Object Aspose.PSD.Rectangle(50, 370, 200, 50)
    $leftAlignLayer = $psdImage.AddTextLayer("Left Aligned", $leftAlignRect)
    $leftAlignLayer.DisplayName = "Left Aligned Text"
    
    # Center text (simulated by positioning)
    $centerRect = New-Object Aspose.PSD.Rectangle(300, 370, 200, 50)
    $centerLayer = $psdImage.AddTextLayer("Center Text", $centerRect)
    $centerLayer.DisplayName = "Center Text"
    
    # Right-aligned text (simulated by positioning)
    $rightRect = New-Object Aspose.PSD.Rectangle(550, 370, 200, 50)
    $rightLayer = $psdImage.AddTextLayer("Right Text", $rightRect)
    $rightLayer.DisplayName = "Right Text"
    
    Write-Host "Created text layers with different alignment positions" -ForegroundColor Green
    
    # 7. Modify text layer properties programmatically
    Write-Host "Modifying text layer properties..." -ForegroundColor Cyan
    
    # Change position
    $textLayer1.Left += 10
    $textLayer1.Top += 5
    Write-Host "Repositioned first text layer" -ForegroundColor Yellow
    
    # Change size
    $textLayer2.Right = $textLayer2.Left + 600
    $textLayer2.Bottom = $textLayer2.Top + 100
    Write-Host "Resized second text layer" -ForegroundColor Yellow
    
    # Change visibility
    $originalVisibility = $textLayer3.Visible
    $textLayer3.Visible = false
    Write-Host "Changed visibility of measurement text layer to: $($textLayer3.Visible)" -ForegroundColor Yellow
    # Restore visibility for output
    $textLayer3.Visible = $originalVisibility
    
    # 8. Analyze all text layers in the document
    Write-Host "Analyzing all text layers in document..." -ForegroundColor Cyan
    
    $textLayerCount = 0
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $textLayerCount++
            $textLayer = [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
            
            Write-Host "Text Layer #$textLayerCount - $($textLayer.DisplayName):" -ForegroundColor White
            Write-Host "  Position: ($($textLayer.Left), $($textLayer.Top))" -ForegroundColor Gray
            Write-Host "  Size: $($textLayer.Width)x$($textLayer.Height)" -ForegroundColor Gray
            Write-Host "  Text Length: $($textLayer.Text.Length) chars" -ForegroundColor Gray
            Write-Host "  Opacity: $($textLayer.Opacity) ($([math]::Round($textLayer.Opacity/255*100))%)" -ForegroundColor Gray
            Write-Host "  Visible: $($textLayer.Visible)" -ForegroundColor Gray
        }
    }
    
    Write-Host "Found $textLayerCount text layers in total" -ForegroundColor Green
    
    # 9. Create summary text layer with document info
    Write-Host "Creating document summary text layer..." -ForegroundColor Cyan
    
    $summaryText = "Document: $textLayerCount text layers, Canvas: $($psdImage.Width)x$($psdImage.Height)"
    $summaryRect = New-Object Aspose.PSD.Rectangle(50, 500, 600, 40)
    $summaryLayer = $psdImage.AddTextLayer($summaryText, $summaryRect)
    $summaryLayer.DisplayName = "Document Summary"
    $summaryLayer.Opacity = 150  # Semi-transparent
    
    Write-Host "Created document summary layer" -ForegroundColor Green
    
    # 10. Property validation and error handling
    Write-Host "Performing property validation..." -ForegroundColor Cyan
    
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $textLayer = [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
            
            # Validate properties
            $isValid = $true
            $validationMessages = @()
            
            if ($textLayer.Width -le 0 -or $textLayer.Height -le 0) {
                $isValid = $false
                $validationMessages += "Invalid dimensions"
            }
            
            if ($textLayer.Opacity -lt 0 -or $textLayer.Opacity -gt 255) {
                $isValid = $false
                $validationMessages += "Invalid opacity value"
            }
            
            if ([string]::IsNullOrEmpty($textLayer.Text)) {
                $validationMessages += "Empty text content"
            }
            
            if ($validationMessages.Count -gt 0) {
                Write-Host "Layer '$($textLayer.DisplayName)' issues: $($validationMessages -join ', ')" -ForegroundColor Yellow
            }
        }
    }
    
    # Save results
    Write-Host "Finalizing text properties analysis..." -ForegroundColor Yellow
    
    # Save as PSD
    Write-Host "Saving PSD with analyzed text properties..." -ForegroundColor Yellow
    $psdImage.Save($outputPath)
    
    # Save PNG preview
    Write-Host "Saving PNG preview..." -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    
    Write-Host "Text properties analysis completed successfully!" -ForegroundColor Green
    Write-Host "Output PSD: $outputPath" -ForegroundColor White
    Write-Host "Preview PNG: $previewPath" -ForegroundColor White
    
    # Display operation summary
    Write-Host "`nText Properties Analysis Summary:" -ForegroundColor Magenta
    Write-Host "- Examined basic text layer properties" -ForegroundColor White
    Write-Host "- Accessed advanced TextData properties" -ForegroundColor White
    Write-Host "- Created text with custom properties" -ForegroundColor White
    Write-Host "- Analyzed text measurement and bounds" -ForegroundColor White
    Write-Host "- Demonstrated different text alignments" -ForegroundColor White
    Write-Host "- Modified text layer properties programmatically" -ForegroundColor White
    Write-Host "- Analyzed all text layers in document" -ForegroundColor White
    Write-Host "- Created document summary" -ForegroundColor White
    Write-Host "- Performed property validation" -ForegroundColor White
    
} catch {
    Write-Host "Error during text properties analysis: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "Text layer properties test completed." -ForegroundColor Green
