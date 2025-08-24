# Test Script #17: Smart Filter Sharpen
# Demonstrates sharpen filter application with various sharpen algorithms and intensity controls

# Load Aspose.PSD library
# . ".\Load-AsposePSD.ps1"

# Define input/output paths
$psdFile = Join-Path ${pwd} "test/smartfilter_sharpen_output.psd"
$pngFile = Join-Path ${pwd} "test/smartfilter_sharpen_preview.png"

Write-Host "=== Smart Filter Sharpen Test ===" -ForegroundColor Green

try {
    # Create new PSD image
    $width = 800
    $height = 600
    $psdImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    Write-Host "Created base PSD image: ${width}x${height}" -ForegroundColor Yellow
    
    # Create source content layer with detailed pattern
    $sourceLayer = $psdImage.AddRegularLayer()
    $sourceLayer.DisplayName = "Source Content (Soft)"
    $sourceLayer.Left = 0
    $sourceLayer.Top = 0
    $sourceLayer.Right = $width
    $sourceLayer.Bottom = $height
    
    # Generate soft content that will benefit from sharpening
    $sourceWidth = $width
    $sourceHeight = $height
    $sourceRect = New-Object Aspose.PSD.Rectangle(0, 0, $sourceWidth, $sourceHeight)
    $sourcePixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    Write-Host "Generating soft source content with details..." -ForegroundColor Cyan
    
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            # Create detailed pattern with soft edges
            $centerX = $sourceWidth / 2
            $centerY = $sourceHeight / 2
            $distFromCenter = [Math]::Sqrt(($x - $centerX) * ($x - $centerX) + ($y - $centerY) * ($y - $centerY))
            
            # Create concentric circles with soft transitions
            $circlePattern = [Math]::Sin($distFromCenter * 0.02) * 0.5 + 0.5
            $ringPattern = [Math]::Sin($distFromCenter * 0.08) * 0.3 + 0.7
            
            # Add checkerboard detail
            $checkerSize = 20
            $checkerX = [Math]::Floor($x / $checkerSize) % 2
            $checkerY = [Math]::Floor($y / $checkerSize) % 2
            $checkerPattern = if (($checkerX + $checkerY) % 2 -eq 0) { 0.8 } else { 0.6 }
            
            # Combine patterns with blur-like smoothing
            $baseIntensity = ($circlePattern * $ringPattern * $checkerPattern)
            
            # Apply soft blur effect to simulate unsharp content
            $blurRadius = 2
            $blurredIntensity = 0
            $blurCount = 0
            
            for ($by = -$blurRadius; $by -le $blurRadius; $by++) {
                for ($bx = -$blurRadius; $bx -le $blurRadius; $bx++) {
                    $sampleX = $x + $bx
                    $sampleY = $y + $by
                    
                    if ($sampleX -ge 0 -and $sampleX -lt $sourceWidth -and $sampleY -ge 0 -and $sampleY -lt $sourceHeight) {
                        $weight = 1.0 / (1.0 + [Math]::Sqrt($bx*$bx + $by*$by))
                        $blurredIntensity += $baseIntensity * $weight
                        $blurCount += $weight
                    }
                }
            }
            
            if ($blurCount -gt 0) {
                $blurredIntensity /= $blurCount
            }
            
            # Convert to RGB with color variation
            $r = [int](255 * ($blurredIntensity * 0.8 + 0.2))
            $g = [int](255 * ($blurredIntensity * 0.9 + 0.1))
            $b = [int](255 * ($blurredIntensity * 0.7 + 0.3))
            
            $alpha = 255
            $sourcePixels[$index] = ([int]$alpha -shl 24) -bor ([int]$r -shl 16) -bor ([int]$g -shl 8) -bor [int]$b
        }
    }
    
    $sourceLayer.SaveArgb32Pixels($sourceRect, $sourcePixels)
    Write-Host "Soft source content generated successfully" -ForegroundColor Green
    
    # Sharpen Filter 1: Unsharp Mask
    Write-Host "`nApplying Sharpen Filter 1: Unsharp Mask..." -ForegroundColor Magenta
    
    $unsharpLayer = $psdImage.AddRegularLayer()
    $unsharpLayer.DisplayName = "Unsharp Mask Sharpen"
    $unsharpLayer.Left = 0
    $unsharpLayer.Top = 0
    $unsharpLayer.Right = $width
    $unsharpLayer.Bottom = $height
    
    $unsharpPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    # Unsharp mask parameters
    $unsharpRadius = 2.0
    $unsharpAmount = 1.5
    $unsharpThreshold = 10
    
    # First, create a blurred version (Gaussian-like blur)
    $blurredPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            $totalR = 0; $totalG = 0; $totalB = 0; $totalWeight = 0
            
            $radius = [int]$unsharpRadius
            for ($dy = -$radius; $dy -le $radius; $dy++) {
                for ($dx = -$radius; $dx -le $radius; $dx++) {
                    $sampleX = $x + $dx
                    $sampleY = $y + $dy
                    
                    if ($sampleX -ge 0 -and $sampleX -lt $sourceWidth -and $sampleY -ge 0 -and $sampleY -lt $sourceHeight) {
                        $distance = [Math]::Sqrt($dx*$dx + $dy*$dy)
                        if ($distance -le $unsharpRadius) {
                            $weight = [Math]::Exp(-($distance * $distance) / (2 * $unsharpRadius * $unsharpRadius))
                            
                            $sampleIndex = $sampleY * $sourceWidth + $sampleX
                            $sampleColor = $sourcePixels[$sampleIndex]
                            
                            $sampleR = ($sampleColor -shr 16) -band 0xFF
                            $sampleG = ($sampleColor -shr 8) -band 0xFF
                            $sampleB = $sampleColor -band 0xFF
                            
                            $totalR += $sampleR * $weight
                            $totalG += $sampleG * $weight
                            $totalB += $sampleB * $weight
                            $totalWeight += $weight
                        }
                    }
                }
            }
            
            if ($totalWeight -gt 0) {
                $blurR = [int]($totalR / $totalWeight)
                $blurG = [int]($totalG / $totalWeight)
                $blurB = [int]($totalB / $totalWeight)
                $blurredPixels[$index] = ([int]255 -shl 24) -bor ([int]$blurR -shl 16) -bor ([int]$blurG -shl 8) -bor [int]$blurB
            }
        }
    }
    
    # Apply unsharp mask
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            $originalColor = $sourcePixels[$index]
            $blurredColor = $blurredPixels[$index]
            
            $origR = ($originalColor -shr 16) -band 0xFF
            $origG = ($originalColor -shr 8) -band 0xFF
            $origB = $originalColor -band 0xFF
            
            $blurR = ($blurredColor -shr 16) -band 0xFF
            $blurG = ($blurredColor -shr 8) -band 0xFF
            $blurB = $blurredColor -band 0xFF
            
            # Calculate difference
            $diffR = $origR - $blurR
            $diffG = $origG - $blurG
            $diffB = $origB - $blurB
            
            # Apply threshold
            $diffMagnitude = [Math]::Sqrt($diffR*$diffR + $diffG*$diffG + $diffB*$diffB)
            
            if ($diffMagnitude -gt $unsharpThreshold) {
                # Apply sharpening
                $sharpenR = [Math]::Max(0, [Math]::Min(255, $origR + $diffR * $unsharpAmount))
                $sharpenG = [Math]::Max(0, [Math]::Min(255, $origG + $diffG * $unsharpAmount))
                $sharpenB = [Math]::Max(0, [Math]::Min(255, $origB + $diffB * $unsharpAmount))
                
                $unsharpPixels[$index] = ([int]255 -shl 24) -bor ([int]$sharpenR -shl 16) -bor ([int]$sharpenG -shl 8) -bor [int]$sharpenB
            } else {
                $unsharpPixels[$index] = $sourcePixels[$index]
            }
        }
    }
    
    $unsharpLayer.SaveArgb32Pixels($sourceRect, $unsharpPixels)
    $unsharpLayer.Opacity = 255
    Write-Host "Unsharp Mask applied (Radius: $unsharpRadius, Amount: $unsharpAmount, Threshold: $unsharpThreshold)" -ForegroundColor Green
    
    # Sharpen Filter 2: Laplacian Sharpen
    Write-Host "Applying Sharpen Filter 2: Laplacian Sharpen..." -ForegroundColor Magenta
    
    $laplacianLayer = $psdImage.AddRegularLayer()
    $laplacianLayer.DisplayName = "Laplacian Sharpen"
    $laplacianLayer.Left = 0
    $laplacianLayer.Top = 0
    $laplacianLayer.Right = $width
    $laplacianLayer.Bottom = $height
    
    $laplacianPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    # Laplacian kernel (8-connected)
    $laplacianKernel = @(
        @(-1, -1, -1),
        @(-1,  8, -1),
        @(-1, -1, -1)
    )
    $laplacianStrength = 0.3
    
    for ($y = 1; $y -lt ($sourceHeight - 1); $y++) {
        for ($x = 1; $x -lt ($sourceWidth - 1); $x++) {
            $index = $y * $sourceWidth + $x
            
            $originalColor = $sourcePixels[$index]
            $origR = ($originalColor -shr 16) -band 0xFF
            $origG = ($originalColor -shr 8) -band 0xFF
            $origB = $originalColor -band 0xFF
            
            # Apply Laplacian kernel
            $laplacianR = 0; $laplacianG = 0; $laplacianB = 0
            
            for ($ky = 0; $ky -lt 3; $ky++) {
                for ($kx = 0; $kx -lt 3; $kx++) {
                    $sampleX = $x + $kx - 1
                    $sampleY = $y + $ky - 1
                    $sampleIndex = $sampleY * $sourceWidth + $sampleX
                    $sampleColor = $sourcePixels[$sampleIndex]
                    
                    $sampleR = ($sampleColor -shr 16) -band 0xFF
                    $sampleG = ($sampleColor -shr 8) -band 0xFF
                    $sampleB = $sampleColor -band 0xFF
                    
                    $kernelValue = $laplacianKernel[$ky][$kx]
                    $laplacianR += $sampleR * $kernelValue
                    $laplacianG += $sampleG * $kernelValue
                    $laplacianB += $sampleB * $kernelValue
                }
            }
            
            # Add sharpening effect
            $sharpenR = [Math]::Max(0, [Math]::Min(255, $origR + $laplacianR * $laplacianStrength))
            $sharpenG = [Math]::Max(0, [Math]::Min(255, $origG + $laplacianG * $laplacianStrength))
            $sharpenB = [Math]::Max(0, [Math]::Min(255, $origB + $laplacianB * $laplacianStrength))
            
            $laplacianPixels[$index] = ([int]255 -shl 24) -bor ([int]$sharpenR -shl 16) -bor ([int]$sharpenG -shl 8) -bor [int]$sharpenB
        }
    }
    
    # Handle borders
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            if ($x -eq 0 -or $x -eq ($sourceWidth - 1) -or $y -eq 0 -or $y -eq ($sourceHeight - 1)) {
                $laplacianPixels[$index] = $sourcePixels[$index]
            }
        }
    }
    
    $laplacianLayer.SaveArgb32Pixels($sourceRect, $laplacianPixels)
    $laplacianLayer.Opacity = 180
    Write-Host "Laplacian Sharpen applied (Strength: $laplacianStrength)" -ForegroundColor Green
    
    # Sharpen Filter 3: High Pass Sharpen
    Write-Host "Applying Sharpen Filter 3: High Pass Sharpen..." -ForegroundColor Magenta
    
    $highpassLayer = $psdImage.AddRegularLayer()
    $highpassLayer.DisplayName = "High Pass Sharpen"
    $highpassLayer.Left = 0
    $highpassLayer.Top = 0
    $highpassLayer.Right = $width
    $highpassLayer.Bottom = $height
    
    $highpassPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    # High pass parameters
    $highpassRadius = 3
    $highpassStrength = 2.0
    
    # Create high pass by subtracting blur from original
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            # Calculate local average (box blur)
            $totalR = 0; $totalG = 0; $totalB = 0; $count = 0
            
            for ($dy = -$highpassRadius; $dy -le $highpassRadius; $dy++) {
                for ($dx = -$highpassRadius; $dx -le $highpassRadius; $dx++) {
                    $sampleX = $x + $dx
                    $sampleY = $y + $dy
                    
                    if ($sampleX -ge 0 -and $sampleX -lt $sourceWidth -and $sampleY -ge 0 -and $sampleY -lt $sourceHeight) {
                        $sampleIndex = $sampleY * $sourceWidth + $sampleX
                        $sampleColor = $sourcePixels[$sampleIndex]
                        
                        $sampleR = ($sampleColor -shr 16) -band 0xFF
                        $sampleG = ($sampleColor -shr 8) -band 0xFF
                        $sampleB = $sampleColor -band 0xFF
                        
                        $totalR += $sampleR
                        $totalG += $sampleG
                        $totalB += $sampleB
                        $count++
                    }
                }
            }
            
            $originalColor = $sourcePixels[$index]
            $origR = ($originalColor -shr 16) -band 0xFF
            $origG = ($originalColor -shr 8) -band 0xFF
            $origB = $originalColor -band 0xFF
            
            if ($count -gt 0) {
                $avgR = $totalR / $count
                $avgG = $totalG / $count
                $avgB = $totalB / $count
                
                # High pass = original - blur + 128 (neutral gray)
                $highpassR = 128 + ($origR - $avgR) * $highpassStrength
                $highpassG = 128 + ($origG - $avgG) * $highpassStrength
                $highpassB = 128 + ($origB - $avgB) * $highpassStrength
                
                # Clamp values
                $highpassR = [Math]::Max(0, [Math]::Min(255, $highpassR))
                $highpassG = [Math]::Max(0, [Math]::Min(255, $highpassG))
                $highpassB = [Math]::Max(0, [Math]::Min(255, $highpassB))
                
                $highpassPixels[$index] = ([int]255 -shl 24) -bor ([int]$highpassR -shl 16) -bor ([int]$highpassG -shl 8) -bor [int]$highpassB
            } else {
                $highpassPixels[$index] = ([int]255 -shl 24) -bor ([int]128 -shl 16) -bor ([int]128 -shl 8) -bor [int]128
            }
        }
    }
    
    $highpassLayer.SaveArgb32Pixels($sourceRect, $highpassPixels)
    $highpassLayer.Opacity = 150
    Write-Host "High Pass Sharpen applied (Radius: $highpassRadius, Strength: $highpassStrength)" -ForegroundColor Green
    
    # Create comparison panel
    Write-Host "`nAdding sharpen filter comparison panel..." -ForegroundColor Cyan
    
    $comparisonLayer = $psdImage.AddRegularLayer()
    $comparisonLayer.DisplayName = "Sharpen Comparison"
    $comparisonLayer.Left = 0
    $comparisonLayer.Top = 0
    $comparisonLayer.Right = $width
    $comparisonLayer.Bottom = $height
    
    $compPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    # Initialize transparent
    for ($i = 0; $i -lt $compPixels.Length; $i++) {
        $compPixels[$i] = ([int]0 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    }
    
    # Add comparison grid in corner
    $gridX = $sourceWidth - 250
    $gridY = $sourceHeight - 200
    $gridWidth = 230
    $gridHeight = 180
    
    if ($gridX -gt 0 -and $gridY -gt 0) {
        # Background
        for ($y = $gridY; $y -lt ($gridY + $gridHeight) -and $y -lt $sourceHeight; $y++) {
            for ($x = $gridX; $x -lt ($gridX + $gridWidth) -and $x -lt $sourceWidth; $x++) {
                $index = $y * $sourceWidth + $x
                $alpha = if ($x -eq $gridX -or $x -eq ($gridX + $gridWidth - 1) -or $y -eq $gridY -or $y -eq ($gridY + $gridHeight - 1)) { 255 } else { 220 }
                $color = if ($alpha -eq 255) { ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]200 -shl 8) -bor [int]0 } else { ([int]220 -shl 24) -bor ([int]50 -shl 16) -bor ([int]50 -shl 8) -bor [int]50 }
                $compPixels[$index] = $color
            }
        }
        
        # Add sample regions
        $sampleSize = 40
        $sampleSpacing = 50
        $regions = @(
            @{ name = "Original"; x = $gridX + 10; y = $gridY + 20; pixels = $sourcePixels },
            @{ name = "Unsharp"; x = $gridX + 10 + $sampleSpacing; y = $gridY + 20; pixels = $unsharpPixels },
            @{ name = "Laplacian"; x = $gridX + 10; y = $gridY + 70; pixels = $laplacianPixels },
            @{ name = "HighPass"; x = $gridX + 10 + $sampleSpacing; y = $gridY + 70; pixels = $highpassPixels }
        )
        
        foreach ($region in $regions) {
            $startX = $region.x
            $startY = $region.y
            $regionPixels = $region.pixels
            
            # Sample from center of image
            $centerSampleX = $sourceWidth / 2
            $centerSampleY = $sourceHeight / 2
            
            for ($sy = 0; $sy -lt $sampleSize -and ($startY + $sy) -lt $sourceHeight; $sy++) {
                for ($sx = 0; $sx -lt $sampleSize -and ($startX + $sx) -lt $sourceWidth; $sx++) {
                    $targetIndex = ($startY + $sy) * $sourceWidth + ($startX + $sx)
                    $sourceIndex = [int](($centerSampleY + $sy - $sampleSize/2) * $sourceWidth + ($centerSampleX + $sx - $sampleSize/2))
                    
                    if ($sourceIndex -ge 0 -and $sourceIndex -lt $regionPixels.Length) {
                        $compPixels[$targetIndex] = $regionPixels[$sourceIndex]
                    }
                }
            }
        }
    }
    
    $comparisonLayer.SaveArgb32Pixels($sourceRect, $compPixels)
    Write-Host "Sharpen comparison panel added successfully" -ForegroundColor Green
    
    # Save as PSD
    Write-Host "`nSaving PSD file: $psdFile" -ForegroundColor Yellow
    $psdImage.Save($psdFile)
    
    # Save as PNG preview
    Write-Host "Saving PNG preview: $pngFile" -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($pngFile, $pngOptions)
    
    Write-Host "`n=== Sharpen Filter Test Completed Successfully ===" -ForegroundColor Green
    Write-Host "Features demonstrated:" -ForegroundColor Cyan
    Write-Host "• Unsharp Mask with radius, amount, and threshold controls" -ForegroundColor White
    Write-Host "• Laplacian edge enhancement with 8-connected kernel" -ForegroundColor White
    Write-Host "• High Pass sharpening with neutral gray overlay" -ForegroundColor White
    Write-Host "• Threshold-based selective sharpening" -ForegroundColor White
    Write-Host "• Visual comparison panel for all sharpen methods" -ForegroundColor White
    Write-Host "• Edge detection and enhancement algorithms" -ForegroundColor White
    
} catch {
    Write-Host "Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}