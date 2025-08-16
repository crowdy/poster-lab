# 레이어 상세 분석 및 투명도 문제 진단 스크립트
param(
    [Parameter(Mandatory = $true)]
    [string]$PsdPath,
    
    [Parameter(Mandatory = $true)]
    [string]$LayerName,
    
    [Parameter(Mandatory = $true)]
    [string]$OutputDir
)

# Aspose.PSD 로드
. "$PSScriptRoot\Load-AsposePSD.ps1"
if (-not (Load-AsposePSD)) { Write-Error "Aspose.PSD load failed"; exit 1 }

# 출력 디렉토리 생성
if (-not (Test-Path $OutputDir)) { New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null }

Write-Host "=== PSD 레이어 투명도 문제 진단 ===" -ForegroundColor Yellow

# PSD 로드
$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

$img = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
$psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img

try {
    # 타깃 레이어 찾기
    $targetLayer = $psd.Layers | Where-Object { $_.Name -eq $LayerName } | Select-Object -First 1
    if (-not $targetLayer) {
        Write-Error "Layer '$LayerName' not found"
        return
    }

    Write-Host "`n1. 레이어 기본 정보 분석:" -ForegroundColor Green
    Write-Host "   레이어 이름: '$($targetLayer.Name)'"
    Write-Host "   레이어 타입: $($targetLayer.GetType().Name)"
    Write-Host "   가시성: $($targetLayer.IsVisible)"
    Write-Host "   불투명도: $($targetLayer.Opacity)"
    Write-Host "   바운드: $($targetLayer.Bounds.Left),$($targetLayer.Bounds.Top) - $($targetLayer.Bounds.Width)x$($targetLayer.Bounds.Height)"

    # 레이어 인덱스 찾기
    $layerIndex = -1
    for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
        if ($psd.Layers[$i].Name -eq $LayerName) {
            $layerIndex = $i
            break
        }
    }
    Write-Host "   레이어 인덱스: $layerIndex"

    Write-Host "`n2. 레이어 고급 속성 분석:" -ForegroundColor Green
    
    # 블렌딩 모드 확인
    try {
        $blendMode = $targetLayer.BlendModeKey
        Write-Host "   블렌딩 모드: $blendMode"
    } catch {
        Write-Host "   블렌딩 모드: 확인 불가"
    }

    # 레이어 마스크 확인
    try {
        if ($targetLayer.LayerMask) {
            Write-Host "   레이어 마스크: 있음"
            Write-Host "     마스크 바운드: $($targetLayer.LayerMask.Bounds)"
        } else {
            Write-Host "   레이어 마스크: 없음"
        }
    } catch {
        Write-Host "   레이어 마스크: 확인 불가"
    }

    # 클리핑 마스크 확인
    try {
        if ($targetLayer.GetType().GetProperty("IsClipped")) {
            $isClipped = $targetLayer.IsClipped
            Write-Host "   클리핑 마스크: $isClipped"
        }
    } catch {
        Write-Host "   클리핑 마스크: 확인 불가"
    }

    Write-Host "`n3. 픽셀 데이터 분석:" -ForegroundColor Green
    
    # 픽셀 데이터 로드 시도
    try {
        $bounds = $targetLayer.Bounds
        $pixels = $targetLayer.LoadArgb32Pixels($bounds)
        
        if ($pixels -and $pixels.Length -gt 0) {
            Write-Host "   픽셀 데이터: $($pixels.Length)개 픽셀 로드됨"
            
            # 투명하지 않은 픽셀 개수 확인
            $nonTransparentCount = 0
            $samplePixels = @()
            
            # 처음 100개 픽셀만 샘플링 (성능상 이유)
            $sampleSize = [Math]::Min(100, $pixels.Length)
            for ($i = 0; $i -lt $sampleSize; $i++) {
                $pixel = $pixels[$i]
                $alpha = ($pixel -shr 24) -band 0xFF
                
                if ($alpha -gt 0) {
                    $nonTransparentCount++
                }
                
                if ($i -lt 10) {  # 처음 10개 픽셀의 ARGB 값 저장
                    $samplePixels += "ARGB($alpha,$( ($pixel -shr 16) -band 0xFF ),$( ($pixel -shr 8) -band 0xFF ),$( $pixel -band 0xFF ))"
                }
            }
            
            $transparencyRatio = ($sampleSize - $nonTransparentCount) / $sampleSize * 100
            Write-Host "   투명도 분석 (샘플 $sampleSize개):"
            Write-Host "     - 투명하지 않은 픽셀: $nonTransparentCount"
            Write-Host "     - 투명 픽셀 비율: $($transparencyRatio.ToString('F1'))%"
            
            Write-Host "   픽셀 샘플 (처음 10개):"
            $samplePixels | ForEach-Object { Write-Host "     - $_" }
            
            # 만약 모든 픽셀이 투명하다면
            if ($nonTransparentCount -eq 0) {
                Write-Host "   ⚠️  경고: 모든 샘플 픽셀이 투명합니다!" -ForegroundColor Red
            }
            
        } else {
            Write-Host "   ⚠️  픽셀 데이터 로드 실패 또는 빈 데이터" -ForegroundColor Red
        }
    } catch {
        Write-Host "   ⚠️  픽셀 데이터 분석 실패: $($_.Exception.Message)" -ForegroundColor Red
    }

    Write-Host "`n4. 다양한 추출 방법 테스트:" -ForegroundColor Green
    
    $testResults = @()
    
    # 방법 1: 기본 Layer.Save
    try {
        $outFile1 = Join-Path $OutputDir "test_method1_basic.png"
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $targetLayer.Save($outFile1, $pngOptions)
        
        if (Test-Path $outFile1) {
            $fileSize = (Get-Item $outFile1).Length
            $testResults += "Method 1 (기본 저장): 성공 ($fileSize bytes)"
        } else {
            $testResults += "Method 1 (기본 저장): 파일 생성 실패"
        }
    } catch {
        $testResults += "Method 1 (기본 저장): 예외 발생 - $($_.Exception.Message)"
    }
    
    # 방법 2: 픽셀 데이터로 새 이미지 생성
    try {
        $outFile2 = Join-Path $OutputDir "test_method2_pixels.png"
        $bounds = $targetLayer.Bounds
        $pixels = $targetLayer.LoadArgb32Pixels($bounds)
        
        if ($pixels -and $pixels.Length -gt 0) {
            $rasterImg = New-Object Aspose.PSD.RasterImage($bounds.Width, $bounds.Height)
            $rasterImg.SaveArgb32Pixels($rasterImg.Bounds, $pixels)
            $rasterImg.Save($outFile2, $pngOptions)
            $rasterImg.Dispose()
            
            if (Test-Path $outFile2) {
                $fileSize = (Get-Item $outFile2).Length
                $testResults += "Method 2 (픽셀 데이터): 성공 ($fileSize bytes)"
            } else {
                $testResults += "Method 2 (픽셀 데이터): 파일 생성 실패"
            }
        } else {
            $testResults += "Method 2 (픽셀 데이터): 픽셀 데이터 없음"
        }
    } catch {
        $testResults += "Method 2 (픽셀 데이터): 예외 발생 - $($_.Exception.Message)"
    }
    
    # 방법 3: 합성 방법 (전체 이미지에서 레이어만 보이게 한 후 크롭)
    try {
        $outFile3 = Join-Path $OutputDir "test_method3_composite.png"
        
        # 모든 레이어 숨기고 타깃만 보이게
        $originalVisibility = @()
        for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
            $originalVisibility += $psd.Layers[$i].IsVisible
            $psd.Layers[$i].IsVisible = $false
        }
        $targetLayer.IsVisible = $true
        
        # 전체 이미지 저장
        $tempFile = Join-Path $OutputDir "temp_composite.png"
        $psd.Save($tempFile, $pngOptions)
        
        # 가시성 복구
        for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
            $psd.Layers[$i].IsVisible = $originalVisibility[$i]
        }
        
        if (Test-Path $tempFile) {
            # System.Drawing을 사용해서 크롭 (가능한 경우)
            try {
                Add-Type -AssemblyName System.Drawing
                $fullImg = [System.Drawing.Image]::FromFile($tempFile)
                $bounds = $targetLayer.Bounds
                
                # 바운드가 이미지 범위를 벗어나지 않도록 조정
                $cropX = [Math]::Max(0, $bounds.Left)
                $cropY = [Math]::Max(0, $bounds.Top)
                $cropW = [Math]::Min($bounds.Width, $fullImg.Width - $cropX)
                $cropH = [Math]::Min($bounds.Height, $fullImg.Height - $cropY)
                
                if ($cropW -gt 0 -and $cropH -gt 0) {
                    $cropRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
                    $croppedImg = New-Object System.Drawing.Bitmap($cropW, $cropH)
                    $graphics = [System.Drawing.Graphics]::FromImage($croppedImg)
                    $graphics.DrawImage($fullImg, 0, 0, $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
                    $graphics.Dispose()
                    
                    $croppedImg.Save($outFile3, [System.Drawing.Imaging.ImageFormat]::Png)
                    $croppedImg.Dispose()
                }
                $fullImg.Dispose()
                
                Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
                
                if (Test-Path $outFile3) {
                    $fileSize = (Get-Item $outFile3).Length
                    $testResults += "Method 3 (합성+크롭): 성공 ($fileSize bytes)"
                } else {
                    $testResults += "Method 3 (합성+크롭): 크롭 실패"
                }
            } catch {
                $testResults += "Method 3 (합성+크롭): System.Drawing 크롭 실패 - $($_.Exception.Message)"
                Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
            }
        } else {
            $testResults += "Method 3 (합성+크롭): 합성 이미지 생성 실패"
        }
    } catch {
        $testResults += "Method 3 (합성+크롭): 예외 발생 - $($_.Exception.Message)"
    }
    
    # 결과 출력
    Write-Host "   테스트 결과:"
    $testResults | ForEach-Object { Write-Host "     - $_" }

    Write-Host "`n5. 권장사항:" -ForegroundColor Green
    
    # 분석 결과에 따른 권장사항
    if ($transparencyRatio -eq 100) {
        Write-Host "   ❌ 문제: 레이어의 원본 픽셀 데이터가 완전히 투명합니다." -ForegroundColor Red
        Write-Host "   💡 원인 추정:" -ForegroundColor Yellow
        Write-Host "     - 이 레이어는 스마트 오브젝트이거나 조정 레이어일 가능성"
        Write-Host "     - 레이어 효과나 블렌딩 모드에 의해서만 보이는 레이어"
        Write-Host "     - 다른 레이어를 참조하는 클리핑 마스크"
        Write-Host "   🔧 해결책: Method 3 (합성+크롭) 사용 권장"
    } elseif ($transparencyRatio -gt 90) {
        Write-Host "   ⚠️  문제: 레이어가 거의 투명합니다 ($($transparencyRatio.ToString('F1'))% 투명)" -ForegroundColor Yellow
        Write-Host "   💡 일부 픽셀 데이터가 있지만 매우 희박합니다."
        Write-Host "   🔧 해결책: Method 2나 Method 3 시도"
    } else {
        Write-Host "   ✅ 레이어에 실제 픽셀 데이터가 있습니다." -ForegroundColor Green
        Write-Host "   💡 저장 과정에서 다른 문제가 있을 수 있습니다."
        Write-Host "   🔧 해결책: 저장 옵션이나 색상 공간 확인 필요"
    }

} finally {
    $psd.Dispose()
}

Write-Host "`n=== 진단 완료 ===" -ForegroundColor Yellow
Write-Host "생성된 테스트 파일들을 Paint와 Photoshop에서 확인해보세요."

<#

3. 예상되는 원인들 (우선순위별)
가능성 1: 스마트 오브젝트 또는 참조 레이어

레이어가 외부 파일을 참조하는 스마트 오브젝트
원본 픽셀 데이터가 없고 참조만 있음

가능성 2: 레이어 효과 의존성

레이어 자체는 투명하지만 그림자, 글로우 등의 효과로만 보임
블렌딩 모드로 다른 레이어와 합성되어서만 보임

가능성 3: 클리핑 마스크

다른 레이어를 마스크로 사용하는 클리핑 레이어
원본 데이터는 있지만 마스크 적용 전 상태가 저장됨

가능성 4: 조정 레이어

색상 보정이나 필터 효과만 있는 레이어
실제 이미지 데이터가 없음

#>