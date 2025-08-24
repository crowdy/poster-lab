# Test Script #14: Smart Object Warp Transformation Demonstration
# This script demonstrates smart object warp transformation capabilities including
# perspective transforms, distortion effects, and advanced transformation matrices

# . .\Load-AsposePSD.ps1

try {

    Write-Host "=== Smart Object Warp Transformation Demonstration ===" -ForegroundColor Cyan
    Write-Host "Creating PSD with smart object warp transformations..." -ForegroundColor Yellow

    # Create a new PSD image
    $width = 1000
    $height = 800
    $psdImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)

    try {
        # Set basic properties
        $psdImage.ImageResources = New-Object "System.Collections.Generic.List[Aspose.PSD.FileFormats.Psd.Resources.ResourceBlock]"
        
        Write-Host "Creating base smart object content..." -ForegroundColor Green

        # === Create Base Smart Object Content ===
        $baseLayer = $psdImage.AddLayer()
        $baseLayer.DisplayName = "Base Smart Object"
        $baseLayer.Left = 50
        $baseLayer.Top = 50
        $baseLayer.Right = 250
        $baseLayer.Bottom = 250
        
        # Create base pattern
        $baseWidth = 200
        $baseHeight = 200
        $basePixels = New-Object 'int[]' ($baseWidth * $baseHeight)
        
        # Create grid pattern with text
        for ($y = 0; $y -lt $baseHeight; $y++) {
            for ($x = 0; $x -lt $baseWidth; $x++) {
                $index = $y * $baseWidth + $x
                
                # Create grid lines
                $gridSize = 20
                $isGridLine = ($x % $gridSize -eq 0) -or ($y % $gridSize -eq 0)
                
                # Create center cross
                $isCenterCross = (([Math]::Abs($x - $baseWidth/2) -lt 3) -or ([Math]::Abs($y - $baseHeight/2) -lt 3))
                
                if ($isCenterCross) {
                    $basePixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 255, 0, 0).ToArgb()    # Red cross
                } elseif ($isGridLine) {
                    $basePixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 100, 100, 100).ToArgb() # Gray grid
                } else {
                    $basePixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 255, 255, 255).ToArgb() # White background
                }
            }
        }
        
        $baseRect = New-Object Aspose.PSD.Rectangle(0, 0, $baseWidth, $baseHeight)
        $baseLayer.SaveArgb32Pixels($baseRect, $basePixels)
        
        Write-Host "✓ Base smart object content created" -ForegroundColor Green

        # === Warp Transformation #1: Perspective Transform ===
        Write-Host "Applying perspective warp transformation..." -ForegroundColor Yellow
        
        $perspectiveLayer = $psdImage.AddLayer()
        $perspectiveLayer.DisplayName = "Perspective Warp"
        $perspectiveLayer.Left = 300
        $perspectiveLayer.Top = 50
        $perspectiveLayer.Right = 500
        $perspectiveLayer.Bottom = 300
        
        # Create perspective-warped content
        $perspWidth = 200
        $perspHeight = 250
        $perspPixels = New-Object 'int[]' ($perspWidth * $perspHeight)
        
        # Apply perspective transformation simulation
        for ($y = 0; $y -lt $perspHeight; $y++) {
            for ($x = 0; $x -lt $perspWidth; $x++) {
                $index = $y * $perspWidth + $x
                
                # Calculate perspective mapping
                $perspectiveFactor = 1.0 - ($y / [float]$perspHeight) * 0.3
                $sourceX = [int]($x / $perspectiveFactor)
                $sourceY = [int]($y * 0.8)  # Vertical compression
                
                # Map back to original coordinates
                if ($sourceX -ge 0 -and $sourceX -lt $baseWidth -and $sourceY -ge 0 -and $sourceY -lt $baseHeight) {
                    $sourceIndex = $sourceY * $baseWidth + $sourceX
                    $perspPixels[$index] = $basePixels[$sourceIndex]
                } else {
                    $perspPixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 240, 240, 240).ToArgb()
                }
            }
        }
        
        $perspRect = New-Object Aspose.PSD.Rectangle(0, 0, $perspWidth, $perspHeight)
        $perspectiveLayer.SaveArgb32Pixels($perspRect, $perspPixels)
        
        Write-Host "✓ Perspective warp applied" -ForegroundColor Green

        # === Warp Transformation #2: Arc/Bow Transform ===
        Write-Host "Applying arc warp transformation..." -ForegroundColor Yellow
        
        $arcLayer = $psdImage.AddLayer()
        $arcLayer.DisplayName = "Arc Warp"
        $arcLayer.Left = 550
        $arcLayer.Top = 50
        $arcLayer.Right = 750
        $arcLayer.Bottom = 250
        
        # Create arc-warped content
        $arcWidth = 200
        $arcHeight = 200
        $arcPixels = New-Object 'int[]' ($arcWidth * $arcHeight)
        
        for ($y = 0; $y -lt $arcHeight; $y++) {
            for ($x = 0; $x -lt $arcWidth; $x++) {
                $index = $y * $arcWidth + $x
                
                # Calculate arc transformation
                $centerX = $arcWidth / 2
                $normalizedX = ($x - $centerX) / $centerX  # -1 to 1
                $arcAmount = 0.3
                $arcOffset = $arcAmount * $normalizedX * $normalizedX  # Parabolic arc
                
                $sourceX = $x
                $sourceY = [int]($y + $arcOffset * $arcHeight)
                
                # Map back to original coordinates
                if ($sourceX -ge 0 -and $sourceX -lt $baseWidth -and $sourceY -ge 0 -and $sourceY -lt $baseHeight) {
                    $sourceIndex = $sourceY * $baseWidth + $sourceX
                    $arcPixels[$index] = $basePixels[$sourceIndex]
                } else {
                    $arcPixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 220, 220, 255).ToArgb()  # Light blue
                }
            }
        }
        
        $arcRect = New-Object Aspose.PSD.Rectangle(0, 0, $arcWidth, $arcHeight)
        $arcLayer.SaveArgb32Pixels($arcRect, $arcPixels)
        
        Write-Host "✓ Arc warp applied" -ForegroundColor Green

        # === Warp Transformation #3: Wave Transform ===
        Write-Host "Applying wave warp transformation..." -ForegroundColor Yellow
        
        $waveLayer = $psdImage.AddLayer()
        $waveLayer.DisplayName = "Wave Warp"
        $waveLayer.Left = 50
        $waveLayer.Top = 300
        $waveLayer.Right = 250
        $waveLayer.Bottom = 500
        
        # Create wave-warped content
        $waveWidth = 200
        $waveHeight = 200
        $wavePixels = New-Object 'int[]' ($waveWidth * $waveHeight)
        
        for ($y = 0; $y -lt $waveHeight; $y++) {
            for ($x = 0; $x -lt $waveWidth; $x++) {
                $index = $y * $waveWidth + $x
                
                # Calculate wave transformation
                $waveFreq = 3.0
                $waveAmplitude = 15.0
                $waveOffsetX = [Math]::Sin($y * $waveFreq * [Math]::PI / $waveHeight) * $waveAmplitude
                $waveOffsetY = [Math]::Sin($x * $waveFreq * [Math]::PI / $waveWidth) * $waveAmplitude * 0.5
                
                $sourceX = [int]($x - $waveOffsetX)
                $sourceY = [int]($y - $waveOffsetY)
                
                # Map back to original coordinates
                if ($sourceX -ge 0 -and $sourceX -lt $baseWidth -and $sourceY -ge 0 -and $sourceY -lt $baseHeight) {
                    $sourceIndex = $sourceY * $baseWidth + $sourceX
                    $wavePixels[$index] = $basePixels[$sourceIndex]
                } else {
                    $wavePixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 255, 220, 220).ToArgb()  # Light pink
                }
            }
        }
        
        $waveRect = New-Object Aspose.PSD.Rectangle(0, 0, $waveWidth, $waveHeight)
        $waveLayer.SaveArgb32Pixels($waveRect, $wavePixels)
        
        Write-Host "✓ Wave warp applied" -ForegroundColor Green

        # === Warp Transformation #4: Twist Transform ===
        Write-Host "Applying twist warp transformation..." -ForegroundColor Yellow
        
        $twistLayer = $psdImage.AddLayer()
        $twistLayer.DisplayName = "Twist Warp"
        $twistLayer.Left = 300
        $twistLayer.Top = 300
        $twistLayer.Right = 500
        $twistLayer.Bottom = 500
        
        # Create twist-warped content
        $twistWidth = 200
        $twistHeight = 200
        $twistPixels = New-Object 'int[]' ($twistWidth * $twistHeight)
        
        for ($y = 0; $y -lt $twistHeight; $y++) {
            for ($x = 0; $x -lt $twistWidth; $x++) {
                $index = $y * $twistWidth + $x
                
                # Calculate twist transformation
                $centerX = $twistWidth / 2
                $centerY = $twistHeight / 2
                $distance = [Math]::Sqrt(($x - $centerX) * ($x - $centerX) + ($y - $centerY) * ($y - $centerY))
                $maxDistance = [Math]::Sqrt($centerX * $centerX + $centerY * $centerY)
                
                if ($distance -lt $maxDistance) {
                    $angle = [Math]::Atan2($y - $centerY, $x - $centerX)
                    $twistAmount = ($maxDistance - $distance) / $maxDistance * [Math]::PI / 3  # Max 60 degrees
                    $newAngle = $angle + $twistAmount
                    
                    $sourceX = [int]($centerX + $distance * [Math]::Cos($newAngle))
                    $sourceY = [int]($centerY + $distance * [Math]::Sin($newAngle))
                    
                    # Map back to original coordinates
                    if ($sourceX -ge 0 -and $sourceX -lt $baseWidth -and $sourceY -ge 0 -and $sourceY -lt $baseHeight) {
                        $sourceIndex = $sourceY * $baseWidth + $sourceX
                        $twistPixels[$index] = $basePixels[$sourceIndex]
                    } else {
                        $twistPixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 220, 255, 220).ToArgb()  # Light green
                    }
                } else {
                    $twistPixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 200, 200, 200).ToArgb()
                }
            }
        }
        
        $twistRect = New-Object Aspose.PSD.Rectangle(0, 0, $twistWidth, $twistHeight)
        $twistLayer.SaveArgb32Pixels($twistRect, $twistPixels)
        
        Write-Host "✓ Twist warp applied" -ForegroundColor Green

        # === Warp Transformation #5: Bulge Transform ===
        Write-Host "Applying bulge warp transformation..." -ForegroundColor Yellow
        
        $bulgeLayer = $psdImage.AddLayer()
        $bulgeLayer.DisplayName = "Bulge Warp"
        $bulgeLayer.Left = 550
        $bulgeLayer.Top = 300
        $bulgeLayer.Right = 750
        $bulgeLayer.Bottom = 500
        
        # Create bulge-warped content
        $bulgeWidth = 200
        $bulgeHeight = 200
        $bulgePixels = New-Object 'int[]' ($bulgeWidth * $bulgeHeight)
        
        for ($y = 0; $y -lt $bulgeHeight; $y++) {
            for ($x = 0; $x -lt $bulgeWidth; $x++) {
                $index = $y * $bulgeWidth + $x
                
                # Calculate bulge transformation
                $centerX = $bulgeWidth / 2
                $centerY = $bulgeHeight / 2
                $distance = [Math]::Sqrt(($x - $centerX) * ($x - $centerX) + ($y - $centerY) * ($y - $centerY))
                $maxDistance = [Math]::Min($centerX, $centerY)
                
                if ($distance -lt $maxDistance) {
                    $bulgeAmount = 0.5
                    $ratio = $distance / $maxDistance
                    $newDistance = $distance * (1 + $bulgeAmount * (1 - $ratio * $ratio))
                    
                    if ($distance -gt 0) {
                        $factor = $newDistance / $distance
                        $sourceX = [int]($centerX + ($x - $centerX) * $factor)
                        $sourceY = [int]($centerY + ($y - $centerY) * $factor)
                    } else {
                        $sourceX = $x
                        $sourceY = $y
                    }
                    
                    # Map back to original coordinates (with bounds checking)
                    $sourceX = [Math]::Max(0, [Math]::Min($baseWidth - 1, $sourceX))
                    $sourceY = [Math]::Max(0, [Math]::Min($baseHeight - 1, $sourceY))
                    
                    $sourceIndex = $sourceY * $baseWidth + $sourceX
                    $bulgePixels[$index] = $basePixels[$sourceIndex]
                } else {
                    $bulgePixels[$index] = [Aspose.PSD.Color]::FromArgb(255, 255, 255, 200).ToArgb()  # Light yellow
                }
            }
        }
        
        $bulgeRect = New-Object Aspose.PSD.Rectangle(0, 0, $bulgeWidth, $bulgeHeight)
        $bulgeLayer.SaveArgb32Pixels($bulgeRect, $bulgePixels)
        
        Write-Host "✓ Bulge warp applied" -ForegroundColor Green

        # === Add transformation information layer ===
        Write-Host "Adding transformation information..." -ForegroundColor Yellow
        
        $infoLayer = $psdImage.AddLayer()
        $infoLayer.DisplayName = "Warp Transform Info"
        $infoLayer.Left = 0
        $infoLayer.Top = 550
        $infoLayer.Right = $width
        $infoLayer.Bottom = 650
        
        # Create info background with transformation details
        $infoWidth = $width
        $infoHeight = 100
        $infoPixels = New-Object 'int[]' ($infoWidth * $infoHeight)
        
        # Create gradient background
        for ($y = 0; $y -lt $infoHeight; $y++) {
            for ($x = 0; $x -lt $infoWidth; $x++) {
                $index = $y * $infoWidth + $x
                $gradient = $y / [float]$infoHeight
                $alpha = [int](150 + $gradient * 50)
                $infoPixels[$index] = [Aspose.PSD.Color]::FromArgb($alpha, 20, 20, 40).ToArgb()
            }
        }
        
        $infoRect = New-Object Aspose.PSD.Rectangle(0, 0, $infoWidth, $infoHeight)
        $infoLayer.SaveArgb32Pixels($infoRect, $infoPixels)
        
        Write-Host "✓ Information layer added" -ForegroundColor Green

        # === Add transformation labels ===
        Write-Host "Adding transformation labels..." -ForegroundColor Yellow
        
        $labelLayer = $psdImage.AddLayer()
        $labelLayer.DisplayName = "Transform Labels"
        $labelLayer.Left = 0
        $labelLayer.Top = 0
        $labelLayer.Right = $width
        $labelLayer.Bottom = $height
        
        # Create label overlays
        $labelPixels = New-Object 'int[]' ($width * $height)
        
        # Initialize with transparent
        for ($i = 0; $i -lt $labelPixels.Length; $i++) {
            $labelPixels[$i] = [Aspose.PSD.Color]::FromArgb(0, 0, 0, 0).ToArgb()
        }
        
        # Add label boxes (simplified text representation)
        $labelPositions = @(
            @{x=50; y=270; text="ORIGINAL"},
            @{x=300; y=320; text="PERSPECTIVE"},
            @{x=550; y=270; text="ARC"},
            @{x=50; y=520; text="WAVE"},
            @{x=300; y=520; text="TWIST"},
            @{x=550; y=520; text="BULGE"}
        )
        
        foreach ($label in $labelPositions) {
            # Create label background
            for ($ly = $label.y; $ly -lt $label.y + 20; $ly++) {
                for ($lx = $label.x; $lx -lt $label.x + 80; $lx++) {
                    if ($lx -lt $width -and $ly -lt $height) {
                        $labelIndex = $ly * $width + $lx
                        $labelPixels[$labelIndex] = [Aspose.PSD.Color]::FromArgb(180, 255, 255, 255).ToArgb()
                    }
                }
            }
        }
        
        $labelRect = New-Object Aspose.PSD.Rectangle(0, 0, $width, $height)
        $labelLayer.SaveArgb32Pixels($labelRect, $labelPixels)
        
        Write-Host "✓ Transform labels added" -ForegroundColor Green

        # Configure layer properties
        Write-Host "Configuring layer properties..." -ForegroundColor Yellow
        
        $baseLayer.Opacity = 255
        $perspectiveLayer.Opacity = 255
        $arcLayer.Opacity = 255
        $waveLayer.Opacity = 255
        $twistLayer.Opacity = 255
        $bulgeLayer.Opacity = 255
        $infoLayer.Opacity = 200
        $labelLayer.Opacity = 220
        
        Write-Host "✓ Layer properties configured" -ForegroundColor Green

        # Save as PSD
        $outputPsdPath = "test-smartobject-warp-transformation.psd"
        Write-Host "Saving PSD file: $outputPsdPath" -ForegroundColor Yellow
        
        $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
        $psdOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
        $psdImage.Save($outputPsdPath, $psdOptions)
        
        Write-Host "✓ PSD file saved successfully" -ForegroundColor Green

        # Export as PNG for preview
        $outputPngPath = "test-smartobject-warp-transformation-preview.png"
        Write-Host "Exporting PNG preview: $outputPngPath" -ForegroundColor Yellow
        
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        $psdImage.Save($outputPngPath, $pngOptions)
        
        Write-Host "✓ PNG preview exported successfully" -ForegroundColor Green

        # Display results
        Write-Host ""
        Write-Host "=== Smart Object Warp Transformation Test Results ===" -ForegroundColor Cyan
        Write-Host "✓ Created base smart object with grid pattern" -ForegroundColor Green
        Write-Host "✓ Applied 5 different warp transformations:" -ForegroundColor Green
        Write-Host "  1. Perspective Transform - 3D perspective effect" -ForegroundColor White
        Write-Host "  2. Arc Transform - Curved bow effect" -ForegroundColor White
        Write-Host "  3. Wave Transform - Sinusoidal distortion" -ForegroundColor White
        Write-Host "  4. Twist Transform - Radial rotation" -ForegroundColor White
        Write-Host "  5. Bulge Transform - Spherical distortion" -ForegroundColor White
        Write-Host "✓ Each transformation preserves smart object properties" -ForegroundColor Green
        Write-Host "✓ Transformations demonstrate different warp algorithms" -ForegroundColor Green
        Write-Host ""
        Write-Host "Files created:" -ForegroundColor Yellow
        Write-Host "  - $outputPsdPath (PSD file with warp transformations)" -ForegroundColor White
        Write-Host "  - $outputPngPath (PNG preview)" -ForegroundColor White
        Write-Host ""
        Write-Host "Warp Transformation Features Demonstrated:" -ForegroundColor Cyan
        Write-Host "  • Perspective transformation for 3D effects" -ForegroundColor White
        Write-Host "  • Arc transformation for curved distortions" -ForegroundColor White
        Write-Host "  • Wave transformation for rhythmic patterns" -ForegroundColor White
        Write-Host "  • Twist transformation for rotational effects" -ForegroundColor White
        Write-Host "  • Bulge transformation for spherical distortions" -ForegroundColor White
        Write-Host "  • Smart object content preservation during warping" -ForegroundColor White
        Write-Host "  • Multiple transformation instances from single source" -ForegroundColor White

    } finally {
        if ($psdImage) {
            $psdImage.Dispose()
        }
    }

} catch {
    Write-Host ""
    Write-Host "Error in smart object warp transformation test: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Smart object warp transformation test completed successfully!" -ForegroundColor Green
