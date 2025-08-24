# test-smartobject-copying.ps1
# Demonstrates smart object copying operations in Aspose.PSD
# Script #11 of 18 - Smart Objects: Copying and Duplication

# Load Aspose.PSD
# . ".\Load-AsposePSD.ps1"

try {
    Write-Host "=== Smart Object Copying Demo ===" -ForegroundColor Cyan
    
    # Create a new PSD image
    $width = 900
    $height = 700
    
    Write-Host "Creating new PSD image (${width}x${height})..." -ForegroundColor Yellow
    $image = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($width, $height)
    
    # Create white background
    $backgroundColor = [Aspose.PSD.Color]::White
    $graphics = New-Object Aspose.PSD.Graphics($image)
    $graphics.Clear($backgroundColor)
    
    Write-Host "Creating and copying smart objects..." -ForegroundColor Green
    
    # 1. Create original smart object (source)
    Write-Host "1. Creating original smart object..." -ForegroundColor White
    
    # Create source content
    $sourceWidth = 120
    $sourceHeight = 120
    $sourceLayer = $image.AddRegularLayer()
    $sourceLayer.DisplayName = "Original Smart Object"
    $sourceLayer.Left = 50
    $sourceLayer.Top = 50
    $sourceLayer.Right = 50 + $sourceWidth
    $sourceLayer.Bottom = 50 + $sourceHeight
    
    # Create distinctive content using pixel manipulation
    $sourceRect = New-Object Aspose.PSD.Rectangle(0, 0, $sourceWidth, $sourceHeight)
    $sourcePixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    # Create a complex pattern with gradient background and circles
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            # Create blue to red gradient
            $ratio = [Math]::Min(1.0, ($x + $y) / ($sourceWidth + $sourceHeight))
            $red = [int](0 + $ratio * 255)
            $green = [int](0)
            $blue = [int](255 - $ratio * 255)
            
            # Add yellow circle
            $centerX = $sourceWidth / 2
            $centerY = $sourceHeight / 2
            $distance = [Math]::Sqrt([Math]::Pow($x - $centerX, 2) + [Math]::Pow($y - $centerY, 2))
            
            if ($distance -lt 40) {
                $red = 255; $green = 255; $blue = 0
                
                # Add green inner circle
                if ($distance -lt 20) {
                    $red = 0; $green = 255; $blue = 0
                }
            }
            
            $alpha = 255
            $sourcePixels[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
        }
    }
    
    $sourceLayer.SaveArgb32Pixels($sourceRect, $sourcePixels)
    Write-Host "   Original smart object created with complex pattern" -ForegroundColor Green
    
    # 2. Create multiple copies using layer duplication
    Write-Host "2. Creating copies using layer duplication..." -ForegroundColor White
    
    $copies = @()
    $positions = @(
        @{X=200; Y=50},   # Copy 1
        @{X=350; Y=50},   # Copy 2
        @{X=500; Y=50},   # Copy 3
        @{X=650; Y=50}    # Copy 4
    )
    
    for ($i = 0; $i -lt $positions.Length; $i++) {
        # Create duplicate layer
        $copyLayer = $image.AddRegularLayer()
        $copyLayer.DisplayName = "Smart Object Copy $($i + 1)"
        $copyLayer.Left = $positions[$i].X
        $copyLayer.Top = $positions[$i].Y
        $copyLayer.Right = $positions[$i].X + $sourceWidth
        $copyLayer.Bottom = $positions[$i].Y + $sourceHeight
        
        # Copy the same content (simulate smart object sharing)
        $copyLayer.SaveArgb32Pixels($sourceRect, $sourcePixels)
        
        $copies += $copyLayer
        Write-Host "   Copy $($i + 1) created at position ($($positions[$i].X), $($positions[$i].Y))" -ForegroundColor Green
    }
    
    # 3. Create copies with transformations
    Write-Host "3. Creating copies with transformations..." -ForegroundColor White
    
    $transformedPositions = @(
        @{X=50; Y=220; ScaleX=0.5; ScaleY=0.5; Name="Scaled Down 50%"},
        @{X=200; Y=220; ScaleX=1.5; ScaleY=1.5; Name="Scaled Up 150%"},
        @{X=400; Y=220; ScaleX=1.0; ScaleY=0.5; Name="Horizontally Stretched"},
        @{X=600; Y=220; ScaleX=0.5; ScaleY=1.5; Name="Vertically Stretched"}
    )
    
    for ($i = 0; $i -lt $transformedPositions.Length; $i++) {
        $transform = $transformedPositions[$i]
        $scaledWidth = [int]($sourceWidth * $transform.ScaleX)
        $scaledHeight = [int]($sourceHeight * $transform.ScaleY)
        
        $transformedLayer = $image.AddRegularLayer()
        $transformedLayer.DisplayName = $transform.Name
        $transformedLayer.Left = $transform.X
        $transformedLayer.Top = $transform.Y
        $transformedLayer.Right = $transform.X + $scaledWidth
        $transformedLayer.Bottom = $transform.Y + $scaledHeight
        
        # Create scaled content using pixel manipulation
        $scaledRect = New-Object Aspose.PSD.Rectangle(0, 0, $scaledWidth, $scaledHeight)
        $scaledPixels = New-Object 'int[]' ($scaledWidth * $scaledHeight)
        
        for ($y = 0; $y -lt $scaledHeight; $y++) {
            for ($x = 0; $x -lt $scaledWidth; $x++) {
                $index = $y * $scaledWidth + $x
                
                # Map to original coordinates
                $origX = [int]($x / $transform.ScaleX)
                $origY = [int]($y / $transform.ScaleY)
                
                if ($origX -lt $sourceWidth -and $origY -lt $sourceHeight) {
                    $origIndex = $origY * $sourceWidth + $origX
                    $scaledPixels[$index] = $sourcePixels[$origIndex]
                } else {
                    $scaledPixels[$index] = ([int]255 -shl 24) -bor ([int]255 -shl 16) -bor ([int]255 -shl 8) -bor [int]255
                }
            }
        }
        
        $transformedLayer.SaveArgb32Pixels($scaledRect, $scaledPixels)
        Write-Host "   $($transform.Name) created" -ForegroundColor Green
    }
    
    # 4. Create linked copies (demonstrate shared content concept)
    Write-Host "4. Creating linked copies demonstration..." -ForegroundColor White
    
    # Create shared content identifier
    $sharedContentId = [System.Guid]::NewGuid().ToString().Substring(0, 8)
    
    $linkedPositions = @(
        @{X=50; Y=400},
        @{X=200; Y=400},
        @{X=350; Y=400}
    )
    
    # Create linked content with border to show they're linked
    $linkedPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            # Add border
            if ($x -lt 5 -or $x -ge ($sourceWidth - 5) -or $y -lt 5 -or $y -ge ($sourceHeight - 5)) {
                $linkedPixels[$index] = ([int]255 -shl 24) -bor ([int]0 -shl 16) -bor ([int]0 -shl 8) -bor [int]0 # Black border
            } else {
                # Use original content but adjusted for border
                $innerX = $x - 5
                $innerY = $y - 5
                $innerWidth = $sourceWidth - 10
                $innerHeight = $sourceHeight - 10
                
                # Create same pattern as original but smaller
                $ratio = [Math]::Min(1.0, ($innerX + $innerY) / ($innerWidth + $innerHeight))
                $red = [int](0 + $ratio * 255)
                $green = [int](0)
                $blue = [int](255 - $ratio * 255)
                
                # Add yellow circle
                $centerX = $innerWidth / 2
                $centerY = $innerHeight / 2
                $distance = [Math]::Sqrt([Math]::Pow($innerX - $centerX, 2) + [Math]::Pow($innerY - $centerY, 2))
                
                if ($distance -lt 35) {
                    $red = 255; $green = 255; $blue = 0
                    
                    # Add green inner circle
                    if ($distance -lt 17) {
                        $red = 0; $green = 255; $blue = 0
                    }
                }
                
                $alpha = 255
                $linkedPixels[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
            }
        }
    }
    
    for ($i = 0; $i -lt $linkedPositions.Length; $i++) {
        $linkedLayer = $image.AddRegularLayer()
        $linkedLayer.DisplayName = "Linked SO [$sharedContentId] - Instance $($i + 1)"
        $linkedLayer.Left = $linkedPositions[$i].X
        $linkedLayer.Top = $linkedPositions[$i].Y
        $linkedLayer.Right = $linkedPositions[$i].X + $sourceWidth
        $linkedLayer.Bottom = $linkedPositions[$i].Y + $sourceHeight
        
        # All linked copies have identical content
        $linkedLayer.SaveArgb32Pixels($sourceRect, $linkedPixels)
        
        Write-Host "   Linked instance $($i + 1) created" -ForegroundColor Green
    }
    
    # 5. Demonstrate content update simulation
    Write-Host "5. Simulating content update across linked copies..." -ForegroundColor White
    
    # Create "updated" versions showing how linked smart objects would update together
    $updatedPositions = @(
        @{X=550; Y=400},
        @{X=700; Y=400}
    )
    
    # Create updated content (purple theme instead of blue/red)
    $updatedPixels = New-Object 'int[]' ($sourceWidth * $sourceHeight)
    
    for ($y = 0; $y -lt $sourceHeight; $y++) {
        for ($x = 0; $x -lt $sourceWidth; $x++) {
            $index = $y * $sourceWidth + $x
            
            # Add dark magenta border
            if ($x -lt 5 -or $x -ge ($sourceWidth - 5) -or $y -lt 5 -or $y -ge ($sourceHeight - 5)) {
                $updatedPixels[$index] = ([int]255 -shl 24) -bor ([int]139 -shl 16) -bor ([int]0 -shl 8) -bor [int]139 # Dark magenta border
            } else {
                # Updated content with purple theme
                $innerX = $x - 5
                $innerY = $y - 5
                $innerWidth = $sourceWidth - 10
                $innerHeight = $sourceHeight - 10
                
                # Create purple to pink gradient
                $ratio = [Math]::Min(1.0, ($innerX + $innerY) / ($innerWidth + $innerHeight))
                $red = [int](128 + $ratio * 127)   # Purple to Pink
                $green = [int](0 + $ratio * 192)
                $blue = [int](128 + $ratio * 127)
                
                # Add cyan circle
                $centerX = $innerWidth / 2
                $centerY = $innerHeight / 2
                $distance = [Math]::Sqrt([Math]::Pow($innerX - $centerX, 2) + [Math]::Pow($innerY - $centerY, 2))
                
                if ($distance -lt 35) {
                    $red = 0; $green = 255; $blue = 255 # Cyan
                    
                    # Add orange inner circle
                    if ($distance -lt 17) {
                        $red = 255; $green = 165; $blue = 0 # Orange
                    }
                }
                
                $alpha = 255
                $updatedPixels[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
            }
        }
    }
    
    for ($i = 0; $i -lt $updatedPositions.Length; $i++) {
        $updatedLayer = $image.AddRegularLayer()
        $updatedLayer.DisplayName = "Updated Linked SO [$sharedContentId] - Instance $($i + 4)"
        $updatedLayer.Left = $updatedPositions[$i].X
        $updatedLayer.Top = $updatedPositions[$i].Y
        $updatedLayer.Right = $updatedPositions[$i].X + $sourceWidth
        $updatedLayer.Bottom = $updatedPositions[$i].Y + $sourceHeight
        
        # Updated content
        $updatedLayer.SaveArgb32Pixels($sourceRect, $updatedPixels)
        
        Write-Host "   Updated linked instance $($i + 4) created" -ForegroundColor Green
    }
    
    # 6. Add informational text
    Write-Host "6. Adding informational labels..." -ForegroundColor White
    
    try {
        $labels = @(
            @{Text="Original"; X=50; Y=30},
            @{Text="Direct Copies"; X=200; Y=30},
            @{Text="Scaled Copies"; X=50; Y=200},
            @{Text="Linked Instances (Before Update)"; X=50; Y=380},
            @{Text="Linked Instances (After Update)"; X=550; Y=380}
        )
        
        foreach ($label in $labels) {
            $labelRect = New-Object Aspose.PSD.Rectangle($label.X, $label.Y, 300, 20)
            $labelLayer = $image.AddTextLayer($label.Text, $labelRect)
            if ($labelLayer -and $labelLayer.TextData -and $labelLayer.TextData.Items -and $labelLayer.TextData.Items.Count -gt 0) {
                $labelLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::Black
                $labelLayer.TextData.Items[0].Style.FontSize = 12
                $labelLayer.TextData.UpdateLayerData()
            }
        }
        
        # Add summary information
        $summaryY = 580
        $summaryTexts = @(
            "Smart Object Copying Concepts:",
            "• Direct copies: Independent instances with same appearance",
            "• Linked copies: Share the same source content",
            "• Transformations: Scaling, rotation while preserving quality",
            "• Content updates: Changes propagate to all linked instances"
        )
        
        for ($i = 0; $i -lt $summaryTexts.Length; $i++) {
            $summaryRect = New-Object Aspose.PSD.Rectangle(50, $summaryY + ($i * 20), 800, 18)
            $summaryLayer = $image.AddTextLayer($summaryTexts[$i], $summaryRect)
            if ($summaryLayer -and $summaryLayer.TextData -and $summaryLayer.TextData.Items -and $summaryLayer.TextData.Items.Count -gt 0) {
                $summaryLayer.TextData.Items[0].Style.FillColor = [Aspose.PSD.Color]::DarkBlue
                $summaryLayer.TextData.Items[0].Style.FontSize = 11
                $summaryLayer.TextData.UpdateLayerData()
            }
        }
        
        Write-Host "   Text labels added successfully" -ForegroundColor Green
    } catch {
        Write-Host "   Could not add text layers (expected in .NET 8): $($_.Exception)" -ForegroundColor Yellow
    }
    
    Write-Host "Smart object copying demonstration completed!" -ForegroundColor Green
    
    # Save as PSD
    $outputPsd = join-path ${pwd} "test/smartobject_copying_output.psd"
    Write-Host "Saving PSD file: $outputPsd" -ForegroundColor Yellow
    $image.Save($outputPsd)
    
    # Save as PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $outputPng = join-path ${pwd} "test/smartobject_copying_preview.png"
    Write-Host "Saving PNG preview: $outputPng" -ForegroundColor Yellow
    $image.Save($outputPng, $pngOptions)
    
    Write-Host "=== Smart Object Copying Demo Completed Successfully ===" -ForegroundColor Cyan
    Write-Host "Output files:" -ForegroundColor White
    Write-Host "- PSD: $outputPsd" -ForegroundColor Gray
    Write-Host "- PNG: $outputPng" -ForegroundColor Gray
    
    # Display summary
    Write-Host "`nDemonstrations included:" -ForegroundColor White
    Write-Host "1. Original smart object creation with complex pattern" -ForegroundColor Gray
    Write-Host "2. Multiple copies using layer duplication" -ForegroundColor Gray
    Write-Host "3. Copies with various transformations (scaling, stretching)" -ForegroundColor Gray
    Write-Host "4. Linked copies demonstration with shared content concept" -ForegroundColor Gray
    Write-Host "5. Content update simulation across linked instances" -ForegroundColor Gray
    Write-Host "6. Informational labels and documentation" -ForegroundColor Gray
    
} catch {
    Write-Host "Error occurred: $($_.Exception)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($image) {
        $image.Dispose()
        Write-Host "Resources disposed." -ForegroundColor Gray
    }
}

Write-Host "`nScript completed." -ForegroundColor Cyan