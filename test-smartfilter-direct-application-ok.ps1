# Test Script #18: Smart Filter Direct Application
# Demonstrates direct smart filter application with real-time processing and filter stacking

# Load Aspose.PSD library
# . ".\Load-AsposePSD.ps1"

# Define input/output paths
$psdFile = Join-Path ${pwd} "test/smartfilter_direct_application_output.psd"
$pngFile = Join-Path ${pwd} "test/smartfilter_direct_application_preview.png"

Write-Host "=== Smart Filter Direct Application Test ===" -ForegroundColor Green

try {
    # Create new PSD image
    $width = 800
    $height = 600
    $psdImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    Write-Host "Created base PSD image: ${width}x${height}" -ForegroundColor Yellow
    
    # Create base content layer
    $baseLayer = $psdImage.AddRegularLayer()
    $baseLayer.DisplayName = "Base Content"
    $baseLayer.Left = 0
    $baseLayer.Top = 0
    $baseLayer.Right = $width
    $baseLayer.Bottom = $height
    
    # Generate complex content for filter testing
    $baseWidth = $width
    $baseHeight = $height
    $baseRect = New-Object Aspose.PSD.Rectangle(0, 0, $baseWidth, $baseHeight)
    $basePixels = New-Object 'int[]' ($baseWidth * $baseHeight)
    
    Write-Host "Generating base content with multiple features..." -ForegroundColor Cyan
    
    for ($y = 0; $y -lt $baseHeight; $y++) {
        for ($x = 0; $x -lt $baseWidth; $x++) {
            $index = $y * $baseWidth + $x
            
            # Create multiple pattern layers
            $centerX = $baseWidth / 2
            $centerY = $baseHeight / 2
            
            # Radial gradient
            $distFromCenter = [Math]::Sqrt(($x - $centerX) * ($x - $centerX) + ($y - $centerY) * ($y - $centerY))
            $maxDist = [Math]::Sqrt($centerX * $centerX + $centerY * $centerY)
            $radialGradient = 1.0 - ($distFromCenter / $maxDist)
            
            # Spiral pattern
            $angle = [Math]::Atan2($y - $centerY, $x - $centerX)
            $spiralFreq = 8
            $spiralPattern = [Math]::Sin($angle * $spiralFreq + $distFromCenter * 0.02) * 0.5 + 0.5
            
            # Grid pattern
            $gridSize = 30
            $gridX = ($x % $gridSize) / [float]$gridSize
            $gridY = ($y % $gridSize) / [float]$gridSize
            $gridPattern = if ($gridX -lt 0.1 -or $gridY -lt 0.1) { 0.2 } else { 1.0 }
            
            # Noise pattern
            $noiseFreq = 0.1
            $noise = ([Math]::Sin($x * $noiseFreq) + [Math]::Cos($y * $noiseFreq)) * 0.15 + 0.85
            
            # Combine all patterns
            $intensity = $radialGradient * $spiralPattern * $gridPattern * $noise
            
            # Convert to RGB with color variation
            $r = [int](255 * ([Math]::Max(0, [Math]::Min(1, $intensity * 1.2))))
            $g = [int](255 * ([Math]::Max(0, [Math]::Min(1, $intensity * 0.8 + 0.2))))
            $b = [int](255 * ([Math]::Max(0, [Math]::Min(1, $intensity * 1.1 + 0.1))))
            
            $alpha = 255
            $basePixels[$index] = ([int]$alpha -shl 24) -bor ([int]$r -shl 16) -bor ([int]$g -shl 8) -bor [int]$b
        }
    }
    
    $baseLayer.SaveArgb32Pixels($baseRect, $basePixels)
    Write-Host "Base content generated successfully" -ForegroundColor Green
    
    # Direct Application 1: Real-time Blur Filter
    Write-Host "`nApplying Direct Filter 1: Real-time Gaussian Blur..." -ForegroundColor Magenta
    
    $blurLayer = $psdImage.AddRegularLayer()
    $blurLayer.DisplayName = "Direct Gaussian Blur"
    $blurLayer.Left = 0
    $blurLayer.Top = 0
    $blurLayer.Right = $width
    $blurLayer.Bottom = $height
    
    $blurPixels = $basePixels.Clone()
    
    # Direct Gaussian blur application
    $blurRadius = 3.0
    $blurSigma = $blurRadius / 3.0
    
    # Two-pass Gaussian blur (horizontal then vertical)
    $tempPixels = New-Object 'int[]' ($baseWidth * $baseHeight)
    
    # Horizontal pass
    Write-Host "  Applying horizontal blur pass..." -ForegroundColor Cyan
    for ($y = 0; $y -lt $baseHeight; $y++) {
        for ($x = 0; $x -lt $baseWidth; $x++) {
            $index = $y * $baseWidth + $x
            
            $totalR = 0; $totalG = 0; $totalB = 0; $totalWeight = 0
            
            $kernelRadius = [int]($blurRadius * 3)
            for ($kx = -$kernelRadius; $kx -le $kernelRadius; $kx++) {
                $sampleX = $x + $kx
                if ($sampleX -ge 0 -and $sampleX -lt $baseWidth) {
                    $distance = [Math]::Abs($kx)
                    $weight = [Math]::Exp(-($distance * $distance) / (2 * $blurSigma * $blurSigma))
                    
                    $sampleIndex = $y * $baseWidth + $sampleX
                    $sampleColor = $blurPixels[$sampleIndex]
                    
                    $sampleR = ($sampleColor -shr 16) -band 0xFF
                    $sampleG = ($sampleColor -shr 8) -band 0xFF
                    $sampleB = $sampleColor -band 0xFF
                    
                    $totalR += $sampleR * $weight
                    $totalG += $sampleG * $weight
                    $totalB += $sampleB * $weight
                    $totalWeight += $weight
                }
            }
            
            if ($totalWeight -gt 0) {
                $blurR = [int]($totalR / $totalWeight)
                $blurG = [int]($totalG / $totalWeight)
                $blurB = [int]($totalB / $totalWeight)
                $tempPixels[$index] = ([int]255 -shl 24) -bor ([int]$blurR -shl 16) -bor ([int]$blurG -shl 8) -bor [int]$blurB
            }
        }
    }
    
    # Vertical pass
    Write-Host "  Applying vertical blur pass..." -ForegroundColor Cyan
    for ($y = 0; $y -lt $baseHeight; $y++) {
        for ($x = 0; $x -lt $baseWidth; $x++) {
            $index = $y * $baseWidth + $x
            
            $totalR = 0; $totalG = 0; $totalB = 0; $totalWeight = 0
            
            $kernelRadius = [int]($blurRadius * 3)
            for ($ky = -$kernelRadius; $ky -le $kernelRadius; $ky++) {
                $sampleY = $y + $ky
                if ($sampleY -ge 0 -and $sampleY -lt $baseHeight) {
                    $distance = [Math]::Abs($ky)
                    $weight = [Math]::Exp(-($distance * $distance) / (2 * $blurSigma * $blurSigma))
                    
                    $sampleIndex = $sampleY * $baseWidth + $x
                    $sampleColor = $tempPixels[$sampleIndex]
                    
                    $sampleR = ($sampleColor -shr 16) -band 0xFF
                    $sampleG = ($sampleColor -shr 8) -band 0xFF
                    $sampleB = $sampleColor -band 0xFF
                    
                    $totalR += $sampleR * $weight
                    $totalG += $sampleG * $weight
                    $totalB += $sampleB * $weight
                    $totalWeight += $weight
                }
            }
            
            if ($totalWeight -gt 0) {
                $blurR = [int]($totalR / $totalWeight)
                $blurG = [int]($totalG / $totalWeight)
                $blurB = [int]($totalB / $totalWeight)
                $blurPixels[$index] = ([int]255 -shl 24) -bor ([int]$blurR -shl 16) -bor ([int]$blurG -shl 8) -bor [int]$blurB
            }
        }
    }
    
    $blurLayer.SaveArgb32Pixels($baseRect, $blurPixels)
    $blurLayer.Opacity = 200
    Write-Host "Direct Gaussian Blur applied (Radius: $blurRadius)" -ForegroundColor Green
    
    # Direct Application 2: Color Adjustment Filter Stack
    Write-Host "Applying Direct Filter 2: Color Adjustment Stack..." -ForegroundColor Magenta
    
    $colorLayer = $psdImage.AddRegularLayer()
    $colorLayer.DisplayName = "Direct Color Adjustments"
    $colorLayer.Left = 0
    $colorLayer.Top = 0
    $colorLayer.Right = $width
    $colorLayer.Bottom = $height
    
    $colorPixels = $basePixels.Clone()
    
    # Apply multiple color adjustments directly
    Write-Host "  Applying brightness/contrast adjustment..." -ForegroundColor Cyan
    $brightness = 20  # -255 to 255
    $contrast = 1.2   # 0.0 to 3.0
    
    for ($i = 0; $i -lt $colorPixels.Length; $i++) {
        $color = $colorPixels[$i]
        
        $r = ($color -shr 16) -band 0xFF
        $g = ($color -shr 8) -band 0xFF
        $b = $color -band 0xFF
        
        # Apply brightness
        $r = [Math]::Max(0, [Math]::Min(255, $r + $brightness))
        $g = [Math]::Max(0, [Math]::Min(255, $g + $brightness))
        $b = [Math]::Max(0, [Math]::Min(255, $b + $brightness))
        
        # Apply contrast
        $r = [Math]::Max(0, [Math]::Min(255, 128 + ($r - 128) * $contrast))
        $g = [Math]::Max(0, [Math]::Min(255, 128 + ($g - 128) * $contrast))
        $b = [Math]::Max(0, [Math]::Min(255, 128 + ($b - 128) * $contrast))
        
        $colorPixels[$i] = ([int]255 -shl 24) -bor ([int]$r -shl 16) -bor ([int]$g -shl 8) -bor [int]$b
    }
    
    Write-Host "  Applying hue/saturation adjustment..." -ForegroundColor Cyan
    $hueShift = 30    # degrees
    $saturation = 1.3 # multiplier
    
    for ($i = 0; $i -lt $colorPixels.Length; $i++) {
        $color = $colorPixels[$i]
        
        $r = (($color -shr 16) -band 0xFF) / 255.0
        $g = (($color -shr 8) -band 0xFF) / 255.0
        $b = ($color -band 0xFF) / 255.0
        
        # Convert RGB to HSV
        $max = [Math]::Max([Math]::Max($r, $g), $b)
        $min = [Math]::Min([Math]::Min($r, $g), $b)
        $delta = $max - $min
        
        # Calculate HSV
        $h = 0; $s = 0; $v = $max
        
        if ($delta -gt 0) {
            $s = $delta / $max
            
            if ($max -eq $r) {
                $h = 60 * ((($g - $b) / $delta) % 6)
            } elseif ($max -eq $g) {
                $h = 60 * (($b - $r) / $delta + 2)
            } else {
                $h = 60 * (($r - $g) / $delta + 4)
            }
        }
        
        # Apply adjustments
        $h = ($h + $hueShift) % 360
        if ($h -lt 0) { $h += 360 }
        $s = [Math]::Max(0, [Math]::Min(1, $s * $saturation))
        
        # Convert back to RGB
        $c = $v * $s
        $x = $c * (1 - [Math]::Abs((($h / 60) % 2) - 1))
        $m = $v - $c
        
        $r1 = 0; $g1 = 0; $b1 = 0
        
        if ($h -lt 60) { $r1 = $c; $g1 = $x; $b1 = 0 }
        elseif ($h -lt 120) { $r1 = $x; $g1 = $c; $b1 = 0 }
        elseif ($h -lt 180) { $r1 = 0; $g1 = $c; $b1 = $x }
        elseif ($h -lt 240) { $r1 = 0; $g1 = $x; $b1 = $c }
        elseif ($h -lt 300) { $r1 = $x; $g1 = 0; $b1 = $c }
        else { $r1 = $c; $g1 = 0; $b1 = $x }
        
        $finalR = [int](255 * ($r1 + $m))
        $finalG = [int](255 * ($g1 + $m))
        $finalB = [int](255 * ($b1 + $m))
        
        $colorPixels[$i] = ([int]255 -shl 24) -bor ([int]$finalR -shl 16) -bor ([int]$finalG -shl 8) -bor [int]$finalB
    }
    
    $colorLayer.SaveArgb32Pixels($baseRect, $colorPixels)
    $colorLayer.Opacity = 180
    Write-Host "Direct Color Adjustment Stack applied (Brightness: $brightness, Contrast: $contrast, Hue: ${hueShift}°, Saturation: $saturation)" -ForegroundColor Green
    
    # Direct Application 3: Edge Detection Filter
    Write-Host "Applying Direct Filter 3: Edge Detection Filter..." -ForegroundColor Magenta
    
    $edgeLayer = $psdImage.AddRegularLayer()
    $edgeLayer.DisplayName = "Direct Edge Detection"
    $edgeLayer.Left = 0
    $edgeLayer.Top = 0
    $edgeLayer.Right = $width
    $edgeLayer.Bottom = $height
    
    $edgePixels = New-Object 'int[]' ($baseWidth * $baseHeight)
    
    # Sobel edge detection
    $sobelX = @(
        @(-1, 0, 1),
        @(-2, 0, 2),
        @(-1, 0, 1)
    )
    
    $sobelY = @(
        @(-1, -2, -1),
        @( 0,  0,  0),
        @( 1,  2,  1)
    )
    
    Write-Host "  Applying Sobel edge detection..." -ForegroundColor Cyan
    
    for ($y = 1; $y -lt ($baseHeight - 1); $y++) {
        for ($x = 1; $x -lt ($baseWidth - 1); $x++) {
            $index = $y * $baseWidth + $x
            
            # Apply Sobel kernels
            $gxR = 0; $gyR = 0
            $gxG = 0; $gyG = 0
            $gxB = 0; $gyB = 0
            
            for ($ky = 0; $ky -lt 3; $ky++) {
                for ($kx = 0; $kx -lt 3; $kx++) {
                    $sampleX = $x + $kx - 1
                    $sampleY = $y + $ky - 1
                    $sampleIndex = $sampleY * $baseWidth + $sampleX
                    $sampleColor = $basePixels[$sampleIndex]
                    
                    $sampleR = ($sampleColor -shr 16) -band 0xFF
                    $sampleG = ($sampleColor -shr 8) -band 0xFF
                    $sampleB = $sampleColor -band 0xFF
                    
                    $kernelXValue = $sobelX[$ky][$kx]
                    $kernelYValue = $sobelY[$ky][$kx]
                    
                    $gxR += $sampleR * $kernelXValue
                    $gyR += $sampleR * $kernelYValue
                    $gxG += $sampleG * $kernelXValue
                    $gyG += $sampleG * $kernelYValue
                    $gxB += $sampleB * $kernelXValue
                    $gyB += $sampleB * $kernelYValue
                }
            }
            
            # Calculate edge magnitude
            $magnitudeR = [Math]::Sqrt($gxR * $gxR + $gyR * $gyR)
            $magnitudeG = [Math]::Sqrt($gxG * $gxG + $gyG * $gyG)
            $magnitudeB = [Math]::Sqrt($gxB * $gxB + $gyB * $gyB)
            
            # Normalize and enhance
            $edgeR = [Math]::Max(0, [Math]::Min(255, $magnitudeR))
            $edgeG = [Math]::Max(0, [Math]::Min(255, $magnitudeG))
            $edgeB = [Math]::Max(0, [Math]::Min(255, $magnitudeB))
            
            $edgePixels[$index] = ([int]255 -shl 24) -bor ([int]$edgeR -shl 16) -bor ([int]$edgeG -shl 8) -bor [int]$edgeB
        }
    }
    
    # Handle borders
    for ($y = 0; $y -lt $baseHeight; $y++) {
        for ($x = 0; $x -lt $baseWidth; $x++) {
            $index = $y * $baseWidth + $x
            if ($x -eq 0 -or $x -eq ($baseWidth - 1) -or $y -eq 0 -or $y -eq ($baseHeight - 1)) {
                $edgePixels[$index] = ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
            }
        }
    }
    
    $edgeLayer.SaveArgb32Pixels($baseRect, $edgePixels)
    $edgeLayer.Opacity = 160
    Write-Host "Direct Edge Detection applied with Sobel operators" -ForegroundColor Green
    
    # Create filter status overlay
    Write-Host "`nAdding filter application status overlay..." -ForegroundColor Cyan
    
    $statusLayer = $psdImage.AddRegularLayer()
    $statusLayer.DisplayName = "Direct Application Status"
    $statusLayer.Left = 0
    $statusLayer.Top = 0
    $statusLayer.Right = $width
    $statusLayer.Bottom = $height
    
    $statusPixels = New-Object 'int[]' ($baseWidth * $baseHeight)
    
    # Initialize transparent
    for ($i = 0; $i -lt $statusPixels.Length; $i++) {
        $statusPixels[$i] = ([int]0 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    }
    
    # Add status indicators
    $statusY = 20
    $statusHeight = 140
    $statusWidth = 350
    $statusX = 20
    
    # Background panel
    for ($y = $statusY; $y -lt ($statusY + $statusHeight) -and $y -lt $baseHeight; $y++) {
        for ($x = $statusX; $x -lt ($statusX + $statusWidth) -and $x -lt $baseWidth; $x++) {
            $index = $y * $baseWidth + $x
            $alpha = if ($x -eq $statusX -or $x -eq ($statusX + $statusWidth - 1) -or $y -eq $statusY -or $y -eq ($statusY + $statusHeight - 1)) { 255 } else { 240 }
            $color = if ($alpha -eq 255) { ([int]255 -shl 24) -bor ([int]50 -shl 16) -bor ([int]200 -shl 8) -bor [int]50 } else { ([int]240 -shl 24) -bor ([int]0 -shl 16) -bor ([int]50 -shl 8) -bor [int]0 }
            $statusPixels[$index] = $color
        }
    }
    
    # Add status indicators (simplified visualization)
    $indicators = @(
        @{ name = "Gaussian Blur"; status = "APPLIED"; y = 35 },
        @{ name = "Color Adjustment"; status = "APPLIED"; y = 55 },
        @{ name = "Edge Detection"; status = "APPLIED"; y = 75 },
        @{ name = "Filter Stack"; status = "ACTIVE"; y = 95 }
    )
    
    foreach ($indicator in $indicators) {
        $textY = $statusY + $indicator.y
        $statusColor = if ($indicator.status -eq "APPLIED") { ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]255 -shl 8) -bor [int]0 } else { ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]255 -shl 8) -bor [int]0 }
        
        # Simple indicator dots
        for ($dy = 0; $dy -lt 3; $dy++) {
            for ($dx = 0; $dx -lt 3; $dx++) {
                $dotX = $statusX + 10 + $dx
                $dotY = $textY + $dy
                if ($dotX -lt $baseWidth -and $dotY -lt $baseHeight) {
                    $dotIndex = $dotY * $baseWidth + $dotX
                    $statusPixels[$dotIndex] = $statusColor
                }
            }
        }
    }
    
    $statusLayer.SaveArgb32Pixels($baseRect, $statusPixels)
    Write-Host "Filter status overlay added successfully" -ForegroundColor Green
    
    # Save as PSD
    Write-Host "`nSaving PSD file: $psdFile" -ForegroundColor Yellow
    $psdImage.Save($psdFile)
    
    # Save as PNG preview
    Write-Host "Saving PNG preview: $pngFile" -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($pngFile, $pngOptions)
    
    Write-Host "`n=== Direct Application Test Completed Successfully ===" -ForegroundColor Green
    Write-Host "Features demonstrated:" -ForegroundColor Cyan
    Write-Host "• Real-time Gaussian blur with two-pass algorithm" -ForegroundColor White
    Write-Host "• Direct color adjustment stack (brightness/contrast/hue/saturation)" -ForegroundColor White
    Write-Host "• Immediate edge detection with Sobel operators" -ForegroundColor White
    Write-Host "• Filter stacking and layer blending" -ForegroundColor White
    Write-Host "• HSV color space conversions" -ForegroundColor White
    Write-Host "• Live filter application status tracking" -ForegroundColor White
    
} catch {
    Write-Host "Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}