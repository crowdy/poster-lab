param(
    [switch]$WhatIf,              # 시뮬레이션 모드 (실제 파일 생성 안함)
    [switch]$Verbose,             # 상세 진행 상황 출력
    [switch]$Force,               # 기존 파일 덮어쓰기
    [switch]$Debug,               # 극도로 상세한 디버깅 정보 출력
    [int]$Limit = 0               # 처리할 PSD 파일 개수 제한 (0 = 모든 파일)
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ===== 유틸 함수 =====
function Get-MachineCountFromCSV {
    param([string]$CsvPath, [switch]$DebugMode)
    
    if (-not (Test-Path $CsvPath)) {
        Write-Error "Machine analysis CSV not found: $CsvPath"
        return @{}
    }
    
    $machineData = @{}
    try {
        if ($DebugMode) { Write-Host "DEBUG: Reading CSV from $CsvPath" }
        
        # CSV 파일 첫 몇 줄 미리보기 (디버깅)
        if ($DebugMode) {
            $preview = Get-Content $CsvPath -First 5
            Write-Host "DEBUG: CSV Preview (first 5 lines):"
            $preview | ForEach-Object { Write-Host "  $_" }
        }
        
        $csv = Import-Csv -Path $CsvPath -Encoding UTF8
        
        # CSV 컬럼 확인
        if ($DebugMode -and $csv.Count -gt 0) {
            $columns = $csv[0].PSObject.Properties.Name
            Write-Host "DEBUG: CSV Columns detected: $($columns -join ', ')"
        }
        
        foreach ($row in $csv) {
            # FileName에서 UUID 추출 (.json 확장자 제거)
            $uuid = ""
            if ($row.FileName) {
                $uuid = [System.IO.Path]::GetFileNameWithoutExtension($row.FileName)
            }
            
            if ($DebugMode) { 
                Write-Host "DEBUG: Processing row - UUID: '$uuid', MachineCount: '$($row.MachineCount)', Orientation: '$($row.Orientation)', LogoType: '$($row.logo_type)', MainChara: '$($row.main_character_count)', SubChara: '$($row.sub_character_count)'"
            }
            
            if ($uuid -and $row.MachineCount) {
                # 명시적으로 필드 값 확인 및 변환
                $mainCharaValue = 0
                $subCharaValue = 0
                
                if ($row.PSObject.Properties['main_character_count'] -and $row.main_character_count -ne $null -and $row.main_character_count -ne '') {
                    try {
                        $mainCharaValue = [int]$row.main_character_count
                    } catch {
                        Write-Warning "Invalid main_character_count value for $uuid`: '$($row.main_character_count)'"
                        $mainCharaValue = 0
                    }
                }
                
                if ($row.PSObject.Properties['sub_character_count'] -and $row.sub_character_count -ne $null -and $row.sub_character_count -ne '') {
                    try {
                        $subCharaValue = [int]$row.sub_character_count
                    } catch {
                        Write-Warning "Invalid sub_character_count value for $uuid`: '$($row.sub_character_count)'"
                        $subCharaValue = 0
                    }
                }
                
                $machineData[$uuid] = @{
                    MachineCount = [int]$row.MachineCount
                    Orientation = if ($row.Orientation) { $row.Orientation } else { "unknown" }
                    LogoType = if ($row.logo_type) { $row.logo_type } else { "unknown" }
                    MainCharaCount = $mainCharaValue
                    SubCharaCount = $subCharaValue
                }
                if ($DebugMode) { 
                    Write-Host "DEBUG: Added $uuid -> $($row.MachineCount) machines, orientation: $($machineData[$uuid].Orientation), logo_type: $($machineData[$uuid].LogoType), main_chara: $($machineData[$uuid].MainCharaCount), sub_chara: $($machineData[$uuid].SubCharaCount)"
                }
            }
        }
        
        Write-Host "Loaded machine data for $($machineData.Count) UUIDs"
        
        if ($DebugMode) {
            Write-Host "DEBUG: Machine data summary:"
            $machineData.GetEnumerator() | Sort-Object Key | ForEach-Object {
                Write-Host "  $($_.Key) = $($_.Value.MachineCount) machines, orientation: $($_.Value.Orientation), logo_type: $($_.Value.LogoType), main_chara: $($_.Value.MainCharaCount), sub_chara: $($_.Value.SubCharaCount)"
            }
        }
        
        return $machineData
    } catch {
        Write-Error "Failed to parse machine CSV: $_"
        if ($DebugMode) { 
            Write-Host "DEBUG: Exception details: $($_.Exception.GetType().Name) - $($_.Exception.Message)"
        }
        return @{}
    }
}


function Process-PsdForMachines {
    param(
        [string]$SourcePsdPath,
        [string]$UUID,
        [int]$MachineCount,
        [string]$Orientation,
        [string]$LogoType,
        [int]$MainCharaCount,
        [int]$SubCharaCount,
        [string]$TemplateRoot,
        [switch]$WhatIfMode,
        [switch]$DebugMode
    )
    
    if ($DebugMode) { 
        Write-Host "Processing UUID: $UUID with $MachineCount machines (orientation: $Orientation, logo_type: $LogoType, main_chara: m$MainCharaCount, sub_chara: s$SubCharaCount)"
        Write-Host "Source PSD: $SourcePsdPath"
        $sourceFileSize = (Get-Item $SourcePsdPath).Length
        Write-Host "DEBUG: Source PSD size: $([math]::Round($sourceFileSize/1MB, 2)) MB"
    }
    
    # MachineCount에 따라 해당 machine 폴더 하나만 생성
    $orientationDir = Join-Path $TemplateRoot $Orientation
    $logoTypeDir = Join-Path $orientationDir $LogoType
    $machineDir = Join-Path $logoTypeDir "machine_$MachineCount"
    $mainCharaDir = Join-Path $machineDir "m$MainCharaCount"
    $subCharaDir = Join-Path $mainCharaDir "s$SubCharaCount"
    $uuidDir = Join-Path $subCharaDir $UUID
    $outputPsdPath = Join-Path $uuidDir "$UUID.psd"
    
    if ($DebugMode) {
        Write-Host "  Processing machine_$MachineCount"
        Write-Host "    Output: $outputPsdPath"
    }
    
    try {
        if (-not $WhatIfMode) {
            # 디렉토리 생성
            if (-not (Test-Path $uuidDir)) {
                New-Item -ItemType Directory -Path $uuidDir -Force | Out-Null
                if ($DebugMode) { Write-Host "    DEBUG: Created directory: $uuidDir" }
            }
            
            # PSD 파일 복사
            Copy-Item -Path $SourcePsdPath -Destination $outputPsdPath -Force
            
            if (Test-Path $outputPsdPath) {
                $fileSize = (Get-Item $outputPsdPath).Length
                if ($DebugMode) {
                    Write-Host "    ✓ Copied PSD ($([math]::Round($fileSize/1MB, 2)) MB) to machine_$MachineCount"
                } else {
                    Write-Host "    ✓ Copied PSD for machine_$MachineCount"
                }
                return $true
            } else {
                Write-Warning "    PSD file was not copied: $outputPsdPath"
                return $false
            }
        } else {
            # WhatIf 모드
            Write-Host "    [SIMULATION] Would create: $outputPsdPath"
            Write-Host "    [SIMULATION] Would copy PSD file from: $SourcePsdPath"
            return $true
        }
        
    } catch {
        Write-Error "Failed to process PSD $UUID`: $($_.Exception.Message)"
        if ($DebugMode) {
            Write-Host "DEBUG: Exception details: $($_.Exception.GetType().Name)"
            Write-Host "DEBUG: Stack trace: $($_.ScriptStackTrace)"
        }
        return $false
    }
}

# ===== 메인 실행 =====
$startTime = Get-Date
Write-Host "=== PSD Templatization Started at $($startTime.ToString('yyyy-MM-dd HH:mm:ss')) ==="

# 경로 설정
$posterDir = "d:\poster"
$csvPath = "d:\poster.csv"
$templateRoot = "e:\psd_template"

# 파일 시스템 확인
if ($Debug) {
    Write-Host "DEBUG: File system check:"
    Write-Host "  Poster directory exists: $(Test-Path $posterDir)"
    Write-Host "  CSV file exists: $(Test-Path $csvPath)"
    Write-Host "  Template root will be: $templateRoot"
}

# 머신 데이터 정보 로드 (MachineCount + Orientation)
$machineData = Get-MachineCountFromCSV -CsvPath $csvPath -DebugMode:$Debug
if ($machineData.Count -eq 0) {
    Write-Error "No machine data loaded"
    exit 1
}

# 템플릿 루트 디렉토리 생성
if (-not $WhatIf -and -not (Test-Path $templateRoot)) {
    Write-Host "Creating template root directory: $templateRoot"
    New-Item -ItemType Directory -Path $templateRoot -Force | Out-Null
}

# PSD 파일 처리
$psdFiles = Get-ChildItem -Path $posterDir -Filter "*.psd" | Where-Object { $_.BaseName -match '^[0-9a-fA-F\-]{36}$' }
Write-Host "Found $($psdFiles.Count) UUID-named PSD files"

# Limit 옵션 적용
if ($Limit -gt 0 -and $psdFiles.Count -gt $Limit) {
    $psdFiles = $psdFiles | Select-Object -First $Limit
    Write-Host "Limited to first $Limit files for testing" -ForegroundColor Yellow
}

$processedCount = 0
$successCount = 0
$errorCount = 0

foreach ($psdFile in $psdFiles) {
    $uuid = $psdFile.BaseName
    $processedCount++
    
    if (-not $machineData.ContainsKey($uuid)) {
        Write-Warning "No machine data for UUID: $uuid (skipping)"
        $errorCount++
        continue
    }
    
    $machines = $machineData[$uuid].MachineCount
    $orientation = $machineData[$uuid].Orientation
    $logoType = $machineData[$uuid].LogoType
    $mainCharaCount = $machineData[$uuid].MainCharaCount
    $subCharaCount = $machineData[$uuid].SubCharaCount
    Write-Host "[$processedCount/$($psdFiles.Count)] Processing $uuid ($machines machines, $orientation orientation, $logoType logo_type, m$mainCharaCount, s$subCharaCount)..."
    
    try {
        if (Process-PsdForMachines -SourcePsdPath $psdFile.FullName -UUID $uuid -MachineCount $machines -Orientation $orientation -LogoType $logoType -MainCharaCount $mainCharaCount -SubCharaCount $subCharaCount -TemplateRoot $templateRoot -WhatIfMode:$WhatIf -DebugMode:($Verbose -or $Debug)) {
            $successCount++
            Write-Host "  ✓ Successfully processed $uuid"
        } else {
            $errorCount++
            Write-Warning "  ✗ Failed to process $uuid"
        }
    } catch {
        $errorCount++
        Write-Error "  ✗ Exception processing $uuid`: $($_.Exception.Message)"
        if ($Debug) {
            Write-Host "DEBUG: Full exception details:"
            Write-Host "  Type: $($_.Exception.GetType().Name)"
            Write-Host "  Message: $($_.Exception.Message)"
            Write-Host "  Stack: $($_.ScriptStackTrace)"
        }
    }
    
}

# 결과 요약
$endTime = Get-Date
$duration = $endTime - $startTime
Write-Host ""
Write-Host "=== PSD Templatization Completed ==="
Write-Host "Duration: $($duration.ToString('hh\:mm\:ss'))"
Write-Host "Total PSD files: $($psdFiles.Count)"
Write-Host "Processed: $processedCount"
Write-Host "Successful: $successCount"
Write-Host "Errors: $errorCount"

if ($WhatIf) {
    Write-Host ""
    Write-Host "*** SIMULATION MODE - No files were actually created ***"
    Write-Host "Run without -WhatIf to perform actual processing"
}

if ($Limit -gt 0) {
    Write-Host ""
    Write-Host "*** LIMITED MODE - Only processed first $Limit PSD files ***" -ForegroundColor Yellow
    Write-Host "Remove -Limit parameter to process all files"
}

if ($errorCount -gt 0) {
    Write-Warning "Some PSDs failed to process. Check the output above for details."
    exit 1
} else {
    Write-Host "All PSDs processed successfully!" -ForegroundColor Green
    exit 0
}
