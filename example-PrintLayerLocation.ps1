# PSD 레이어 위치 정보 출력 PowerShell 스크립트

. ".\Load-AsposePSD.ps1"

# PSD 파일 경로
$PsdPath = "e:\psd_template\horizontal\renewalOpen\machine_1\m1\s1\001708ff-86d1-419b-bc19-2dd530b087c6\001708ff-86d1-419b-bc19-2dd530b087c6_moved.psd"

try {
    Write-Host "PSD 파일을 로드하는 중..." -ForegroundColor Green
    
    # PSD 로드 옵션 설정
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true
    
    # PSD 파일 로드
    $psd = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
    
    Write-Host "총 레이어 수: $($psd.Layers.Count)" -ForegroundColor Cyan
    Write-Host "캔버스 크기: $($psd.Width) x $($psd.Height)" -ForegroundColor Cyan
    Write-Host ""
    
    # 헤더 출력
    Write-Host "=" * 120 -ForegroundColor Yellow
    Write-Host ("{0,-5} {1,-25} {2,-15} {3,-15} {4,-15} {5,-15} {6,-10} {7,-10}" -f `
        "Index", "Layer Name", "TL (Top-Left)", "TR (Top-Right)", "BL (Bottom-Left)", "BR (Bottom-Right)", "Width", "Height") -ForegroundColor White
    Write-Host "=" * 120 -ForegroundColor Yellow
    
    # 각 레이어의 위치 정보 출력
    for ($i = 0; $i -lt $psd.Layers.Count; $i++) {
        $layer = $psd.Layers[$i]
        
        # 레이어 이름 (null 체크)
        $layerName = if ($layer.Name) { $layer.Name } else { $layer.DisplayName }
        if (-not $layerName) { $layerName = "<Unnamed>" }
        
        # 레이어 이름이 너무 길면 줄임
        if ($layerName.Length -gt 23) {
            $layerName = $layerName.Substring(0, 20) + "..."
        }
        
        # 레이어 좌표 정보 가져오기
        $left = $layer.Left
        $top = $layer.Top
        $right = $layer.Right
        $bottom = $layer.Bottom
        $width = $layer.Width
        $height = $layer.Height
        
        # 네 모서리 좌표 계산
        $topLeft = "($left, $top)"
        $topRight = "($right, $top)"
        $bottomLeft = "($left, $bottom)"
        $bottomRight = "($right, $bottom)"
        
        # 레이어 타입에 따른 색상 설정
        $layerColor = "White"
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
            $layerColor = "Cyan"
        } elseif ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $layerColor = "Yellow"
        } elseif ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers.AdjustmentLayer]) {
            $layerColor = "Magenta"
        }
        
        # 정보 출력
        Write-Host ("{0,-5} {1,-25} {2,-15} {3,-15} {4,-15} {5,-15} {6,-10} {7,-10}" -f `
            $i, $layerName, $topLeft, $topRight, $bottomLeft, $bottomRight, $width, $height) -ForegroundColor $layerColor
    }
    
    Write-Host "=" * 120 -ForegroundColor Yellow
    Write-Host ""
    
    # 추가 정보 출력
    Write-Host "=== 범례 ===" -ForegroundColor Magenta
    Write-Host "흰색: 일반 레이어" -ForegroundColor White
    Write-Host "파란색: Smart Object 레이어" -ForegroundColor Cyan
    Write-Host "노란색: 텍스트 레이어" -ForegroundColor Yellow
    Write-Host "보라색: 조정 레이어" -ForegroundColor Magenta
    Write-Host ""
    
    # 특정 레이어 상세 정보 (옵션)
    Write-Host "=== 상세 정보가 필요한 레이어 인덱스를 입력하세요 (Enter로 건너뛰기) ===" -ForegroundColor Green
    $selectedIndex = Read-Host "레이어 인덱스"
    
    if ($selectedIndex -and $selectedIndex -match '^\d+$' -and [int]$selectedIndex -lt $psd.Layers.Count) {
        $selectedLayer = $psd.Layers[[int]$selectedIndex]
        
        Write-Host ""
        Write-Host "=== 레이어 $selectedIndex 상세 정보 ===" -ForegroundColor Green
        Write-Host "이름: $($selectedLayer.Name)" -ForegroundColor White
        Write-Host "표시 이름: $($selectedLayer.DisplayName)" -ForegroundColor White
        Write-Host "타입: $($selectedLayer.GetType().Name)" -ForegroundColor White
        Write-Host "가시성: $($selectedLayer.IsVisible)" -ForegroundColor White
        Write-Host "불투명도: $($selectedLayer.Opacity)" -ForegroundColor White
        Write-Host "블렌드 모드: $($selectedLayer.BlendModeKey)" -ForegroundColor White
        Write-Host "레이어 크기: $($selectedLayer.Width) x $($selectedLayer.Height)" -ForegroundColor White
        Write-Host "레이어 위치:" -ForegroundColor White
        Write-Host "  - Left: $($selectedLayer.Left)" -ForegroundColor Gray
        Write-Host "  - Top: $($selectedLayer.Top)" -ForegroundColor Gray
        Write-Host "  - Right: $($selectedLayer.Right)" -ForegroundColor Gray
        Write-Host "  - Bottom: $($selectedLayer.Bottom)" -ForegroundColor Gray
        Write-Host "  - Bounds: $($selectedLayer.Bounds)" -ForegroundColor Gray
        
        # Smart Object 추가 정보
        if ($selectedLayer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
            $smartLayer = $selectedLayer -as [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]
            Write-Host "Smart Object 정보:" -ForegroundColor Cyan
            Write-Host "  - Content Type: $($smartLayer.ContentType)" -ForegroundColor Gray
            Write-Host "  - Contents Bounds: $($smartLayer.ContentsBounds)" -ForegroundColor Gray
        }
    }
    
} catch {
    Write-Host "오류 발생: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "스택 트레이스: $($_.ScriptStackTrace)" -ForegroundColor Red
} finally {
    # 리소스 정리
    if ($psd) {
        $psd.Dispose()
        Write-Host "PSD 리소스 정리 완료" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "=== 사용법 안내 ===" -ForegroundColor Magenta
Write-Host "TL = Top-Left (좌상단), TR = Top-Right (우상단)"
Write-Host "BL = Bottom-Left (좌하단), BR = Bottom-Right (우하단)"
Write-Host "좌표는 전체 캔버스를 기준으로 한 픽셀 위치입니다."
Write-Host "음수 좌표는 레이어가 캔버스 영역 밖으로 확장되었음을 의미합니다."