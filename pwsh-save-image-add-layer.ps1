Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.Drawing.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\System.Drawing.Common.dll"

$basePngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_018_machine_main_g02_#1.png"
$layerPngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_080_text-all.png"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\save-image-add-layer.psd"

# 기본 이미지(PNG) 로드
$baseImage = [Aspose.PSD.Image]::Load($basePngFilePath)

# 추가할 이미지(PNG) 로드 (이 이미지가 레이어로 추가될 것임)
$layerImage = [Aspose.PSD.Image]::Load($layerPngFilePath)

# 레이어로 추가할 이미지 생성
$layer = [Aspose.PSD.Layer]::new()
$layer.Name = "New Layer"
$layer.AddImage($layerImage)

# 기본 이미지에 레이어 추가
$baseImage.Layers.Add($layer)

# PSD로 저장
$baseImage.Save($psdFilePath)

Write-Host "변환 완료! 레이어가 추가된 PSD 파일이 저장되었습니다: $psdFilePath"
