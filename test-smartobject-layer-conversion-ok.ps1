# Load Aspose.PSD - 이 스크립트를 실행하기 전에 Aspose.PSD.dll을 로드해야 합니다.
# 예: Add-Type -Path "C:\path\to\Aspose.PSD.dll"

$image = $null # finally 블록에서 참조할 수 있도록 미리 선언

try {
    Write-Host "=== Layer to Smart Object Conversion Demo (Corrected v6) ===" -ForegroundColor Cyan
    
    # [수정] 스크립트가 작업을 시작할 템플릿 PSD 파일 경로
    # 이 파일은 간단한 빈 PSD 파일이어도 됩니다.
    $sourcePsdPath = join-path ${pwd} "test/template.psd"
    if (-not (Test-Path -Path $sourcePsdPath)) {
        throw "Source template file not found: '$sourcePsdPath'. Please create a simple PSD file with this name."
    }
    
    # [수정] 새 이미지를 만드는 대신, 기존 PSD 파일을 불러옵니다.
    # 이렇게 하면 SmartObjectProvider가 올바르게 초기화됩니다.
    Write-Host "Loading template PSD: '$sourcePsdPath'..." -ForegroundColor Yellow
    $image = [Aspose.PSD.Image]::Load($sourcePsdPath)
    
    Write-Host "Creating a new layer to be converted..." -ForegroundColor Green
    
    # 1. Add a regular raster layer for conversion
    Write-Host "1. Adding a new regular raster layer..." -ForegroundColor White
    
    $rasterLayer = $image.AddRegularLayer()
    $rasterLayer.DisplayName = "Geometric Shapes Layer" # 고유한 이름 지정
    $rasterLayer.Left = 50
    $rasterLayer.Top = 50
    $rasterLayer.Right = 250
    $rasterLayer.Bottom = 200
    
    $layerWidth = $rasterLayer.Width
    $layerHeight = $rasterLayer.Height
    $layerRect = New-Object Aspose.PSD.Rectangle(0, 0, $layerWidth, $layerHeight)
    $layerPixels = New-Object 'int[]' ($layerWidth * $layerHeight)
    
    $whiteColor = [Aspose.PSD.Color]::White.ToArgb()
    $blueColor = [Aspose.PSD.Color]::Blue.ToArgb()

    for ($i = 0; $i -lt $layerPixels.Length; $i++) {
        $layerPixels[$i] = $whiteColor
    }
    
    for ($y = 20; $y -lt 80; $y++) {
        for ($x = 20; $x -lt 100; $x++) {
            $index = $y * $layerWidth + $x
            $layerPixels[$index] = $blueColor
        }
    }
    
    $rasterLayer.SaveArgb32Pixels($layerRect, $layerPixels)
    Write-Host "   Geometric shapes layer added." -ForegroundColor Green
    
    # 2. Perform the ACTUAL smart object conversion
    Write-Host "2. Converting the new raster layer to a Smart Object..." -ForegroundColor White
    
    if ($image.SmartObjectProvider -eq $null) {
        throw "SmartObjectProvider is still null. The source PSD might be corrupted or too simple."
    }
    
    # 이름으로 변환할 레이어의 인덱스를 동적으로 찾습니다.
    $layerNameToConvert = "Geometric Shapes Layer"
    $layerToConvertIndex = -1
    for ($i = 0; $i -lt $image.Layers.Length; $i++) {
        if ($image.Layers[$i].DisplayName -eq $layerNameToConvert) {
            $layerToConvertIndex = $i
            break
        }
    }

    if ($layerToConvertIndex -eq -1) {
        throw "Could not find the layer to convert: '$layerNameToConvert'"
    }

    Write-Host "   Found layer '$layerNameToConvert' at index $layerToConvertIndex." -ForegroundColor Gray
    
    # ConvertToSmartObject 메서드가 반환하는 객체를 직접 변수에 할당합니다.
    $smartObjectLayer = $image.SmartObjectProvider.ConvertToSmartObject($layerToConvertIndex)
    
    # 변환이 성공적으로 객체를 반환했는지 확인합니다.
    if ($smartObjectLayer -ne $null -and $smartObjectLayer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
        $smartObjectLayer.DisplayName = "[SO] Geometric Shapes"
        Write-Host "   Layer converted successfully." -ForegroundColor Green
        
        # 3. Demonstrate benefits: Create an instance (copy) of the smart object
        Write-Host "3. Creating an instance (copy) of the smart object..." -ForegroundColor White
        
        $instanceLayer = $smartObjectLayer.NewSmartObjectViaCopy()
        $instanceLayer.DisplayName = "[SO Instance] Geometric Shapes"
        
        # 위치 이동
        $instanceLayer.Left = 300
        $instanceLayer.Top = 50
        $instanceLayer.Right = $instanceLayer.Left + $instanceLayer.Width
        $instanceLayer.Bottom = $instanceLayer.Top + $instanceLayer.Height
        Write-Host "   Instance created." -ForegroundColor Green
    } else {
        Write-Host "   Layer conversion to Smart Object FAILED. The returned object is null or not a SmartObjectLayer." -ForegroundColor Red
    }

    Write-Host "Demonstration completed!" -ForegroundColor Green
    
    # Save as PSD
    $outputPsd = Join-Path ${pwd} "test/smartobject_conversion_output.psd"
    Write-Host "Saving PSD file: $outputPsd" -ForegroundColor Yellow
    $image.Save($outputPsd)
    
    # Save as PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $outputPng = Join-Path ${pwd} "test/smartobject_conversion_preview.png"
    Write-Host "Saving PNG preview: $outputPng" -ForegroundColor Yellow
    $image.Save($outputPng, $pngOptions)
    
    Write-Host "=== Layer to Smart Object Conversion Demo Completed Successfully ===" -ForegroundColor Cyan

} catch {
    Write-Host "An error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($image) {
        $image.Dispose()
        Write-Host "Image resources disposed." -ForegroundColor Gray
    }
}

Write-Host "`nScript completed." -ForegroundColor Cyan