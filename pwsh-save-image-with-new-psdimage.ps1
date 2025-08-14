# Aspose.PSD 라이브러리 로드
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.Drawing.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\System.Drawing.Common.dll"

# 파일 경로 설정
$basePngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_001_background_g00_#1.png"
$layerPngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_080_text-all.png"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\save-image-add-layer.psd"

try {
    # 방법 1: 공식 문서 방식 - Stream을 사용한 Layer 생성
    Write-Host "공식 문서 방식으로 시도 중..."
    
    # 기본 이미지 로드하여 크기 정보 얻기
    $baseImage = [Aspose.PSD.Image]::Load($basePngFilePath)
    $width = $baseImage.Width
    $height = $baseImage.Height
    $baseImage.Dispose()

    $canvasWidth = 3508
    $canvasHeight = 4967

    $width = $canvasWidth
    $height = $canvasHeight

    # 새로운 PSD 이미지 생성
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::new($width, $height)
    
    # 기본 이미지를 Stream으로 변환하여 Layer 생성
    $baseImageStream = [System.IO.File]::OpenRead($basePngFilePath)
    $baseLayer = [Aspose.PSD.FileFormats.Psd.Layers.Layer]::new($baseImageStream)
    $baseLayer.Name = "Base Layer"
    $psdImage.AddLayer($baseLayer)
    $baseImageStream.Close()
    
    # 추가할 레이어 이미지를 Stream으로 변환하여 Layer 생성
    $layerImageStream = [System.IO.File]::OpenRead($layerPngFilePath)
    $newLayer = [Aspose.PSD.FileFormats.Psd.Layers.Layer]::new($layerImageStream)
    $newLayer.Name = "Text Layer"
    $psdImage.AddLayer($newLayer)
    $layerImageStream.Close()
    
    # PSD로 저장
    $psdImage.Save($psdFilePath)
    
    Write-Host "성공! 레이어가 추가된 PSD 파일이 저장되었습니다: $psdFilePath"
    
    # 리소스 정리
    $psdImage.Dispose()
}
catch {
    Write-Error "공식 방식 실패: $($_.Exception.Message)"
    
    # 방법 2: PSD 변환 후 레이어 추가 방식
    try {
        Write-Host "PSD 변환 방식으로 재시도 중..."
        
        # 기본 이미지를 먼저 PSD로 변환
        $baseImage = [Aspose.PSD.Image]::Load($basePngFilePath)
        $psdOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
        $baseImage.Save($psdFilePath, $psdOptions)
        $baseImage.Dispose()
        
        # 생성된 PSD 파일 다시 로드
        $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::Load($psdFilePath)
        
        # 레이어 이미지를 Stream으로 추가
        $layerImageStream = [System.IO.File]::OpenRead($layerPngFilePath)
        $newLayer = [Aspose.PSD.FileFormats.Psd.Layers.Layer]::new($layerImageStream)
        $newLayer.Name = "Added Layer"
        $psdImage.AddLayer($newLayer)
        $layerImageStream.Close()
        
        # 최종 저장
        $psdImage.Save($psdFilePath)
        
        Write-Host "PSD 변환 방식으로 성공! 레이어가 추가된 PSD 파일이 저장되었습니다: $psdFilePath"
        
        # 리소스 정리
        $psdImage.Dispose()
    }
    catch {
        Write-Error "PSD 변환 방식도 실패: $($_.Exception.Message)"
        
        # 방법 3: 단순 변환 방식 (백업)
        try {
            Write-Host "단순 변환 방식으로 재시도 중..."
            
            # 기본 이미지만 PSD로 변환
            $baseImage = [Aspose.PSD.Image]::Load($basePngFilePath)
            $psdOptions = [Aspose.PSD.ImageOptions.PsdOptions]::new()
            $baseImage.Save($psdFilePath, $psdOptions)
            $baseImage.Dispose()
            
            Write-Host "기본 이미지만 PSD로 변환 완료: $psdFilePath"
            Write-Host "추가 레이어는 수동으로 Photoshop에서 추가하세요."
        }
        catch {
            Write-Error "모든 방식 실패: $($_.Exception.Message)"
        }
    }
}


