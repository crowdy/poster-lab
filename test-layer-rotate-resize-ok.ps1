# Test script for layer rotation and resize operations using Aspose.PSD
# Demonstrates layer transformation capabilities including rotation and scaling

# Load Aspose.PSD assembly
# . .\Load-AsposePSD.ps1

# Input and output paths
$inputPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$outputPath = join-path ${pwd} "test_layer-rotate-resize.psd"
$previewPath = join-path ${pwd} "test_layer-rotate-resize_preview.png"

Write-Host "Starting layer rotation and resize test..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::Load($inputPath, $loadOptions)
    
    Write-Host "Loaded PSD with $($psdImage.Layers.Count) layers" -ForegroundColor Yellow
    
    # 1. 전체 이미지 회전 및 리사이즈 (C# 예제와 동일한 방식)
    Write-Host "Applying rotation to entire image..." -ForegroundColor Cyan
    
    # RotateFlip 적용 (270도 회전 + XY 플립)
    $rotateFlipType = [Aspose.PSD.RotateFlipType]::Rotate270FlipXY
    $psdImage.RotateFlip($rotateFlipType)
    Write-Host "Applied RotateFlip: Rotate270FlipXY" -ForegroundColor Green
    
    # 2. 이미지 리사이즈 (C# 예제와 동일한 방식)
    Write-Host "Resizing image..." -ForegroundColor Cyan
    $newWidth = 800
    $newHeight = 600
    $psdImage.Resize($newWidth, $newHeight)
    Write-Host "Resized image to ${newWidth}x${newHeight}" -ForegroundColor Green
    
    # 3. 개별 레이어 속성 조정
    Write-Host "Adjusting layer properties..." -ForegroundColor Cyan
    
    # 적절한 레이어 찾기 (배경 레이어 제외)
    $targetLayer = $null
    for ($i = 1; $i -lt $psdImage.Layers.Count; $i++) {
        $layer = $psdImage.Layers[$i]
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.Layer]) {
            $targetLayer = $layer
            Write-Host "Selected layer '$($layer.DisplayName)' for property adjustment" -ForegroundColor Cyan
            break
        }
    }
    
    if ($targetLayer -ne $null) {
        # 투명도 조정
        $targetLayer.Opacity = 204  # 80% of 255
        Write-Host "Adjusted layer opacity to 80%" -ForegroundColor Green
        
        # 블렌드 모드 변경
        $targetLayer.BlendModeKey = [Aspose.PSD.FileFormats.Core.Blending.BlendMode]::Multiply
        Write-Host "Changed blend mode to Multiply" -ForegroundColor Green
        
        # 레이어 위치 조정
        $offsetX = 50
        $offsetY = 30
        $originalLeft = $targetLayer.Left
        $originalTop = $targetLayer.Top
        $targetLayer.Left = $originalLeft + $offsetX
        $targetLayer.Top = $originalTop + $offsetY
        $targetLayer.Right = $targetLayer.Right + $offsetX
        $targetLayer.Bottom = $targetLayer.Bottom + $offsetY
        Write-Host "Moved layer by offset (${offsetX}, ${offsetY})" -ForegroundColor Green
    }
    
    # 4. 새 레이어 생성 및 설정
    Write-Host "Creating new layer..." -ForegroundColor Cyan
    try {
        $newLayer = $psdImage.AddRegularLayer()
        if ($newLayer -ne $null) {
            $newLayer.DisplayName = "Transform Test Layer"
            
            # 레이어 위치 및 크기 설정
            $layerWidth = 150
            $layerHeight = 100
            $newLayer.Left = 100
            $newLayer.Top = 100
            $newLayer.Right = $newLayer.Left + $layerWidth
            $newLayer.Bottom = $newLayer.Top + $layerHeight
            
            # 레이어 속성 설정
            $newLayer.Opacity = 180  # 70% opacity
            $newLayer.BlendModeKey = [Aspose.PSD.FileFormats.Core.Blending.BlendMode]::Normal
            
            Write-Host "Created new layer with dimensions ${layerWidth}x${layerHeight}" -ForegroundColor Green
        }
    } catch {
        Write-Host "Warning: Could not create new layer - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # 5. 색상 조정 레이어 추가 (가능한 경우)
    Write-Host "Attempting to add adjustment layer..." -ForegroundColor Cyan
    try {
        # 휘도/대비 조정 레이어 추가 시도
        $adjustmentLayer = $psdImage.AddBrightnessContrastAdjustmentLayer(10, 15)
        if ($adjustmentLayer -ne $null) {
            Write-Host "Added brightness/contrast adjustment layer" -ForegroundColor Green
        }
    } catch {
        Write-Host "Warning: Could not add adjustment layer - $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Save as PSD
    Write-Host "Saving transformed PSD..." -ForegroundColor Yellow
    $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
    $psdImage.Save($outputPath, $psdOptions)
    
    # Save PNG preview
    Write-Host "Saving PNG preview..." -ForegroundColor Yellow
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    $psdImage.Save($previewPath, $pngOptions)
    
    Write-Host "Layer transformation completed successfully!" -ForegroundColor Green
    Write-Host "Output PSD: $outputPath" -ForegroundColor White
    Write-Host "Preview PNG: $previewPath" -ForegroundColor White
    
    # Display transformation summary
    Write-Host "`nTransformation Summary:" -ForegroundColor Magenta
    Write-Host "- Applied RotateFlip: Rotate270FlipXY" -ForegroundColor White
    Write-Host "- Resized image to ${newWidth}x${newHeight}" -ForegroundColor White
    Write-Host "- Adjusted layer opacity and blend mode" -ForegroundColor White
    Write-Host "- Moved existing layer" -ForegroundColor White
    Write-Host "- Created new layer (if supported)" -ForegroundColor White
    Write-Host "- Added adjustment layer (if supported)" -ForegroundColor White
    
} catch {
    Write-Host "Error during layer transformation: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "Resources disposed successfully" -ForegroundColor Gray
    }
}

Write-Host "Layer rotation and resize test completed." -ForegroundColor Green