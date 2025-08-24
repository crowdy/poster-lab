# add-chara-count.ps1
# CSV 파일에 main character와 sub character 카운트를 추가하는 스크립트

param(
    [string]$CsvPath = "d:\poster-json-machine-analysis.csv",
    [string]$LayerInfoDir = "d:\poster\layerinfo\",
    [string]$OutputPath = "d:\poster-json-machine-analysis.csv"
)

# 파일 존재 확인
if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV 파일을 찾을 수 없습니다: $CsvPath"
    exit 1
}

if (-not (Test-Path $LayerInfoDir)) {
    Write-Error "Layer info 디렉토리를 찾을 수 없습니다: $LayerInfoDir"
    exit 1
}

Write-Host "CSV 파일 읽는 중: $CsvPath"

# CSV 파일 읽기
try {
    $csvData = Import-Csv -Path $CsvPath -Encoding UTF8
}
catch {
    Write-Error "CSV 파일을 읽는 중 오류가 발생했습니다: $_"
    exit 1
}

Write-Host "총 $($csvData.Count)개의 레코드를 처리합니다."

# Layer info 파일에서 character 카운트를 가져오는 함수
function Get-CharacterCounts {
    param([string]$UUID)
    
    $layerInfoPath = Join-Path $LayerInfoDir "$UUID.md"
    
    # 기본값
    $mainCharaCount = 0
    $subCharaCount = 0
    
    if (Test-Path $layerInfoPath) {
        try {
            # UTF-8로 파일 읽기
            $content = Get-Content -Path $layerInfoPath -Encoding UTF8
            
            foreach ($line in $content) {
                # chara_main_을 포함하는 라인 카운트
                if ($line -match "chara_main_") {
                    $mainCharaCount++
                }
                
                # chara_sub_을 포함하는 라인 카운트
                if ($line -match "chara_sub_") {
                    $subCharaCount++
                }
            }
            
            Write-Host "처리됨: $UUID -> main: $mainCharaCount, sub: $subCharaCount"
        }
        catch {
            Write-Warning "Layer info 파일 읽기 오류 ($UUID.md): $_"
        }
    }
    else {
        Write-Host "Layer info 파일 없음: $UUID -> main: 0, sub: 0"
    }
    
    return @{
        MainCount = $mainCharaCount
        SubCount = $subCharaCount
    }
}

# 각 행에 대해 character 카운트 추가
$updatedData = foreach ($row in $csvData) {
    $uuid = $row.FileNameWithoutExtension
    
    # Character 카운트 가져오기
    if ($uuid -and $uuid -ne "archive") {
        $charaCounts = Get-CharacterCounts -UUID $uuid
        $mainCharaCount = $charaCounts.MainCount
        $subCharaCount = $charaCounts.SubCount
    }
    else {
        # archive 파일이나 UUID가 없는 경우
        $mainCharaCount = 0
        $subCharaCount = 0
        Write-Host "UUID 없음 또는 archive: $($row.FileName) -> main: 0, sub: 0"
    }
    
    # 새로운 객체 생성 (기존 속성 + character counts)
    [PSCustomObject]@{
        FileName = $row.FileName
        MachineCount = $row.MachineCount
        FileNameWithoutExtension = $row.FileNameWithoutExtension
        Orientation = $row.Orientation
        main_character_count = $mainCharaCount
        sub_character_count = $subCharaCount
    }
}

Write-Host "결과를 저장하는 중: $OutputPath"

# 업데이트된 데이터를 새 CSV 파일로 저장
try {
    $updatedData | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "성공적으로 완료되었습니다!"
    Write-Host "출력 파일: $OutputPath"
    
    # 통계 정보 출력
    Write-Host "`n=== Character Count 통계 ==="
    
    # Main character 통계
    $mainCharaStats = $updatedData | Group-Object main_character_count | Sort-Object Name
    Write-Host "Main Character Count 분포:"
    foreach ($stat in $mainCharaStats) {
        Write-Host "  $($stat.Name)개: $($stat.Count)개 파일"
    }
    
    # Sub character 통계
    $subCharaStats = $updatedData | Group-Object sub_character_count | Sort-Object Name
    Write-Host "Sub Character Count 분포:"
    foreach ($stat in $subCharaStats) {
        Write-Host "  $($stat.Name)개: $($stat.Count)개 파일"
    }
    
    # 전체 통계
    $totalMainChara = ($updatedData | Measure-Object main_character_count -Sum).Sum
    $totalSubChara = ($updatedData | Measure-Object sub_character_count -Sum).Sum
    Write-Host "전체 Main Character: $totalMainChara"
    Write-Host "전체 Sub Character: $totalSubChara"
    
    # 샘플 데이터 표시 (처음 5개)
    Write-Host "`n=== 샘플 데이터 (처음 5개) ==="
    $updatedData | Select-Object -First 5 | Format-Table -AutoSize
    
}
catch {
    Write-Error "파일 저장 중 오류가 발생했습니다: $_"
    exit 1
}