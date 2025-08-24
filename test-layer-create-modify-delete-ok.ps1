# 레이어 생성/수정/삭제 테스트
$PsdPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$OutputPath = join-path ${pwd} "test-layer-create-modify-delete-output.psd"
$PreviewPath = join-path ${pwd} "test-layer-create-modify-delete-preview.png"

# Load Options 설정
$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

# PSD 로딩
$psd = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
$psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$psd

try {
    Write-Host "원본 레이어 수: $($psdImage.Layers.Length)"
    
    # 새 레이어 생성
    $newLayer = $psdImage.AddRegularLayer()
    $newLayer.Left = 100
    $newLayer.Top = 100
    $newLayer.Right = 200
    $newLayer.Bottom = 200
    
    # 픽셀 데이터 설정 (빨간색 사각형)
    $rect = New-Object Aspose.PSD.Rectangle(0, 0, 100, 100)
    $pixelData = New-Object int[] (10000)
    for ($i = 0; $i -lt 10000; $i++) {
        $pixelData[$i] = -65536  # 빨간색 ARGB
    }
    $newLayer.SaveArgb32Pixels($rect, $pixelData)
    $newLayer.DisplayName = "Test Layer"
    
    Write-Host "레이어 생성 완료. 현재 레이어 수: $($psdImage.Layers.Length)"
    
    # 레이어 수정 (위치 변경)
    $newLayer.Left = 150
    $newLayer.Top = 150
    Write-Host "레이어 위치 수정 완료"
    
    # 저장
    $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions($psdImage)
    $psdImage.Save($OutputPath, $psdOptions)
    
    # PNG 미리보기 생성
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $psdImage.Save($PreviewPath, $pngOptions)
    
    Write-Host "성공: $OutputPath 저장됨"
}
finally {
    $psd.Dispose()
}
