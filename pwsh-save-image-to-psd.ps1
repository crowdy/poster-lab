Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.Drawing.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\System.Drawing.Common.dll"

$pngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_018_machine_main_g02_#1.png"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\test.psd"

# PNG 파일을 로드하여 PSD로 변환
$pngImage = [Aspose.PSD.Image]::Load($pngFilePath)

# PSD로 저장
$pngImage.Save($psdFilePath)

Write-Host "변환 완료! PSD 파일이 저장되었습니다: $psdFilePath"