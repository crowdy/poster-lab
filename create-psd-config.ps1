# create-psd-config.ps1
# Configuration file for create-psd.ps1 script

<#
.SYNOPSIS
    Configuration settings for PSD creation script

.DESCRIPTION
    This file contains all configurable parameters used by create-psd.ps1
    Modify these values to customize the behavior of the script

.NOTES
    Version: 1.0
    Author: PSD Script Team
    Last Modified: 2025-08-18
#>

# ================================================================================
# 기본 디렉토리 경로 설정
# ================================================================================

# 템플릿 기본 디렉토리
$Config_TemplateBaseDir = "e:\psd_template"

# 머신 데이터 기본 디렉토리  
$Config_MachineDataBaseDir = "d:\poster\machine"

# 작업 디렉토리 기본 경로
$Config_WorkingBaseDir = "e:\poster-ai\working"

# 백업 디렉토리 (향후 사용 예정)
$Config_BackupBaseDir = "e:\poster-ai\backup"

# ================================================================================
# 로깅 설정
# ================================================================================

# 로그 파일명
$Config_LogFileName = "create-psd.log"

# 로그 레벨 (DEBUG, INFO, WARN, ERROR)
$Config_LogLevel = "INFO"
$Config_LogLevel = "DEBUG"

# 로그 날짜 형식
$Config_LogDateFormat = "yyyy-MM-dd HH:mm:ss"

# 콘솔 출력 활성화
$Config_ConsoleLogging = $true

# 파일 로깅 활성화
$Config_FileLogging = $true

# 로그 파일 최대 크기 (MB)
$Config_MaxLogFileSize = 10

# ================================================================================
# 파일 처리 설정
# ================================================================================

# 머신 이미지 크기 임계값 (바이트 단위: 1MB = 1048576)
$Config_MachineSizeThreshold = 1048576

# 지원하는 이미지 확장자
$Config_SupportedImageExtensions = @(".png", ".jpg", ".jpeg")

# PSD 파일 확장자
$Config_PsdExtension = ".psd"

# UUID 정규식 패턴
$Config_UuidPattern = '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'

# ================================================================================
# 머신 데이터 설정
# ================================================================================

# 머신별 필수 하위 디렉토리
$Config_RequiredMachineSubDirs = @("characters", "icon", "machine")

# 머신 이름 파일 우선순위 (PNG 우선, 없으면 TXT)
$Config_MachineNameFiles = @("machine_name.png", "machine_name.txt")

# 아이콘 이미지 개수 (머신당)
$Config_IconImagesPerMachine = 2

# ================================================================================
# 템플릿 검증 설정
# ================================================================================

# 템플릿 디렉토리별 최소 PSD 파일 수
$Config_MinPsdFilesPerTemplate = 1

# 템플릿 디렉토리별 최대 PSD 파일 수
$Config_MaxPsdFilesPerTemplate = 1

# 템플릿 디렉토리별 최소 PNG 파일 수
$Config_MinPngFilesPerTemplate = 1

# ================================================================================
# 유효한 파라미터 값 설정
# ================================================================================

# 유효한 orientation 값
$Config_ValidOrientations = @("horizontal", "vertical")

# 유효한 logotype 값
$Config_ValidLogotypes = @(
    "grandOpen",
    "newMachineReplacement", 
    "newOpen",
    "refreshOpen",
    "renewalOpen"
)

# ================================================================================
# Aspose.PSD 설정
# ================================================================================

# Aspose.PSD 라이브러리 경로
$Config_AsposePsdLibraryPath = "e:\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.dll"

# PSD 처리 시 메모리 제한 (MB)
$Config_PsdMemoryLimit = 512

# Smart Object 처리는 사용하지 않음 (직접 레이어 교체 방식 사용)

# PSD 저장 시 압축 사용
$Config_EnablePsdCompression = $false

# ================================================================================
# 성능 및 타임아웃 설정
# ================================================================================

# 파일 복사 작업 타임아웃 (초)
$Config_FileCopyTimeout = 300

# PSD 처리 작업 타임아웃 (초)
$Config_PsdProcessingTimeout = 600

# 최대 재시도 횟수
$Config_MaxRetryCount = 3

# 재시도 간격 (초)
$Config_RetryIntervalSeconds = 5

# ================================================================================
# 디버깅 및 개발 설정
# ================================================================================

# 디버그 모드 활성화
$Config_DebugMode = $true

# 실패시 작업 디렉토리 보존
$Config_PreserveWorkingDirOnFailure = $true

# 중간 파일 보존 (디버깅용)
$Config_PreserveIntermediateFiles = $false

# ================================================================================
# 향후 기능 설정 (현재 미사용)
# ================================================================================

# 날짜/시간 형식 설정 (datetime 파라미터용)
$Config_DateTimeFormats = @(
    "yyyy-MM-dd",
    "yyyy-MM-dd HH:mm:ss",
    "yyyyMMdd",
    "yyyyMMddHHmmss"
)

# 사용자 문구 기본값 (userphrase 파라미터용)
$Config_DefaultUserPhrases = @(
    "Welcome!",
    "Grand Opening!",
    "New Machine!",
    "Special Event!",
    "Limited Time!"
)

# 텍스트 이미지 생성 설정 (machine_name.txt 처리용)
$Config_TextImageSettings = @{
    FontFamily = "Arial"
    FontSize = 24
    FontColor = "#000000"
    BackgroundColor = "#FFFFFF" 
    ImageWidth = 200
    ImageHeight = 50
    TextAlignment = "Center"
}

# ================================================================================
# 에러 메시지 설정
# ================================================================================

$Config_ErrorMessages = @{
    InvalidOrientation = "Invalid orientation. Must be one of: {0}"
    InvalidLogotype = "Invalid logotype. Must be one of: {0}"
    InvalidMachineIds = "Invalid machineIds format. Must be comma-separated numbers"
    MachineDataNotFound = "Machine data directory not found: {0}"
    TemplateNotFound = "No suitable template found for the given parameters"
    WorkingDirCreationFailed = "Failed to create working directory: {0}"
    FileCopyFailed = "Failed to copy file from {0} to {1}: {2}"
    PsdProcessingFailed = "Failed to process PSD file: {0}"
    AsposePsdLibraryNotFound = "Aspose.PSD library not found at: {0}"
}

# ================================================================================
# 진행상황 표시 설정
# ================================================================================

# 전체 단계 수
$Config_TotalSteps = 5

# 단계별 설명
$Config_StepDescriptions = @{
    1 = "Parameter validation"
    2 = "Template acquisition" 
    3 = "Working directory preparation"
    4 = "Machine data copying"
    5 = "PSD processing"
}

# 진행상황 표시 형식
$Config_ProgressFormat = "[{0}/{1}] {2}"

# ================================================================================
# 파일명 패턴 설정
# ================================================================================

# 작업 디렉토리명 패턴
$Config_WorkingDirNamePattern = "{0}-{1}" # {timestamp}-{uuid}

# 타임스탬프 형식
$Config_TimestampFormat = "yyyyMMddHHmmss"

# 복사될 파일명 패턴들
$Config_FileNamePatterns = @{
    CharacterMain = "chara_main_{0}_1.png"          # {gXX}
    MachineMain = "machine_main_{0}_1.png"          # {gXX}
    MachineFrame = "machine-frame_{0}_1.png"        # {gXX}
    MachineIcon1 = "machine-icon_{0}_1.png"         # {gXX}
    MachineIcon2 = "machine-icon_{0}_2.png"         # {gXX}
    MachineName = "machine-name_{0}_1.png"          # {gXX}
}

# 머신 그룹 번호 형식 (g01, g02, ...)
$Config_MachineGroupFormat = "g{0:D2}"

# ================================================================================
# 설정 검증 함수
# ================================================================================

function Test-ConfigurationPaths {
    <#
    .SYNOPSIS
        설정된 경로들이 유효한지 검증
    #>
    
    $errors = @()
    
    # 필수 디렉토리 경로 검증
    $requiredPaths = @(
        $Config_TemplateBaseDir,
        $Config_MachineDataBaseDir
    )
    
    foreach ($path in $requiredPaths) {
        if (-not (Test-Path $path)) {
            $errors += "Required directory not found: $path"
        }
    }
    
    # Aspose.PSD 라이브러리 경로 검증
    if (-not (Test-Path $Config_AsposePsdLibraryPath)) {
        $errors += "Aspose.PSD library not found: $Config_AsposePsdLibraryPath"
    }
    
    return $errors
}

# ================================================================================
# 설정 표시 함수
# ================================================================================

function Show-Configuration {
    <#
    .SYNOPSIS
        현재 설정값들을 표시
    #>
    
    Write-Host "=== create-psd.ps1 Configuration ===" -ForegroundColor Cyan
    Write-Host "Template Base Dir: $Config_TemplateBaseDir" -ForegroundColor Yellow
    Write-Host "Machine Data Dir: $Config_MachineDataBaseDir" -ForegroundColor Yellow  
    Write-Host "Working Base Dir: $Config_WorkingBaseDir" -ForegroundColor Yellow
    Write-Host "Log Level: $Config_LogLevel" -ForegroundColor Yellow
    Write-Host "Debug Mode: $Config_DebugMode" -ForegroundColor Yellow
    Write-Host "Machine Size Threshold: $($Config_MachineSizeThreshold / 1MB) MB" -ForegroundColor Yellow
    Write-Host "======================================" -ForegroundColor Cyan
}

# ================================================================================
# 초기화 메시지
# ================================================================================

if ($Config_DebugMode) {
    Write-Host "create-psd-config.ps1 loaded successfully" -ForegroundColor Green
    
    # 설정 검증
    $configErrors = Test-ConfigurationPaths
    if ($configErrors.Count -gt 0) {
        Write-Warning "Configuration validation errors found:"
        $configErrors | ForEach-Object { Write-Warning "  $_" }
    }
}
