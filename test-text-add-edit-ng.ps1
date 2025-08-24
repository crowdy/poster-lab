# Test script for adding text layers using alternative methods for .NET 8 compatibility
# Avoids AddTextLayer method that has System.Drawing compatibility issues

# Load Aspose.PSD assembly
# . .\Load-AsposePSD.ps1

# Add System.Drawing.Common if not already loaded (for .NET 8 compatibility)
try {
    Add-Type -AssemblyName "System.Drawing.Common"
    Write-Host "System.Drawing.Common loaded successfully" -ForegroundColor Green
} catch {
    Write-Host "Warning: Could not load System.Drawing.Common: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Input and output paths
$inputPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$outputPath = join-path ${pwd} "test_text-alternative.psd"
$previewPath = join-path ${pwd} "test_text-alternative_preview.png"

Write-Host "Starting alternative text layer test..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $img = [Aspose.PSD.Image]::Load($inputPath, $loadOptions)
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # Method 1: Try creating new PSD with text layer (like C# SupportOfEditFontNameInTextPortionStyle example)
    Write-Host "Attempting to create new PSD with text layer..." -ForegroundColor Cyan
    
    try {
        # Create a new small PSD image for text testing
        $newPsdImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage(500, 500)
        
        # Add background fill layer
        $backgroundFillLayer = [Aspose.PSD.FileFormats.Psd.Layers.FillLayers.FillLayer]::CreateInstance([Aspose.PSD.FileFormats.Psd.Layers.FillSettings.FillType]::Color)
        $colorFillSettings = [Aspose.PSD.FileFormats.Psd.Layers.FillSettings.IColorFillSettings]$backgroundFillLayer.FillSettings
        $colorFillSettings.Color = [Aspose.PSD.Color]::White
        $newPsdImage.AddLayer($backgroundFillLayer)
        
        # Try to add text layer to new PSD
        $textRect = New-Object Aspose.PSD.Rectangle(10, 35, 480, 60)
        $textLayer = $newPsdImage.AddTextLayer("Test Text Layer", $textRect)
        
        if ($textLayer -ne $null) {
            Write-Host "Successfully created text layer in new PSD" -ForegroundColor Green
            
            # Save the new PSD with text
            $newPsdPath = join-path ${pwd} "test_new-text.psd"
            $newPsdImage.Save($newPsdPath)
            Write-Host "Saved new PSD with text layer: $newPsdPath" -ForegroundColor Green
        }
        
        $newPsdImage.Dispose()
        
    } catch {
        Write-Host "Could not create new PSD with text: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Method 2: Try to work with existing text layers only
    Write-Host "Searching for existing text layers..." -ForegroundColor Cyan
    
    $existingTextLayers = @()
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $existingTextLayers += [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
        }
    }
    
    Write-Host "Found $($existingTextLayers.Count) existing text layers" -ForegroundColor Green
    
    if ($existingTextLayers.Count -gt 0) {
        Write-Host "Working with existing text layers..." -ForegroundColor Cyan
        
        for ($i = 0; $i -lt $existingTextLayers.Count; $i++) {
            $textLayer = $existingTextLayers[$i]
            
            Write-Host "Text Layer $($i+1): $($textLayer.DisplayName)" -ForegroundColor White
            Write-Host "  Text: '$($textLayer.Text)'" -ForegroundColor Gray
            Write-Host "  Bounds: Left=$($textLayer.Left), Top=$($textLayer.Top), Width=$($textLayer.Width), Height=$($textLayer.Height)" -ForegroundColor Gray
            
            # Modify properties safely
            try {
                # Adjust opacity
                $originalOpacity = $textLayer.Opacity
                $textLayer.Opacity = [Math]::Max(100, $originalOpacity - 20)
                Write-Host "  Adjusted opacity from $originalOpacity to $($textLayer.Opacity)" -ForegroundColor Yellow
                
                # Ensure visibility
                $textLayer.Visible = $true
                
                # Try to modify text content if possible
                if ($textLayer.TextData -and $textLayer.TextData.Items -and $textLayer.TextData.Items.Count -gt 0) {
                    Write-Host "  TextData available - attempting to modify font size" -ForegroundColor Green
                    
                    $firstPortion = $textLayer.TextData.Items[0]
                    if ($firstPortion.Style) {
                        $originalFontSize = $firstPortion.Style.FontSize
                        $firstPortion.Style.FontSize = [Math]::Max(12, $originalFontSize + 2)
                        Write-Host "  Changed font size from $originalFontSize to $($firstPortion.Style.FontSize)" -ForegroundColor Green
                        
                        # Update layer data
                        $textLayer.TextData.UpdateLayerData()
                        Write-Host "  Updated layer data successfully" -ForegroundColor Green
                    }
                }
                
            } catch {
                Write-Host "  Could not modify text layer: $($_.Exception.Message)" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "No existing text layers found in the PSD" -ForegroundColor Yellow
    }
    
    # Method 3: Create regular layer and manually add text-like content
    Write-Host "Creating regular layer with text-like content..." -ForegroundColor Cyan
    
    try {
        $regularLayer = $psdImage.AddRegularLayer()
        if ($regularLayer -ne $null) {
            $regularLayer.DisplayName = "Manual Text Layer"
            
            # Set layer bounds
            $layerWidth = 300
            $layerHeight = 50
            $regularLayer.Left = 50
            $regularLayer.Top = 50
            $regularLayer.Right = $regularLayer.Left + $layerWidth
            $regularLayer.Bottom = $regularLayer.Top + $layerHeight
            
            # Create simple colored rectangle to simulate text area
            $rect = New-Object Aspose.PSD.Rectangle(0, 0, $layerWidth, $layerHeight)
            $pixelData = New-Object 'int[]' ($layerWidth * $layerHeight)
            
            # Fill with semi-transparent color to indicate text area
            $textColor = ([int]200 -shl 24) -bor ([int]100 -shl 16) -bor ([int]100 -shl 8) -bor [int]100
            for ($i = 0; $i -lt $pixelData.Length; $i++) {
                $pixelData[$i] = $textColor
            }
            
            $regularLayer.SaveArgb32Pixels($rect, $pixelData)
            Write-Host "Created regular layer as text placeholder" -ForegroundColor Green
        }
    } catch {
        Write-Host "Could not create regular layer: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Method 4: Try different approach for adding text
    Write-Host "Attempting alternative text creation method..." -ForegroundColor Cyan
    
    try {
        # Try to use Graphics-based approach (if available)
        Write-Host "Checking for alternative text methods..." -ForegroundColor Yellow
        
        # Create a simple text representation using regular layer
        $textRepLayer = $psdImage.AddRegularLayer()
        if ($textRepLayer -ne $null) {
            $textRepLayer.DisplayName = "Text Representation"
            $textRepLayer.Left = 100
            $textRepLayer.Top = 150
            $textRepLayer.Right = 400
            $textRepLayer.Bottom = 200
            
            Write-Host "Created text representation layer" -ForegroundColor Green
        }
        
    } catch {
        Write-Host "Alternative text method failed: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Save results
    Write-Host "Saving results..." -ForegroundColor Yellow
    
    # Save as PSD
    $psdImage.Save($outputPath)
    Write-Host "Saved PSD file: $outputPath" -ForegroundColor Green
    
    # Save PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    Write-Host "Saved PNG preview: $previewPath" -ForegroundColor Green
    
    Write-Host "Alternative text layer operations completed!" -ForegroundColor Green
    
    # Display summary
    Write-Host "`nOperations Summary:" -ForegroundColor Magenta
    Write-Host "- Attempted new PSD creation with text layer" -ForegroundColor White
    Write-Host "- Modified existing text layers ($($existingTextLayers.Count) found)" -ForegroundColor White
    Write-Host "- Created regular layers as text placeholders" -ForegroundColor White
    Write-Host "- Successfully saved PSD and PNG files" -ForegroundColor White
    Write-Host "`nNote: AddTextLayer method incompatible with .NET 8" -ForegroundColor Red
    Write-Host "Consider using older .NET version or alternative text creation methods" -ForegroundColor Yellow
    
} catch {
    Write-Host "Error during alternative text operations: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "Alternative text layer test completed." -ForegroundColor Green