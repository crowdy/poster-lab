# PSD-Utilities.ps1
# Common utility functions for PSD creation scripts

<#
.SYNOPSIS
    create-psd.ps1에서 사용하는 공통 유틸리티 함수들

.DESCRIPTION
    로깅, 파일 처리, 디렉토리 관리 등의 재사용 가능한 헬퍼 함수들을 포함합니다.
    다른 PSD 관련 스크립트에서도 재사용 가능하도록 설계되었습니다.

.NOTES
    Dependencies: create-psd-config.ps1
#>

# ================================================================================
# 전역 변수
# ================================================================================

# 로그 파일 경로 (Initialize-LogFile에서 설정)
$script:LogFilePath = $null

# ================================================================================
# 로깅 함수들
# ================================================================================

function Write-PSDLog {
    <#
    .SYNOPSIS
        PSD 스크립트용 통합 로깅 함수
    
    .PARAMETER Level
        로그 레벨 - DEBUG, INFO, WARN, ERROR
    .PARAMETER Message
        로그 메시지
    .PARAMETER Force
        로그 레벨 무시하고 강제 출력
    #>
    
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("DEBUG", "INFO", "WARN", "ERROR")]
        [string]$Level,
        
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [switch]$Force
    )
    
    # 로그 레벨 필터링
    $levelPriority = @{
        "DEBUG" = 0
        "INFO"  = 1  
        "WARN"  = 2
        "ERROR" = 3
    }
    
    $configLevelPriority = $levelPriority[$Config_LogLevel]
    $messageLevelPriority = $levelPriority[$Level]
    
    if (-not $Force -and $messageLevelPriority -lt $configLevelPriority) {
        return  # 설정된 로그 레벨보다 낮으면 출력 안함
    }
    
    # 로그 메시지 포맷
    $timestamp = Get-Date -Format $Config_LogDateFormat
    $formattedMessage = "[$timestamp] [$Level] $Message"
    
    # 콘솔 출력
    if ($Config_ConsoleLogging) {
        $color = switch ($Level) {
            "DEBUG" { "Gray" }
            "INFO"  { "White" }
            "WARN"  { "Yellow" }
            "ERROR" { "Red" }
        }
        Write-Host $formattedMessage -ForegroundColor $color
    }
    
    # 파일 출력
    if ($Config_FileLogging -and $script:LogFilePath) {
        try {
            # 로그 파일 크기 체크
            if (Test-Path $script:LogFilePath) {
                $logFile = Get-Item $script:LogFilePath
                if ($logFile.Length -gt ($Config_MaxLogFileSize * 1MB)) {
                    # 로그 파일이 너무 크면 백업하고 새로 시작
                    $backupPath = $script:LogFilePath + ".old"
                    Move-Item $script:LogFilePath $backupPath -Force
                }
            }
            
            Add-Content -Path $script:LogFilePath -Value $formattedMessage -Encoding UTF8
        } catch {
            # 파일 로깅 실패시 콘솔에만 에러 표시
            Write-Host "Failed to write to log file: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

function Initialize-LogFile {
    <#
    .SYNOPSIS
        로그 파일을 초기화합니다.
    
    .PARAMETER workingPath
        작업 디렉토리 경로 (로그 파일이 생성될 위치)
    #>
    
    param(
        [string]$workingPath
    )
    
    if ($Config_FileLogging -and $workingPath) {
        $script:LogFilePath = Join-Path $workingPath $Config_LogFileName
        
        try {
            # 로그 파일 헤더 작성
            $header = @"
================================================================================
create-psd.ps1 Execution Log
Started: $(Get-Date -Format $Config_LogDateFormat)
Working Directory: $workingPath
================================================================================
"@
            Set-Content -Path $script:LogFilePath -Value $header -Encoding UTF8
            Write-PSDLog "INFO" "Log file initialized: $script:LogFilePath"
        } catch {
            Write-Host "Failed to initialize log file: $($_.Exception.Message)" -ForegroundColor Red
            $script:LogFilePath = $null
        }
    }
}

# ================================================================================
# 파일 처리 함수들
# ================================================================================

function Get-UniqueRandomFile {
    <#
    .SYNOPSIS
        파일 배열에서 중복되지 않는 랜덤 파일을 선택합니다.
    
    .PARAMETER fileArray
        선택할 파일들의 배열
    .PARAMETER usedFiles
        이미 사용된 파일들을 추적하는 해시테이블
    .PARAMETER category
        파일 카테고리 (디버깅용)
    
    .OUTPUTS
        [System.IO.FileInfo] 선택된 파일
    #>
    
    param(
        [System.IO.FileInfo[]]$fileArray,
        [hashtable]$usedFiles,
        [string]$category = "unknown"
    )
    
    if (-not $fileArray -or $fileArray.Count -eq 0) {
        throw "No files available for selection in category: $category"
    }
    
    # 사용되지 않은 파일들 필터링
    $availableFiles = $fileArray | Where-Object { -not $usedFiles.ContainsKey($_.FullName) }
    
    if ($availableFiles.Count -eq 0) {
        # 모든 파일이 사용되었으면 임의로 선택 (중복 허용)
        $selectedFile = $fileArray | Get-Random
        Write-PSDLog "WARN" "All files used in category '$category', allowing duplicate: $($selectedFile.Name)"
    } else {
        $selectedFile = $availableFiles | Get-Random
        Write-PSDLog "DEBUG" "Selected file in category '$category': $($selectedFile.Name)"
    }
    
    # 사용된 파일로 마킹
    $usedFiles[$selectedFile.FullName] = $true
    
    return $selectedFile
}

function Test-ImageFile {
    <#
    .SYNOPSIS
        이미지 파일의 유효성을 검사합니다.
    
    .PARAMETER FilePath
        검사할 이미지 파일 경로
    
    .OUTPUTS
        [bool] 유효한 이미지 파일이면 $true
    #>
    
    param(
        [string]$FilePath
    )
    
    if (-not (Test-Path $FilePath)) {
        return $false
    }
    
    $file = Get-Item $FilePath
    
    # 확장자 검사
    if ($file.Extension -notin $Config_SupportedImageExtensions) {
        return $false
    }
    
    # 파일 크기 검사 (0바이트 파일 제외)
    if ($file.Length -eq 0) {
        return $false
    }
    
    # TODO: 실제 이미지 헤더 검증 추가 가능
    # 현재는 기본적인 검사만 수행
    
    return $true
}

function Copy-FileWithValidation {
    <#
    .SYNOPSIS
        파일 복사를 수행하고 결과를 검증합니다.
    
    .PARAMETER SourcePath
        소스 파일 경로
    .PARAMETER DestinationPath  
        대상 파일 경로
    .PARAMETER ValidateImage
        이미지 파일 검증 여부
    
    .OUTPUTS
        [bool] 복사 성공 여부
    #>
    
    param(
        [string]$SourcePath,
        [string]$DestinationPath,
        [switch]$ValidateImage
    )
    
    try {
        if (-not (Test-Path $SourcePath)) {
            throw "Source file not found: $SourcePath"
        }
        
        if ($ValidateImage -and -not (Test-ImageFile $SourcePath)) {
            throw "Invalid image file: $SourcePath"
        }
        
        # 대상 디렉토리 생성 (필요시)
        $destDir = Split-Path $DestinationPath -Parent
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
        
        # 파일 복사
        Copy-Item $SourcePath -Destination $DestinationPath -Force
        
        # 복사 결과 검증
        if (-not (Test-Path $DestinationPath)) {
            throw "File copy failed: destination file not found"
        }
        
        $sourceSize = (Get-Item $SourcePath).Length
        $destSize = (Get-Item $DestinationPath).Length
        
        if ($sourceSize -ne $destSize) {
            throw "File copy failed: size mismatch (source: $sourceSize, dest: $destSize)"
        }
        
        Write-PSDLog "DEBUG" "File copied successfully: $SourcePath -> $DestinationPath"
        return $true
        
    } catch {
        Write-PSDLog "ERROR" "File copy failed: $($_.Exception.Message)"
        return $false
    }
}

# ================================================================================
# 디렉토리 관리 함수들
# ================================================================================

function Get-DirectorySize {
    <#
    .SYNOPSIS
        디렉토리의 총 크기를 계산합니다.
    
    .PARAMETER Path
        디렉토리 경로
    
    .OUTPUTS
        [long] 디렉토리 크기 (바이트)
    #>
    
    param(
        [string]$Path
    )
    
    if (-not (Test-Path $Path)) {
        return 0
    }
    
    try {
        $size = (Get-ChildItem $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
        return [long]$size
    } catch {
        Write-PSDLog "WARN" "Failed to calculate directory size: $Path - $($_.Exception.Message)"
        return 0
    }
}

# ================================================================================
# 설정 및 검증 함수들
# ================================================================================

function Test-ConfigurationPaths {
    <#
    .SYNOPSIS
        설정된 경로들이 유효한지 검증합니다.
    
    .OUTPUTS
        [string[]] 발견된 오류 목록
    #>
    
    $errors = @()
    
    # 필수 디렉토리 경로 검증
    $requiredPaths = @(
        @{ Path = $Config_TemplateBaseDir; Name = "Template Base Directory" },
        @{ Path = $Config_MachineDataBaseDir; Name = "Machine Data Base Directory" }
    )
    
    foreach ($pathInfo in $requiredPaths) {
        if (-not (Test-Path $pathInfo.Path)) {
            $errors += "$($pathInfo.Name) not found: $($pathInfo.Path)"
        }
    }
    
    # 작업 디렉토리 기본 경로 확인 (없으면 생성 시도)
    if (-not (Test-Path $Config_WorkingBaseDir)) {
        try {
            New-Item -ItemType Directory -Path $Config_WorkingBaseDir -Force | Out-Null
            Write-PSDLog "INFO" "Created working base directory: $Config_WorkingBaseDir"
        } catch {
            $errors += "Cannot create working base directory: $Config_WorkingBaseDir"
        }
    }
    
    return $errors
}

function Show-Configuration {
    <#
    .SYNOPSIS
        현재 설정값들을 표시합니다.
    #>
    
    Write-Host ""
    Write-Host "=== create-psd.ps1 Configuration ===" -ForegroundColor Cyan
    Write-Host "Template Base Dir    : $Config_TemplateBaseDir" -ForegroundColor Yellow
    Write-Host "Machine Data Dir     : $Config_MachineDataBaseDir" -ForegroundColor Yellow  
    Write-Host "Working Base Dir     : $Config_WorkingBaseDir" -ForegroundColor Yellow
    Write-Host "Log Level            : $Config_LogLevel" -ForegroundColor Yellow
    Write-Host "Debug Mode           : $Config_DebugMode" -ForegroundColor Yellow
    Write-Host "Console Logging      : $Config_ConsoleLogging" -ForegroundColor Yellow
    Write-Host "File Logging         : $Config_FileLogging" -ForegroundColor Yellow
    Write-Host "Machine Size Threshold: $($Config_MachineSizeThreshold / 1MB) MB" -ForegroundColor Yellow
    Write-Host "Embed Smart Objects  : $Config_EmbedLinkedSmartObjects" -ForegroundColor Yellow
    Write-Host "Preserve on Failure  : $Config_PreserveWorkingDirOnFailure" -ForegroundColor Yellow
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host ""
}

function Test-AsposePSDAvailability {
    <#
    .SYNOPSIS
        Aspose.PSD 라이브러리 사용 가능 여부를 확인합니다.
    
    .OUTPUTS
        [bool] 사용 가능하면 $true
    #>
    
    try {
        # Aspose.PSD 클래스가 로드되어 있는지 확인
        $asposeType = [Aspose.PSD.Image] -as [type]
        if ($asposeType) {
            Write-PSDLog "DEBUG" "Aspose.PSD is available"
            return $true
        } else {
            Write-PSDLog "WARN" "Aspose.PSD type not found"
            return $false
        }
    } catch {
        Write-PSDLog "WARN" "Aspose.PSD availability check failed: $($_.Exception.Message)"
        return $false
    }
}

# ================================================================================
# 문자열 및 데이터 처리 함수들
# ================================================================================

function Format-FileSize {
    <#
    .SYNOPSIS
        파일 크기를 읽기 쉬운 형태로 포맷합니다.
    
    .PARAMETER Bytes
        바이트 단위 크기
    
    .OUTPUTS
        [string] 포맷된 크기 문자열
    #>
    
    param(
        [long]$Bytes
    )
    
    if ($Bytes -ge 1GB) {
        return "{0:N2} GB" -f ($Bytes / 1GB)
    } elseif ($Bytes -ge 1MB) {
        return "{0:N2} MB" -f ($Bytes / 1MB)
    } elseif ($Bytes -ge 1KB) {
        return "{0:N2} KB" -f ($Bytes / 1KB)
    } else {
        return "$Bytes bytes"
    }
}

function Get-RelativePath {
    <#
    .SYNOPSIS
        상대 경로를 계산합니다.
    
    .PARAMETER BasePath
        기준 경로
    .PARAMETER TargetPath
        대상 경로
    
    .OUTPUTS
        [string] 상대 경로
    #>
    
    param(
        [string]$BasePath,
        [string]$TargetPath
    )
    
    try {
        $basePath = Resolve-Path $BasePath -ErrorAction Stop
        $targetPath = Resolve-Path $TargetPath -ErrorAction Stop
        
        $relativePath = [System.IO.Path]::GetRelativePath($basePath, $targetPath)
        return $relativePath
    } catch {
        # 상대 경로 계산 실패시 절대 경로 반환
        return $TargetPath
    }
}

# ================================================================================
# 진행상황 및 성능 모니터링
# ================================================================================

function Measure-ScriptBlock {
    <#
    .SYNOPSIS
        스크립트 블록의 실행 시간을 측정합니다.
    
    .PARAMETER ScriptBlock
        측정할 스크립트 블록
    .PARAMETER Description
        작업 설명
    
    .OUTPUTS
        스크립트 블록의 실행 결과
    #>
    
    param(
        [scriptblock]$ScriptBlock,
        [string]$Description = "Operation"
    )
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    try {
        Write-PSDLog "DEBUG" "$Description started"
        $result = & $ScriptBlock
        $stopwatch.Stop()
        
        Write-PSDLog "DEBUG" "$Description completed in $($stopwatch.ElapsedMilliseconds)ms"
        return $result
        
    } catch {
        $stopwatch.Stop()
        Write-PSDLog "ERROR" "$Description failed after $($stopwatch.ElapsedMilliseconds)ms: $($_.Exception.Message)"
        throw
    }
}

# ================================================================================
# Export functions for module use (optional)
# ================================================================================

# Export-ModuleMember -Function @(
#     'Write-PSDLog', 'Initialize-LogFile',
#     'Get-UniqueRandomFile', 'Test-ImageFile', 'Copy-FileWithValidation',
#     'Get-DirectorySize',
#     'Test-ConfigurationPaths', 'Show-Configuration', 'Test-AsposePSDAvailability',
#     'Format-FileSize', 'Get-RelativePath', 'Measure-ScriptBlock'
# )