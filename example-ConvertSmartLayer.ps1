# PSD 레이어를 Linked Smart Object로 변환하는 PowerShell 스크립트

. ".\Load-AsposePSD.ps1"

# 빈 PNG 파일을 생성하는 함수
function CreateEmptyPngFile {
    param(
        [string]$FilePath,
        [int]$Width = 100,
        [int]$Height = 100
    )
    
    try {
        # Aspose.PSD를 사용하여 빈 이미지 생성
        $emptyImage = New-Object Aspose.PSD.Image($Width, $Height)
        
        # PNG 옵션 설정
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        
        # 빈 이미지를 PNG로 저장
        $emptyImage.Save($FilePath, $pngOptions)
        $emptyImage.Dispose()
        
        Write-Host "빈 PNG 파일 생성 성공 (${Width}x${Height}): $FilePath" -ForegroundColor Green
    }
    catch {
        Write-Host "Aspose.PSD로 빈 PNG 생성 실패, .NET 방식으로 시도합니다..." -ForegroundColor Yellow
        
        # .NET 방식으로 빈 PNG 파일 생성 (대안)
        Add-Type -AssemblyName System.Drawing
        
        $bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        
        # 투명한 배경으로 채우기
        $graphics.Clear([System.Drawing.Color]::Transparent)
        
        # PNG로 저장
        $bitmap.Save($FilePath, [System.Drawing.Imaging.ImageFormat]::Png)
        
        # 리소스 정리
        $graphics.Dispose()
        $bitmap.Dispose()
        
        Write-Host "빈 PNG 파일 생성 성공 (.NET 방식, ${Width}x${Height}): $FilePath" -ForegroundColor Green
    }
}

# 파일 경로 설정
$PsdPath = "e:\psd_template\machine_1\001708ff-86d1-419b-bc19-2dd530b087c6\001708ff-86d1-419b-bc19-2dd530b087c6.psd"
$OutputPsdPath = "e:\psd_template\machine_1\001708ff-86d1-419b-bc19-2dd530b087c6\001708ff-86d1-419b-bc19-2dd530b087c6_linked.psd"

# 링크할 외부 파일 경로 (레이어 6의 내용을 저장할 파일)
$ExternalFilePath = "e:\psd_template\machine_1\001708ff-86d1-419b-bc19-2dd530b087c6\layer6_content.png"

try {
    # PSD 파일 로드
    Write-Host "PSD 파일을 로드하는 중..." -ForegroundColor Green
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true
    $psd = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
    
    Write-Host "총 레이어 수: $($psd.Layers.Count)" -ForegroundColor Cyan
    
    # 레이어 6이 존재하는지 확인
    if ($psd.Layers.Count -le 6) {
        throw "레이어 6이 존재하지 않습니다. 총 레이어 수: $($psd.Layers.Count)"
    }
    
    $targetLayer = $psd.Layers[6]
    Write-Host "레이어 6 정보: $($targetLayer.GetType().Name) - $($targetLayer.DisplayName)" -ForegroundColor Yellow
    
    # 이미 Smart Object인지 확인
    if ($targetLayer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
        Write-Host "레이어 6은 이미 Smart Object입니다." -ForegroundColor Yellow
        $smartLayer = $targetLayer
        
        # ContentType 확인
        $contentType = $smartLayer.ContentType
        Write-Host "현재 Smart Object 타입: $contentType" -ForegroundColor Cyan
        
        if ($contentType -eq [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectType]::AvailableLinked) {
            Write-Host "이미 Linked Smart Object입니다." -ForegroundColor Green
        } else {
            Write-Host "Embedded Smart Object를 Linked Smart Object로 변환합니다..." -ForegroundColor Yellow
            
            # 빈 PNG 파일 생성
            Write-Host "빈 PNG 파일을 생성합니다..." -ForegroundColor Yellow
            CreateEmptyPngFile -FilePath $ExternalFilePath -Width 100 -Height 100
            Write-Host "빈 PNG 파일 생성 완료: $ExternalFilePath" -ForegroundColor Green
            
            # ReplaceContents를 사용하여 Embedded를 Linked로 변환
            $smartLayer.ReplaceContents($ExternalFilePath)
            Write-Host "Embedded Smart Object를 Linked로 변환 완료" -ForegroundColor Green
        }
    } else {
        Write-Host "일반 레이어를 Smart Object로 변환합니다..." -ForegroundColor Yellow
        
        # 먼저 레이어를 Smart Object로 변환 (Embedded로 생성됨)
        $smartLayer = $psd.SmartObjectProvider.ConvertToSmartObject(6)
        
        # 변환 결과 검증
        if ($smartLayer -eq $null) {
            throw "레이어를 Smart Object로 변환하는 데 실패했습니다."
        }
        
        Write-Host "레이어 6을 Smart Object로 변환 완료 (Embedded)" -ForegroundColor Green
        
        # 빈 PNG 파일 생성
        Write-Host "빈 PNG 파일을 생성합니다..." -ForegroundColor Yellow
        CreateEmptyPngFile -FilePath $ExternalFilePath -Width 100 -Height 100
        Write-Host "빈 PNG 파일 생성 완료: $ExternalFilePath" -ForegroundColor Green
        
        # ReplaceContents를 사용하여 Embedded Smart Object를 Linked로 변환
        Write-Host "Embedded Smart Object를 Linked로 변환합니다..." -ForegroundColor Yellow
        $smartLayer.ReplaceContents($ExternalFilePath)
        Write-Host "Smart Object를 외부 파일에 링크 완료" -ForegroundColor Green
    }
    
    # 변경 사항 저장
    Write-Host "변경된 PSD 파일을 저장하는 중..." -ForegroundColor Green
    $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions($psd)
    $psd.Save($OutputPsdPath, $psdOptions)
    
    Write-Host "작업 완료!" -ForegroundColor Green
    Write-Host "출력 파일: $OutputPsdPath" -ForegroundColor Cyan
    Write-Host "링크된 외부 파일: $ExternalFilePath" -ForegroundColor Cyan
    
    # 결과 확인
    Write-Host "`n=== 결과 확인 ===" -ForegroundColor Magenta
    $finalLayer = $psd.Layers[6]
    if ($finalLayer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
        $contentType = $finalLayer.ContentType
        Write-Host "최종 Smart Object 타입: $contentType" -ForegroundColor Cyan
        if ($contentType -eq [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectType]::AvailableLinked) {
            Write-Host "✓ 성공: 레이어 6이 Linked Smart Object로 변환되었습니다!" -ForegroundColor Green
        } else {
            Write-Host "⚠ 경고: Smart Object이지만 링크되지 않았습니다." -ForegroundColor Yellow
        }
    } else {
        Write-Host "✗ 실패: 레이어가 Smart Object로 변환되지 않았습니다." -ForegroundColor Red
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

# 사용법 안내
Write-Host "`n=== 사용법 안내 ===" -ForegroundColor Magenta
Write-Host "1. 이 스크립트는 레이어 6을 Linked Smart Object로 변환합니다."
Write-Host "2. 외부 파일이 생성되며, Photoshop에서 이 파일을 수정하면 PSD에도 반영됩니다."
Write-Host "3. 생성된 파일들을 함께 보관해야 링크가 유지됩니다."

# ================================
# 수정된 접근법과 주의사항
# ================================
<#
실행 오류 분석 및 해결책:

오류 1: "You cannot call a method on a null-valued expression."
- ConvertToSmartObject()가 null을 반환하는 경우 발생
- 해결책: 반환값 검증 추가

오류 2: "Use ReplaceContents to change embedded smart layer to linked instead."
- RelinkToFile()은 이미 Linked Smart Object에서만 작동
- ConvertToSmartObject()는 항상 Embedded Smart Object를 생성
- 해결책: ReplaceContents() 메서드 사용

올바른 순서:
1. ConvertToSmartObject() → Embedded Smart Object 생성
2. ReplaceContents(filePath) → Embedded를 Linked로 변환

핵심 개념:
- ConvertToSmartObject(): 레이어 → Embedded Smart Object
- ReplaceContents(): Embedded Smart Object → Linked Smart Object (또는 내용 교체)
- RelinkToFile(): 이미 Linked인 Smart Object의 링크 대상 변경

두 번째 질문에 대한 답변:

Q: RemoveLayer()와 AddLayer()를 사용하면 레이어 순서가 바뀌어서 PSD 렌더링 결과가 달라지지 않을까요?

A: 맞습니다! 매우 중요한 지적입니다. RemoveLayer()와 AddLayer()를 사용하면:
1. 레이어의 순서(z-order)가 변경됩니다
2. 레이어 간의 블렌딩 모드나 마스크 관계가 영향받을 수 있습니다
3. PSD 작업자에게는 예상치 못한 결과를 초래할 수 있습니다

더 안전한 접근법:
1. 기존 레이어의 속성을 모두 보존하면서 Smart Object로 변환
2. 레이어의 위치(인덱스)를 유지
3. 다른 레이어들과의 관계를 보존

현재 스크립트에서 사용하는 방법인 SmartObjectProvider.ConvertToSmartObject(layerIndex)가
레이어 순서를 보존하는 더 안전한 방법입니다.

권장사항:
- 현재 스크립트의 방법 (ConvertToSmartObject + ReplaceContents)을 사용하세요
- RemoveLayer/AddLayer 조합은 피하세요
- 작업 전에 PSD 백업을 만드세요
#>