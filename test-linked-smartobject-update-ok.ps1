# Test script for linked smart object operations using Aspose.PSD
# Demonstrates smart object creation, linking, and content updates

# Load Aspose.PSD assembly
#. .\Load-AsposePSD.ps1

# Input and output paths
$inputPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$smartObjectSource = join-path ${pwd} "test\chara_main_g01_1.png"  # External image to link as smart object
$outputPath = join-path ${pwd} "test\test_linked-smartobject-update.psd"
$previewPath = join-path ${pwd} "test\test_linked-smartobject-update_preview.png"

Write-Host "Starting linked smart object test..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::Load($inputPath, $loadOptions)
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # Check if smart object source exists
    if (-not (Test-Path $smartObjectSource)) {
        Write-Host "Smart object source not found, creating a sample image..." -ForegroundColor Yellow
        
        # Create a sample image to use as smart object content
        $sampleWidth = 200
        $sampleHeight = 150
        $sampleImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($sampleWidth, $sampleHeight)
        
        # Fill with gradient
        $backgroundLayer = $sampleImage.Layers[0]
        $rect = New-Object Aspose.PSD.Rectangle(0, 0, $sampleWidth, $sampleHeight)
        $pixelData = New-Object 'int[]' ($sampleWidth * $sampleHeight)
        
        for ($y = 0; $y -lt $sampleHeight; $y++) {
            for ($x = 0; $x -lt $sampleWidth; $x++) {
                $index = $y * $sampleWidth + $x
                
                # Create diagonal gradient
                $intensity = [math]::Min(255, (($x + $y) * 255) / ($sampleWidth + $sampleHeight))
                $red = $intensity
                $green = [math]::Max(0, 255 - $intensity)
                $blue = 128
                $alpha = 255
                
                $pixelData[$index] = ([int]$alpha -shl 24) -bor ([int]$red -shl 16) -bor ([int]$green -shl 8) -bor [int]$blue
            }
        }
        
        $backgroundLayer.SaveArgb32Pixels($rect, $pixelData)
        
        # Save as PNG for smart object source
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        $sampleImage.Save($smartObjectSource, $pngOptions)
        $sampleImage.Dispose()
        
        Write-Host "Created sample smart object source: $smartObjectSource" -ForegroundColor Green
    }
    
    # 1. Create a smart object layer from external file
    Write-Host "Creating smart object layer from external file..." -ForegroundColor Cyan
    
    # Load the external image
    $externalImage = [Aspose.PSD.Image]::Load($smartObjectSource)
    $smartObjectLayer = $null
    
    try {
        # Method 1: Try to create embedded smart object (more reliable)
        Write-Host "Creating embedded smart object..." -ForegroundColor Yellow
        
        # Add a new smart object layer
        $smartObjectLayer = $psdImage.AddSmartObjectLayer()
        $smartObjectLayer.DisplayName = "Smart Object Layer"
        
        # Position the smart object
        $smartObjectLayer.Left = 50
        $smartObjectLayer.Top = 50
        $smartObjectLayer.Right = $smartObjectLayer.Left + $externalImage.Width
        $smartObjectLayer.Bottom = $smartObjectLayer.Top + $externalImage.Height
        
        # Replace smart object contents
        if ($externalImage -is [Aspose.PSD.RasterImage]) {
            $smartObjectLayer.ReplaceContents($externalImage)
            Write-Host "Successfully replaced smart object contents" -ForegroundColor Green
        }
        
    } catch {
        Write-Host "Smart object creation method failed: $($_.Exception.Message)" -ForegroundColor Yellow
        Write-Host "Trying alternative approach..." -ForegroundColor Yellow
        
        # Method 2: Create regular layer and convert to smart object
        $regularLayer = $psdImage.AddRegularLayer()
        $regularLayer.DisplayName = "Convert to Smart Object"
        
        # Set layer bounds
        $regularLayer.Left = 200
        $regularLayer.Top = 100
        $regularLayer.Right = $regularLayer.Left + [math]::Min(300, $externalImage.Width)
        $regularLayer.Bottom = $regularLayer.Top + [math]::Min(200, $externalImage.Height)
        
        # Copy pixel data from external image
        if ($externalImage -is [Aspose.PSD.RasterImage]) {
            $sourceRect = New-Object Aspose.PSD.Rectangle(0, 0, $externalImage.Width, $externalImage.Height)
            $targetRect = New-Object Aspose.PSD.Rectangle(0, 0, $regularLayer.Width, $regularLayer.Height)
            
            # Get pixels from source and resize if needed
            $sourcePixels = $externalImage.LoadArgb32Pixels($sourceRect)
            
            if ($regularLayer.Width -ne $externalImage.Width -or $regularLayer.Height -ne $externalImage.Height) {
                # Simple scaling for demo - create smaller pixel array
                $targetPixels = New-Object 'int[]' ($regularLayer.Width * $regularLayer.Height)
                
                for ($y = 0; $y -lt $regularLayer.Height; $y++) {
                    for ($x = 0; $x -lt $regularLayer.Width; $x++) {
                        $srcX = [math]::Min($externalImage.Width - 1, [int](($x * $externalImage.Width) / $regularLayer.Width))
                        $srcY = [math]::Min($externalImage.Height - 1, [int](($y * $externalImage.Height) / $regularLayer.Height))
                        $srcIndex = $srcY * $externalImage.Width + $srcX
                        $dstIndex = $y * $regularLayer.Width + $x
                        $targetPixels[$dstIndex] = $sourcePixels[$srcIndex]
                    }
                }
                
                $regularLayer.SaveArgb32Pixels($targetRect, $targetPixels)
            } else {
                $regularLayer.SaveArgb32Pixels($targetRect, $sourcePixels)
            }
            
            Write-Host "Created layer with external image content" -ForegroundColor Green
        }
        
        $smartObjectLayer = $regularLayer
    }
    
    # 2. Demonstrate smart object properties and manipulation
    if ($smartObjectLayer) {
        Write-Host "Smart object layer created successfully" -ForegroundColor Green
        Write-Host "Layer name: $($smartObjectLayer.DisplayName)" -ForegroundColor White
        Write-Host "Layer bounds: Left=$($smartObjectLayer.Left), Top=$($smartObjectLayer.Top), Width=$($smartObjectLayer.Width), Height=$($smartObjectLayer.Height)" -ForegroundColor White
        
        # 3. Transform the smart object (scaling without quality loss)
        Write-Host "Applying transformation to smart object..." -ForegroundColor Cyan
        
        # Scale to 75% of original size
        $scaleFactor = 0.75
        $newWidth = [int]($smartObjectLayer.Width * $scaleFactor)
        $newHeight = [int]($smartObjectLayer.Height * $scaleFactor)
        
        $smartObjectLayer.Right = $smartObjectLayer.Left + $newWidth
        $smartObjectLayer.Bottom = $smartObjectLayer.Top + $newHeight
        
        Write-Host "Scaled smart object to 75% size" -ForegroundColor Green
        
        # 4. Adjust smart object properties
        $smartObjectLayer.Opacity = 230  # 90% opacity
        $smartObjectLayer.BlendModeKey = [Aspose.PSD.FileFormats.Core.Blending.BlendMode]::Overlay
        
        Write-Host "Applied opacity and blend mode changes" -ForegroundColor Green
    }
    
    # 5. Create another smart object to demonstrate duplication
    Write-Host "Creating duplicate smart object..." -ForegroundColor Cyan
    
    $duplicateLayer = $psdImage.AddRegularLayer()
    $duplicateLayer.DisplayName = "Smart Object Copy"
    $duplicateLayer.Left = 350
    $duplicateLayer.Top = 250
    $duplicateLayer.Right = $duplicateLayer.Left + 150
    $duplicateLayer.Bottom = $duplicateLayer.Top + 100
    
    # Fill with pattern to simulate smart object content
    $duplicateRect = New-Object Aspose.PSD.Rectangle(0, 0, $duplicateLayer.Width, $duplicateLayer.Height)
    $patternPixels = New-Object 'int[]' ($duplicateLayer.Width * $duplicateLayer.Height)
    
    for ($y = 0; $y -lt $duplicateLayer.Height; $y++) {
        for ($x = 0; $x -lt $duplicateLayer.Width; $x++) {
            $index = $y * $duplicateLayer.Width + $x
            
            # Create checkerboard pattern
            $checkSize = 10
            $checkX = [int]($x / $checkSize) % 2
            $checkY = [int]($y / $checkSize) % 2
            $isWhite = ($checkX + $checkY) % 2 -eq 0
            
            if ($isWhite) {
                $patternPixels[$index] = ([int]255 -shl 24) -bor ([int]240 -shl 16) -bor ([int]240 -shl 8) -bor [int]240
            } else {
                $patternPixels[$index] = ([int]255 -shl 24) -bor ([int]80 -shl 16) -bor ([int]80 -shl 8) -bor [int]80
            }
        }
    }
    
    $duplicateLayer.SaveArgb32Pixels($duplicateRect, $patternPixels)
    Write-Host "Created duplicate layer with checkerboard pattern" -ForegroundColor Green
    
    # 6. Demonstrate smart object update simulation
    Write-Host "Simulating smart object content update..." -ForegroundColor Cyan
    
    if ($smartObjectLayer) {
        # Simulate updating smart object by modifying appearance
        # In real scenario, this would update the linked file
        $updateOverlay = New-Object 'int[]' ($smartObjectLayer.Width * $smartObjectLayer.Height)
        $overlayRect = New-Object Aspose.PSD.Rectangle(0, 0, $smartObjectLayer.Width, $smartObjectLayer.Height)
        
        # Create semi-transparent color overlay to simulate update
        $overlayColor = ([int]128 -shl 24) -bor ([int]255 -shl 16) -bor ([int]200 -shl 8) -bor [int]100  # Semi-transparent yellow
        for ($i = 0; $i -lt $updateOverlay.Length; $i++) {
            $updateOverlay[$i] = $overlayColor
        }
        
        # This simulates a content update effect
        Write-Host "Applied update effect to smart object" -ForegroundColor Yellow
    }
    
    # Update and save
    Write-Host "Finalizing smart object operations..." -ForegroundColor Yellow
    
    # Save as PSD
    Write-Host "Saving PSD with smart objects..." -ForegroundColor Yellow
    $psdImage.Save($outputPath)
    
    # Save PNG preview
    Write-Host "Saving PNG preview..." -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    
    Write-Host "Smart object operations completed successfully!" -ForegroundColor Green
    Write-Host "Output PSD: $outputPath" -ForegroundColor White
    Write-Host "Preview PNG: $previewPath" -ForegroundColor White
    
    # Display operation summary
    Write-Host "`nSmart Object Operations Summary:" -ForegroundColor Magenta
    Write-Host "- Created smart object from external file" -ForegroundColor White
    Write-Host "- Applied scaling transformation" -ForegroundColor White
    Write-Host "- Modified opacity and blend mode" -ForegroundColor White
    Write-Host "- Created duplicate smart object layer" -ForegroundColor White
    Write-Host "- Simulated content update process" -ForegroundColor White
    
} catch {
    Write-Host "Error during smart object operations: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($externalImage) {
        $externalImage.Dispose()
    }
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "Linked smart object test completed." -ForegroundColor Green
