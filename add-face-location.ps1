# add-face-location.ps1
# CSV 파일에 character face 위치 정보를 추가하는 스크립트

param(
    [string]$CsvPath = "d:\poster-json-machine-analysis.csv",
    [string]$PsdDir = "d:\poster\",
    [string]$OutputPath = "d:\poster-json-machine-analysis.csv"
)

# Load-AsposePSD.ps1 로드
. ".\Load-AsposePSD.ps1"

# 파일 존재 확인
if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV 파일을 찾을 수 없습니다: $CsvPath"
    exit 1
}

if (-not (Test-Path $PsdDir)) {
    Write-Error "PSD 디렉토리를 찾을 수 없습니다: $PsdDir"
    exit 1
}

Write-Host "CSV 파일 읽는 중: $CsvPath" -ForegroundColor Green

# CSV 파일 읽기
try {
    $csvData = Import-Csv -Path $CsvPath -Encoding UTF8
}
catch {
    Write-Error "CSV 파일을 읽는 중 오류가 발생했습니다: $_"
    exit 1
}

Write-Host "총 $($csvData.Count)개의 레코드를 처리합니다." -ForegroundColor Cyan

# PSD 파일에서 face 위치 정보를 가져오는 함수
function Get-FaceLocations {
    param([string]$UUID)
    
    $psdPath = Join-Path $PsdDir "$UUID.psd"
    
    # 기본 반환값 (모든 face 위치를 빈 문자열로 초기화)
    $result = @{
        m1_face_xy_width = ""
        m2_face_xy_width = ""
        m3_face_xy_width = ""
        m4_face_xy_width = ""
        m5_face_xy_width = ""
        m6_face_xy_width = ""
        s1_face_xy_width = ""
        s2_face_xy_width = ""
        s3_face_xy_width = ""
        s4_face_xy_width = ""
        s5_face_xy_width = ""
        s6_face_xy_width = ""
    }
    
    if (-not (Test-Path $psdPath)) {
        Write-Host "PSD 파일 없음: $UUID" -ForegroundColor Yellow
        return $result
    }
    
    try {
        Write-Host "PSD 분석 중: $UUID" -ForegroundColor Gray
        
        # PSD 로드 옵션 설정
        $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
        $loadOptions.LoadEffectsResource = $true
        $loadOptions.UseDiskForLoadEffectsResource = $true
        
        # PSD 파일 로드
        $psd = [Aspose.PSD.Image]::Load($psdPath, $loadOptions)
        
        $mainCharaCount = 0
        $subCharaCount = 0
        
        # 각 레이어를 순회하면서 character와 face 레이어 찾기
        for ($i = 0; $i -lt $psd.Layers.Count; $i++) {
            $layer = $psd.Layers[$i]
            $layerName = if ($layer.Name) { $layer.Name } else { $layer.DisplayName }
            if (-not $layerName) { continue }
            
            # Main character 레이어 찾기
            if ($layerName -match "^chara_main_") {
                $mainCharaCount++
                if ($mainCharaCount -le 6) {
                    # 다음 레이어가 face인지 확인
                    if (($i + 1) -lt $psd.Layers.Count) {
                        $nextLayer = $psd.Layers[$i + 1]
                        $nextLayerName = if ($nextLayer.Name) { $nextLayer.Name } else { $nextLayer.DisplayName }
                        
                        if ($nextLayerName -eq "face") {
                            $relativeX = $nextLayer.Left
                            $relativeY = $nextLayer.Top
                            $faceWidth = $nextLayer.Width
                            
                            $columnName = "m$mainCharaCount" + "_face_xy_width"
                            $result[$columnName] = "$relativeX, $relativeY, $faceWidth"
                            
                            Write-Host "  Main $mainCharaCount face: ($relativeX, $relativeY, $faceWidth)" -ForegroundColor Blue
                        }
                    }
                }
            }
            
            # Sub character 레이어 찾기
            if ($layerName -match "^chara_sub_") {
                $subCharaCount++
                if ($subCharaCount -le 6) {
                    # 다음 레이어가 face인지 확인
                    if (($i + 1) -lt $psd.Layers.Count) {
                        $nextLayer = $psd.Layers[$i + 1]
                        $nextLayerName = if ($nextLayer.Name) { $nextLayer.Name } else { $nextLayer.DisplayName }
                        
                        if ($nextLayerName -eq "face") {
                            # face의 상대적 위치 계산
                            $relativeX = $nextLayer.Left
                            $relativeY = $nextLayer.Top
                            $faceWidth = $nextLayer.Width
                            
                            $columnName = "s$subCharaCount" + "_face_xy_width"
                            $result[$columnName] = "$relativeX, $relativeY, $faceWidth"
                            
                            Write-Host "  Sub $subCharaCount face: ($relativeX, $relativeY, $faceWidth)" -ForegroundColor Magenta
                        }
                    }
                }
            }
        }
        
        Write-Host "  처리 완료: Main $mainCharaCount개, Sub $subCharaCount개" -ForegroundColor Green
        
    }
    catch {
        Write-Warning "PSD 파일 분석 오류 ($UUID.psd): $_"
    }
    finally {
        # 리소스 정리
        if ($psd) {
            $psd.Dispose()
        }
    }
    
    return $result
}

# 각 행에 대해 face 위치 정보 추가
$updatedData = foreach ($row in $csvData) {
    $uuid = $row.FileNameWithoutExtension
    
    # Face 위치 정보 가져오기
    if ($uuid -and $uuid -ne "archive") {
        $faceLocations = Get-FaceLocations -UUID $uuid
    }
    else {
        # archive 파일이나 UUID가 없는 경우 모든 face 위치를 빈 문자열로
        $faceLocations = @{
            m1_face_xy_width = ""
            m2_face_xy_width = ""
            m3_face_xy_width = ""
            m4_face_xy_width = ""
            m5_face_xy_width = ""
            m6_face_xy_width = ""
            s1_face_xy_width = ""
            s2_face_xy_width = ""
            s3_face_xy_width = ""
            s4_face_xy_width = ""
            s5_face_xy_width = ""
            s6_face_xy_width = ""
        }
        Write-Host "UUID 없음 또는 archive: $($row.FileName)" -ForegroundColor Yellow
    }
    
    # 새로운 객체 생성 (기존 속성 + face 위치 정보)
    [PSCustomObject]@{
        FileName = $row.FileName
        MachineCount = $row.MachineCount
        FileNameWithoutExtension = $row.FileNameWithoutExtension
        Orientation = $row.Orientation
        main_character_count = $row.main_character_count
        sub_character_count = $row.sub_character_count
        logo_type = $row.logo_type
        m1_face_xy_width = $faceLocations.m1_face_xy_width
        m2_face_xy_width = $faceLocations.m2_face_xy_width
        m3_face_xy_width = $faceLocations.m3_face_xy_width
        m4_face_xy_width = $faceLocations.m4_face_xy_width
        m5_face_xy_width = $faceLocations.m5_face_xy_width
        m6_face_xy_width = $faceLocations.m6_face_xy_width
        s1_face_xy_width = $faceLocations.s1_face_xy_width
        s2_face_xy_width = $faceLocations.s2_face_xy_width
        s3_face_xy_width = $faceLocations.s3_face_xy_width
        s4_face_xy_width = $faceLocations.s4_face_xy_width
        s5_face_xy_width = $faceLocations.s5_face_xy_width
        s6_face_xy_width = $faceLocations.s6_face_xy_width
    }
}

Write-Host "결과를 저장하는 중: $OutputPath" -ForegroundColor Green

# 업데이트된 데이터를 새 CSV 파일로 저장
try {
    $updatedData | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "성공적으로 완료되었습니다!" -ForegroundColor Green
    Write-Host "출력 파일: $OutputPath" -ForegroundColor Cyan
    
    # 통계 정보 출력
    Write-Host "`n=== Face 위치 정보 통계 ===" -ForegroundColor Magenta
    
    # Main character face 통계
    $mainFaceCount = 0
    $subFaceCount = 0
    
    foreach ($row in $updatedData) {
        for ($i = 1; $i -le 6; $i++) {
            $mainColumn = "m$i" + "_face_xy_width"
            $subColumn = "s$i" + "_face_xy_width"
            
            if ($row.$mainColumn -and $row.$mainColumn -ne "") {
                $mainFaceCount++
            }
            if ($row.$subColumn -and $row.$subColumn -ne "") {
                $subFaceCount++
            }
        }
    }
    
    Write-Host "총 Main Character Face: $mainFaceCount개" -ForegroundColor Blue
    Write-Host "총 Sub Character Face: $subFaceCount개" -ForegroundColor Magenta
    
    # 샘플 데이터 표시 (처음 3개, face 위치 정보만)
    Write-Host "`n=== 샘플 Face 위치 데이터 (처음 3개) ===" -ForegroundColor Magenta
    $sampleData = $updatedData | Select-Object -First 3 | Select-Object FileNameWithoutExtension, m1_face_xy_width, m2_face_xy_width, s1_face_xy_width, s2_face_xy_width
    $sampleData | Format-Table -AutoSize
    
}
catch {
    Write-Error "파일 저장 중 오류가 발생했습니다: $_"
    exit 1
}

Write-Host "`n=== 사용법 안내 ===" -ForegroundColor Yellow
Write-Host "Face 위치 형식: 'x, y, width'"
Write-Host "  - x, y: character 레이어 기준 상대적 위치"
Write-Host "  - width: face 레이어의 너비"
Write-Host "  - 빈 문자열: 해당 face가 존재하지 않음"
Write-Host ""
Write-Host "예시: '405, 44, 203' = character 기준 (405, 44) 위치에 너비 203인 face"
