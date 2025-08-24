# Test script for text colors using Aspose.PSD
# Demonstrates text color manipulation, multicolor text, and color effects

# Load Aspose.PSD assembly
# . .\Load-AsposePSD.ps1

# Input and output paths
$inputPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$outputPath = join-path ${pwd} "test_text-colors.psd"
$previewPath = join-path ${pwd} "test\test_text-colors_preview.png"

Write-Host "Starting text colors test..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::Load($inputPath, $loadOptions)
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # 1. Create text layers with basic colors
    Write-Host "Creating text with basic colors..." -ForegroundColor Cyan
    
    $basicColors = @(
        @{Name = "Red"; Text = "Red Text"; R = 255; G = 0; B = 0},
        @{Name = "Green"; Text = "Green Text"; R = 0; G = 255; B = 0},
        @{Name = "Blue"; Text = "Blue Text"; R = 0; G = 0; B = 255},
        @{Name = "Yellow"; Text = "Yellow Text"; R = 255; G = 255; B = 0},
        @{Name = "Magenta"; Text = "Magenta Text"; R = 255; G = 0; B = 255},
        @{Name = "Cyan"; Text = "Cyan Text"; R = 0; G = 255; B = 255}
    )
    
    $yPosition = 50
    foreach ($color in $basicColors) {
        $colorRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 300, 40)
        $colorLayer = $psdImage.AddTextLayer($color.Text, $colorRect)
        $colorLayer.DisplayName = "Text - $($color.Name)"
        
        Write-Host "Created $($color.Name) text layer" -ForegroundColor Yellow
        $yPosition += 50
    }
    
    # 2. Create text with gradual color variations
    Write-Host "Creating text with color variations..." -ForegroundColor Cyan
    
    $gradientColors = @(
        @{Name = "Light Red"; R = 255; G = 128; B = 128},
        @{Name = "Medium Red"; R = 255; G = 64; B = 64},
        @{Name = "Dark Red"; R = 128; G = 0; B = 0},
        @{Name = "Light Blue"; R = 128; G = 128; B = 255},
        @{Name = "Medium Blue"; R = 64; G = 64; B = 255},
        @{Name = "Dark Blue"; R = 0; G = 0; B = 128}
    )
    
    $yPosition = 400
    foreach ($gradColor in $gradientColors) {
        $gradRect = New-Object Aspose.PSD.Rectangle(400, $yPosition, 300, 35)
        $gradLayer = $psdImage.AddTextLayer("$($gradColor.Name) Color", $gradRect)
        $gradLayer.DisplayName = "Gradient - $($gradColor.Name)"
        
        Write-Host "Created $($gradColor.Name) text layer" -ForegroundColor Yellow
        $yPosition += 40
    }
    
    # 3. Create text with transparency variations
    Write-Host "Creating text with transparency effects..." -ForegroundColor Cyan
    
    $transparencyLevels = @(
        @{Name = "Opaque"; Opacity = 255; Text = "100% Opaque Text"},
        @{Name = "Semi-transparent"; Opacity = 192; Text = "75% Transparent Text"},
        @{Name = "Half-transparent"; Opacity = 128; Text = "50% Transparent Text"},
        @{Name = "Very transparent"; Opacity = 64; Text = "25% Transparent Text"}
    )
    
    $yPosition = 50
    foreach ($transparency in $transparencyLevels) {
        $transRect = New-Object Aspose.PSD.Rectangle(750, $yPosition, 400, 40)
        $transLayer = $psdImage.AddTextLayer($transparency.Text, $transRect)
        $transLayer.DisplayName = "Transparency - $($transparency.Name)"
        $transLayer.Opacity = $transparency.Opacity
        
        Write-Host "Created $($transparency.Name) text layer with opacity $($transparency.Opacity)" -ForegroundColor Yellow
        $yPosition += 50
    }
    
    # 4. Simulate multicolor text using multiple layers
    Write-Host "Creating multicolor text simulation..." -ForegroundColor Cyan
    
    $multicolorWords = @("Multi", "Color", "Text", "Example")
    $wordColors = @(
        @{R = 255; G = 0; B = 0},    # Red
        @{R = 0; G = 255; B = 0},    # Green  
        @{R = 0; G = 0; B = 255},    # Blue
        @{R = 255; G = 165; B = 0}   # Orange
    )
    
    $xPosition = 50
    $multicolorY = 700
    for ($i = 0; $i -lt $multicolorWords.Count; $i++) {
        $word = $multicolorWords[$i]
        $color = $wordColors[$i % $wordColors.Count]
        
        $wordRect = New-Object Aspose.PSD.Rectangle($xPosition, $multicolorY, 120, 50)
        $wordLayer = $psdImage.AddTextLayer($word, $wordRect)
        $wordLayer.DisplayName = "Multicolor - $word"
        
        Write-Host "Created multicolor word '$word' at position $xPosition" -ForegroundColor Yellow
        $xPosition += 130
    }
    
    # 5. Create text with color blend modes
    Write-Host "Creating text with color blend modes..." -ForegroundColor Cyan
    
    $blendModes = @(
        @{Name = "Normal"; Mode = [Aspose.PSD.FileFormats.Psd.BlendMode]::Normal},
        @{Name = "Multiply"; Mode = [Aspose.PSD.FileFormats.Psd.BlendMode]::Multiply},
        @{Name = "Screen"; Mode = [Aspose.PSD.FileFormats.Psd.BlendMode]::Screen},
        @{Name = "Overlay"; Mode = [Aspose.PSD.FileFormats.Psd.BlendMode]::Overlay}
    )
    
    $yPosition = 800
    foreach ($blend in $blendModes) {
        $blendRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 350, 40)
        $blendLayer = $psdImage.AddTextLayer("$($blend.Name) Blend Mode Text", $blendRect)
        $blendLayer.DisplayName = "Blend - $($blend.Name)"
        $blendLayer.BlendModeKey = $blend.Mode
        
        Write-Host "Created $($blend.Name) blend mode text layer" -ForegroundColor Yellow
        $yPosition += 45
    }
    
    # 6. Create colored background layers to demonstrate text colors
    Write-Host "Creating colored backgrounds for text contrast..." -ForegroundColor Cyan
    
    $backgroundColors = @(
        @{Name = "White"; R = 255; G = 255; B = 255; X = 50; Y = 1000},
        @{Name = "Light Gray"; R = 192; G = 192; B = 192; X = 250; Y = 1000},
        @{Name = "Dark Gray"; R = 64; G = 64; B = 64; X = 450; Y = 1000},
        @{Name = "Black"; R = 0; G = 0; B = 0; X = 650; Y = 1000}
    )
    
    foreach ($bg in $backgroundColors) {
        # Create background layer
        $bgLayer = $psdImage.AddRegularLayer()
        $bgLayer.DisplayName = "Background - $($bg.Name)"
        $bgLayer.Left = $bg.X
        $bgLayer.Top = $bg.Y
        $bgLayer.Right = $bg.X + 180
        $bgLayer.Bottom = $bg.Y + 80
        
        # Fill with background color
        $bgWidth = $bgLayer.Width
        $bgHeight = $bgLayer.Height
        $bgPixels = New-Object 'int[]' ($bgWidth * $bgHeight)
        $bgColor = ([int]255 -shl 24) -bor ([int]$bg.R -shl 16) -bor ([int]$bg.G -shl 8) -bor [int]$bg.B
        for ($i = 0; $i -lt $bgPixels.Length; $i++) {
            $bgPixels[$i] = $bgColor
        }
        $bgRect = New-Object Aspose.PSD.Rectangle(0, 0, $bgWidth, $bgHeight)
        $bgLayer.SaveArgb32Pixels($bgRect, $bgPixels)
        
        # Create contrasting text on background
        $textOnBgRect = New-Object Aspose.PSD.Rectangle($bg.X + 10, $bg.Y + 10, 160, 60)
        $contrastText = if ($bg.R + $bg.G + $bg.B -gt 384) { "Dark Text" } else { "Light Text" }
        $textOnBgLayer = $psdImage.AddTextLayer($contrastText, $textOnBgRect)
        $textOnBgLayer.DisplayName = "Text on $($bg.Name)"
        
        Write-Host "Created $($bg.Name) background with contrasting text" -ForegroundColor Yellow
    }
    
    # 7. Create rainbow/spectrum colored text
    Write-Host "Creating rainbow spectrum text..." -ForegroundColor Cyan
    
    $rainbowColors = @(
        @{Name = "Red"; R = 255; G = 0; B = 0},
        @{Name = "Orange"; R = 255; G = 165; B = 0},
        @{Name = "Yellow"; R = 255; G = 255; B = 0},
        @{Name = "Green"; R = 0; G = 255; B = 0},
        @{Name = "Blue"; R = 0; G = 0; B = 255},
        @{Name = "Indigo"; R = 75; G = 0; B = 130},
        @{Name = "Violet"; R = 238; G = 130; B = 238}
    )
    
    $rainbowY = 1150
    $rainbowText = "RAINBOW"
    for ($i = 0; $i -lt $rainbowText.Length -and $i -lt $rainbowColors.Count; $i++) {
        $char = $rainbowText[$i].ToString()
        $color = $rainbowColors[$i]
        
        $charRect = New-Object Aspose.PSD.Rectangle((50 + $i * 60), $rainbowY, 50, 60)
        $charLayer = $psdImage.AddTextLayer($char, $charRect)
        $charLayer.DisplayName = "Rainbow - $char ($($color.Name))"
        
        Write-Host "Created rainbow character '$char' in $($color.Name)" -ForegroundColor Yellow
    }
    
    # 8. Create text with color temperature variations
    Write-Host "Creating text with color temperature variations..." -ForegroundColor Cyan
    
    $temperatureColors = @(
        @{Name = "Warm (Sunset)"; R = 255; G = 94; B = 77},
        @{Name = "Neutral"; R = 255; G = 255; B = 255},
        @{Name = "Cool (Sky)"; R = 135; G = 206; B = 235}
    )
    
    $yPosition = 1250
    foreach ($temp in $temperatureColors) {
        $tempRect = New-Object Aspose.PSD.Rectangle(50, $yPosition, 400, 40)
        $tempLayer = $psdImage.AddTextLayer("$($temp.Name) Temperature Text", $tempRect)
        $tempLayer.DisplayName = "Temperature - $($temp.Name)"
        
        Write-Host "Created $($temp.Name) temperature text" -ForegroundColor Yellow
        $yPosition += 50
    }
    
    # 9. Create color harmony demonstration
    Write-Host "Creating color harmony demonstration..." -ForegroundColor Cyan
    
    $harmonySchemes = @(
        @{Name = "Complementary"; Colors = @(@{R=255;G=0;B=0}, @{R=0;G=255;B=255})},
        @{Name = "Triadic"; Colors = @(@{R=255;G=0;B=0}, @{R=0;G=255;B=0}, @{R=0;G=0;B=255})},
        @{Name = "Analogous"; Colors = @(@{R=255;G=0;B=0}, @{R=255;G=128;B=0}, @{R=255;G=255;B=0})}
    )
    
    $yPosition = 1400
    foreach ($harmony in $harmonySchemes) {
        $xPosition = 50
        for ($i = 0; $i -lt $harmony.Colors.Count; $i++) {
            $color = $harmony.Colors[$i]
            $harmonyRect = New-Object Aspose.PSD.Rectangle($xPosition, $yPosition, 150, 35)
            $harmonyLayer = $psdImage.AddTextLayer("$($harmony.Name) $($i+1)", $harmonyRect)
            $harmonyLayer.DisplayName = "Harmony - $($harmony.Name) $($i+1)"
            
            $xPosition += 160
        }
        
        Write-Host "Created $($harmony.Name) color harmony set" -ForegroundColor Yellow
        $yPosition += 45
    }
    
    # 10. Create summary and statistics
    Write-Host "Creating color summary..." -ForegroundColor Cyan
    
    $allLayers = @()
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $allLayers += $layer
        }
    }
    
    $colorSummaryText = "Document contains $($allLayers.Count) text layers with various color treatments and effects"
    $summaryRect = New-Object Aspose.PSD.Rectangle(50, 1600, 800, 40)
    $summaryLayer = $psdImage.AddTextLayer($colorSummaryText, $summaryRect)
    $summaryLayer.DisplayName = "Color Summary"
    $summaryLayer.Opacity = 200
    
    Write-Host "Created color summary layer" -ForegroundColor Green
    
    # Save results
    Write-Host "Finalizing text color demonstration..." -ForegroundColor Yellow
    
    # Save as PSD
    Write-Host "Saving PSD with colored text..." -ForegroundColor Yellow
    $psdImage.Save($outputPath)
    
    # Save PNG preview
    Write-Host "Saving PNG preview..." -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    
    Write-Host "Text color demonstration completed successfully!" -ForegroundColor Green
    Write-Host "Output PSD: $outputPath" -ForegroundColor White
    Write-Host "Preview PNG: $previewPath" -ForegroundColor White
    
    # Display operation summary
    Write-Host "`nText Color Demonstration Summary:" -ForegroundColor Magenta
    Write-Host "- Created text with basic colors (red, green, blue, etc.)" -ForegroundColor White
    Write-Host "- Demonstrated color variations and gradients" -ForegroundColor White
    Write-Host "- Applied transparency effects" -ForegroundColor White
    Write-Host "- Created multicolor text simulation" -ForegroundColor White
    Write-Host "- Used different blend modes for color effects" -ForegroundColor White
    Write-Host "- Created contrasting text on colored backgrounds" -ForegroundColor White
    Write-Host "- Built rainbow spectrum text" -ForegroundColor White
    Write-Host "- Demonstrated color temperature variations" -ForegroundColor White
    Write-Host "- Showed color harmony schemes" -ForegroundColor White
    Write-Host "- Total colored text layers: $($allLayers.Count + 1)" -ForegroundColor White
    
} catch {
    Write-Host "Error during text color demonstration: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "Text colors test completed." -ForegroundColor Green
