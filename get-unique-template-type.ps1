# get-unique-template-type.ps1
# CSV 파일에서 main character face 위치를 분석하여 고유한 템플릿 유형을 찾는 스크립트

param(
    [string]$CsvPath = "d:\poster-json-machine-analysis.csv"
)

# 파일 존재 확인
if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV 파일을 찾을 수 없습니다: $CsvPath"
    exit 1
}

Write-Host "CSV 파일 분석 중: $CsvPath" -ForegroundColor Green

# CSV 파일 읽기
try {
    $csvData = Import-Csv -Path $CsvPath -Encoding UTF8
}
catch {
    Write-Error "CSV 파일을 읽는 중 오류가 발생했습니다: $_"
    exit 1
}

Write-Host "총 $($csvData.Count)개의 레코드를 처리합니다." -ForegroundColor Cyan

# Main character face 위치 패턴을 만드는 함수
function Get-MainCharacterFacePattern {
    param($row)
    
    # m1부터 m6까지의 face 위치 정보를 하나의 문자열로 결합
    $pattern = @()
    for ($i = 1; $i -le 6; $i++) {
        $columnName = "m$i" + "_face_xy_width"
        $value = if ($row.$columnName) { $row.$columnName } else { "" }
        $pattern += $value
    }
    
    # 패턴을 | 구분자로 결합 (빈 값도 포함)
    return ($pattern -join "|")
}

# 각 행에 대해 main character face 패턴 생성
Write-Host "`n=== Main Character Face 패턴 분석 ===`n" -ForegroundColor Yellow

$templateData = @{}
$processedCount = 0

foreach ($row in $csvData) {
    $uuid = $row.FileNameWithoutExtension
    
    # archive나 빈 UUID는 건너뛰기
    if (-not $uuid -or $uuid -eq "archive") {
        continue
    }
    
    # Main character face 패턴 생성
    $pattern = Get-MainCharacterFacePattern -row $row
    
    # 패턴이 완전히 비어있으면 건너뛰기 (모든 main character face가 없는 경우)
    if ($pattern -eq "||||||||") {
        Write-Host "Face 정보 없음: $uuid" -ForegroundColor Gray
        continue
    }
    
    # 패턴별로 그룹화
    if (-not $templateData.ContainsKey($pattern)) {
        $templateData[$pattern] = @{
            Count = 0
            Examples = @()
        }
    }
    
    $templateData[$pattern].Count++
    
    # 예시로 처음 3개까지만 저장
    if ($templateData[$pattern].Examples.Count -lt 3) {
        $templateData[$pattern].Examples += $uuid
    }
    
    $processedCount++
    
    if ($processedCount % 50 -eq 0) {
        Write-Host "처리 진행률: $processedCount/$($csvData.Count)" -ForegroundColor Gray
    }
}

Write-Host "`n처리 완료: $processedCount개 레코드 분석됨`n" -ForegroundColor Green

# 결과 분석
$uniqueTemplates = $templateData.Keys.Count
$totalFiles = ($templateData.Values | Measure-Object -Property Count -Sum).Sum

Write-Host "=== 템플릿 분석 결과 ===" -ForegroundColor Magenta
Write-Host "고유한 템플릿 종류: $uniqueTemplates개" -ForegroundColor Green
Write-Host "분석된 총 파일 수: $totalFiles개" -ForegroundColor Green
Write-Host ""

# 사용 빈도별로 정렬
$sortedTemplates = $templateData.GetEnumerator() | Sort-Object -Property {$_.Value.Count} -Descending

Write-Host "=== 템플릿별 사용 빈도 ===" -ForegroundColor Yellow
Write-Host "순위  사용횟수  비율      템플릿 패턴" -ForegroundColor White
Write-Host "-" * 80 -ForegroundColor Gray

$rank = 1
foreach ($template in $sortedTemplates) {
    $pattern = $template.Key
    $count = $template.Value.Count
    $percentage = [Math]::Round(($count / $totalFiles) * 100, 1)
    
    # 패턴을 읽기 쉽게 표시 (너무 길면 줄임)
    $displayPattern = if ($pattern.Length -gt 50) { 
        $pattern.Substring(0, 47) + "..." 
    } else { 
        $pattern 
    }
    
    Write-Host ("{0,3}   {1,7}   {2,5}%    {3}" -f $rank, $count, $percentage, $displayPattern) -ForegroundColor White
    $rank++
}

Write-Host ""
Write-Host "=== 상위 10개 템플릿 상세 정보 ===" -ForegroundColor Yellow

$top10Templates = $sortedTemplates | Select-Object -First 10
$templateIndex = 1

foreach ($template in $top10Templates) {
    $pattern = $template.Key
    $count = $template.Value.Count
    $examples = $template.Value.Examples
    $percentage = [Math]::Round(($count / $totalFiles) * 100, 1)
    
    Write-Host ""
    Write-Host "[$templateIndex] 템플릿 (사용횟수: $count, 비율: $percentage%)" -ForegroundColor Cyan
    
    # 패턴 분석
    $facePositions = $pattern -split "\|"
    for ($i = 0; $i -lt $facePositions.Length; $i++) {
        $faceNum = $i + 1
        $position = $facePositions[$i]
        if ($position -and $position -ne "") {
            Write-Host "  m$faceNum face: $position" -ForegroundColor Blue
        } else {
            Write-Host "  m$faceNum face: (없음)" -ForegroundColor Gray
        }
    }
    
    Write-Host "  예시 파일: $($examples -join ', ')" -ForegroundColor Green
    $templateIndex++
}

# 통계 요약
Write-Host ""
Write-Host "=== 통계 요약 ===" -ForegroundColor Magenta

# 템플릿 사용 분포 분석
$usageGroups = @{
    "1회 사용" = 0
    "2-5회 사용" = 0
    "6-10회 사용" = 0
    "11-20회 사용" = 0
    "21회 이상 사용" = 0
}

foreach ($template in $templateData.Values) {
    $count = $template.Count
    if ($count -eq 1) {
        $usageGroups["1회 사용"]++
    } elseif ($count -le 5) {
        $usageGroups["2-5회 사용"]++
    } elseif ($count -le 10) {
        $usageGroups["6-10회 사용"]++
    } elseif ($count -le 20) {
        $usageGroups["11-20회 사용"]++
    } else {
        $usageGroups["21회 이상 사용"]++
    }
}

Write-Host "사용 빈도 분포:" -ForegroundColor White
foreach ($group in $usageGroups.GetEnumerator()) {
    $percentage = [Math]::Round(($group.Value / $uniqueTemplates) * 100, 1)
    Write-Host "  $($group.Key): $($group.Value)개 템플릿 ($percentage%)" -ForegroundColor Gray
}

# 가장 많이 사용된 템플릿
$mostUsedTemplate = $sortedTemplates | Select-Object -First 1
$mostUsedCount = $mostUsedTemplate.Value.Count
$mostUsedPercentage = [Math]::Round(($mostUsedCount / $totalFiles) * 100, 1)

Write-Host ""
Write-Host "가장 많이 사용된 템플릿: $mostUsedCount회 사용 ($mostUsedPercentage%)" -ForegroundColor Green
Write-Host "템플릿 다양성 지수: $([Math]::Round($uniqueTemplates / $totalFiles, 3))" -ForegroundColor Green

Write-Host ""
Write-Host "=== 분석 완료 ===" -ForegroundColor Green
Write-Host "- 총 $uniqueTemplates종류의 고유한 템플릿 발견" -ForegroundColor White
Write-Host "- $totalFiles개 파일 분석 완료" -ForegroundColor White
Write-Host "- Main character face 위치 패턴 기준 분석" -ForegroundColor White

Write-Host ""
Write-Host "=== 사용법 안내 ===" -ForegroundColor Yellow
Write-Host "패턴 형식: 'm1_face|m2_face|m3_face|m4_face|m5_face|m6_face'" -ForegroundColor White
Write-Host "각 face 위치는 'x, y, width' 형태이며, 빈 값은 해당 character가 없음을 의미합니다." -ForegroundColor White
Write-Host "동일한 패턴을 가진 PSD들은 같은 템플릿으로 분류됩니다." -ForegroundColor White
