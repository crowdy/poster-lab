# PSD 색상 정보 분석 및 색상 공간 문제 해결
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

if (-not (Test-Path $OutputDir)) { New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null }

Write-Host "=== PSD 색상 공간 문제 해결 ===" -ForegroundColor Yellow

$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

$img = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
$psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img

try {
    Write-Host "`n1. PSD 파일 색상 정보:" -ForegroundColor Green
    Write-Host "   색상 모드: $($psd.ColorMode)"
    Write-Host "   비트 깊이: $($psd.BitsPerChannel)"
    Write-Host "   채널 수: $($psd.ChannelsCount)"
    Write-Host "   해상도: $($psd.HorizontalResolution) x $($psd.VerticalResolution) DPI"
    
    # 색상 프로파일 확인
    try {
        if ($psd.ColorProfiles -and $psd.ColorProfiles.Length -gt 0) {
            Write-Host "   색상 프로파일: 있음 ($($psd.ColorProfiles.Length)개)"
            for ($i = 0; $i -lt $psd.ColorProfiles.Length; $i++) {
                Write-Host "     [$i] $($psd.ColorProfiles[$i].Description)"
            }
        } else {
            Write-Host "   색상 프로파일: 없음"
        }
    } catch {
        Write-Host "   색상 프로파일: 확인 불가"
    }

    # 타깃 레이어 찾기
    $targetLayer = $psd.Layers | Where-Object { $_.Name -eq $LayerName } | Select-Object -First 1
    if (-not $targetLayer) {
        Write-Error "Layer '$LayerName' not found"
        return
    }

    Write-Host "`n2. 레이어별 색상 분석:" -ForegroundColor Green
    Write-Host "   레이어 이름: '$($targetLayer.Name)'"
    
    # 레이어의 색상 정보
    try {
        if ($targetLayer.GetType().GetProperty("ChannelsCount")) {
            Write-Host "   레이어 채널 수: $($targetLayer.ChannelsCount)"
        }
    } catch {}

    Write-Host "`n3. 색상 공간 변환 추출 테스트:" -ForegroundColor Green

    $bounds = $targetLayer.Bounds
    $testResults = @()

    # 방법 A: RGB 변환 후 저장
    try {
        Write-Host "   방법 A: RGB 색상 공간 강제 변환..."
        $outFileA = Join-Path $OutputDir "fixed_rgb_conversion.png"
        
        # PSD를 RGB 모드로 변환
        if ($psd.ColorMode -ne [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb) {
            Write-Host "     현재 색상 모드에서 RGB로 변환 중..."
            # 전체 PSD를 RGB로 변환
            $psd.ConvertToRgb()
        }
        
        # PNG 옵션 설정 (sRGB 강제)
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        $pngOptions.BitDepth = 8  # 8비트 강제
        
        $targetLayer.Save($outFileA, $pngOptions)
        
        if (Test-Path $outFileA) {
            $fileSize = (Get-Item $outFileA).Length
            $testResults += "방법 A (RGB 변환): 성공 ($fileSize bytes)"
        }
    } catch {
        $testResults += "방법 A (RGB 변환): 실패 - $($_.Exception.Message)"
    }

    # 방법 B: 픽셀 데이터 정규화
    try {
        Write-Host "   방법 B: 픽셀 데이터 정규화..."
        $outFileB = Join-Path $OutputDir "fixed_normalized_pixels.png"
        
        $pixels = $targetLayer.LoadArgb32Pixels($bounds)
        
        if ($pixels -and $pixels.Length -gt 0) {
            # 픽셀 값 분석 및 정규화
            $normalizedPixels = New-Object 'int[]' $pixels.Length
            
            # 색상 범위 확인
            $minR = 255; $maxR = 0
            $minG = 255; $maxG = 0
            $minB = 255; $maxB = 0
            
            # 샘플링해서 색상 범위 확인 (성능상 이유로 전체의 1%만)
            $sampleSize = [Math]::Max(1000, [Math]::Min(10000, $pixels.Length / 100))
            for ($i = 0; $i -lt $sampleSize; $i++) {
                $pixel = $pixels[$i]
                $r = ($pixel -shr 16) -band 0xFF
                $g = ($pixel -shr 8) -band 0xFF
                $b = $pixel -band 0xFF
                
                if ($r -lt $minR) { $minR = $r }
                if ($r -gt $maxR) { $maxR = $r }
                if ($g -lt $minG) { $minG = $g }
                if ($g -gt $maxG) { $maxG = $g }
                if ($b -lt $minB) { $minB = $b }
                if ($b -gt $maxB) { $maxB = $b }
            }
            
            Write-Host "     색상 범위 분석 (샘플 $sampleSize개):"
            Write-Host "       R: $minR ~ $maxR"
            Write-Host "       G: $minG ~ $maxG"
            Write-Host "       B: $minB ~ $maxB"
            
            # 색상 범위가 너무 좁으면 정규화 적용
            $needsNormalization = ($maxR - $minR) -lt 50 -or ($maxG - $minG) -lt 50 -or ($maxB - $minB) -lt 50
            
            if ($needsNormalization) {
                Write-Host "     색상 범위가 좁음 - 정규화 적용"
                
                for ($i = 0; $i -lt $pixels.Length; $i++) {
                    $pixel = $pixels[$i]
                    $a = ($pixel -shr 24) -band 0xFF
                    $r = ($pixel -shr 16) -band 0xFF
                    $g = ($pixel -shr 8) -band 0xFF
                    $b = $pixel -band 0xFF
                    
                    # 정규화 (0-255 범위로 확장)
                    if ($maxR -gt $minR) { $r = [Math]::Round(($r - $minR) * 255.0 / ($maxR - $minR)) }
                    if ($maxG -gt $minG) { $g = [Math]::Round(($g - $minG) * 255.0 / ($maxG - $minG)) }
                    if ($maxB -gt $minB) { $b = [Math]::Round(($b - $minB) * 255.0 / ($maxB - $minB)) }
                    
                    # 범위 제한
                    $r = [Math]::Max(0, [Math]::Min(255, $r))
                    $g = [Math]::Max(0, [Math]::Min(255, $g))
                    $b = [Math]::Max(0, [Math]::Min(255, $b))
                    
                    $normalizedPixels[$i] = ($a -shl 24) -bor ($r -shl 16) -bor ($g -shl 8) -bor $b
                }
            } else {
                Write-Host "     색상 범위 정상 - 정규화 생략"
                $normalizedPixels = $pixels
            }
            
            # 정규화된 픽셀로 이미지 생성
            Add-Type -AssemblyName System.Drawing
            $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
            
            try {
                $bmpData = $bitmap.LockBits(
                    (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                    [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
                )
                
                # 메모리 복사
                [System.Runtime.InteropServices.Marshal]::Copy($normalizedPixels, 0, $bmpData.Scan0, $normalizedPixels.Length)
                $bitmap.UnlockBits($bmpData)
                
                # sRGB로 저장
                $bitmap.Save($outFileB, [System.Drawing.Imaging.ImageFormat]::Png)
                
                if (Test-Path $outFileB) {
                    $fileSize = (Get-Item $outFileB).Length
                    $testResults += "방법 B (정규화): 성공 ($fileSize bytes)"
                }
            } finally {
                $bitmap.Dispose()
            }
        }
    } catch {
        $testResults += "방법 B (정규화): 실패 - $($_.Exception.Message)"
    }

    # 방법 C: 감마 보정 적용
    try {
        Write-Host "   방법 C: 감마 보정 적용..."
        $outFileC = Join-Path $OutputDir "fixed_gamma_corrected.png"
        
        $pixels = $targetLayer.LoadArgb32Pixels($bounds)
        
        if ($pixels -and $pixels.Length -gt 0) {
            $gammaValue = 2.2  # 표준 sRGB 감마
            $correctedPixels = New-Object 'int[]' $pixels.Length
            
            for ($i = 0; $i -lt $pixels.Length; $i++) {
                $pixel = $pixels[$i]
                $a = ($pixel -shr 24) -band 0xFF
                $r = ($pixel -shr 16) -band 0xFF
                $g = ($pixel -shr 8) -band 0xFF
                $b = $pixel -band 0xFF
                
                # 감마 보정 적용
                $r = [Math]::Round(255 * [Math]::Pow($r / 255.0, 1.0 / $gammaValue))
                $g = [Math]::Round(255 * [Math]::Pow($g / 255.0, 1.0 / $gammaValue))
                $b = [Math]::Round(255 * [Math]::Pow($b / 255.0, 1.0 / $gammaValue))
                
                # 범위 제한
                $r = [Math]::Max(0, [Math]::Min(255, $r))
                $g = [Math]::Max(0, [Math]::Min(255, $g))
                $b = [Math]::Max(0, [Math]::Min(255, $b))
                
                $correctedPixels[$i] = ($a -shl 24) -bor ($r -shl 16) -bor ($g -shl 8) -bor $b
            }
            
            # 감마 보정된 픽셀로 이미지 생성
            Add-Type -AssemblyName System.Drawing
            $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
            
            try {
                $bmpData = $bitmap.LockBits(
                    (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                    [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
                )
                
                [System.Runtime.InteropServices.Marshal]::Copy($correctedPixels, 0, $bmpData.Scan0, $correctedPixels.Length)
                $bitmap.UnlockBits($bmpData)
                $bitmap.Save($outFileC, [System.Drawing.Imaging.ImageFormat]::Png)
                
                if (Test-Path $outFileC) {
                    $fileSize = (Get-Item $outFileC).Length
                    $testResults += "방법 C (감마 보정): 성공 ($fileSize bytes)"
                }
            } finally {
                $bitmap.Dispose()
            }
        }
    } catch {
        $testResults += "방법 C (감마 보정): 실패 - $($_.Exception.Message)"
    }

    Write-Host "`n4. 테스트 결과:" -ForegroundColor Green
    $testResults | ForEach-Object { Write-Host "   - $_" }

    Write-Host "`n5. 권장사항:" -ForegroundColor Green
    if ($psd.ColorMode -ne [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb) {
        Write-Host "   ⚠️  PSD가 RGB 모드가 아닙니다 - 색상 공간 변환 필요" -ForegroundColor Yellow
    }
    
    if ($psd.BitsPerChannel -gt 8) {
        Write-Host "   ⚠️  비트 깊이가 8비트보다 높습니다 - 정규화 필요" -ForegroundColor Yellow
    }
    
    Write-Host "   💡 생성된 파일들을 Paint와 Photoshop에서 테스트해보세요."
    Write-Host "   🔧 가장 잘 보이는 방법을 확인한 후 해당 방법을 스크립트에 적용하세요."

} finally {
    $psd.Dispose()
}

<#

PS E:\logical-experiment\local-proj-1> .\Diagnose-Layer.ps1 -PsdPath "D:\poster\00ca01ee-bc7d-4f37-b4b5-e380afe07a88.psd" -LayerName "chara_main_g02 #1" -OutputDir ".temp_diagnosis"
Aspose.PSD libraries loaded successfully
=== PSD 레이어 투명도 문제 진단 ===

1. 레이어 기본 정보 분석:
   레이어 이름: 'chara_main_g02 #1'
   레이어 타입: Layer
   가시성: True
   불투명도: 255
   바운드: 0,0 - 1828x4932
   레이어 인덱스: 7

2. 레이어 고급 속성 분석:
   블렌딩 모드: Normal
   레이어 마스크: 없음

3. 픽셀 데이터 분석:
   픽셀 데이터: 9015696개 픽셀 로드됨
   투명도 분석 (샘플 ):
     - 투명하지 않은 픽셀: 100
     - 투명 픽셀 비율: 0.0%
   픽셀 샘플 (처음 10개):
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)
     - ARGB(255,0,0,0)

4. 다양한 추출 방법 테스트:
   테스트 결과:
     - Method 1 (기본 저장): 성공 (27476 bytes)
     - Method 2 (픽셀 데이터): 예외 발생 - A constructor was not found. Cannot find an appropriate constructor for type Aspose.PSD.RasterImage.
     - Method 3 (합성+크롭): 성공 (54547 bytes)

5. 권장사항:
   ✅ 레이어에 실제 픽셀 데이터가 있습니다.
   💡 저장 과정에서 다른 문제가 있을 수 있습니다.
   🔧 해결책: 저장 옵션이나 색상 공간 확인 필요

=== 진단 완료 ===
생성된 테스트 파일들을 Paint와 Photoshop에서 확인해보세요.
PS E:\logical-experiment\local-proj-1> .\Analyze-ColorSpace.ps1 -PsdPath "D:\poster\00ca01ee-bc7d-4f37-b4b5-e380afe07a88.psd" -LayerName "chara_main_g02 #1" -OutputDir ".temp_color_fix"
Aspose.PSD libraries loaded successfully
=== PSD 색상 공간 문제 해결 ===

1. PSD 파일 색상 정보:
   색상 모드: Rgb
   비트 깊이: 8
   채널 수: 3
   해상도: 150 x 150 DPI
   색상 프로파일: 없음

2. 레이어별 색상 분석:
   레이어 이름: 'chara_main_g02 #1'
   레이어 채널 수: 4

3. 색상 공간 변환 추출 테스트:
   방법 A: RGB 색상 공간 강제 변환...
   방법 B: 픽셀 데이터 정규화...
     색상 범위 분석 (샘플 ):
       R: 0 ~ 255
       G: 0 ~ 255
       B: 0 ~ 255
     색상 범위 정상 - 정규화 생략
   방법 C: 감마 보정 적용...
PS E:\logical-experiment\local-proj-1>


감마 보정 적용...

에서 프롬프트로 돌아오지 않아서 정지했습니다. 너무 오래 걸리는 것 같아서 사용은 비 현실적인 것 같습니다.

.temp_color_fix\fixed_normalized_pixels.png

로 이미지 저장이 성공했습니다.

.temp_color_fix\fixed_rgb_conversion.png

도 생성되었지만, 역시 투명한 이미지입니다.

정상적으로 저장되지 않았던 원인을 다시 한 번 정리해 주세요

해결 방법은 LoadArgb32Pixels method를 사용하는 것이었군요?

#>