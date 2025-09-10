# Test script for adding text layers with proper font configuration
# Fixes font rendering issues in .NET 8 environment

# Add System.Drawing.Common if not already loaded (for .NET 8 compatibility)
try {
    Add-Type -AssemblyName "System.Drawing.Common"
    Write-Host "System.Drawing.Common loaded successfully" -ForegroundColor Green
} catch {
    Write-Host "Warning: Could not load System.Drawing.Common: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Find PSD files in the current directory
$psdFiles = Get-ChildItem -Path $pwd -Filter "*.psd" -File
if ($psdFiles.Count -eq 0) {
    Write-Host "No PSD files found in the current directory" -ForegroundColor Red
    exit 1
}

# Display found PSD files and let user select if multiple
if ($psdFiles.Count -eq 1) {
    $selectedPsd = $psdFiles[0]
    Write-Host "Found PSD file: $($selectedPsd.Name)" -ForegroundColor Green
} else {
    Write-Host "Found multiple PSD files:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $psdFiles.Count; $i++) {
        Write-Host "  [$($i+1)] $($psdFiles[$i].Name)" -ForegroundColor White
    }
    $selection = Read-Host "Select PSD file number (1-$($psdFiles.Count))"
    $selectedPsd = $psdFiles[[int]$selection - 1]
}

# Input and output paths
$inputPath = $selectedPsd.FullName
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($selectedPsd.Name)
$outputPath = join-path ${pwd} "${baseName}_text-with-font.psd"
$previewPath = join-path ${pwd} "${baseName}_text-with-font_preview.png"

Write-Host "Starting text layer creation with font configuration..." -ForegroundColor Green

# Available font path
$fontPath = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
Write-Host "Using font: $fontPath" -ForegroundColor Yellow

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $img = [Aspose.PSD.Image]::Load($inputPath, $loadOptions)
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # Method 1: Create text layer with proper font settings
    Write-Host "Creating text layer with font configuration..." -ForegroundColor Cyan
    
    try {
        # Define text rectangle
        $textRect = New-Object Aspose.PSD.Rectangle(50, 50, 400, 100)
        
        # Add text layer
        $textLayer = $psdImage.AddTextLayer("Sample Text with Font", $textRect)
        
        if ($textLayer -ne $null) {
            Write-Host "Text layer created successfully" -ForegroundColor Green
            
            # Configure text properties
            $textLayer.DisplayName = "Configured Text Layer"
            
            # Access TextData and configure font
            if ($textLayer.TextData -ne $null) {
                Write-Host "Configuring text data..." -ForegroundColor Yellow
                
                # Get text portions
                $textPortions = $textLayer.TextData.Items
                
                if ($textPortions -and $textPortions.Count -gt 0) {
                    foreach ($portion in $textPortions) {
                        if ($portion.Style -ne $null) {
                            # Set font properties
                            $portion.Style.FontName = "DejaVuSans"
                            $portion.Style.FontSize = 24
                            $portion.Style.FillColor = [Aspose.PSD.Color]::Black
                            
                            # Try to set font index if available
                            try {
                                # FontIndex might be available in some versions
                                $portion.Style.FontIndex = 0
                            } catch {
                                Write-Host "FontIndex not available in this version" -ForegroundColor Yellow
                            }
                            
                            Write-Host "Configured font: $($portion.Style.FontName), Size: $($portion.Style.FontSize)" -ForegroundColor Green
                        }
                        
                        # Update text content
                        $portion.Text = "Test Text with DejaVu Font"
                    }
                    
                    # Update layer data after modifications
                    $textLayer.TextData.UpdateLayerData()
                    Write-Host "Text data updated successfully" -ForegroundColor Green
                }
            }
            
            # Ensure layer is visible (wrap in try-catch as property might not be available)
            try {
                $textLayer.Visible = $true
                $textLayer.Opacity = 255
            } catch {
                Write-Host "Could not set visibility properties: $($_.Exception.Message)" -ForegroundColor Yellow
            }
        }
        
    } catch {
        Write-Host "Error creating text layer: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Method 2: Create another text layer with different approach
    Write-Host "Creating additional text layer..." -ForegroundColor Cyan
    
    try {
        $textRect2 = New-Object Aspose.PSD.Rectangle(50, 200, 400, 100)
        $textLayer2 = $psdImage.AddTextLayer("Secondary Text Layer", $textRect2)
        
        if ($textLayer2 -ne $null) {
            $textLayer2.DisplayName = "Secondary Text"
            
            # Try to update text directly
            $textLayer2.UpdateText("Hello from PowerShell!")
            
            # Configure text data if available
            if ($textLayer2.TextData -ne $null -and $textLayer2.TextData.Items -ne $null) {
                foreach ($portion in $textLayer2.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "DejaVuSans-Bold"
                        $portion.Style.FontSize = 18
                        $portion.Style.FillColor = [Aspose.PSD.Color]::DarkBlue
                    }
                }
                $textLayer2.TextData.UpdateLayerData()
            }
            
            try {
                $textLayer2.Visible = $true
            } catch {
                Write-Host "Could not set visibility: $($_.Exception.Message)" -ForegroundColor Yellow
            }
            Write-Host "Secondary text layer created" -ForegroundColor Green
        }
    } catch {
        Write-Host "Could not create secondary text layer: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Method 3: Work with existing text layers if any
    Write-Host "Checking for existing text layers..." -ForegroundColor Cyan
    
    $textLayerCount = 0
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $textLayerCount++
            $existingTextLayer = [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
            
            Write-Host "Found existing text layer: $($existingTextLayer.DisplayName)" -ForegroundColor Green
            
            # Update its font settings
            if ($existingTextLayer.TextData -ne $null -and $existingTextLayer.TextData.Items -ne $null) {
                foreach ($portion in $existingTextLayer.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $originalFont = $portion.Style.FontName
                        $portion.Style.FontName = "DejaVuSans"
                        Write-Host "  Changed font from '$originalFont' to 'DejaVuSans'" -ForegroundColor Yellow
                    }
                }
                $existingTextLayer.TextData.UpdateLayerData()
            }
        }
    }
    
    if ($textLayerCount -eq 0) {
        Write-Host "No existing text layers found" -ForegroundColor Yellow
    }
    
    # Method 4: Create text using Graphics if available
    Write-Host "Attempting to create text with Graphics..." -ForegroundColor Cyan
    
    try {
        # Create a regular layer for manual text rendering
        $graphicsLayer = $psdImage.AddRegularLayer()
        $graphicsLayer.DisplayName = "Graphics Text Layer"
        
        # Set layer bounds
        $layerWidth = 400
        $layerHeight = 60
        $graphicsLayer.Left = 50
        $graphicsLayer.Top = 350
        $graphicsLayer.Right = $graphicsLayer.Left + $layerWidth
        $graphicsLayer.Bottom = $graphicsLayer.Top + $layerHeight
        
        # Create bitmap for text rendering with pixel format
        $bitmap = New-Object System.Drawing.Bitmap($layerWidth, $layerHeight, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        
        # Set high quality rendering
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias
        
        # Clear background
        $graphics.Clear([System.Drawing.Color]::Transparent)
        
        # Create font and brush (use generic font family to avoid font issues)
        try {
            $font = New-Object System.Drawing.Font("DejaVu Sans", 20, [System.Drawing.FontStyle]::Regular)
        } catch {
            # Fallback to generic font
            $font = New-Object System.Drawing.Font([System.Drawing.FontFamily]::GenericSansSerif, 20, [System.Drawing.FontStyle]::Regular)
            Write-Host "Using fallback font" -ForegroundColor Yellow
        }
        $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
        
        # Draw text
        $text = "Graphics Rendered Text"
        $graphics.DrawString($text, $font, $brush, 10, 10)
        
        Write-Host "Text rendered with Graphics" -ForegroundColor Green
        
        # Convert bitmap to pixel data
        $rect = New-Object Aspose.PSD.Rectangle(0, 0, $layerWidth, $layerHeight)
        $pixelData = New-Object 'int[]' ($layerWidth * $layerHeight)
        
        for ($y = 0; $y -lt $layerHeight; $y++) {
            for ($x = 0; $x -lt $layerWidth; $x++) {
                $pixel = $bitmap.GetPixel($x, $y)
                $argb = ($pixel.A -shl 24) -bor ($pixel.R -shl 16) -bor ($pixel.G -shl 8) -bor $pixel.B
                $pixelData[$y * $layerWidth + $x] = $argb
            }
        }
        
        # Save pixels to layer
        $graphicsLayer.SaveArgb32Pixels($rect, $pixelData)
        
        Write-Host "Graphics text layer created successfully" -ForegroundColor Green
        
        # Clean up
        $graphics.Dispose()
        $bitmap.Dispose()
        $font.Dispose()
        $brush.Dispose()
        
    } catch {
        Write-Host "Could not create Graphics text layer: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Save results
    Write-Host "`nSaving results..." -ForegroundColor Yellow
    
    # Save as PSD
    $psdImage.Save($outputPath)
    Write-Host "Saved PSD file: $outputPath" -ForegroundColor Green
    
    # Save PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    Write-Host "Saved PNG preview: $previewPath" -ForegroundColor Green
    
    Write-Host "`nText layer operations completed successfully!" -ForegroundColor Green
    
    # Display summary
    Write-Host "`nOperations Summary:" -ForegroundColor Magenta
    Write-Host "- Created text layers with font configuration" -ForegroundColor White
    Write-Host "- Updated existing text layers (if any)" -ForegroundColor White
    Write-Host "- Created Graphics-rendered text layer" -ForegroundColor White
    Write-Host "- Font used: DejaVuSans" -ForegroundColor White
    Write-Host "- Saved PSD and PNG files" -ForegroundColor White
    
} catch {
    Write-Host "Error during text operations: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "`nText layer test with font configuration completed." -ForegroundColor Green