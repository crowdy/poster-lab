# ================================================================================
# Aspose.PSD 얼굴 좌표 기준 레이어 교체 및 조정 테스트
# (test-replace-regular-layer-with-face-adjusted-ok.ps1)
# ================================================================================

# --- 설정 ---
# 입력 PSD 파일 경로
$PsdPath = "0b6b884a-4ec1-4ea6-bf15-02e41fe6a915.psd"
# 교체할 이미지 파일 경로
$PngPath = "chara_main_g01_1.png"
# 출력 PSD 파일 경로
$OutputPath = "new_face_adjusted.psd"

# 교체 대상 레이어 이름
$TargetLayerName = "chara_main_g01 #1"
# 얼굴 위치 기준 레이어 이름 (검증용)
$FaceMarkerLayerName = "face"

# PNG 이미지 내 얼굴 영역 정보 (좌상단 x, y, 너비, 높이)
$pngFaceRect = New-Object Aspose.PSD.Rectangle(993, 1087, 301, 301)

# --- 리소스 변수 초기화 ---
$psdImage = $null
$pngImage = $null

try {
    # --- 파일 존재 여부 확인 ---
    if (-not (Test-Path $PsdPath)) { throw "입력 PSD 파일을 찾을 수 없습니다: $PsdPath" }
    if (-not (Test-Path $PngPath)) { throw "교체할 PNG 파일을 찾을 수 없습니다: $PngPath" }

    Write-Host "1. 이미지 로딩 시작..." -ForegroundColor Cyan
    
    $psdImage = [Aspose.PSD.Image]::Load($PsdPath) -as [Aspose.PSD.FileFormats.Psd.PsdImage]
    $pngImage = [Aspose.PSD.Image]::Load($PngPath) -as [Aspose.PSD.RasterImage]

    if (-not $psdImage) { throw "PSD 파일을 PsdImage 객체로 로드하는 데 실패했습니다." }
    if (-not $pngImage) { throw "PNG 파일을 RasterImage 객체로 로드하는 데 실패했습니다." }
    
    Write-Host "   - PSD 로드 완료: $($psdImage.Width)x$($psdImage.Height)"
    Write-Host "   - PNG 로드 완료: $($pngImage.Width)x$($pngImage.Height)"

    # --- 기준 레이어 정보 수집 ---
    Write-Host "2. 기준 레이어 정보 수집 중..." -ForegroundColor Cyan
    
    # [!!! 중요 수정 사항 시작 !!!]
    
    # 1. 대상 레이어의 인덱스를 찾습니다.
    $targetLayerIndex = -1
    for ($i = 0; $i -lt $psdImage.Layers.Length; $i++) {
        if ($psdImage.Layers[$i].DisplayName -eq $TargetLayerName) {
            $targetLayerIndex = $i
            break
        }
    }

    if ($targetLayerIndex -eq -1) { throw "대상 레이어를 찾지 못했습니다: '$TargetLayerName'" }

    $targetLayer = $psdImage.Layers[$targetLayerIndex]
    Write-Host "   - 대상 레이어 '$($targetLayer.DisplayName)' (인덱스: $targetLayerIndex) 찾음"

    # 2. 대상 레이어의 바로 다음 인덱스를 사용하여 얼굴 마커 레이어를 가져옵니다.
    $faceMarkerLayerIndex = $targetLayerIndex + 1
    if ($faceMarkerLayerIndex -ge $psdImage.Layers.Length) {
        throw "대상 레이어 '$($TargetLayerName)' 다음에 얼굴 기준 레이어가 없습니다."
    }
    
    $faceMarkerLayer = $psdImage.Layers[$faceMarkerLayerIndex]
    
    # 3. (선택적) 찾은 레이어의 이름이 예상과 같은지 확인하여 안정성을 높입니다.
    if ($faceMarkerLayer.DisplayName -ne $FaceMarkerLayerName) {
        Write-Host "경고: '$($TargetLayerName)' 다음 레이어의 이름이 '$($FaceMarkerLayerName)'이 아닙니다 (실제 이름: '$($faceMarkerLayer.DisplayName)'). 계산은 계속 진행합니다." -ForegroundColor Yellow
    }

    Write-Host "   - 얼굴 기준 레이어 '$($faceMarkerLayer.DisplayName)' (인덱스: $faceMarkerLayerIndex) 찾음"

    # [!!! 중요 수정 사항 종료 !!!]
    
    # PSD 내 얼굴 목표 위치 (전체 캔버스 기준 좌표)
    $psdFaceLayerRect = New-Object Aspose.PSD.Rectangle($faceMarkerLayer.Left, $faceMarkerLayer.Top, $faceMarkerLayer.Width, $faceMarkerLayer.Height)
    Write-Host "   - 얼굴 목표 위치 (PSD): X=$($psdFaceLayerRect.X), Y=$($psdFaceLayerRect.Y), W=$($psdFaceLayerRect.Width), H=$($psdFaceLayerRect.Height)"
    Write-Host "   - 원본 얼굴 위치 (PNG): X=$($pngFaceRect.X), Y=$($pngFaceRect.Y), W=$($pngFaceRect.Width), H=$($pngFaceRect.Height)"

    # --- 크기 및 위치 계산 ---
    Write-Host "3. 새로운 크기 및 위치 계산 중..." -ForegroundColor Cyan
    
    # 1. 확대/축소 비율 계산 (너비 기준)
    $scaleRatio = $psdFaceLayerRect.Width / $pngFaceRect.Width
    Write-Host "   - 계산된 확대/축소 비율: $scaleRatio"
    
    # 2. 비율에 따른 PNG 이미지의 새로운 전체 크기 계산
    $newPngWidth = [int]($pngImage.Width * $scaleRatio)
    $newPngHeight = [int]($pngImage.Height * $scaleRatio)
    Write-Host "   - PNG의 새로운 전체 크기: $($newPngWidth)x$($newPngHeight)"
    
    # 3. 리사이즈된 PNG 내에서 얼굴의 새로운 상대 위치 계산
    $newPngFaceX = [int]($pngFaceRect.X * $scaleRatio)
    $newPngFaceY = [int]($pngFaceRect.Y * $scaleRatio)
    
    # 4. 최종 레이어의 좌상단 위치 계산
    # (목표 얼굴 위치) - (리사이즈된 이미지 내의 얼굴 상대 위치) = (이미지가 시작되어야 할 위치)
    $finalLayerLeft = $psdFaceLayerRect.Left - $newPngFaceX
    $finalLayerTop = $psdFaceLayerRect.Top - $newPngFaceY
    Write-Host "   - 최종 레이어 위치: Left=$finalLayerLeft, Top=$finalLayerTop"
    
    # --- PNG 이미지 리사이즈 ---
    Write-Host "4. PNG 이미지 리사이즈 중..." -ForegroundColor Cyan
    $pngImage.Resize($newPngWidth, $newPngHeight)
    
    # --- 픽셀 데이터 교체 및 레이어 조정 ---
    Write-Host "5. 레이어 업데이트 시작..." -ForegroundColor Cyan
    
    # 1. 리사이즈된 PNG에서 픽셀 데이터 가져오기
    $pngRect = New-Object Aspose.PSD.Rectangle(0, 0, $pngImage.Width, $pngImage.Height)
    $pngPixels = $pngImage.LoadArgb32Pixels($pngRect)

    # 2. 대상 레이어 위치 및 크기 업데이트
    $targetLayer.Left = $finalLayerLeft
    $targetLayer.Top = $finalLayerTop
    $targetLayer.Right = $finalLayerLeft + $newPngWidth
    $targetLayer.Bottom = $finalLayerTop + $newPngHeight
    
    # 3. 픽셀 데이터 저장 (레이어 크기가 이미 조정되었으므로 Resize()는 불필요)
    $targetRect = New-Object Aspose.PSD.Rectangle(0, 0, $targetLayer.Width, $targetLayer.Height)
    $targetLayer.SaveArgb32Pixels($targetRect, $pngPixels)
    
    Write-Host "   - 레이어 위치, 크기, 콘텐츠 업데이트 완료."
    
    # --- PSD 파일 저장 ---
    Write-Host "6. 변경된 PSD 파일 저장 중..." -ForegroundColor Cyan
    $psdImage.Save($OutputPath)
    
    Write-Host "성공: 파일이 '$OutputPath'(으)로 저장되었습니다." -ForegroundColor Green

} catch {
    # --- 오류 처리 ---
    Write-Host "오류 발생: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "스크립트 실행이 중단되었습니다." -ForegroundColor Red

} finally {
    # --- 리소스 해제 ---
    if ($psdImage) { $psdImage.Dispose() }
    if ($pngImage) { $pngImage.Dispose() }
    Write-Host "7. 모든 리소스를 정리했습니다." -ForegroundColor Gray
}