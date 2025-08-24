# 레이어 마스크 적용 테스트
$PsdPath = join-path ${pwd} "test\004074e3-7c95-470e-9777-ad8955de45d7.psd"
$OutputPath = join-path ${pwd} "test-layer-mask-apply-output.psd"
$PreviewPath = join-path ${pwd} "test-layer-mask-apply-preview.png"

# Load Options 설정
$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

# PSD 로딩
$psd = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
$psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$psd

try {
    Write-Host "레이어 수: $($psdImage.Layers.Length)"
    
    # 첫 번째 레이어 선택 (배경 레이어가 아닌)
    $targetLayer = $null
    for ($i = 0; $i -lt $psdImage.Layers.Length; $i++) {
        if ($psdImage.Layers[$i].Name -ne "Background") {
            $targetLayer = $psdImage.Layers[$i]
            break
        }
    }
    
    if ($targetLayer -ne $null) {
        Write-Host "대상 레이어: $($targetLayer.DisplayName)"
        
        # 레이어 마스크 생성 (원형 마스크)
        $maskWidth = $targetLayer.Right - $targetLayer.Left
        $maskHeight = $targetLayer.Bottom - $targetLayer.Top
        $centerX = $maskWidth / 2
        $centerY = $maskHeight / 2
        $radius = [Math]::Min($maskWidth, $maskHeight) / 3
        
        # 마스크 영역 정의
        $maskLeft = $targetLayer.Left
        $maskTop = $targetLayer.Top
        $maskRight = $targetLayer.Right
        $maskBottom = $targetLayer.Bottom
        
        $maskData = New-Object byte[] ($maskWidth * $maskHeight)
        
        for ($y = 0; $y -lt $maskHeight; $y++) {
            for ($x = 0; $x -lt $maskWidth; $x++) {
                $distance = [Math]::Sqrt([Math]::Pow($x - $centerX, 2) + [Math]::Pow($y - $centerY, 2))
                $index = $y * $maskWidth + $x
                if ($distance -le $radius) {
                    $maskData[$index] = 255  # 완전 불투명
                } else {
                    $maskData[$index] = 0    # 완전 투명
                }
            }
        }
        
        # LayerMaskDataShort 객체 생성 (LayerMaskData 대신)
        $layerMaskData = New-Object Aspose.PSD.FileFormats.Psd.Layers.LayerMaskDataShort
        $layerMaskData.ImageData = $maskData  # ImageDataVector 대신 ImageData 사용
        $layerMaskData.Left = $maskLeft
        $layerMaskData.Top = $maskTop
        $layerMaskData.Right = $maskRight
        $layerMaskData.Bottom = $maskBottom
        
        # 마스크 적용
        $targetLayer.AddLayerMask($layerMaskData)
        
        Write-Host "원형 마스크 적용 완료"
    } else {
        Write-Host "마스크를 적용할 레이어를 찾을 수 없습니다"
    }
    
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