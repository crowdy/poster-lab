# Test Script #16: Smart Filter Custom Renderer
# Demonstrates custom smart filter renderer capabilities including custom algorithms and advanced effects

# Load Aspose.PSD library
# . ".\Load-AsposePSD.ps1"

# Define input/output paths
$psdFile = Join-Path ${pwd} "test/smartfilter_custom_renderer_output.psd"
$pngFile = Join-Path ${pwd} "test/smartfilter_custom_renderer_preview.png"

Write-Host "=== Smart Filter Custom Renderer Test ===" -ForegroundColor Green

try {
    # Create new PSD image
    $width = 800
    $height = 600
    $psdImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    Write-Host "Created base PSD image: ${width}x${height}" -ForegroundColor Yellow
    
    # Create background layer with pattern
    $bgLayer = $psdImage.AddRegularLayer()
    $bgLayer.DisplayName = "Background Pattern"
    $bgLayer.Left = 0
    $bgLayer.Top = 0
    $bgLayer.Right = $width
    $bgLayer.Bottom = $height
    
    # Generate background pattern with noise and gradient
    $bgWidth = $width
    $bgHeight = $height
    $bgRect = New-Object Aspose.PSD.Rectangle(0, 0, $bgWidth, $bgHeight)
    $bgPixels = New-Object 'int[]' ($bgWidth * $bgHeight)
    
    Write-Host "Generating background pattern with gradient and noise..." -ForegroundColor Cyan
    
    for ($y = 0; $y -lt $bgHeight; $y++) {
        for ($x = 0; $x -lt $bgWidth; $x++) {
            $index = $y * $bgWidth + $x
            
            # Create gradient base
            $gradientR = [int](255 * ($x / [float]$bgWidth))
            $gradientG = [int](255 * ($y / [float]$bgHeight))
            $gradientB = [int](128 + 127 * [Math]::Sin(($x + $y) * 0.02))
            
            # Add noise
            $noise = (Get-Random -Minimum -30 -Maximum 30)
            $r = [Math]::Max(0, [Math]::Min(255, $gradientR + $noise))
            $g = [Math]::Max(0, [Math]::Min(255, $gradientG + $noise))
            $b = [Math]::Max(0, [Math]::Min(255, $gradientB + $noise))
            
            $alpha = 255
            $bgPixels[$index] = ([int]$alpha -shl 24) -bor ([int]$r -shl 16) -bor ([int]$g -shl 8) -bor [int]$b
        }
    }
    
    $bgLayer.SaveArgb32Pixels($bgRect, $bgPixels)
    Write-Host "Background pattern applied successfully" -ForegroundColor Green
    
    # Custom Renderer 1: Oil Painting Effect
    Write-Host "`nApplying Custom Renderer 1: Oil Painting Effect..." -ForegroundColor Magenta
    
    $oilLayer = $psdImage.AddRegularLayer()
    $oilLayer.DisplayName = "Oil Painting Filter"
    $oilLayer.Left = 0
    $oilLayer.Top = 0
    $oilLayer.Right = $width
    $oilLayer.Bottom = $height
    
    $oilPixels = $bgPixels.Clone()
    
    # Oil painting algorithm with brush stroke simulation
    $brushSize = 5
    for ($y = $brushSize; $y -lt ($bgHeight - $brushSize); $y += 2) {
        for ($x = $brushSize; $x -lt ($bgWidth - $brushSize); $x += 2) {
            $index = $y * $bgWidth + $x
            
            # Sample surrounding pixels for oil effect
            $totalR = 0; $totalG = 0; $totalB = 0; $count = 0
            
            for ($dy = -$brushSize; $dy -le $brushSize; $dy++) {
                for ($dx = -$brushSize; $dx -le $brushSize; $dx++) {
                    $sampleX = $x + $dx
                    $sampleY = $y + $dy
                    
                    if ($sampleX -ge 0 -and $sampleX -lt $bgWidth -and $sampleY -ge 0 -and $sampleY -lt $bgHeight) {
                        $sampleIndex = $sampleY * $bgWidth + $sampleX
                        $sampleColor = $bgPixels[$sampleIndex]
                        
                        $sampleR = ($sampleColor -shr 16) -band 0xFF
                        $sampleG = ($sampleColor -shr 8) -band 0xFF
                        $sampleB = $sampleColor -band 0xFF
                        
                        $weight = 1.0 / (1.0 + [Math]::Sqrt($dx*$dx + $dy*$dy))
                        $totalR += $sampleR * $weight
                        $totalG += $sampleG * $weight
                        $totalB += $sampleB * $weight
                        $count += $weight
                    }
                }
            }
            
            if ($count -gt 0) {
                $avgR = [int]($totalR / $count)
                $avgG = [int]($totalG / $count)
                $avgB = [int]($totalB / $count)
                
                # Apply oil painting quantization
                $levels = 8
                $quantR = [int]([Math]::Round($avgR / 255.0 * $levels) * 255 / $levels)
                $quantG = [int]([Math]::Round($avgG / 255.0 * $levels) * 255 / $levels)
                $quantB = [int]([Math]::Round($avgB / 255.0 * $levels) * 255 / $levels)
                
                # Apply to surrounding area (brush stroke)
                for ($by = -1; $by -le 1; $by++) {
                    for ($bx = -1; $bx -le 1; $bx++) {
                        $targetX = $x + $bx
                        $targetY = $y + $by
                        if ($targetX -ge 0 -and $targetX -lt $bgWidth -and $targetY -ge 0 -and $targetY -lt $bgHeight) {
                            $targetIndex = $targetY * $bgWidth + $targetX
                            $oilPixels[$targetIndex] = ([int]255 -shl 24) -bor ([int]$quantR -shl 16) -bor ([int]$quantG -shl 8) -bor [int]$quantB
                        }
                    }
                }
            }
        }
    }
    
    $oilLayer.SaveArgb32Pixels($bgRect, $oilPixels)
    $oilLayer.Opacity = 180
    Write-Host "Oil Painting effect applied with quantization levels" -ForegroundColor Green
    
    # Custom Renderer 2: Emboss Effect
    Write-Host "Applying Custom Renderer 2: Advanced Emboss Effect..." -ForegroundColor Magenta
    
    $embossLayer = $psdImage.AddRegularLayer()
    $embossLayer.DisplayName = "Emboss Filter"
    $embossLayer.Left = 0
    $embossLayer.Top = 0
    $embossLayer.Right = $width
    $embossLayer.Bottom = $height
    
    $embossPixels = New-Object 'int[]' ($bgWidth * $bgHeight)
    
    # Advanced emboss with lighting simulation
    $lightAngle = [Math]::PI / 4  # 45 degrees
    $lightX = [Math]::Cos($lightAngle)
    $lightY = [Math]::Sin($lightAngle)
    $embossStrength = 2.0
    
    for ($y = 1; $y -lt ($bgHeight - 1); $y++) {
        for ($x = 1; $x -lt ($bgWidth - 1); $x++) {
            $index = $y * $bgWidth + $x
            
            # Get surrounding pixels for gradient calculation
            $topLeft = $bgPixels[($y-1) * $bgWidth + ($x-1)]
            $top = $bgPixels[($y-1) * $bgWidth + $x]
            $topRight = $bgPixels[($y-1) * $bgWidth + ($x+1)]
            $left = $bgPixels[$y * $bgWidth + ($x-1)]
            $right = $bgPixels[$y * $bgWidth + ($x+1)]
            $bottomLeft = $bgPixels[($y+1) * $bgWidth + ($x-1)]
            $bottom = $bgPixels[($y+1) * $bgWidth + $x]
            $bottomRight = $bgPixels[($y+1) * $bgWidth + ($x+1)]
            
            # Extract RGB values
            $tlR = ($topLeft -shr 16) -band 0xFF; $tlG = ($topLeft -shr 8) -band 0xFF; $tlB = $topLeft -band 0xFF
            $tR = ($top -shr 16) -band 0xFF; $tG = ($top -shr 8) -band 0xFF; $tB = $top -band 0xFF
            $trR = ($topRight -shr 16) -band 0xFF; $trG = ($topRight -shr 8) -band 0xFF; $trB = $topRight -band 0xFF
            $lR = ($left -shr 16) -band 0xFF; $lG = ($left -shr 8) -band 0xFF; $lB = $left -band 0xFF
            $rR = ($right -shr 16) -band 0xFF; $rG = ($right -shr 8) -band 0xFF; $rB = $right -band 0xFF
            $blR = ($bottomLeft -shr 16) -band 0xFF; $blG = ($bottomLeft -shr 8) -band 0xFF; $blB = $bottomLeft -band 0xFF
            $bR = ($bottom -shr 16) -band 0xFF; $bG = ($bottom -shr 8) -band 0xFF; $bB = $bottom -band 0xFF
            $brR = ($bottomRight -shr 16) -band 0xFF; $brG = ($bottomRight -shr 8) -band 0xFF; $brB = $bottomRight -band 0xFF
            
            # Calculate gradients using Sobel operators
            $gxR = (-$tlR - 2*$lR - $blR + $trR + 2*$rR + $brR)
            $gyR = (-$tlR - 2*$tR - $trR + $blR + 2*$bR + $brR)
            
            $gxG = (-$tlG - 2*$lG - $blG + $trG + 2*$rG + $brG)
            $gyG = (-$tlG - 2*$tG - $trG + $blG + 2*$bG + $brG)
            
            $gxB = (-$tlB - 2*$lB - $blB + $trB + 2*$rB + $brB)
            $gyB = (-$tlB - 2*$tB - $trB + $blB + 2*$bB + $brB)
            
            # Calculate lighting based on gradient and light direction
            $dotProductR = ($gxR * $lightX + $gyR * $lightY) * $embossStrength
            $dotProductG = ($gxG * $lightX + $gyG * $lightY) * $embossStrength
            $dotProductB = ($gxB * $lightX + $gyB * $lightY) * $embossStrength
            
            # Apply emboss effect with midtone bias
            $embossR = [Math]::Max(0, [Math]::Min(255, 128 + $dotProductR))
            $embossG = [Math]::Max(0, [Math]::Min(255, 128 + $dotProductG))
            $embossB = [Math]::Max(0, [Math]::Min(255, 128 + $dotProductB))
            
            $embossPixels[$index] = ([int]255 -shl 24) -bor ([int]$embossR -shl 16) -bor ([int]$embossG -shl 8) -bor [int]$embossB
        }
    }
    
    # Handle borders
    for ($y = 0; $y -lt $bgHeight; $y++) {
        for ($x = 0; $x -lt $bgWidth; $x++) {
            $index = $y * $bgWidth + $x
            if ($x -eq 0 -or $x -eq ($bgWidth - 1) -or $y -eq 0 -or $y -eq ($bgHeight - 1)) {
                $embossPixels[$index] = ([int]255 -shl 24) -bor ([int]128 -shl 16) -bor ([int]128 -shl 8) -bor [int]128
            }
        }
    }
    
    $embossLayer.SaveArgb32Pixels($bgRect, $embossPixels)
    $embossLayer.Opacity = 200
    Write-Host "Advanced Emboss effect applied with Sobel gradient detection" -ForegroundColor Green
    
    # Custom Renderer 3: Color Halftone Effect
    Write-Host "Applying Custom Renderer 3: Color Halftone Effect..." -ForegroundColor Magenta
    
    $halftoneLayer = $psdImage.AddRegularLayer()
    $halftoneLayer.DisplayName = "Color Halftone Filter"
    $halftoneLayer.Left = 0
    $halftoneLayer.Top = 0
    $halftoneLayer.Right = $width
    $halftoneLayer.Bottom = $height
    
    $halftonePixels = New-Object 'int[]' ($bgWidth * $bgHeight)
    
    # Initialize with white background
    for ($i = 0; $i -lt $halftonePixels.Length; $i++) {
        $halftonePixels[$i] = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]255 -shl 8) -bor [int]255
    }
    
    # Color halftone with different dot patterns for RGB
    $dotSize = 8
    $angles = @(15, 45, 75)  # Different angles for RGB channels
    
    for ($channel = 0; $channel -lt 3; $channel++) {
        $angle = $angles[$channel] * [Math]::PI / 180
        $cosAngle = [Math]::Cos($angle)
        $sinAngle = [Math]::Sin($angle)
        
        for ($y = 0; $y -lt $bgHeight; $y += $dotSize) {
            for ($x = 0; $x -lt $bgWidth; $x += $dotSize) {
                # Sample source color at this position
                if ($y -lt $bgHeight -and $x -lt $bgWidth) {
                    $sourceIndex = $y * $bgWidth + $x
                    $sourceColor = $bgPixels[$sourceIndex]
                    
                    $sourceR = ($sourceColor -shr 16) -band 0xFF
                    $sourceG = ($sourceColor -shr 8) -band 0xFF
                    $sourceB = $sourceColor -band 0xFF
                    
                    # Get channel intensity
                    $intensity = switch ($channel) {
                        0 { $sourceR / 255.0 }
                        1 { $sourceG / 255.0 }
                        2 { $sourceB / 255.0 }
                    }
                    
                    # Calculate dot radius based on intensity
                    $dotRadius = $intensity * ($dotSize / 2)
                    
                    # Draw dot with rotation
                    for ($dy = -$dotSize; $dy -le $dotSize; $dy++) {
                        for ($dx = -$dotSize; $dx -le $dotSize; $dx++) {
                            $targetX = $x + $dx
                            $targetY = $y + $dy
                            
                            if ($targetX -ge 0 -and $targetX -lt $bgWidth -and $targetY -ge 0 -and $targetY -lt $bgHeight) {
                                # Rotate coordinates
                                $rotX = $dx * $cosAngle - $dy * $sinAngle
                                $rotY = $dx * $sinAngle + $dy * $cosAngle
                                $distance = [Math]::Sqrt($rotX * $rotX + $rotY * $rotY)
                                
                                if ($distance -le $dotRadius) {
                                    $targetIndex = $targetY * $bgWidth + $targetX
                                    $currentColor = $halftonePixels[$targetIndex]
                                    
                                    $currentR = ($currentColor -shr 16) -band 0xFF
                                    $currentG = ($currentColor -shr 8) -band 0xFF
                                    $currentB = $currentColor -band 0xFF
                                    
                                    # Blend with channel color
                                    $newR = $currentR
                                    $newG = $currentG
                                    $newB = $currentB
                                    
                                    switch ($channel) {
                                        0 { $newR = [Math]::Min(255, $newR + $sourceR * $intensity) }
                                        1 { $newG = [Math]::Min(255, $newG + $sourceG * $intensity) }
                                        2 { $newB = [Math]::Min(255, $newB + $sourceB * $intensity) }
                                    }
                                    
                                    $halftonePixels[$targetIndex] = ([int]255 -shl 24) -bor ([int]$newR -shl 16) -bor ([int]$newG -shl 8) -bor [int]$newB
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    $halftoneLayer.SaveArgb32Pixels($bgRect, $halftonePixels)
    $halftoneLayer.Opacity = 160
    Write-Host "Color Halftone effect applied with rotated dot patterns" -ForegroundColor Green
    
    # Create info panel
    Write-Host "Adding custom renderer information panel..." -ForegroundColor Cyan
    
    $infoLayer = $psdImage.AddRegularLayer()
    $infoLayer.DisplayName = "Custom Renderer Info"
    $infoLayer.Left = 0
    $infoLayer.Top = 0
    $infoLayer.Right = $width
    $infoLayer.Bottom = $height
    
    $infoPixels = New-Object 'int[]' ($bgWidth * $bgHeight)
    
    # Initialize transparent
    for ($i = 0; $i -lt $infoPixels.Length; $i++) {
        $infoPixels[$i] = ([int]0 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0
    }
    
    # Add info panel background
    $panelX = 20
    $panelY = 20
    $panelWidth = 300
    $panelHeight = 160
    
    for ($y = $panelY; $y -lt ($panelY + $panelHeight) -and $y -lt $bgHeight; $y++) {
        for ($x = $panelX; $x -lt ($panelX + $panelWidth) -and $x -lt $bgWidth; $x++) {
            $index = $y * $bgWidth + $x
            $alpha = if ($x -eq $panelX -or $x -eq ($panelX + $panelWidth - 1) -or $y -eq $panelY -or $y -eq ($panelY + $panelHeight - 1)) { 255 } else { 200 }
            $color = if ($alpha -eq 255) { ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]150 -shl 8) -bor [int]255 } else { ([int]200 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0 }
            $infoPixels[$index] = $color
        }
    }
    
    # Add visual indicators for each renderer type
    $indicators = @(
        @{ name = "Oil Painting"; x = 40; y = 50; color = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]165 -shl 8) -bor [int]0 },
        @{ name = "Emboss"; x = 40; y = 80; color = ([int]255 -shl 24) -bor ([int]128 -shl 16) -bor ([int]128 -shl 8) -bor [int]128 },
        @{ name = "Halftone"; x = 40; y = 110; color = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]0 -shl 8) -bor [int]255 }
    )
    
    foreach ($indicator in $indicators) {
        # Draw indicator square
        for ($dy = 0; $dy -lt 8; $dy++) {
            for ($dx = 0; $dx -lt 8; $dx++) {
                $indX = $indicator.x + $dx
                $indY = $indicator.y + $dy
                if ($indX -lt $bgWidth -and $indY -lt $bgHeight) {
                    $indIndex = $indY * $bgWidth + $indX
                    $infoPixels[$indIndex] = $indicator.color
                }
            }
        }
    }
    
    $infoLayer.SaveArgb32Pixels($bgRect, $infoPixels)
    Write-Host "Information panel added successfully" -ForegroundColor Green
    
    # Display information in console
    Write-Host "`nCustom Renderer Information:" -ForegroundColor Yellow
    Write-Host "  CUSTOM RENDERERS APPLIED:" -ForegroundColor White
    Write-Host "  1. Oil Painting Renderer" -ForegroundColor White
    Write-Host "     - Brush stroke simulation" -ForegroundColor Gray
    Write-Host "     - Color quantization" -ForegroundColor Gray
    Write-Host "  2. Advanced Emboss Renderer" -ForegroundColor White
    Write-Host "     - Sobel gradient detection" -ForegroundColor Gray
    Write-Host "     - Lighting simulation" -ForegroundColor Gray
    Write-Host "  3. Color Halftone Renderer" -ForegroundColor White
    Write-Host "     - Multi-angle dot patterns" -ForegroundColor Gray
    Write-Host "     - Channel separation" -ForegroundColor Gray
    
    # Save as PSD
    Write-Host "`nSaving PSD file: $psdFile" -ForegroundColor Yellow
    $psdImage.Save($psdFile)
    
    # Save as PNG preview
    Write-Host "Saving PNG preview: $pngFile" -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($pngFile, $pngOptions)
    
    Write-Host "`n=== Custom Renderer Test Completed Successfully ===" -ForegroundColor Green
    Write-Host "Features demonstrated:" -ForegroundColor Cyan
    Write-Host "• Oil Painting custom renderer with brush stroke simulation" -ForegroundColor White
    Write-Host "• Advanced Emboss renderer with Sobel gradient detection" -ForegroundColor White
    Write-Host "• Color Halftone renderer with multi-angle dot patterns" -ForegroundColor White
    Write-Host "• Custom algorithm implementation for each effect" -ForegroundColor White
    Write-Host "• Layer blending and opacity control" -ForegroundColor White
    Write-Host "• Information panel with renderer details" -ForegroundColor White
    
} catch {
    Write-Host "Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}