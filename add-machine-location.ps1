# add-machine-location.ps1
# CSV 파일에 machine 위치 정보를 추가하는 스크립트

param(
    [string]$CsvPath = "d:\poster-json-machine-analysis.csv",
    [string]$PsdDir = "d:\poster\",
    [string]$OutputPath = "d:\poster-json-machine-analysis_updated.csv"
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

# PSD 파일에서 machine 위치 정보를 가져오는 함수
function Get-MachineLocations {
    param([string]$UUID, [int]$MachineCount)
    
    $psdPath = Join-Path $PsdDir "$UUID.psd"
    
    # 기본 반환값 (모든 machine 위치를 빈 문자열로 초기화)
    $result = @{}
    for ($i = 1; $i -le 6; $i++) {
        $result["machine_$i" + "_main_location_pos"] = ""
        $result["machine_$i" + "_icon_1_pos"] = ""
        $result["machine_$i" + "_icon_2_pos"] = ""
        $result["machine_$i" + "_smart_icon_pos"] = ""
        $result["machine_$i" + "_frame_pos"] = ""
    }
    
    if (-not (Test-Path $psdPath)) {
        Write-Host "PSD 파일 없음: $UUID" -ForegroundColor Yellow
        return $result
    }
    
    try {
        Write-Host "PSD 분석 중: $UUID (Machine Count: $MachineCount)" -ForegroundColor Gray
        
        # PSD 로드 옵션 설정
        $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
        $loadOptions.LoadEffectsResource = $true
        $loadOptions.UseDiskForLoadEffectsResource = $true
        
        # PSD 파일 로드
        $psd = [Aspose.PSD.Image]::Load($psdPath, $loadOptions)
        
        # 각 레이어를 순회하면서 machine 레이어 찾기
        for ($i = 0; $i -lt $psd.Layers.Count; $i++) {
            $layer = $psd.Layers[$i]
            $layerName = if ($layer.Name) { $layer.Name } else { $layer.DisplayName }
            if (-not $layerName) { continue }
            
            # machine 번호 추출 (g01, g02, g03, g04, g05, g06)
            for ($machineNum = 1; $machineNum -le $MachineCount -and $machineNum -le 6; $machineNum++) {
                $groupNumber = "{0:D2}" -f $machineNum  # 01, 02, 03, 04, 05, 06
                
                # Main location
                if ($layerName -eq "machine_main_g$groupNumber #1") {
                    $columnName = "machine_$machineNum" + "_main_location_pos"
                    $result[$columnName] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)"
                    Write-Host "  Machine $machineNum main: ($($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height))" -ForegroundColor Blue
                }
                
                # Smart icon
                if ($layerName -eq "smart-icon_g$groupNumber #1") {
                    $columnName = "machine_$machineNum" + "_smart_icon_pos"
                    $result[$columnName] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)"
                    Write-Host "  Machine $machineNum smart icon: ($($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height))" -ForegroundColor Magenta
                }
                
                # Icon 1
                if ($layerName -eq "machine-icon_g$groupNumber #1") {
                    $columnName = "machine_$machineNum" + "_icon_1_pos"
                    $result[$columnName] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)"
                    Write-Host "  Machine $machineNum icon 1: ($($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height))" -ForegroundColor Green
                }
                
                # Icon 2
                if ($layerName -eq "machine-icon_g$groupNumber #2") {
                    $columnName = "machine_$machineNum" + "_icon_2_pos"
                    $result[$columnName] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)"
                    Write-Host "  Machine $machineNum icon 2: ($($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height))" -ForegroundColor Green
                }
                
                # Frame
                if ($layerName -eq "machine-frame_g$groupNumber #1") {
                    $columnName = "machine_$machineNum" + "_frame_pos"
                    $result[$columnName] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)"
                    Write-Host "  Machine $machineNum frame: ($($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height))" -ForegroundColor Cyan
                }
            }
        }
        
        Write-Host "  처리 완료: $MachineCount개 machine 분석됨" -ForegroundColor Green
        
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

# 각 행에 대해 machine 위치 정보 추가
$currentRecord = 0
$totalRecords = $csvData.Count
$updatedData = foreach ($row in $csvData) {
    $currentRecord++
    $uuid = $row.FileNameWithoutExtension
    $machineCount = if ($row.MachineCount) { [int]$row.MachineCount } else { 0 }
    
    # 진행 상황 출력
    Write-Host "[$currentRecord/$totalRecords] 처리 중: $($row.FileName)" -ForegroundColor White
    
    # Machine 위치 정보 가져오기
    if ($uuid -and $uuid -ne "archive" -and $machineCount -gt 0) {
        $machineLocations = Get-MachineLocations -UUID $uuid -MachineCount $machineCount
    }
    else {
        # archive 파일이나 UUID가 없거나 MachineCount가 0인 경우 모든 machine 위치를 빈 문자열로
        $machineLocations = @{}
        for ($i = 1; $i -le 6; $i++) {
            $machineLocations["machine_$i" + "_main_location_pos"] = ""
            $machineLocations["machine_$i" + "_icon_1_pos"] = ""
            $machineLocations["machine_$i" + "_icon_2_pos"] = ""
            $machineLocations["machine_$i" + "_smart_icon_pos"] = ""
            $machineLocations["machine_$i" + "_frame_pos"] = ""
        }
        Write-Host "  -> UUID 없음, archive, 또는 MachineCount=0: $($row.FileName)" -ForegroundColor Yellow
    }
    
    # 새로운 객체 생성 (기존 속성 + machine 위치 정보)
    $newObject = [PSCustomObject]@{}
    
    # 기존 모든 속성 복사
    $row.PSObject.Properties | ForEach-Object {
        $newObject | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
    }
    
    # Machine 위치 정보 추가
    for ($i = 1; $i -le 6; $i++) {
        $mainLocationColumn = "machine_$i" + "_main_location_pos"
        $icon1Column = "machine_$i" + "_icon_1_pos"
        $icon2Column = "machine_$i" + "_icon_2_pos"
        $smartIconColumn = "machine_$i" + "_smart_icon_pos"
        $frameColumn = "machine_$i" + "_frame_pos"
        
        $newObject | Add-Member -MemberType NoteProperty -Name $mainLocationColumn -Value $machineLocations[$mainLocationColumn]
        $newObject | Add-Member -MemberType NoteProperty -Name $icon1Column -Value $machineLocations[$icon1Column]
        $newObject | Add-Member -MemberType NoteProperty -Name $icon2Column -Value $machineLocations[$icon2Column]
        $newObject | Add-Member -MemberType NoteProperty -Name $smartIconColumn -Value $machineLocations[$smartIconColumn]
        $newObject | Add-Member -MemberType NoteProperty -Name $frameColumn -Value $machineLocations[$frameColumn]
    }
    
    $newObject
}

Write-Host "결과를 저장하는 중: $OutputPath" -ForegroundColor Green

# 업데이트된 데이터를 새 CSV 파일로 저장
try {
    $updatedData | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "성공적으로 완료되었습니다!" -ForegroundColor Green
    Write-Host "출력 파일: $OutputPath" -ForegroundColor Cyan
    
    # 통계 정보 출력
    Write-Host "`n=== Machine 위치 정보 통계 ===" -ForegroundColor Magenta
    
    # Machine 위치 정보 통계
    $machinePositionCounts = @{}
    for ($i = 1; $i -le 6; $i++) {
        $machinePositionCounts["machine_$i"] = @{
            main = 0
            icon_1 = 0
            icon_2 = 0
            smart_icon = 0
            frame = 0
        }
    }
    
    foreach ($row in $updatedData) {
        for ($i = 1; $i -le 6; $i++) {
            $mainColumn = "machine_$i" + "_main_location_pos"
            $icon1Column = "machine_$i" + "_icon_1_pos"
            $icon2Column = "machine_$i" + "_icon_2_pos"
            $smartIconColumn = "machine_$i" + "_smart_icon_pos"
            $frameColumn = "machine_$i" + "_frame_pos"
            
            if ($row.$mainColumn -and $row.$mainColumn -ne "") {
                $machinePositionCounts["machine_$i"].main++
            }
            if ($row.$icon1Column -and $row.$icon1Column -ne "") {
                $machinePositionCounts["machine_$i"].icon_1++
            }
            if ($row.$icon2Column -and $row.$icon2Column -ne "") {
                $machinePositionCounts["machine_$i"].icon_2++
            }
            if ($row.$smartIconColumn -and $row.$smartIconColumn -ne "") {
                $machinePositionCounts["machine_$i"].smart_icon++
            }
            if ($row.$frameColumn -and $row.$frameColumn -ne "") {
                $machinePositionCounts["machine_$i"].frame++
            }
        }
    }
    
    # 통계 출력
    for ($i = 1; $i -le 6; $i++) {
        $counts = $machinePositionCounts["machine_$i"]
        if ($counts.main -gt 0 -or $counts.icon_1 -gt 0 -or $counts.icon_2 -gt 0 -or $counts.smart_icon -gt 0 -or $counts.frame -gt 0) {
            Write-Host "Machine $i 위치 정보:" -ForegroundColor Blue
            Write-Host "  Main: $($counts.main)개" -ForegroundColor Gray
            Write-Host "  Icon 1: $($counts.icon_1)개" -ForegroundColor Gray
            Write-Host "  Icon 2: $($counts.icon_2)개" -ForegroundColor Gray
            Write-Host "  Smart Icon: $($counts.smart_icon)개" -ForegroundColor Gray
            Write-Host "  Frame: $($counts.frame)개" -ForegroundColor Gray
        }
    }
    
    # 샘플 데이터 표시 (처음 3개, machine 위치 정보만)
    Write-Host "`n=== 샘플 Machine 위치 데이터 (처음 3개) ===" -ForegroundColor Magenta
    $sampleData = $updatedData | Select-Object -First 3 | Select-Object FileNameWithoutExtension, machine_1_main_location_pos, machine_1_icon_1_pos, machine_1_smart_icon_pos, machine_1_frame_pos
    $sampleData | Format-Table -AutoSize
    
}
catch {
    Write-Error "파일 저장 중 오류가 발생했습니다: $_"
    exit 1
}

Write-Host "`n=== 사용법 안내 ===" -ForegroundColor Yellow
Write-Host "Machine 위치 형식: 'x, y, width, height'" -ForegroundColor White
Write-Host "  - x, y: 절대적 위치 (캔버스 기준)" -ForegroundColor White
Write-Host "  - width, height: 레이어의 크기" -ForegroundColor White
Write-Host "  - 빈 문자열: 해당 machine 요소가 존재하지 않음" -ForegroundColor White
Write-Host "" -ForegroundColor White
Write-Host "예시: '1234, 567, 300, 200' = 절대 위치 (1234, 567)에 크기 300x200인 요소" -ForegroundColor White
Write-Host "" -ForegroundColor White
Write-Host "Machine 요소들:" -ForegroundColor White
Write-Host "  - main_location: machine_main_g{01..06} #1" -ForegroundColor White
Write-Host "  - icon_1: machine-icon_g{01..06} #1" -ForegroundColor White
Write-Host "  - icon_2: machine-icon_g{01..06} #2" -ForegroundColor White
Write-Host "  - smart_icon: smart-icon_g{01..06} #1" -ForegroundColor White
Write-Host "  - frame: machine-frame_g{01..06} #1" -ForegroundColor White
