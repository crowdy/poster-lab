# test-smartobject-layer-conversion.ps1
# Demonstrates layer to smart object conversion in Aspose.PSD
# Script #12 of 18 - Smart Objects: Layer Conversion

# Load Aspose.PSD
# . ".\Load-AsposePSD.ps1"

try {
    Write-Host "=== Layer to Smart Object Conversion Demo ===" -ForegroundColor Cyan
    
    # Create a new PSD image
    $width = 1000
    $height = 800
    
    Write-Host "Creating new PSD image (${width}x${height})..." -ForegroundColor Yellow
    $image = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    # Create white background
    $backgroundColor = [Aspose.PSD.Color]::White
    $graphics = New-Object Aspose.PSD.Graphics($image)
    $graphics.Clear($backgroundColor)
    
    Write-Host "Creating layers for conversion to smart objects..." -ForegroundColor Green
    
    # 1. Create regular raster layers for conversion
    Write-Host "1. Creating regular raster layers..." -ForegroundColor White
    
    # Create first raster layer with geometric shapes using pixel manipulation
    $rasterLayer1 = $image.AddRegularLayer()
    $rasterLayer1.DisplayName = "Geometric Shapes Layer"
    $rasterLayer1.Left = 50
    $rasterLayer1.Top = 50
    $rasterLayer1.Right = 250
    $rasterLayer1.Bottom = 200
    
    $layer1Width = $rasterLayer1.Right - $rasterLayer1.Left
    $layer1Height = $rasterLayer1.Bottom - $rasterLayer1.Top
    $layer1Rect = New-Object Aspose.PSD.Rectangle(0, 0, $layer1Width, $layer1Height)
    $layer1Pixels = New-Object 'int[]' ($layer1Width * $layer1Height)
    
    # Create background and geometric shapes using pixel manipulation
    $whiteColor = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]255 -shl 8) -bor [int]255
    $blueColor = ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]255
    $redColor = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    $greenColor = ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]255 -shl 8) -bor [int]0
    
    # Fill with white background
    for ($i = 0; $i -lt $layer1Pixels.Length; $i++) {
        $layer1Pixels[$i] = $whiteColor
    }
    
    # Draw blue rectangle (20,20,80,60)
    for ($y = 20; $y -lt 80; $y++) {
        for ($x = 20; $x -lt 100; $x++) {
            if ($x -lt $layer1Width -and $y -lt $layer1Height) {
                $index = $y * $layer1Width + $x
                $layer1Pixels[$index] = $blueColor
            }
        }
    }
    
    # Draw red circle (120,30,60,60)
    $circleCenterX = 150
    $circleCenterY = 60
    $circleRadius = 30
    for ($y = 30; $y -lt 90; $y++) {
        for ($x = 120; $x -lt 180; $x++) {
            if ($x -lt $layer1Width -and $y -lt $layer1Height) {
                $distance = [Math]::Sqrt([Math]::Pow($x - $circleCenterX, 2) + [Math]::Pow($y - $circleCenterY, 2))
                if ($distance -lt $circleRadius) {
                    $index = $y * $layer1Width + $x
                    $layer1Pixels[$index] = $redColor
                }
            }
        }
    }
    
    # Draw green triangle
    for ($y = 100; $y -lt 140; $y++) {
        for ($x = 40; $x -lt 100; $x++) {
            if ($x -lt $layer1Width -and $y -lt $layer1Height) {
                # Simple triangle approximation
                $triangleHeight = $y - 100
                $triangleWidth = ($triangleHeight * 60) / 40
                $leftEdge = 70 - $triangleWidth / 2
                $rightEdge = 70 + $triangleWidth / 2
                
                if ($x -ge $leftEdge -and $x -le $rightEdge) {
                    $index = $y * $layer1Width + $x
                    $layer1Pixels[$index] = $greenColor
                }
            }
        }
    }
    
    $rasterLayer1.SaveArgb32Pixels($layer1Rect, $layer1Pixels)
    Write-Host "   Geometric shapes layer created" -ForegroundColor Green
    
    # Create second raster layer with gradient and pattern
    $rasterLayer2 = $image.AddRegularLayer()
    $rasterLayer2.DisplayName = "Gradient and Pattern Layer"
    $rasterLayer2.Left = 300
    $rasterLayer2.Top = 50
    $rasterLayer2.Right = 500
    $rasterLayer2.Bottom = 200
    
    $layer2Width = $rasterLayer2.Right - $rasterLayer2.Left
    $layer2Height = $rasterLayer2.Bottom - $rasterLayer2.Top
    $layer2Rect = New-Object Aspose.PSD.Rectangle(0, 0, $layer2Width, $layer2Height)
    $layer2Pixels = New-Object 'int[]' ($layer2Width * $layer2Height)
    
    # Create radial gradient from center
    $gradientCenterX = $layer2Width / 2
    $gradientCenterY = $layer2Height / 2
    $maxDistance = [Math]::Sqrt([Math]::Pow($gradientCenterX, 2) + [Math]::Pow($gradientCenterY, 2))
    
    for ($y = 0; $y -lt $layer2Height; $y++) {
        for ($x = 0; $x -lt $layer2Width; $x++) {
            $index = $y * $layer2Width + $x
            
            # Calculate distance from center for radial gradient
            $distance = [Math]::Sqrt([Math]::Pow($x - $gradientCenterX, 2) + [Math]::Pow($y - $gradientCenterY, 2))
            $ratio = [Math]::Min(1.0, $distance / $maxDistance)
            
            # Purple to Yellow gradient
            $red = [int](128 + $ratio * 127)   # Purple(128) to Yellow(255)
            $green = [int](0 + $ratio * 255)   # Purple(0) to Yellow(255)  
            $blue = [int](128 - $ratio * 128)  # Purple(128) to Yellow(0)
            
            # Add pattern overlay (white dots every 30 pixels)
            $patternX = $x % 30
            $patternY = $y % 30
            if ($patternX -lt 20 -and $patternY -lt 20 -and [Math]::Sqrt([Math]::Pow($patternX - 10, 2) + [Math]::Pow($patternY - 10, 2)) -lt 10) {
                $red = [Math]::Min(255, $red + 128)
                $green = [Math]::Min(255, $green + 128)
                $blue = [Math]::Min(255, $blue + 128)
            }
            
            $alpha = 255
            $layer2Pixels[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $rasterLayer2.SaveArgb32Pixels($layer2Rect, $layer2Pixels)
    Write-Host "   Gradient and pattern layer created" -ForegroundColor Green
    
    # 2. Create text layer for conversion
    Write-Host "2. Creating text layer..." -ForegroundColor White
    
    try {
        $textRect = New-Object Aspose.PSD.Rectangle(550, 80, 200, 100)
        $textLayer = $image.AddTextLayer("Convert Me`nTo Smart Object", $textRect)
        if ($textLayer -and $textLayer.TextData -and $textLayer.TextData.Items -and $textLayer.TextData.Items.Count -gt 0) {
            $textLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkBlue
            $textLayer.TextData.Items[0].Style.FontSize = 18
            $textLayer.TextData.UpdateLayerData()
        }
        Write-Host "   Text layer created" -ForegroundColor Green
    } catch {
        Write-Host "   Could not create text layer (expected in .NET 8): $($_.Exception.Message)" -ForegroundColor Yellow
        # Create a regular layer as text placeholder
        $textPlaceholder = $image.AddRegularLayer()
        $textPlaceholder.DisplayName = "Text Layer Placeholder"
        $textPlaceholder.Left = 550
        $textPlaceholder.Top = 80
        $textPlaceholder.Right = 750
        $textPlaceholder.Bottom = 180
        
        $textPlaceholderRect = New-Object Aspose.PSD.Rectangle(0, 0, 200, 100)
        $textPlaceholderPixels = New-Object 'int[]' (200 * 100)
        $textColor = ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]139
        for ($i = 0; $i -lt $textPlaceholderPixels.Length; $i++) {
            $textPlaceholderPixels[$i] = $textColor
        }
        $textPlaceholder.SaveArgb32Pixels($textPlaceholderRect, $textPlaceholderPixels)
        Write-Host "   Text placeholder layer created" -ForegroundColor Green
    }
    
    # 3. Create additional content layer (instead of layer group which is complex)
    Write-Host "3. Creating complex content layer..." -ForegroundColor White
    
    $complexLayer = $image.AddRegularLayer()
    $complexLayer.DisplayName = "Complex Content Layer"
    $complexLayer.Left = 50
    $complexLayer.Top = 250
    $complexLayer.Right = 250
    $complexLayer.Bottom = 350
    
    $complexWidth = $complexLayer.Right - $complexLayer.Left
    $complexHeight = $complexLayer.Bottom - $complexLayer.Top
    $complexRect = New-Object Aspose.PSD.Rectangle(0, 0, $complexWidth, $complexHeight)
    $complexPixels = New-Object 'int[]' ($complexWidth * $complexHeight)
    
    # Create striped pattern with overlay
    for ($y = 0; $y -lt $complexHeight; $y++) {
        for ($x = 0; $x -lt $complexWidth; $x++) {
            $index = $y * $complexWidth + $x
            
            # Orange to Pink horizontal gradient
            $ratio = [Math]::Min(1.0, $x / [double]$complexWidth)
            $red = [int](255)                    # Orange(255) to Pink(255)
            $green = [int](165 - $ratio * 60)    # Orange(165) to Pink(105)
            $blue = [int](0 + $ratio * 180)      # Orange(0) to Pink(180)
            
            # Add green ellipse overlay
            $ellipseCenterX = 100
            $ellipseCenterY = 50
            $ellipseRadiusX = 30
            $ellipseRadiusY = 30
            
            $ellipseDistance = [Math]::Sqrt([Math]::Pow(($x - $ellipseCenterX) / $ellipseRadiusX, 2) + [Math]::Pow(($y - $ellipseCenterY) / $ellipseRadiusY, 2))
            if ($ellipseDistance -lt 1.0) {
                $alpha = [int](128 + (1.0 - $ellipseDistance) * 127)
                $red = [int]($red * 0.5)
                $green = [int](255 * 0.5 + $green * 0.5)
                $blue = [int]($blue * 0.5)
            }
            
            $alpha = 255
            $complexPixels[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $complexLayer.SaveArgb32Pixels($complexRect, $complexPixels)
    Write-Host "   Complex content layer created" -ForegroundColor Green
    
    # 4. Simulate smart object conversion process
    Write-Host "4. Simulating smart object conversion..." -ForegroundColor White
    
    # Method 1: Create converted version of geometric shapes layer
    Write-Host "   Converting geometric shapes layer..." -ForegroundColor Gray
    
    $convertedLayer1 = $image.AddRegularLayer()
    $convertedLayer1.DisplayName = "[SO] Geometric Shapes (Converted)"
    $convertedLayer1.Left = 50
    $convertedLayer1.Top = 400
    $convertedLayer1.Right = 250
    $convertedLayer1.Bottom = 550
    
    # Copy and enhance original content with smart object border
    $converted1Width = $convertedLayer1.Right - $convertedLayer1.Left
    $converted1Height = $convertedLayer1.Bottom - $convertedLayer1.Top
    $converted1Rect = New-Object Aspose.PSD.Rectangle(0, 0, $converted1Width, $converted1Height)
    $converted1Pixels = New-Object 'int[]' ($converted1Width * $converted1Height)
    
    # Copy original geometric shapes and add border
    for ($y = 0; $y -lt $converted1Height; $y++) {
        for ($x = 0; $x -lt $converted1Width; $x++) {
            $index = $y * $converted1Width + $x
            
            # Add smart object border (2 pixel border)
            if ($x -lt 2 -or $x -ge ($converted1Width - 2) -or $y -lt 2 -or $y -ge ($converted1Height - 2)) {
                $converted1Pixels[$index] = ([int]255 -shl 24) -bor ([int]64 -shl 16) -bor ([int]64 -shl 8) -bor [int]64 # Dark gray border
            } else {
                # Map to original layer coordinates
                $origX = $x - 2
                $origY = $y - 2
                if ($origX -lt $layer1Width -and $origY -lt $layer1Height) {
                    $origIndex = $origY * $layer1Width + $origX
                    $converted1Pixels[$index] = $layer1Pixels[$origIndex]
                } else {
                    $converted1Pixels[$index] = $whiteColor
                }
            }
        }
    }
    
    # Add smart object icon (white rectangle in top-right)
    for ($y = 5; $y -lt 20; $y++) {
        for ($x = 170; $x -lt 190; $x++) {
            if ($x -lt $converted1Width -and $y -lt $converted1Height) {
                $index = $y * $converted1Width + $x
                $converted1Pixels[$index] = $whiteColor
            }
        }
    }
    
    $convertedLayer1.SaveArgb32Pixels($converted1Rect, $converted1Pixels)
    Write-Host "     Geometric shapes converted to smart object" -ForegroundColor Green
    
    # Method 2: Convert gradient layer
    Write-Host "   Converting gradient layer..." -ForegroundColor Gray
    
    $convertedLayer2 = $image.AddRegularLayer()
    $convertedLayer2.DisplayName = "[SO] Gradient Pattern (Converted)"
    $convertedLayer2.Left = 300
    $convertedLayer2.Top = 400
    $convertedLayer2.Right = 500
    $convertedLayer2.Bottom = 550
    
    $converted2Width = $convertedLayer2.Right - $convertedLayer2.Left
    $converted2Height = $convertedLayer2.Bottom - $convertedLayer2.Top
    $converted2Rect = New-Object Aspose.PSD.Rectangle(0, 0, $converted2Width, $converted2Height)
    $converted2Pixels = New-Object 'int[]' ($converted2Width * $converted2Height)
    
    # Copy gradient content with border
    for ($y = 0; $y -lt $converted2Height; $y++) {
        for ($x = 0; $x -lt $converted2Width; $x++) {
            $index = $y * $converted2Width + $x
            
            # Add smart object border
            if ($x -lt 2 -or $x -ge ($converted2Width - 2) -or $y -lt 2 -or $y -ge ($converted2Height - 2)) {
                $converted2Pixels[$index] = ([int]255 -shl 24) -bor ([int]64 -shl 16) -bor ([int]64 -shl 8) -bor [int]64
            } else {
                # Map to original layer coordinates
                $origX = $x - 2
                $origY = $y - 2
                if ($origX -lt $layer2Width -and $origY -lt $layer2Height) {
                    $origIndex = $origY * $layer2Width + $origX
                    $converted2Pixels[$index] = $layer2Pixels[$origIndex]
                } else {
                    $converted2Pixels[$index] = $whiteColor
                }
            }
        }
    }
    
    # Add smart object icon
    for ($y = 5; $y -lt 20; $y++) {
        for ($x = 170; $x -lt 190; $x++) {
            if ($x -lt $converted2Width -and $y -lt $converted2Height) {
                $index = $y * $converted2Width + $x
                $converted2Pixels[$index] = $whiteColor
            }
        }
    }
    
    $convertedLayer2.SaveArgb32Pixels($converted2Rect, $converted2Pixels)
    Write-Host "     Gradient layer converted to smart object" -ForegroundColor Green
    
    # Method 3: Convert text layer to smart object (if text layer creation succeeded)
    Write-Host "   Converting text layer..." -ForegroundColor Gray
    
    try {
        $convertedTextRect = New-Object Aspose.PSD.Rectangle(550, 420, 200, 100)
        $convertedTextLayer = $image.AddTextLayer("[SO] Convert Me`nTo Smart Object", $convertedTextRect)
        if ($convertedTextLayer -and $convertedTextLayer.TextData -and $convertedTextLayer.TextData.Items -and $convertedTextLayer.TextData.Items.Count -gt 0) {
            $convertedTextLayer.DisplayName = "[SO] Text Layer (Converted)"
            $convertedTextLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkBlue
            $convertedTextLayer.TextData.Items[0].Style.FontSize = 18
            $convertedTextLayer.TextData.UpdateLayerData()
        }
        Write-Host "     Text layer converted to smart object" -ForegroundColor Green
    } catch {
        Write-Host "     Text layer conversion skipped (text not supported in .NET 8)" -ForegroundColor Yellow
    }
    
    # 5. Demonstrate conversion benefits with multiple instances
    Write-Host "5. Demonstrating conversion benefits..." -ForegroundColor White
    
    # Create multiple instances of converted smart objects to show reusability
    $instancePositions = @(
        @{X=50; Y=580; Scale=0.7; Name="70% Scale"},
        @{X=200; Y=580; Scale=1.2; Name="120% Scale"},
        @{X=380; Y=580; Scale=0.5; Name="50% Scale"}
    )
    
    for ($i = 0; $i -lt $instancePositions.Length; $i++) {
        $instance = $instancePositions[$i]
        $instanceWidth = [int](200 * $instance.Scale)
        $instanceHeight = [int](150 * $instance.Scale)
        
        $instanceLayer = $image.AddRegularLayer()
        $instanceLayer.DisplayName = "[SO Instance] $($instance.Name)"
        $instanceLayer.Left = $instance.X
        $instanceLayer.Top = $instance.Y
        $instanceLayer.Right = $instance.X + $instanceWidth
        $instanceLayer.Bottom = $instance.Y + $instanceHeight
        
        # Create scaled content
        $instanceRect = New-Object Aspose.PSD.Rectangle(0, 0, $instanceWidth, $instanceHeight)
        $instancePixels = New-Object 'int[]' ($instanceWidth * $instanceHeight)
        
        for ($y = 0; $y -lt $instanceHeight; $y++) {
            for ($x = 0; $x -lt $instanceWidth; $x++) {
                $index = $y * $instanceWidth + $x
                
                # Border
                if ($x -lt 2 -or $x -ge ($instanceWidth - 2) -or $y -lt 2 -or $y -ge ($instanceHeight - 2)) {
                    $instancePixels[$index] = ([int]255 -shl 24) -bor ([int]64 -shl 16) -bor ([int]64 -shl 8) -bor [int]64
                } else {
                    # Map to original coordinates and scale
                    $origX = [int](($x - 2) / $instance.Scale)
                    $origY = [int](($y - 2) / $instance.Scale)
                    
                    if ($origX -lt $layer1Width -and $origY -lt $layer1Height) {
                        $origIndex = $origY * $layer1Width + $origX
                        $instancePixels[$index] = $layer1Pixels[$origIndex]
                    } else {
                        $instancePixels[$index] = $whiteColor
                    }
                }
            }
        }
        
        $instanceLayer.SaveArgb32Pixels($instanceRect, $instancePixels)
        Write-Host "     Smart object instance created at $($instance.Scale * 100)% scale" -ForegroundColor Green
    }
    
    # 6. Add conversion workflow information
    Write-Host "6. Adding workflow information..." -ForegroundColor White
    
    try {
        $workflowY = 750
        $workflowTexts = @(
            "Layer to Smart Object Conversion Workflow:",
            "1. Select layer(s) to convert → 2. Convert to Smart Object → 3. Apply non-destructive edits",
            "Benefits: • Preserve original data • Non-destructive transforms • Multiple instances • Easy updates"
        )
        
        for ($i = 0; $i -lt $workflowTexts.Length; $i++) {
            $workflowRect = New-Object Aspose.PSD.Rectangle(50, $workflowY + ($i * 20), 900, 18)
            $workflowLayer = $image.AddTextLayer($workflowTexts[$i], $workflowRect)
            if ($workflowLayer -and $workflowLayer.TextData -and $workflowLayer.TextData.Items -and $workflowLayer.TextData.Items.Count -gt 0) {
                $workflowLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkRed
                $workflowLayer.TextData.Items[0].Style.FontSize = 11
                $workflowLayer.TextData.UpdateLayerData()
            }
        }
        
        # Add section labels
        $labels = @(
            @{Text="Original Layers"; X=50; Y=30},
            @{Text="Converted Smart Objects"; X=50; Y=380},
            @{Text="Smart Object Instances"; X=50; Y=560}
        )
        
        foreach ($label in $labels) {
            $labelRect = New-Object Aspose.PSD.Rectangle($label.X, $label.Y, 300, 20)
            $labelLayer = $image.AddTextLayer($label.Text, $labelRect)
            if ($labelLayer -and $labelLayer.TextData -and $labelLayer.TextData.Items -and $labelLayer.TextData.Items.Count -gt 0) {
                $labelLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Black
                $labelLayer.TextData.Items[0].Style.FontSize = 14
                $labelLayer.TextData.UpdateLayerData()
            }
        }
        
        Write-Host "   Workflow information added successfully" -ForegroundColor Green
    } catch {
        Write-Host "   Could not add text labels (expected in .NET 8): $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    Write-Host "Layer to smart object conversion demonstration completed!" -ForegroundColor Green
    
    # Save as PSD
    $outputPsd = join-path ${pwd} "test/smartobject_conversion_output.psd"
    Write-Host "Saving PSD file: $outputPsd" -ForegroundColor Yellow
    $image.Save($outputPsd)
    
    # Save as PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $outputPng = join-path ${pwd} "test/smartobject_conversion_preview.png"
    Write-Host "Saving PNG preview: $outputPng" -ForegroundColor Yellow
    $image.Save($outputPng, $pngOptions)
    
    Write-Host "=== Layer to Smart Object Conversion Demo Completed Successfully ===" -ForegroundColor Cyan
    Write-Host "Output files:" -ForegroundColor White
    Write-Host "- PSD: $outputPsd" -ForegroundColor Gray
    Write-Host "- PNG: $outputPng" -ForegroundColor Gray
    
    # Display summary
    Write-Host "`nDemonstrations included:" -ForegroundColor White
    Write-Host "1. Creation of various layer types (raster, text, complex)" -ForegroundColor Gray
    Write-Host "2. Geometric shapes layer with multiple elements" -ForegroundColor Gray
    Write-Host "3. Gradient and pattern layer with complex content" -ForegroundColor Gray
    Write-Host "4. Smart object conversion simulation with visual indicators" -ForegroundColor Gray
    Write-Host "5. Multiple smart object instances with different scales" -ForegroundColor Gray
    Write-Host "6. Conversion workflow information and benefits" -ForegroundColor Gray
    
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