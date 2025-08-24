# Test script for text formatting using Aspose.PSD
# Demonstrates advanced text formatting including font styles, sizes, and formatting options

# Load Aspose.PSD assembly
# . .\Load-AsposePSD.ps1

# Input and output paths
$inputPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$outputPath = join-path ${pwd} "test_text-formatting.psd"
$previewPath = join-path ${pwd} "test_text-formatting_preview.png"

Write-Host "Starting text formatting test..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::Load($inputPath, $loadOptions)
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # 1. Create text with basic formatting variations
    Write-Host "Creating text with basic formatting variations..." -ForegroundColor Cyan
    
    # Normal text
    $normalRect = New-Object Aspose.PSD.Rectangle(50, 50, 400, 50)
    $normalLayer = $psdImage.AddTextLayer("Normal Text Style", $normalRect)
    $normalLayer.DisplayName = "Normal Text"
    
    Write-Host "Created normal text layer" -ForegroundColor Green
    
    # 2. Simulate different font sizes by creating multiple text layers
    Write-Host "Creating text with different font sizes..." -ForegroundColor Cyan
    
    $fontSizes = @(
        @{Size = "Small"; Text = "Small Text (12pt equivalent)"; Height = 30},
        @{Size = "Medium"; Text = "Medium Text (16pt equivalent)"; Height = 40},
        @{Size = "Large"; Text = "Large Text (24pt equivalent)"; Height = 60},
        @{Size = "Extra Large"; Text = "Extra Large Text (36pt equivalent)"; Height = 80}
    )
    
    $yPosition = 120
    foreach ($fontSize in $fontSizes) {
        $sizeRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 500, $fontSize.Height)
        $sizeLayer = $psdImage.AddTextLayer($fontSize.Text, $sizeRect)
        $sizeLayer.DisplayName = "Text - $($fontSize.Size)"
        
        Write-Host "Created $($fontSize.Size) text layer" -ForegroundColor Yellow
        $yPosition += $fontSize.Height + 10
    }
    
    # 3. Create text with simulated font weight variations
    Write-Host "Creating text with font weight variations..." -ForegroundColor Cyan
    
    $weightTexts = @(
        @{Weight = "Light"; Text = "Light Weight Text"; Opacity = 180},
        @{Weight = "Normal"; Text = "Normal Weight Text"; Opacity = 255},
        @{Weight = "Bold"; Text = "Bold Weight Text"; Opacity = 255}
    )
    
    $yPosition = 400
    foreach ($weight in $weightTexts) {
        $weightRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 400, 50)
        $weightLayer = $psdImage.AddTextLayer($weight.Text, $weightRect)
        $weightLayer.DisplayName = "Text - $($weight.Weight)"
        $weightLayer.Opacity = $weight.Opacity
        
        # Simulate bold by slightly different positioning/duplication concept
        if ($weight.Weight -eq "Bold") {
            # Create a second layer slightly offset to simulate bold effect
            $boldRect = New-Object Aspose.PSD.Rectangle(51, $yPosition, 400, 50)
            $boldLayer = $psdImage.AddTextLayer($weight.Text, $boldRect)
            $boldLayer.DisplayName = "Text - Bold Shadow"
            $boldLayer.Opacity = 128  # Semi-transparent overlay
        }
        
        Write-Host "Created $($weight.Weight) weight text layer" -ForegroundColor Yellow
        $yPosition += 60
    }
    
    # 4. Text with alignment variations (simulated through positioning)
    Write-Host "Creating text with different alignments..." -ForegroundColor Cyan
    
    $alignments = @(
        @{Name = "Left"; X = 50; Text = "Left Aligned Text"},
        @{Name = "Center"; X = 250; Text = "Center Aligned Text"},
        @{Name = "Right"; X = 450; Text = "Right Aligned Text"}
    )
    
    $yPosition = 650
    foreach ($alignment in $alignments) {
        $alignRect = New-Object Aspose.PSD.Rectangle($alignment.X, $yPosition, 200, 40)
        $alignLayer = $psdImage.AddTextLayer($alignment.Text, $alignRect)
        $alignLayer.DisplayName = "Text - $($alignment.Name) Aligned"
        
        Write-Host "Created $($alignment.Name) aligned text layer" -ForegroundColor Yellow
    }
    
    # 5. Create text with paragraph formatting (multi-line with spacing)
    Write-Host "Creating formatted paragraph text..." -ForegroundColor Cyan
    
    $paragraphText = @"
This is a formatted paragraph with multiple lines.
It demonstrates line spacing and paragraph formatting.
Each line is properly spaced for readability.
This simulates paragraph-style text formatting.
"@
    
    $paragraphRect = New-Object Aspose.PSD.Rectangle(50, 750, 600, 120)
    $paragraphLayer = $psdImage.AddTextLayer($paragraphText, $paragraphRect)
    $paragraphLayer.DisplayName = "Formatted Paragraph"
    
    Write-Host "Created formatted paragraph text" -ForegroundColor Green
    
    # 6. Text with special formatting effects (simulated)
    Write-Host "Creating text with special effects..." -ForegroundColor Cyan
    
    # Underlined text simulation (using layer name and positioning)
    $underlineText = "Underlined Text"
    $underlineRect = New-Object Aspose.PSD.Rectangle(50, 900, 300, 40)
    $underlineLayer = $psdImage.AddTextLayer($underlineText, $underlineRect)
    $underlineLayer.DisplayName = "Underlined Text"
    
    # Create underline effect with a thin rectangle layer
    $underlineEffectLayer = $psdImage.AddRegularLayer()
    $underlineEffectLayer.DisplayName = "Underline Effect"
    $underlineEffectLayer.Left = $underlineRect.Left
    $underlineEffectLayer.Top = $underlineRect.Bottom - 5
    $underlineEffectLayer.Right = $underlineRect.Right
    $underlineEffectLayer.Bottom = $underlineRect.Bottom - 2
    
    # Fill underline with black pixels
    $underlineWidth = $underlineEffectLayer.Width
    $underlineHeight = $underlineEffectLayer.Height
    $underlinePixels = New-Object 'int[]' ($underlineWidth * $underlineHeight)
    $blackColor = ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    for ($i = 0; $i -lt $underlinePixels.Length; $i++) {
        $underlinePixels[$i] = $blackColor
    }
    $underlineEffectRect = New-Object Aspose.PSD.Rectangle(0, 0, $underlineWidth, $underlineHeight)
    $underlineEffectLayer.SaveArgb32Pixels($underlineEffectRect, $underlinePixels)
    
    Write-Host "Created underlined text effect" -ForegroundColor Yellow
    
    # Strikethrough text simulation
    $strikeText = "Strikethrough Text"
    $strikeRect = New-Object Aspose.PSD.Rectangle(400, 900, 300, 40)
    $strikeLayer = $psdImage.AddTextLayer($strikeText, $strikeRect)
    $strikeLayer.DisplayName = "Strikethrough Text"
    
    # Create strikethrough effect
    $strikeEffectLayer = $psdImage.AddRegularLayer()
    $strikeEffectLayer.DisplayName = "Strikethrough Effect"
    $strikeEffectLayer.Left = $strikeRect.Left
    $strikeEffectLayer.Top = $strikeRect.Top + ($strikeRect.Height / 2) - 1
    $strikeEffectLayer.Right = $strikeRect.Right
    $strikeEffectLayer.Bottom = $strikeRect.Top + ($strikeRect.Height / 2) + 1
    
    # Fill strikethrough with red pixels
    $strikeWidth = $strikeEffectLayer.Width
    $strikeHeight = $strikeEffectLayer.Height
    $strikePixels = New-Object 'int[]' ($strikeWidth * $strikeHeight)
    $redColor = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    for ($i = 0; $i -lt $strikePixels.Length; $i++) {
        $strikePixels[$i] = $redColor
    }
    $strikeEffectRect = New-Object Aspose.PSD.Rectangle(0, 0, $strikeWidth, $strikeHeight)
    $strikeEffectLayer.SaveArgb32Pixels($strikeEffectRect, $strikePixels)
    
    Write-Host "Created strikethrough text effect" -ForegroundColor Yellow
    
    # 7. Text with advanced spacing and kerning simulation
    Write-Host "Creating text with spacing variations..." -ForegroundColor Cyan
    
    # Normal spacing
    $normalSpacingRect = New-Object Aspose.PSD.Rectangle(50, 980, 200, 40)
    $normalSpacingLayer = $psdImage.AddTextLayer("Normal Spacing", $normalSpacingRect)
    $normalSpacingLayer.DisplayName = "Normal Spacing"
    
    # Wide spacing (simulated by spreading characters)
    $wideSpacingText = "W i d e   S p a c i n g"
    $wideSpacingRect = New-Object Aspose.PSD.Rectangle(300, 980, 300, 40)
    $wideSpacingLayer = $psdImage.AddTextLayer($wideSpacingText, $wideSpacingRect)
    $wideSpacingLayer.DisplayName = "Wide Spacing"
    
    # Tight spacing (simulated by condensed positioning)
    $tightSpacingRect = New-Object Aspose.PSD.Rectangle(650, 980, 150, 40)
    $tightSpacingLayer = $psdImage.AddTextLayer("TightSpacing", $tightSpacingRect)
    $tightSpacingLayer.DisplayName = "Tight Spacing"
    
    Write-Host "Created text with different spacing variations" -ForegroundColor Green
    
    # 8. Text with case variations
    Write-Host "Creating text with case variations..." -ForegroundColor Cyan
    
    $baseText = "Case Variation Example"
    $caseVariations = @(
        @{Name = "UPPERCASE"; Text = $baseText.ToUpper()},
        @{Name = "lowercase"; Text = $baseText.ToLower()},
        @{Name = "Title Case"; Text = $baseText},
        @{Name = "CamelCase"; Text = "CamelCaseExample"}
    )
    
    $yPosition = 1050
    foreach ($case in $caseVariations) {
        $caseRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 400, 35)
        $caseLayer = $psdImage.AddTextLayer($case.Text, $caseRect)
        $caseLayer.DisplayName = "Text - $($case.Name)"
        
        Write-Host "Created $($case.Name) text layer" -ForegroundColor Yellow
        $yPosition += 40
    }
    
    # 9. Text with special characters and symbols
    Write-Host "Creating text with special formatting characters..." -ForegroundColor Cyan
    
    $specialFormattingText = @(
        "Symbols: © ® ™ § ¶ † ‡ • ‰ ′ ″",
        "Math: ± × ÷ ≠ ≤ ≥ ∞ ∑ ∏ √",
        "Currency: $ € £ ¥ ¢ ₹ ₩ ₽ ₪",
        "Arrows: ← → ↑ ↓ ↔ ↕ ⇐ ⇒ ⇑ ⇓"
    )
    
    $yPosition = 1250
    foreach ($specialText in $specialFormattingText) {
        $specialRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 600, 35)
        $specialLayer = $psdImage.AddTextLayer($specialText, $specialRect)
        $specialLayer.DisplayName = "Special Characters"
        
        Write-Host "Created special characters text layer" -ForegroundColor Yellow
        $yPosition += 40
    }
    
    # 10. Create a formatting summary layer
    Write-Host "Creating formatting summary..." -ForegroundColor Cyan
    
    $allTextLayers = @()
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $allTextLayers += $layer
        }
    }
    
    $summaryText = "Document contains $($allTextLayers.Count) formatted text layers with various styles and effects"
    $summaryRect = New-Object Aspose.PSD.Rectangle(50, 1400, 700, 40)
    $summaryLayer = $psdImage.AddTextLayer($summaryText, $summaryRect)
    $summaryLayer.DisplayName = "Formatting Summary"
    $summaryLayer.Opacity = 200  # Semi-transparent
    
    Write-Host "Created formatting summary layer" -ForegroundColor Green
    
    # Apply additional formatting effects to some layers
    Write-Host "Applying additional formatting effects..." -ForegroundColor Cyan
    
    foreach ($layer in $allTextLayers) {
        # Randomly apply some effects for demonstration
        $layerIndex = [array]::IndexOf($allTextLayers, $layer)
        
        switch ($layerIndex % 4) {
            0 { 
                # Normal - no additional effects
            }
            1 { 
                # Semi-transparent
                $layer.Opacity = 180
            }
            2 { 
                # Different blend mode
                $layer.BlendModeKey = [Aspose.PSD.FileFormats.Psd.BlendMode]::Overlay
            }
            3 { 
                # Slight position offset for shadow effect
                $layer.Left += 1
                $layer.Top += 1
            }
        }
    }
    
    # Save results
    Write-Host "Finalizing text formatting demonstration..." -ForegroundColor Yellow
    
    # Save as PSD
    Write-Host "Saving PSD with formatted text..." -ForegroundColor Yellow
    $psdImage.Save($outputPath)
    
    # Save PNG preview
    Write-Host "Saving PNG preview..." -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    
    Write-Host "Text formatting demonstration completed successfully!" -ForegroundColor Green
    Write-Host "Output PSD: $outputPath" -ForegroundColor White
    Write-Host "Preview PNG: $previewPath" -ForegroundColor White
    
    # Display operation summary
    Write-Host "`nText Formatting Demonstration Summary:" -ForegroundColor Magenta
    Write-Host "- Created text with various font sizes" -ForegroundColor White
    Write-Host "- Demonstrated font weight variations" -ForegroundColor White
    Write-Host "- Applied different text alignments" -ForegroundColor White
    Write-Host "- Created formatted paragraph text" -ForegroundColor White
    Write-Host "- Added underline and strikethrough effects" -ForegroundColor White
    Write-Host "- Demonstrated spacing variations" -ForegroundColor White
    Write-Host "- Applied case transformations" -ForegroundColor White
    Write-Host "- Included special characters and symbols" -ForegroundColor White
    Write-Host "- Applied additional formatting effects" -ForegroundColor White
    Write-Host "- Total text layers created: $($allTextLayers.Count + 1)" -ForegroundColor White
    
} catch {
    Write-Host "Error during text formatting demonstration: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "Text formatting test completed." -ForegroundColor Green
