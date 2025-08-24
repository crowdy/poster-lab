# 레이어 7번 위치 이동 PowerShell 스크립트

. ".\Load-AsposePSD.ps1"

# 파일 경로 설정
$PsdPath = "e:\psd_template\horizontal\renewalOpen\machine_1\m1\s1\001708ff-86d1-419b-bc19-2dd530b087c6\001708ff-86d1-419b-bc19-2dd530b087c6.psd"
$OutputPsdPath = "e:\psd_template\horizontal\renewalOpen\machine_1\m1\s1\001708ff-86d1-419b-bc19-2dd530b087c6\001708ff-86d1-419b-bc19-2dd530b087c6_moved.psd"

# 이동 설정
$TargetLayerIndex = 7
$CurrentTopPosition = 962
$NewTopPosition = 1114
$MoveDistance = $NewTopPosition - $CurrentTopPosition

try {
    Write-Host "PSD 파일을 로드하는 중..." -ForegroundColor Green
    
    # PSD 로드 옵션 설정
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true
    
    # PSD 파일 로드
    $psd = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
    
    Write-Host "총 레이어 수: $($psd.Layers.Count)" -ForegroundColor Cyan
    
    # 레이어 인덱스 유효성 검사
    if ($TargetLayerIndex -ge $psd.Layers.Count) {
        throw "레이어 인덱스 $TargetLayerIndex 가 유효하지 않습니다. 최대 인덱스: $($psd.Layers.Count - 1)"
    }
    
    # 대상 레이어 가져오기
    $targetLayer = $psd.Layers[$TargetLayerIndex]
    
    Write-Host ""
    Write-Host "=== 레이어 $TargetLayerIndex 이동 작업 ===" -ForegroundColor Yellow
    Write-Host "레이어 이름: $($targetLayer.Name)" -ForegroundColor White
    Write-Host "레이어 타입: $($targetLayer.GetType().Name)" -ForegroundColor White
    
    # 현재 위치 정보 출력
    Write-Host ""
    Write-Host "현재 위치:" -ForegroundColor Cyan
    Write-Host "  - Left: $($targetLayer.Left)" -ForegroundColor Gray
    Write-Host "  - Top: $($targetLayer.Top)" -ForegroundColor Gray
    Write-Host "  - Right: $($targetLayer.Right)" -ForegroundColor Gray
    Write-Host "  - Bottom: $($targetLayer.Bottom)" -ForegroundColor Gray
    Write-Host "  - Width: $($targetLayer.Width)" -ForegroundColor Gray
    Write-Host "  - Height: $($targetLayer.Height)" -ForegroundColor Gray
    
    # 현재 TOP 위치 확인
    if ($targetLayer.Top -ne $CurrentTopPosition) {
        Write-Host ""
        Write-Host "경고: 현재 TOP 위치가 예상과 다릅니다!" -ForegroundColor Yellow
        Write-Host "예상: $CurrentTopPosition, 실제: $($targetLayer.Top)" -ForegroundColor Yellow
        Write-Host "실제 위치를 기준으로 이동합니다." -ForegroundColor Yellow
        
        # 실제 위치를 기준으로 이동 거리 재계산
        $MoveDistance = $NewTopPosition - $targetLayer.Top
    }
    
    Write-Host ""
    Write-Host "이동 정보:" -ForegroundColor Green
    Write-Host "  - 이동 거리: $MoveDistance 픽셀 (아래로)" -ForegroundColor Gray
    Write-Host "  - 새 TOP 위치: $NewTopPosition" -ForegroundColor Gray
    Write-Host "  - 새 BOTTOM 위치: $($targetLayer.Bottom + $MoveDistance)" -ForegroundColor Gray
    
    # 레이어 위치 이동
    Write-Host ""
    Write-Host "레이어를 이동하는 중..." -ForegroundColor Green
    
    # 새로운 위치 계산
    $newLeft = $targetLayer.Left
    $newTop = $targetLayer.Top + $MoveDistance
    $newRight = $targetLayer.Right
    $newBottom = $targetLayer.Bottom + $MoveDistance
    
    # 위치 설정
    $targetLayer.Left = $newLeft
    $targetLayer.Top = $newTop
    $targetLayer.Right = $newRight
    $targetLayer.Bottom = $newBottom
    
    Write-Host "레이어 위치 이동 완료!" -ForegroundColor Green
    
    # 이동 후 위치 정보 출력
    Write-Host ""
    Write-Host "이동 후 위치:" -ForegroundColor Cyan
    Write-Host "  - Left: $($targetLayer.Left)" -ForegroundColor Gray
    Write-Host "  - Top: $($targetLayer.Top)" -ForegroundColor Gray
    Write-Host "  - Right: $($targetLayer.Right)" -ForegroundColor Gray
    Write-Host "  - Bottom: $($targetLayer.Bottom)" -ForegroundColor Gray
    Write-Host "  - Width: $($targetLayer.Width)" -ForegroundColor Gray
    Write-Host "  - Height: $($targetLayer.Height)" -ForegroundColor Gray
    
    # 변경사항 검증
    if ($targetLayer.Top -eq $NewTopPosition) {
        Write-Host ""
        Write-Host "✓ TOP 위치가 정확히 설정되었습니다: $($targetLayer.Top)" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "⚠ TOP 위치 설정에 문제가 있습니다. 예상: $NewTopPosition, 실제: $($targetLayer.Top)" -ForegroundColor Yellow
    }
    
    # PSD 파일 저장
    Write-Host ""
    Write-Host "PSD 파일을 저장하는 중..." -ForegroundColor Green
    
    # 출력 디렉터리가 없으면 생성
    $outputDir = Split-Path -Parent $OutputPsdPath
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
    
    # PSD 옵션 설정
    $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions($psd)
    
    # 파일 저장
    $psd.Save($OutputPsdPath, $psdOptions)
    
    Write-Host "저장 완료!" -ForegroundColor Green
    Write-Host "출력 파일: $OutputPsdPath" -ForegroundColor Cyan
    
    # 파일 크기 확인
    if (Test-Path $OutputPsdPath) {
        $fileSize = (Get-Item $OutputPsdPath).Length
        $fileSizeMB = [Math]::Round($fileSize / 1MB, 2)
        Write-Host "파일 크기: $fileSizeMB MB" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "=== 작업 완료 ===" -ForegroundColor Green
    Write-Host "레이어 $TargetLayerIndex 가 성공적으로 이동되었습니다." -ForegroundColor White
    Write-Host "TOP: $CurrentTopPosition → $($targetLayer.Top)" -ForegroundColor White
    Write-Host "BOTTOM: $($targetLayer.Bottom - $MoveDistance) → $($targetLayer.Bottom)" -ForegroundColor White
    
} catch {
    Write-Host ""
    Write-Host "오류 발생: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "스택 트레이스: $($_.ScriptStackTrace)" -ForegroundColor Red
    
    # 오류 발생 시 롤백 정보 제공
    Write-Host ""
    Write-Host "문제 해결 방법:" -ForegroundColor Yellow
    Write-Host "1. 레이어 인덱스가 올바른지 확인하세요 (0부터 시작)" -ForegroundColor Gray
    Write-Host "2. PSD 파일이 존재하고 읽기 가능한지 확인하세요" -ForegroundColor Gray
    Write-Host "3. 출력 경로에 쓰기 권한이 있는지 확인하세요" -ForegroundColor Gray
    Write-Host "4. 다른 프로그램에서 PSD 파일을 사용 중이 아닌지 확인하세요" -ForegroundColor Gray
    
} finally {
    # 리소스 정리
    if ($psd) {
        $psd.Dispose()
        Write-Host ""
        Write-Host "PSD 리소스 정리 완료" -ForegroundColor Green
    }
}

# 추가 정보
Write-Host ""
Write-Host "=== 참고 정보 ===" -ForegroundColor Magenta
Write-Host "• 레이어의 위치만 이동되었으며, 레이어 내용은 그대로 유지됩니다"
Write-Host "• 다른 레이어들은 영향받지 않습니다"
Write-Host "• 블렌딩 모드, 투명도 등 다른 속성들은 변경되지 않습니다"
Write-Host "• 원본 파일은 그대로 보존되고 새 파일이 생성됩니다"