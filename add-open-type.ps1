# add-open-type.ps1
# CSV 파일에 JSON 파일의 poster_type 정보를 open_type으로 추가하는 스크립트

param(
    [string]$CsvPath = "d:\poster-json-machine-analysis.csv",
    [string]$JsonDir = "d:\poster-json\",
    [string]$OutputPath = "d:\poster-json-machine-analysis-with-open-type.csv"
)

# 파일 존재 확인
if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV 파일을 찾을 수 없습니다: $CsvPath"
    exit 1
}

if (-not (Test-Path $JsonDir)) {
    Write-Error "JSON 디렉토리를 찾을 수 없습니다: $JsonDir"
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

# 각 행에 대해 open_type 정보 추가
$updatedData = foreach ($row in $csvData) {
    $fileName = $row.FileName
    $jsonFilePath = Join-Path $JsonDir $fileName
    
    # JSON 파일 존재 확인 및 poster_type 값 추출
    $openType = "unknown"
    
    if (Test-Path $jsonFilePath) {
        try {
            $jsonContent = Get-Content -Path $jsonFilePath -Raw -Encoding UTF8 | ConvertFrom-Json
            if ($jsonContent.poster_type) {
                $openType = $jsonContent.poster_type
                Write-Host "처리됨: $fileName -> $openType"
            }
            else {
                Write-Host "poster_type 필드 없음: $fileName -> unknown"
            }
        }
        catch {
            Write-Warning "JSON 파일 파싱 오류 ($fileName): $_"
        }
    }
    else {
        Write-Host "파일 없음: $fileName -> unknown"
    }
    
    # 새로운 객체 생성 (기존 속성 + open_type)
    # CSV의 기존 컬럼 구조에 따라 동적으로 처리
    $newRow = [PSCustomObject]@{}
    
    # 기존 모든 속성 복사
    $row.PSObject.Properties | ForEach-Object {
        $newRow | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
    }
    
    # open_type 속성 추가
    $newRow | Add-Member -MemberType NoteProperty -Name "open_type" -Value $openType
    
    $newRow
}

Write-Host "결과를 저장하는 중: $OutputPath"

# 업데이트된 데이터를 새 CSV 파일로 저장
try {
    $updatedData | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "성공적으로 완료되었습니다!"
    Write-Host "출력 파일: $OutputPath"
    
    # 통계 정보 출력
    $openTypeStats = $updatedData | Group-Object open_type | Sort-Object Name
    Write-Host "`n=== Open Type 통계 ==="
    foreach ($stat in $openTypeStats) {
        Write-Host "$($stat.Name): $($stat.Count)개"
    }
    
    # 샘플 데이터 표시 (처음 5개)
    Write-Host "`n=== 샘플 데이터 (처음 5개) ==="
    $updatedData | Select-Object -First 5 | Format-Table -AutoSize
    
}
catch {
    Write-Error "파일 저장 중 오류가 발생했습니다: $_"
    exit 1
}