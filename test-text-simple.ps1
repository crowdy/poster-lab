# Simplified text layer test script for Aspose.PSD
# Focuses on basic text layer operations without Graphics dependencies

# Load Aspose.PSD assembly using dot-sourcing
. ./Load-AsposePSD.ps1

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
$outputPath = join-path ${pwd} "${baseName}_text-simple.psd"
$previewPath = join-path ${pwd} "${baseName}_text-simple_preview.png"

Write-Host "`nStarting simplified text layer operations..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $img = [Aspose.PSD.Image]::Load($inputPath, $loadOptions)
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # Add multiple text layers with different styles
    $textLayers = @()
    
    # Text layer 1: Basic text
    Write-Host "`nCreating basic text layer..." -ForegroundColor Cyan
    try {
        $textRect1 = New-Object Aspose.PSD.Rectangle(50, 50, 500, 100)
        $textLayer1 = $psdImage.AddTextLayer("Welcome to Poster Lab", $textRect1)
        
        if ($textLayer1 -ne $null) {
            $textLayer1.DisplayName = "Welcome Text"
            
            # Update text properties
            if ($textLayer1.TextData -ne $null -and $textLayer1.TextData.Items -ne $null) {
                foreach ($portion in $textLayer1.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Arial"
                        $portion.Style.FontSize = 36
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(33, 150, 243)  # Blue
                    }
                }
                $textLayer1.TextData.UpdateLayerData()
            }
            
            $textLayers += $textLayer1
            Write-Host "  Created: Welcome Text" -ForegroundColor Green
        }
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 2: Subtitle text
    Write-Host "`nCreating subtitle text layer..." -ForegroundColor Cyan
    try {
        $textRect2 = New-Object Aspose.PSD.Rectangle(50, 150, 500, 80)
        $textLayer2 = $psdImage.AddTextLayer("Professional Design Solutions", $textRect2)
        
        if ($textLayer2 -ne $null) {
            $textLayer2.DisplayName = "Subtitle"
            
            # Update with different style
            if ($textLayer2.TextData -ne $null -and $textLayer2.TextData.Items -ne $null) {
                foreach ($portion in $textLayer2.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Arial"
                        $portion.Style.FontSize = 24
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(96, 125, 139)  # Gray-blue
                    }
                }
                $textLayer2.TextData.UpdateLayerData()
            }
            
            $textLayers += $textLayer2
            Write-Host "  Created: Subtitle" -ForegroundColor Green
        }
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 3: Call to action
    Write-Host "`nCreating call-to-action text layer..." -ForegroundColor Cyan
    try {
        $textRect3 = New-Object Aspose.PSD.Rectangle(50, 250, 400, 60)
        $textLayer3 = $psdImage.AddTextLayer("Get Started Today!", $textRect3)
        
        if ($textLayer3 -ne $null) {
            $textLayer3.DisplayName = "CTA Button Text"
            
            # Bold style for CTA
            if ($textLayer3.TextData -ne $null -and $textLayer3.TextData.Items -ne $null) {
                foreach ($portion in $textLayer3.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Arial"
                        $portion.Style.FontSize = 28
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(255, 87, 34)  # Orange-red
                    }
                }
                $textLayer3.TextData.UpdateLayerData()
            }
            
            $textLayers += $textLayer3
            Write-Host "  Created: CTA Button Text" -ForegroundColor Green
        }
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 4: Footer information
    Write-Host "`nCreating footer text layer..." -ForegroundColor Cyan
    try {
        $textRect4 = New-Object Aspose.PSD.Rectangle(50, 350, 600, 50)
        $textLayer4 = $psdImage.AddTextLayer("© 2025 Poster Lab | All Rights Reserved", $textRect4)
        
        if ($textLayer4 -ne $null) {
            $textLayer4.DisplayName = "Footer"
            
            # Small footer text
            if ($textLayer4.TextData -ne $null -and $textLayer4.TextData.Items -ne $null) {
                foreach ($portion in $textLayer4.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Arial"
                        $portion.Style.FontSize = 14
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(158, 158, 158)  # Light gray
                    }
                }
                $textLayer4.TextData.UpdateLayerData()
            }
            
            $textLayers += $textLayer4
            Write-Host "  Created: Footer" -ForegroundColor Green
        }
    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Update existing text layers in the document
    Write-Host "`nChecking for existing text layers to update..." -ForegroundColor Cyan
    $existingTextCount = 0
    
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $existingTextCount++
            $existingTextLayer = [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
            
            Write-Host "  Found: $($existingTextLayer.DisplayName)" -ForegroundColor Yellow
            
            # Ensure font compatibility
            if ($existingTextLayer.TextData -ne $null -and $existingTextLayer.TextData.Items -ne $null) {
                foreach ($portion in $existingTextLayer.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        # Only update if font might be problematic
                        if ($portion.Style.FontName -match "DejaVu") {
                            $originalFont = $portion.Style.FontName
                            $portion.Style.FontName = "Arial"
                            Write-Host "    Updated font from '$originalFont' to 'Arial'" -ForegroundColor Gray
                        }
                    }
                }
                $existingTextLayer.TextData.UpdateLayerData()
            }
        }
    }
    
    if ($existingTextCount -gt 0) {
        Write-Host "  Updated $existingTextCount existing text layer(s)" -ForegroundColor Green
    } else {
        Write-Host "  No existing text layers found" -ForegroundColor Gray
    }
    
    # Save results
    Write-Host "`nSaving results..." -ForegroundColor Yellow
    
    # Save as PSD
    $psdImage.Save($outputPath)
    Write-Host "  Saved PSD: $outputPath" -ForegroundColor Green
    
    # Save PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    Write-Host "  Saved PNG: $previewPath" -ForegroundColor Green
    
    # Summary
    Write-Host "`n" + ("=" * 60) -ForegroundColor Magenta
    Write-Host "OPERATION SUMMARY" -ForegroundColor Magenta
    Write-Host ("=" * 60) -ForegroundColor Magenta
    Write-Host "  New text layers created: $($textLayers.Count)" -ForegroundColor White
    Write-Host "  Existing layers updated: $existingTextCount" -ForegroundColor White
    Write-Host "  Total layers in PSD: $($psdImage.Layers.Count)" -ForegroundColor White
    Write-Host "  Output files generated: 2" -ForegroundColor White
    Write-Host ("=" * 60) -ForegroundColor Magenta
    
    Write-Host "`nSimplified text operations completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "`nERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "`nResources cleaned up" -ForegroundColor Gray
    }
}