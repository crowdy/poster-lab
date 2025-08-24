# create-psd.ps1
# Main orchestrator script for PSD creation

<#
.SYNOPSIS
    PSD 포스터 생성 메인 스크립트

.DESCRIPTION
    템플릿과 머신 데이터를 조합하여 PSD 파일을 생성합니다.
    Aspose.PSD for .NET을 사용하여 linked smart objects를 embedded로 변환합니다.

.PARAMETER orientation
    포스터 방향 - "horizontal" 또는 "vertical"

.PARAMETER logotype  
    로고 타입 - "grandOpen", "newMachineReplacement", "newOpen", "refreshOpen", "renewalOpen"

.PARAMETER machineIds
    머신 ID 목록 (컴마 구분) - 예: "1,2,3,4"

.PARAMETER datetime
    날짜/시간 설정 - "random" (향후 구현 예정)

.PARAMETER userphrase
    사용자 문구 - "random" (향후 구현 예정)

.EXAMPLE
    .\create-psd.ps1 -orientation horizontal -logotype grandOpen -machineIds "1,2,3"

.NOTES
    Author: PSD Script Team
    Version: 1.0
    Dependencies: create-psd-config.ps1, Load-AsposePSD.ps1, PSD-Functions.ps1, PSD-Utilities.ps1
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$orientation = "vertical",
    
    [Parameter(Mandatory=$false)]
    [string]$logotype = "renewalOpen",
    
    [Parameter(Mandatory=$false)]
    [string]$machineIds = "1",
    
    [Parameter(Mandatory=$false)]
    [string]$datetime = "random",
    
    [Parameter(Mandatory=$false)]
    [string]$userphrase = "random"
)

# ================================================================================
# 스크립트 초기화
# ================================================================================

# 스크립트 시작 시간 기록
$script:StartTime = Get-Date
$script:WorkingPath = $null

# 필수 파일들 로드
try {
    Write-Host "Loading configuration and modules..." -ForegroundColor Cyan
    
    # 설정 파일 로드
    . "$PSScriptRoot\create-psd-config.ps1"
    
    # Aspose.PSD 라이브러리 로드
    # . ".\Load-AsposePSD.ps1"
    # if (-not (Load-AsposePSD)) {
    #     throw "Failed to load Aspose.PSD library"
    # }
    
    # 핵심 함수들 로드
    . "$PSScriptRoot\PSD-Functions.ps1"
    
    # 유틸리티 함수들 로드
    . "$PSScriptRoot\PSD-Utilities.ps1"
    
    Write-Host "All modules loaded successfully" -ForegroundColor Green
    
} catch {
    Write-Error "Failed to load required modules: $($_.Exception.Message)"
    exit 1
}

# ================================================================================
# 메인 실행 로직
# ================================================================================

try {
    # 시작 메시지 출력
    Write-PSDLog "INFO" "========================================"
    Write-PSDLog "INFO" "create-psd.ps1 execution started"
    Write-PSDLog "INFO" "Start Time: $($script:StartTime.ToString($Config_LogDateFormat))"
    Write-PSDLog "INFO" "Parameters:"
    Write-PSDLog "INFO" "  - Orientation: $orientation"
    Write-PSDLog "INFO" "  - Logotype: $logotype"  
    Write-PSDLog "INFO" "  - Machine IDs: $machineIds"
    Write-PSDLog "INFO" "  - DateTime: $datetime"
    Write-PSDLog "INFO" "  - User Phrase: $userphrase"
    Write-PSDLog "INFO" "========================================"
    
    # 설정 표시 (디버그 모드일 때)
    if ($Config_DebugMode) {
        Show-Configuration
    }
    
    # ============================================================================
    # [1/5] Parameter 검증
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Validating parameters..." -PercentComplete 10
    Write-Host ""
    Write-Host "[$($Config_StepDescriptions[1])] Starting..." -ForegroundColor Yellow
    Write-PSDLog "INFO" "[1/$($Config_TotalSteps)] $($Config_StepDescriptions[1]) started"
    
    $validatedMachineIds = Validate-Parameters -orientation $orientation -logotype $logotype -machineIds $machineIds -datetime $datetime -userphrase $userphrase
    
    Write-Host "[$($Config_StepDescriptions[1])] Completed ✓" -ForegroundColor Green
    Write-PSDLog "INFO" "[1/$($Config_TotalSteps)] $($Config_StepDescriptions[1]) completed successfully"
    Write-PSDLog "INFO" "Validated machine IDs: $($validatedMachineIds -join ', ')"
    
    # ============================================================================
    # [2/5] Template 획득
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Finding template..." -PercentComplete 30
    Write-Host ""
    Write-Host "[$($Config_StepDescriptions[2])] Starting..." -ForegroundColor Yellow
    Write-PSDLog "INFO" "[2/$($Config_TotalSteps)] $($Config_StepDescriptions[2]) started"
    
    $templateResult = Get-Template-Path -orientation $orientation -logotype $logotype -machineIds $machineIds
    if (-not $templateResult -or -not $templateResult.Path) {
        throw "No suitable template found for the given parameters"
    }
    
    $templatePath = $templateResult.Path
    $templateUuid = $templateResult.UUID
    
    Write-Host "[$($Config_StepDescriptions[2])] Completed ✓" -ForegroundColor Green
    Write-Host "Selected template: $templatePath" -ForegroundColor Cyan
    Write-Host "Template UUID: $templateUuid" -ForegroundColor Cyan
    Write-PSDLog "INFO" "[2/$($Config_TotalSteps)] $($Config_StepDescriptions[2]) completed successfully"
    Write-PSDLog "INFO" "Selected template path: $templatePath"
    Write-PSDLog "INFO" "Template UUID: $templateUuid"
    
    # ============================================================================
    # [3/5] 작업디렉토리 준비
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Preparing working directory..." -PercentComplete 50
    Write-Host ""
    Write-Host "[$($Config_StepDescriptions[3])] Starting..." -ForegroundColor Yellow
    Write-PSDLog "INFO" "[3/$($Config_TotalSteps)] $($Config_StepDescriptions[3]) started"
    
    $script:WorkingPath = Prepare-Working-Path -TemplatePath $templatePath -TemplateUuid $templateUuid
    
    Write-Host "[$($Config_StepDescriptions[3])] Completed ✓" -ForegroundColor Green
    Write-Host "Working directory: $script:WorkingPath" -ForegroundColor Cyan
    Write-PSDLog "INFO" "[3/$($Config_TotalSteps)] $($Config_StepDescriptions[3]) completed successfully"
    Write-PSDLog "INFO" "Working directory created: $script:WorkingPath"
    
    # 로그 파일 설정 (이제 working directory가 생성되었으므로)
    Initialize-LogFile -workingPath $script:WorkingPath
    
    # ============================================================================
    # [3.5] CSV 데이터 로드 (머신 데이터 복사 전 준비)
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Loading poster CSV data..." -PercentComplete 60
    Write-Host ""
    Write-Host "[CSV 데이터 로드] Starting..." -ForegroundColor Yellow
    Write-PSDLog "INFO" "Loading poster CSV data for machine data copying"
    
    # poster.csv 데이터 로드
    $posterData = Load-PosterCSVData -csvPath "d:\poster.csv"
    if (-not $posterData -or $posterData.Count -eq 0) {
        Write-PSDLog "WARN" "No poster CSV data loaded, proceeding without CSV-based positioning"
    } else {
        Write-PSDLog "INFO" "Loaded poster CSV data for $($posterData.Count) records"
    }
    
    # 작업 디렉토리에서 PSD 파일 UUID 추출
    $psdFiles = Get-ChildItem $script:WorkingPath -Filter "*.psd" -File
    $psdUuid = $null
    $posterRecord = $null
    
    if ($psdFiles.Count -gt 0) {
        $psdFileName = $psdFiles[0].BaseName
        if ($psdFileName -match '^[0-9a-fA-F\-]{36}$') {
            $psdUuid = $psdFileName
            Write-PSDLog "DEBUG" "Extracted PSD UUID: $psdUuid"
            
            # CSV 데이터에서 해당 UUID의 레코드 찾기
            if ($posterData.ContainsKey($psdUuid)) {
                $posterRecord = $posterData[$psdUuid]
                Write-PSDLog "INFO" "Found poster record for UUID: $psdUuid"
                # write all poster record (handle both hashtable and PSCustomObject)
                if ($posterRecord) {
                    if ($posterRecord -is [hashtable]) {
                        foreach ($key in $posterRecord.Keys) {
                            Write-PSDLog "DEBUG" "Poster record [$key]: $($posterRecord[$key])"
                        }
                    } else {
                        # PSCustomObject case (from Import-Csv)
                        foreach ($property in $posterRecord.PSObject.Properties) {
                            Write-PSDLog "DEBUG" "Poster record [$($property.Name)]: $($property.Value)"
                        }
                    }
                }
            } else {
                Write-PSDLog "WARN" "No poster record found for UUID: $psdUuid"
            }
        } else {
            Write-PSDLog "WARN" "PSD filename does not match UUID pattern: $psdFileName"
        }
    } else {
        Write-PSDLog "ERROR" "No PSD file found in working directory"
    }
    
    Write-Host "[CSV 데이터 로드] Completed ✓" -ForegroundColor Green
    
    # ============================================================================
    # [4/5] 머신데이터 복사
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Copying machine data..." -PercentComplete 70
    Write-Host ""
    Write-Host "[$($Config_StepDescriptions[4])] Starting..." -ForegroundColor Yellow
    Write-PSDLog "INFO" "[4/$($Config_TotalSteps)] $($Config_StepDescriptions[4]) started"
    
    Copy-Machine-Data -workingPath $script:WorkingPath -machineIds $machineIds -posterRecord $posterRecord
    
    Write-Host "[$($Config_StepDescriptions[4])] Completed ✓" -ForegroundColor Green
    Write-PSDLog "INFO" "[4/$($Config_TotalSteps)] $($Config_StepDescriptions[4]) completed successfully"
    
    # ============================================================================
    # [5/5] PSD 처리
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Processing PSD..." -PercentComplete 85
    Write-Host ""
    Write-Host "[$($Config_StepDescriptions[5])] Starting..." -ForegroundColor Yellow
    Write-PSDLog "INFO" "[5/$($Config_TotalSteps)] $($Config_StepDescriptions[5]) started"
    
    # Bake-PSD 함수 호출 (새로운 파라미터들과 함께)
    $psdFullPath = Bake-PSD -workingPath $script:WorkingPath -posterRecord $posterRecord -psdUuid $psdUuid -machineIds $validatedMachineIds
    
    Write-Host "[$($Config_StepDescriptions[5])] Completed ✓" -ForegroundColor Green
    Write-PSDLog "INFO" "[5/$($Config_TotalSteps)] $($Config_StepDescriptions[5]) completed successfully"
    Write-PSDLog "INFO" "Final PSD file: $psdFullPath"
    
    # ============================================================================
    # 완료 처리
    # ============================================================================
    Write-Progress -Activity "Creating PSD" -Status "Completed" -PercentComplete 100
    
    $endTime = Get-Date
    $duration = $endTime - $script:StartTime
    
    Write-Host ""
    Write-Host "======================================" -ForegroundColor Green
    Write-Host "✅ SCRIPT COMPLETED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "======================================" -ForegroundColor Green
    Write-Host "Start Time: $($script:StartTime.ToString($Config_LogDateFormat))" -ForegroundColor White
    Write-Host "End Time: $($endTime.ToString($Config_LogDateFormat))" -ForegroundColor White
    Write-Host "Duration: $([math]::Round($duration.TotalSeconds, 2)) seconds" -ForegroundColor White
    Write-Host "Final PSD: $psdFullPath" -ForegroundColor Cyan
    Write-Host "Working Directory: $script:WorkingPath" -ForegroundColor Cyan
    Write-Host "======================================" -ForegroundColor Green
    
    Write-PSDLog "INFO" "========================================"
    Write-PSDLog "INFO" "Script execution completed successfully"
    Write-PSDLog "INFO" "End Time: $($endTime.ToString($Config_LogDateFormat))"
    Write-PSDLog "INFO" "Total Duration: $([math]::Round($duration.TotalSeconds, 2)) seconds"
    Write-PSDLog "INFO" "Final PSD file: $psdFullPath"
    Write-PSDLog "INFO" "========================================"
    
   
    # 진행상황 표시 완료
    Write-Progress -Activity "Creating PSD" -Completed
    
} catch {
    # ============================================================================
    # 에러 처리
    # ============================================================================
    $endTime = Get-Date
    $duration = $endTime - $script:StartTime
    
    Write-Host ""
    Write-Host "======================================" -ForegroundColor Red
    Write-Host "❌ SCRIPT EXECUTION FAILED!" -ForegroundColor Red
    Write-Host "======================================" -ForegroundColor Red
    Write-Host "Start Time: $($script:StartTime.ToString($Config_LogDateFormat))" -ForegroundColor White
    Write-Host "Failure Time: $($endTime.ToString($Config_LogDateFormat))" -ForegroundColor White
    Write-Host "Duration: $([math]::Round($duration.TotalSeconds, 2)) seconds" -ForegroundColor White
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($script:WorkingPath) {
        Write-Host "Working Directory: $script:WorkingPath" -ForegroundColor Yellow
        if ($Config_PreserveWorkingDirOnFailure) {
            Write-Host "(Working directory preserved for debugging)" -ForegroundColor Yellow
        }
    }
    Write-Host "======================================" -ForegroundColor Red
    
    Write-PSDLog "ERROR" "========================================"
    Write-PSDLog "ERROR" "Script execution failed"
    Write-PSDLog "ERROR" "Failure Time: $($endTime.ToString($Config_LogDateFormat))"
    Write-PSDLog "ERROR" "Total Duration: $([math]::Round($duration.TotalSeconds, 2)) seconds"
    Write-PSDLog "ERROR" "Error Message: $($_.Exception.Message)"
    Write-PSDLog "ERROR" "Stack Trace: $($_.ScriptStackTrace)"
    Write-PSDLog "ERROR" "========================================"
    
       
    # 진행상황 표시 완료
    Write-Progress -Activity "Creating PSD" -Completed
    
    # 에러 re-throw
    throw
}
