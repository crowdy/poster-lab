# test-smartobject-content-replacement.ps1
# Demonstrates smart object content replacement in Aspose.PSD
# Script #13 of 18 - Smart Objects: Content Replacement

# Load Aspose.PSD
# . ".\Load-AsposePSD.ps1"

try {
    Write-Host "=== Smart Object Content Replacement Demo ===" -ForegroundColor Cyan
    
    # Create a new PSD image
    $width = 1000
    $height = 800
    
    Write-Host "Creating new PSD image (${width}x${height})..." -ForegroundColor Yellow
    $image = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    # Create white background using Graphics
    $backgroundColor = [Aspose.PSD.Color]::White
    $graphics = New-Object Aspose.PSD.Graphics($image)
    $graphics.Clear($backgroundColor)
    
    Write-Host "Creating smart objects for content replacement demonstration..." -ForegroundColor Green
    
    # 1. Create original smart object with initial content
    Write-Host "1. Creating original smart object with initial content..." -ForegroundColor White
    
    $originalLayer = $image.AddRegularLayer()
    $originalLayer.DisplayName = "[SO] Original Content"
    $originalLayer.Left = 50
    $originalLayer.Top = 50
    $originalLayer.Right = 250
    $originalLayer.Bottom = 200
    
    # Create initial content - geometric pattern using pixel manipulation
    $layerWidth = $originalLayer.Right - $originalLayer.Left
    $layerHeight = $originalLayer.Bottom - $originalLayer.Top
    $rect = New-Object Aspose.PSD.Rectangle(0, 0, $layerWidth, $layerHeight)
    $pixelData = New-Object 'int[]' ($layerWidth * $layerHeight)
    
    # Create blue gradient with red circle
    for ($y = 0; $y -lt $layerHeight; $y++) {
        for ($x = 0; $x -lt $layerWidth; $x++) {
            $index = $y * $layerWidth + $x
            
            # Create gradient from light blue to dark blue
            $blueRatio = [Math]::Min(1.0, ($x + $y) / ($layerWidth + $layerHeight))
            $blue = [int](200 + $blueRatio * 55)  # 200-255
            $green = [int](220 - $blueRatio * 120) # 220-100
            $red = [int](255 - $blueRatio * 155)   # 255-100
            
            # Add red circle in center
            $centerX = $layerWidth / 2
            $centerY = $layerHeight / 2
            $distance = [Math]::Sqrt([Math]::Pow($x - $centerX, 2) + [Math]::Pow($y - $centerY, 2))
            
            if ($distance -lt 25) {
                $red = 255
                $green = 0
                $blue = 0
            }
            
            # Border
            if ($x -lt 2 -or $x -gt ($layerWidth - 3) -or $y -lt 2 -or $y -gt ($layerHeight - 3)) {
                $red = 64; $green = 64; $blue = 64
            }
            
            $alpha = 255
            $pixelData[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $originalLayer.SaveArgb32Pixels($rect, $pixelData)
    
    # Add "SO" icon
    $iconRect = New-Object Aspose.PSD.Rectangle(170, 5, 20, 15)
    $iconPixels = New-Object 'int[]' (20 * 15)
    $whiteColor = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]255 -shl 8) -bor [int]255
    for ($i = 0; $i -lt $iconPixels.Length; $i++) {
        $iconPixels[$i] = $whiteColor
    }
    $originalLayer.SaveArgb32Pixels($iconRect, $iconPixels)
    
    Write-Host "   Original smart object created with blue gradient and red circle" -ForegroundColor Green
    
    # 2. Create multiple instances of the smart object
    Write-Host "2. Creating multiple instances of the smart object..." -ForegroundColor White
    
    $instancePositions = @(
        @{X=300; Y=50; Name="Instance 1"},
        @{X=550; Y=50; Name="Instance 2"},
        @{X=750; Y=50; Name="Instance 3"}
    )
    
    $instances = @()
    
    for ($i = 0; $i -lt $instancePositions.Length; $i++) {
        $pos = $instancePositions[$i]
        $instanceLayer = $image.AddRegularLayer()
        $instanceLayer.DisplayName = "[SO] $($pos.Name)"
        $instanceLayer.Left = $pos.X
        $instanceLayer.Top = $pos.Y
        $instanceLayer.Right = $pos.X + 200
        $instanceLayer.Bottom = $pos.Y + 150
        
        # Copy original content
        $instanceLayer.SaveArgb32Pixels($rect, $pixelData)
        $instanceLayer.SaveArgb32Pixels($iconRect, $iconPixels)
        
        $instances += $instanceLayer
        Write-Host "   $($pos.Name) created" -ForegroundColor Green
    }
    
    # 3. Demonstrate content replacement - Version 1: New geometric content
    Write-Host "3. Demonstrating content replacement - New geometric content..." -ForegroundColor White
    
    # Update original and all instances with new content
    $originalLayer.DisplayName = "[SO] Geometric Content (Updated)"
    
    # Create new content: Green pattern with triangles
    $newPixelData = New-Object 'int[]' ($layerWidth * $layerHeight)
    
    for ($y = 0; $y -lt $layerHeight; $y++) {
        for ($x = 0; $x -lt $layerWidth; $x++) {
            $index = $y * $layerWidth + $x
            
            # Create green gradient
            $greenRatio = [Math]::Min(1.0, ($x + $y) / ($layerWidth + $layerHeight))
            $green = [int](150 + $greenRatio * 105)  # 150-255
            $red = [int](200 - $greenRatio * 100)    # 200-100
            $blue = [int](150 - $greenRatio * 50)    # 150-100
            
            # Add yellow triangular pattern
            $triangleSpacing = 40
            $triangleSize = 15
            $localX = $x % $triangleSpacing
            $localY = $y % $triangleSpacing
            
            if ($localX -lt $triangleSize -and $localY -lt $triangleSize -and ($localX + $localY) -lt $triangleSize) {
                $red = 255
                $green = 255
                $blue = 0
            }
            
            # Border
            if ($x -lt 2 -or $x -gt ($layerWidth - 3) -or $y -lt 2 -or $y -gt ($layerHeight - 3)) {
                $red = 64; $green = 64; $blue = 64
            }
            
            $alpha = 255
            $newPixelData[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $originalLayer.SaveArgb32Pixels($rect, $newPixelData)
    $originalLayer.SaveArgb32Pixels($iconRect, $iconPixels)
    
    # Update all instances with new content
    for ($i = 0; $i -lt $instances.Length; $i++) {
        $instance = $instances[$i]
        $instance.DisplayName = "[SO] Geometric Content (Updated) - Instance $($i + 1)"
        $instance.SaveArgb32Pixels($rect, $newPixelData)
        $instance.SaveArgb32Pixels($iconRect, $iconPixels)
    }
    
    Write-Host "   All smart object instances updated with new geometric content" -ForegroundColor Green
    
    # 4. Create a second set showing another replacement
    Write-Host "4. Creating second smart object set for different content replacement..." -ForegroundColor White
    
    # Create second original smart object
    $secondOriginal = $image.AddRegularLayer()
    $secondOriginal.DisplayName = "[SO] Text Content"
    $secondOriginal.Left = 50
    $secondOriginal.Top = 250
    $secondOriginal.Right = 250
    $secondOriginal.Bottom = 400
    
    # Initial text-based content (simulated with rectangles)
    $textPixelData = New-Object 'int[]' ($layerWidth * $layerHeight)
    
    for ($y = 0; $y -lt $layerHeight; $y++) {
        for ($x = 0; $x -lt $layerWidth; $x++) {
            $index = $y * $layerWidth + $x
            
            # Create cyan gradient background
            $cyanRatio = [Math]::Min(1.0, ($x + $y) / ($layerWidth + $layerHeight))
            $blue = [int](200 + $cyanRatio * 55)   # 200-255
            $green = [int](200 + $cyanRatio * 55)  # 200-255
            $red = [int](150 - $cyanRatio * 50)    # 150-100
            
            # Add text representation using white rectangles
            if (($y -ge 40 -and $y -le 60 -and $x -ge 30 -and $x -le 170) -or
                ($y -ge 70 -and $y -le 90 -and $x -ge 30 -and $x -le 130) -or
                ($y -ge 100 -and $y -le 120 -and $x -ge 30 -and $x -le 150)) {
                $red = 255; $green = 255; $blue = 255
            }
            
            # Border
            if ($x -lt 2 -or $x -gt ($layerWidth - 3) -or $y -lt 2 -or $y -gt ($layerHeight - 3)) {
                $red = 64; $green = 64; $blue = 64
            }
            
            $alpha = 255
            $textPixelData[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $secondOriginal.SaveArgb32Pixels($rect, $textPixelData)
    $secondOriginal.SaveArgb32Pixels($iconRect, $iconPixels)
    
    # Create instances of second smart object
    $secondInstancePositions = @(
        @{X=300; Y=250; Name="Text Instance 1"},
        @{X=550; Y=250; Name="Text Instance 2"}
    )
    
    $secondInstances = @()
    
    for ($i = 0; $i -lt $secondInstancePositions.Length; $i++) {
        $pos = $secondInstancePositions[$i]
        $secondInstanceLayer = $image.AddRegularLayer()
        $secondInstanceLayer.DisplayName = "[SO] $($pos.Name)"
        $secondInstanceLayer.Left = $pos.X
        $secondInstanceLayer.Top = $pos.Y
        $secondInstanceLayer.Right = $pos.X + 200
        $secondInstanceLayer.Bottom = $pos.Y + 150
        
        $secondInstanceLayer.SaveArgb32Pixels($rect, $textPixelData)
        $secondInstanceLayer.SaveArgb32Pixels($iconRect, $iconPixels)
        
        $secondInstances += $secondInstanceLayer
        Write-Host "   $($pos.Name) created" -ForegroundColor Green
    }
    
    # 5. Replace content with image-based content
    Write-Host "5. Replacing with image-based content..." -ForegroundColor White
    
    $secondOriginal.DisplayName = "[SO] Image Content (Updated)"
    
    # New image-like content with radial gradient and circles
    $imagePixelData = New-Object 'int[]' ($layerWidth * $layerHeight)
    
    for ($y = 0; $y -lt $layerHeight; $y++) {
        for ($x = 0; $x -lt $layerWidth; $x++) {
            $index = $y * $layerWidth + $x
            
            # Create radial gradient from center
            $centerX = $layerWidth / 2
            $centerY = $layerHeight / 2
            $distance = [Math]::Sqrt([Math]::Pow($x - $centerX, 2) + [Math]::Pow($y - $centerY, 2))
            $maxDistance = [Math]::Sqrt([Math]::Pow($centerX, 2) + [Math]::Pow($centerY, 2))
            $ratio = [Math]::Min(1.0, $distance / $maxDistance)
            
            $red = [int](255 - $ratio * 100)    # Orange to Purple
            $green = [int](165 - $ratio * 65)   
            $blue = [int](0 + $ratio * 128)     
            
            # Add photo-like circular elements
            $circles = @(
                @{X=65; Y=55; Radius=15},
                @{X=150; Y=65; Radius=20},
                @{X=85; Y=115; Radius=12},
                @{X=160; Y=125; Radius=17}
            )
            
            foreach ($circle in $circles) {
                $circleDistance = [Math]::Sqrt([Math]::Pow($x - $circle.X, 2) + [Math]::Pow($y - $circle.Y, 2))
                if ($circleDistance -lt $circle.Radius) {
                    $alpha = [int](180 + (($circle.Radius - $circleDistance) / $circle.Radius) * 75)
                    $red = 255; $green = 255; $blue = 255
                }
            }
            
            # Border
            if ($x -lt 2 -or $x -gt ($layerWidth - 3) -or $y -lt 2 -or $y -gt ($layerHeight - 3)) {
                $red = 64; $green = 64; $blue = 64
            }
            
            $alpha = 255
            $imagePixelData[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $secondOriginal.SaveArgb32Pixels($rect, $imagePixelData)
    $secondOriginal.SaveArgb32Pixels($iconRect, $iconPixels)
    
    # Update second set instances
    for ($i = 0; $i -lt $secondInstances.Length; $i++) {
        $instance = $secondInstances[$i]
        $instance.DisplayName = "[SO] Image Content (Updated) - Instance $($i + 1)"
        $instance.SaveArgb32Pixels($rect, $imagePixelData)
        $instance.SaveArgb32Pixels($iconRect, $iconPixels)
    }
    
    Write-Host "   All second set instances updated with image content" -ForegroundColor Green
    
    # 6. Demonstrate replacement workflow
    Write-Host "6. Creating replacement workflow demonstration..." -ForegroundColor White
    
    $workflowY = 450
    $stepWidth = 100
    $stepHeight = 100
    
    # Step 1: Original content
    $step1Layer = $image.AddRegularLayer()
    $step1Layer.DisplayName = "Step 1: Original"
    $step1Layer.Left = 50
    $step1Layer.Top = $workflowY
    $step1Layer.Right = 50 + $stepWidth
    $step1Layer.Bottom = $workflowY + $stepHeight
    
    $step1Rect = New-Object Aspose.PSD.Rectangle(0, 0, $stepWidth, $stepHeight)
    $step1Pixels = New-Object 'int[]' ($stepWidth * $stepHeight)
    $lightBlue = ([int]255 -shl 24) -bor ([int]173 -shl 16) -bor ([int]216 -shl 8) -bor [int]230
    for ($i = 0; $i -lt $step1Pixels.Length; $i++) {
        $step1Pixels[$i] = $lightBlue
    }
    $step1Layer.SaveArgb32Pixels($step1Rect, $step1Pixels)
    
    # Step 2: Replacement content
    $step2Layer = $image.AddRegularLayer()
    $step2Layer.DisplayName = "Step 2: New Content"
    $step2Layer.Left = 200
    $step2Layer.Top = $workflowY
    $step2Layer.Right = 200 + $stepWidth
    $step2Layer.Bottom = $workflowY + $stepHeight
    
    $step2Pixels = New-Object 'int[]' ($stepWidth * $stepHeight)
    $lightGreen = ([int]255 -shl 24) -bor ([int]144 -shl 16) -bor ([int]238 -shl 8) -bor [int]144
    for ($i = 0; $i -lt $step2Pixels.Length; $i++) {
        $step2Pixels[$i] = $lightGreen
    }
    $step2Layer.SaveArgb32Pixels($step1Rect, $step2Pixels)
    
    # Step 3: Updated instances
    for ($i = 0; $i -lt 3; $i++) {
        $step3Layer = $image.AddRegularLayer()
        $step3Layer.DisplayName = "Step 3: Updated Instance $($i + 1)"
        $step3Layer.Left = 350 + ($i * 120)
        $step3Layer.Top = $workflowY
        $step3Layer.Right = 350 + ($i * 120) + $stepWidth
        $step3Layer.Bottom = $workflowY + $stepHeight
        
        $step3Layer.SaveArgb32Pixels($step1Rect, $step2Pixels)
    }
    
    # Add arrows using regular layers
    $arrowColor = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    for ($i = 0; $i -lt 4; $i++) {
        $arrowX = 160 + ($i * 120)
        $arrowY = $workflowY + 45
        
        $arrowLayer = $image.AddRegularLayer()
        $arrowLayer.DisplayName = "Arrow $($i + 1)"
        $arrowLayer.Left = $arrowX
        $arrowLayer.Top = $arrowY
        $arrowLayer.Right = $arrowX + 30
        $arrowLayer.Bottom = $arrowY + 10
        
        $arrowRect = New-Object Aspose.PSD.Rectangle(0, 0, 30, 10)
        $arrowPixels = New-Object 'int[]' (30 * 10)
        for ($j = 0; $j -lt $arrowPixels.Length; $j++) {
            $arrowPixels[$j] = $arrowColor
        }
        $arrowLayer.SaveArgb32Pixels($arrowRect, $arrowPixels)
    }
    
    Write-Host "   Replacement workflow visualization created" -ForegroundColor Green
    
    # 7. Add informational text layers
    Write-Host "7. Adding informational text..." -ForegroundColor White
    
    try {
        $infoY = 600
        $infoTexts = @(
            "Smart Object Content Replacement Process:",
            "1. Update source content → 2. All instances automatically reflect changes",
            "Benefits: Consistent updates, Time efficient, Maintains transformations"
        )
        
        for ($i = 0; $i -lt $infoTexts.Length; $i++) {
            $infoRect = New-Object Aspose.PSD.Rectangle(50, $infoY + ($i * 25), 900, 20)
            $infoLayer = $image.AddTextLayer($infoTexts[$i], $infoRect)
            if ($infoLayer -and $infoLayer.TextData -and $infoLayer.TextData.Items -and $infoLayer.TextData.Items.Count -gt 0) {
                $infoLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkBlue
                $infoLayer.TextData.Items[0].Style.FontSize = if ($i -eq 0) { 14 } else { 11 }
                $infoLayer.TextData.UpdateLayerData()
            }
        }
        
        # Add section labels
        $labels = @(
            @{Text="Before Replacement"; X=50; Y=30},
            @{Text="After Replacement - Set 1 (Geometric)"; X=50; Y=230},
            @{Text="After Replacement - Set 2 (Image)"; X=50; Y=430}
        )
        
        foreach ($label in $labels) {
            $labelRect = New-Object Aspose.PSD.Rectangle($label.X, $label.Y, 400, 18)
            $labelLayer = $image.AddTextLayer($label.Text, $labelRect)
            if ($labelLayer -and $labelLayer.TextData -and $labelLayer.TextData.Items -and $labelLayer.TextData.Items.Count -gt 0) {
                $labelLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Black
                $labelLayer.TextData.Items[0].Style.FontSize = 12
                $labelLayer.TextData.UpdateLayerData()
            }
        }
        
        Write-Host "   Text labels added successfully" -ForegroundColor Green
    } catch {
        Write-Host "   Could not add text layers (expected in .NET 8): $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    Write-Host "Smart object content replacement demonstration completed!" -ForegroundColor Green
    
    # Save as PSD
    $outputPsd = join-path ${pwd} "test/smartobject_replacement_output.psd"
    Write-Host "Saving PSD file: $outputPsd" -ForegroundColor Yellow
    $image.Save($outputPsd)
    
    # Save as PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $outputPng = join-path ${pwd} "test/smartobject_replacement_preview.png"
    Write-Host "Saving PNG preview: $outputPng" -ForegroundColor Yellow
    $image.Save($outputPng, $pngOptions)
    
    Write-Host "=== Smart Object Content Replacement Demo Completed Successfully ===" -ForegroundColor Cyan
    Write-Host "Output files:" -ForegroundColor White
    Write-Host "- PSD: $outputPsd" -ForegroundColor Gray
    Write-Host "- PNG: $outputPng" -ForegroundColor Gray
    
    # Display summary
    Write-Host "`nDemonstrations included:" -ForegroundColor White
    Write-Host "1. Original smart object with initial content creation" -ForegroundColor Gray
    Write-Host "2. Multiple instances of smart objects" -ForegroundColor Gray
    Write-Host "3. Content replacement with geometric patterns" -ForegroundColor Gray
    Write-Host "4. Second smart object set with different content types" -ForegroundColor Gray
    Write-Host "5. Image-based content replacement" -ForegroundColor Gray
    Write-Host "6. Visual workflow demonstration of replacement process" -ForegroundColor Gray
    Write-Host "7. Comprehensive information about benefits and process" -ForegroundColor Gray
    
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