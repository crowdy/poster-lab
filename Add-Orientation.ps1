# add-orientation.ps1
# CSV 파일에 JSON 파일의 orientation 정보를 추가하는 스크립트

param(
    [string]$CsvPath = "d:\poster-json-machine-analysis.csv",
    [string]$JsonDir = "d:\poster-json\",
    [string]$OutputPath = "d:\poster-json-machine-analysis-updated.csv"
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

# 각 행에 대해 orientation 정보 추가
$updatedData = foreach ($row in $csvData) {
    $fileName = $row.FileName
    $jsonFilePath = Join-Path $JsonDir $fileName
    
    # JSON 파일 존재 확인 및 orientation 값 추출
    $orientation = "unknown"
    
    if (Test-Path $jsonFilePath) {
        try {
            $jsonContent = Get-Content -Path $jsonFilePath -Raw -Encoding UTF8 | ConvertFrom-Json
            if ($jsonContent.orientation) {
                $orientation = $jsonContent.orientation
                Write-Host "처리됨: $fileName -> $orientation"
            }
            else {
                Write-Host "orientation 필드 없음: $fileName -> unknown"
            }
        }
        catch {
            Write-Warning "JSON 파일 파싱 오류 ($fileName): $_"
        }
    }
    else {
        Write-Host "파일 없음: $fileName -> unknown"
    }
    
    # 새로운 객체 생성 (기존 속성 + Orientation)
    [PSCustomObject]@{
        FileName = $row.FileName
        MachineCount = $row.MachineCount
        FileNameWithoutExtension = $row.FileNameWithoutExtension
        Orientation = $orientation
    }
}

Write-Host "결과를 저장하는 중: $OutputPath"

# 업데이트된 데이터를 새 CSV 파일로 저장
try {
    $updatedData | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "성공적으로 완료되었습니다!"
    Write-Host "출력 파일: $OutputPath"
    
    # 통계 정보 출력
    $orientationStats = $updatedData | Group-Object Orientation | Sort-Object Name
    Write-Host "`n=== Orientation 통계 ==="
    foreach ($stat in $orientationStats) {
        Write-Host "$($stat.Name): $($stat.Count)개"
    }
}
catch {
    Write-Error "파일 저장 중 오류가 발생했습니다: $_"
    exit 1
}