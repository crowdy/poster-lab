# ================================================================================
# Aspose.PSD 일반 레이어 콘텐츠 교체 테스트
# ================================================================================

# --- 설정 ---
# 입력 PSD 파일 경로
$PsdPath = "0b6b884a-4ec1-4ea6-bf15-02e41fe6a915.psd"
# 교체할 이미지 파일 경로
$PngPath = "chara_main_g01_1.png"
# 출력 PSD 파일 경로
$OutputPath = "new.psd"
# 교체 대상 레이어 이름
$TargetLayerName = "chara_main_g01 #1"

# --- 리소스 변수 초기화 ---
$psdImage = $null
$pngImage = $null

try {
    # --- 파일 존재 여부 확인 ---
    if (-not (Test-Path $PsdPath)) {
        throw "입력 PSD 파일을 찾을 수 없습니다: $PsdPath"
    }
    if (-not (Test-Path $PngPath)) {
        throw "교체할 PNG 파일을 찾을 수 없습니다: $PngPath"
    }

    Write-Host "1. 이미지 로딩 시작..." -ForegroundColor Cyan
    
    # Aspose.PSD를 사용하여 PSD 및 PNG 이미지 로드
    $psdImage = [Aspose.PSD.Image]::Load($PsdPath) -as [Aspose.PSD.FileFormats.Psd.PsdImage]
    $pngImage = [Aspose.PSD.Image]::Load($PngPath) -as [Aspose.PSD.RasterImage]

    if (-not $psdImage) { throw "PSD 파일을 PsdImage 객체로 로드하는 데 실패했습니다." }
    if (-not $pngImage) { throw "PNG 파일을 RasterImage 객체로 로드하는 데 실패했습니다." }
    
    Write-Host "   - PSD 로드 완료: $($psdImage.Width)x$($psdImage.Height)"
    Write-Host "   - PNG 로드 완료: $($pngImage.Width)x$($pngImage.Height)"

    # --- 대상 레이어 찾기 ---
    Write-Host "2. 대상 레이어 '$TargetLayerName' 찾는 중..." -ForegroundColor Cyan
    $targetLayer = $psdImage.Layers | Where-Object { $_.DisplayName -eq $TargetLayerName } | Select-Object -First 1
    
    if (-not $targetLayer) {
        throw "레이어를 찾지 못했습니다: '$TargetLayerName'"
    }
    
    Write-Host "   - 레이어 찾음: $($targetLayer.DisplayName)"

    # --- 픽셀 데이터 교체 ---
    Write-Host "3. 픽셀 데이터 교체 시작..." -ForegroundColor Cyan
    
    # 1. 교체할 PNG 이미지에서 픽셀 데이터를 가져옵니다.
    $pngRect = New-Object Aspose.PSD.Rectangle(0, 0, $pngImage.Width, $pngImage.Height)
    $pngPixels = $pngImage.LoadArgb32Pixels($pngRect)
    
    # 2. 대상 레이어의 크기를 PNG 이미지 크기와 동일하게 조정합니다.
    $targetLayer.Resize($pngImage.Width, $pngImage.Height)
    Write-Host "   - 대상 레이어 크기를 $($pngImage.Width)x$($pngImage.Height)(으)로 조정했습니다."

    # 3. 조정된 크기의 레이어에 PNG 픽셀 데이터를 저장합니다.
    $targetRect = New-Object Aspose.PSD.Rectangle(0, 0, $targetLayer.Width, $targetLayer.Height)
    $targetLayer.SaveArgb32Pixels($targetRect, $pngPixels)
    
    Write-Host "   - 픽셀 데이터 교체 완료."

    # --- PSD 파일 저장 ---
    Write-Host "4. 변경된 PSD 파일 저장 중..." -ForegroundColor Cyan
    $psdImage.Save($OutputPath)
    
    Write-Host "성공: 파일이 '$OutputPath'(으)로 저장되었습니다." -ForegroundColor Green

} catch {
    # --- 오류 처리 ---
    Write-Host "오류 발생: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "스크립트 실행이 중단되었습니다." -ForegroundColor Red

} finally {
    # --- 리소스 해제 ---
    # 파일 손상을 방지하기 위해 사용한 모든 이미지 객체를 반드시 Dispose 해야 합니다.
    if ($psdImage) {
        $psdImage.Dispose()
    }
    if ($pngImage) {
        $pngImage.Dispose()
    }
    Write-Host "5. 모든 리소스를 정리했습니다." -ForegroundColor Gray
}