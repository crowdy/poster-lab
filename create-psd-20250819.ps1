<#
PowerShell Script: create-psd.ps1
Reviewed and Enhanced Logic

PARAMETERS:
-orientation [string] (Mandatory) - "horizontal" or "vertical"
-logotype [string] (Mandatory) - "grandOpen", "newMachineReplacement", "newOpen", "refreshOpen", "renewalOpen"
-machineIds [string] (Mandatory) - Comma-separated machine IDs (e.g., "1,2,3,4")
-datetime [string] (Optional) - "random" or specific datetime format
-userphrase [string] (Optional) - "random" or specific phrase

ENHANCED LOGIC STRUCTURE:

## 1. PARAMETER VALIDATION
function Validate-Parameters {
    param($orientation, $logotype, $machineIds, $datetime, $userphrase)
    
    # Validate orientation
    if ($orientation -notin @("horizontal", "vertical")) {
        throw "Invalid orientation. Must be 'horizontal' or 'vertical'"
    }
    
    # Validate logotype
    $validLogotypes = @("grandOpen", "newMachineReplacement", "newOpen", "refreshOpen", "renewalOpen")
    if ($logotype -notin $validLogotypes) {
        throw "Invalid logotype. Must be one of: $($validLogotypes -join ', ')"
    }
    
    # Validate machineIds format
    if (-not ($machineIds -match '^(\d+,)*\d+$')) {
        throw "Invalid machineIds format. Must be comma-separated numbers (e.g., '1,2,3')"
    }
    
    # Parse and validate machine IDs exist
    $machineIdArray = $machineIds -split ',' | ForEach-Object { [int]$_.Trim() }
    foreach ($id in $machineIdArray) {
        $machinePath = "d:\poster\machine\$id"
        if (-not (Test-Path $machinePath)) {
            throw "Machine data directory not found: $machinePath"
        }
    }
    
    return $machineIdArray
}

## 2. TEMPLATE PATH RESOLUTION
function Get-Template-Path {
    param(
        [string]$orientation,
        [string]$logotype,
        [string]$machineIds
    )
    
    # Define template base directory structure
    # Assuming structure: e:\poster-ai\templates\{orientation}\{logotype}\{machine-count}\
    $machineCount = ($machineIds -split ',').Count
    $templateBaseDir = "e:\poster-ai\templates\$orientation\$logotype\$machineCount"
    
    if (-not (Test-Path $templateBaseDir)) {
        Write-Error "Template directory not found: $templateBaseDir"
        return $null
    }
    
    # Find all valid template directories (containing exactly 1 PSD and at least 1 PNG)
    $validTemplates = @()
    Get-ChildItem $templateBaseDir -Directory | ForEach-Object {
        $templateDir = $_.FullName
        $psdFiles = Get-ChildItem $templateDir -Filter "*.psd"
        $pngFiles = Get-ChildItem $templateDir -Filter "*.png"
        
        if ($psdFiles.Count -eq 1 -and $pngFiles.Count -ge 1) {
            $validTemplates += $templateDir
        }
    }
    
    if ($validTemplates.Count -eq 0) {
        Write-Error "No valid templates found in: $templateBaseDir"
        return $null
    }
    
    # Return random template if multiple exist
    return $validTemplates | Get-Random
}

## 3. WORKING DIRECTORY PREPARATION
function Prepare-Working-Path {
    param([string]$TemplatePath)
    
    if (-not $TemplatePath -or -not (Test-Path $TemplatePath)) {
        throw "Invalid template path: $TemplatePath"
    }
    
    # Create working directory with timestamp and UUID
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $newUuid = [System.Guid]::NewGuid().ToString()
    $workingDir = "e:\poster-ai\working\$timestamp-$newUuid"
    
    try {
        New-Item -ItemType Directory -Path $workingDir -Force | Out-Null
        
        # Copy all files from template directory
        $templateFiles = Get-ChildItem $TemplatePath -File
        foreach ($file in $templateFiles) {
            $destFileName = $file.Name
            
            # Replace UUID in PSD filename (assuming format: {uuid}.psd)
            if ($file.Extension -eq ".psd" -and $file.BaseName -match '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$') {
                $destFileName = "$newUuid.psd"
            }
            
            Copy-Item $file.FullName -Destination "$workingDir\$destFileName"
        }
        
        return $workingDir
    }
    catch {
        if (Test-Path $workingDir) {
            Remove-Item $workingDir -Recurse -Force -ErrorAction SilentlyContinue
        }
        throw "Failed to prepare working directory: $($_.Exception.Message)"
    }
}

## 4. MACHINE DATA COPYING (CORRECTED LOGIC)
function Copy-Machine-Data {
    param(
        [string]$workingPath,
        [string]$machineIds
    )
    
    $machineIdArray = $machineIds -split ',' | ForEach-Object { [int]$_.Trim() }
    $usedFiles = @{}  # Track used files to avoid duplicates
    
    for ($i = 0; $i -lt $machineIdArray.Count; $i++) {
        $machineId = $machineIdArray[$i]
        $gNumber = "g$(($i + 1).ToString('D2'))"  # g01, g02, etc.
        
        $machineBasePath = "d:\poster\machine\$machineId"
        
        # Validate machine directories exist
        $requiredDirs = @("characters", "icon", "machine")
        foreach ($dir in $requiredDirs) {
            $dirPath = "$machineBasePath\$dir"
            if (-not (Test-Path $dirPath)) {
                throw "Required directory not found: $dirPath"
            }
        }
        
        try {
            # Character image (1 random from characters)
            $charImages = Get-ChildItem "$machineBasePath\characters" -Filter "*.png"
            if ($charImages.Count -gt 0) {
                $selectedChar = Get-UniqueRandomFile $charImages $usedFiles "characters_$machineId"
                Copy-Item $selectedChar.FullName -Destination "$workingPath\chara_main_${gNumber}_1.png"
            }
            
            # Machine images (separate large and small by file size)
            $machineImages = Get-ChildItem "$machineBasePath\machine" -Filter "*.png"
            $largeImages = $machineImages | Where-Object { $_.Length -ge 1MB }
            $smallImages = $machineImages | Where-Object { $_.Length -lt 1MB }
            
            # Machine main (large file)
            if ($largeImages.Count -gt 0) {
                $selectedLarge = Get-UniqueRandomFile $largeImages $usedFiles "machine_large_$machineId"
                Copy-Item $selectedLarge.FullName -Destination "$workingPath\machine_main_${gNumber}_1.png"
            }
            
            # Machine frame (small file)
            if ($smallImages.Count -gt 0) {
                $selectedSmall = Get-UniqueRandomFile $smallImages $usedFiles "machine_small_$machineId"
                Copy-Item $selectedSmall.FullName -Destination "$workingPath\machine-frame_${gNumber}_1.png"
            }
            
            # Machine icons (2 random from icon directory - CORRECTED)
            $iconImages = Get-ChildItem "$machineBasePath\icon" -Filter "*.png"
            if ($iconImages.Count -ge 2) {
                $selectedIcon1 = Get-UniqueRandomFile $iconImages $usedFiles "icon_${machineId}_1"
                $selectedIcon2 = Get-UniqueRandomFile $iconImages $usedFiles "icon_${machineId}_2"
                Copy-Item $selectedIcon1.FullName -Destination "$workingPath\machine-icon_${gNumber}_1.png"
                Copy-Item $selectedIcon2.FullName -Destination "$workingPath\machine-icon_${gNumber}_2.png"
            }
            elseif ($iconImages.Count -eq 1) {
                Copy-Item $iconImages[0].FullName -Destination "$workingPath\machine-icon_${gNumber}_1.png"
                # Create duplicate for second icon if only one exists
                Copy-Item $iconImages[0].FullName -Destination "$workingPath\machine-icon_${gNumber}_2.png"
            }
            
            # Machine name files (placeholder - to be implemented later)
            # machine-name_${gNumber}_1.png
            
        }
        catch {
            throw "Failed to copy machine data for machine $machineId : $($_.Exception.Message)"
        }
    }
}

## 5. HELPER FUNCTION FOR UNIQUE FILE SELECTION
function Get-UniqueRandomFile {
    param($fileArray, $usedFiles, $category)
    
    $availableFiles = $fileArray | Where-Object { -not $usedFiles.ContainsKey($_.FullName) }
    
    if ($availableFiles.Count -eq 0) {
        # If all files used, reset for this category and use any file
        $selectedFile = $fileArray | Get-Random
    } else {
        $selectedFile = $availableFiles | Get-Random
    }
    
    $usedFiles[$selectedFile.FullName] = $true
    return $selectedFile
}

## 6. PSD PROCESSING
function Bake-PSD {
    param([string]$workingPath)
    
    $psdFile = Get-ChildItem $workingPath -Filter "*.psd" | Select-Object -First 1
    if (-not $psdFile) {
        throw "No PSD file found in working directory: $workingPath"
    }
    
    try {
        # Add Photoshop automation logic here
        # This would typically involve COM automation or external tools
        # For now, return the PSD file path
        return $psdFile.FullName
    }
    catch {
        throw "Failed to process PSD file: $($_.Exception.Message)"
    }
}

## 7. CLEANUP FUNCTION
function Remove-WorkingDirectory {
    param([string]$workingPath)
    
    if ($workingPath -and (Test-Path $workingPath)) {
        try {
            Remove-Item $workingPath -Recurse -Force
            Write-Host "Cleaned up working directory: $workingPath"
        }
        catch {
            Write-Warning "Failed to cleanup working directory: $workingPath"
        }
    }
}

## 8. MAIN EXECUTION LOGIC (ENHANCED)
function Main {
    param($orientation, $logotype, $machineIds, $datetime, $userphrase)
    
    $workingPath = $null
    
    try {
        # Step 1: Validate all parameters
        Write-Host "Validating parameters..."
        $validatedMachineIds = Validate-Parameters $orientation $logotype $machineIds $datetime $userphrase
        
        # Step 2: Get template path
        Write-Host "Finding template..."
        $templatePath = Get-Template-Path $orientation $logotype $machineIds
        if (-not $templatePath) {
            throw "No suitable template found"
        }
        Write-Host "Selected template: $templatePath"
        
        # Step 3: Prepare working directory
        Write-Host "Preparing working directory..."
        $workingPath = Prepare-Working-Path $templatePath
        Write-Host "Working directory: $workingPath"
        
        # Step 4: Copy machine data
        Write-Host "Copying machine data..."
        Copy-Machine-Data $workingPath $machineIds
        
        # Step 5: Process PSD
        Write-Host "Processing PSD file..."
        $psdFullPath = Bake-PSD $workingPath
        
        Write-Host "Process completed successfully!"
        Write-Host "Final PSD: $psdFullPath"
        
        return $psdFullPath
    }
    catch {
        Write-Error "Script execution failed: $($_.Exception.Message)"
        # Cleanup on failure
        if ($workingPath) {
            Remove-WorkingDirectory $workingPath
        }
        throw
    }
}

## MISSING IMPLEMENTATIONS TO CONSIDER:

# 1. Datetime and userphrase parameter usage
   Datetime and userphrase는 이 draft 버전의 다음 버전에서 처리될 예정입니다.
# 2. Machine name generation logic
   Machine name은 machine data가 있는 디렉토리에 machine_name.txt로 존재해야 할 것 같습니다.
   아니면 machine_name.png로 존재
# 3. Photoshop COM automation for baking PSD
   아니요 Photoshop COM을 사용하지 않을 겁니다. 우리는 Aspose.PSD for NET을 사용할 예정입니다.
# 4. Configuration file for template directory structure
   config.ps1 을 두고 include하는 것이 좋을까요?
# 5. Logging mechanism
   로깅은 필요합니다. working_path에 출력하는 것이 좋겠어요. 적당히 출력해주세요
# 6. Progress reporting for long operations
   네. 시작시에 시작시각, 끝났을 때 종료시각, 각 단계가 끝났을 때, [1..n/n] 의 표시를 해주세요
# 7. Rollback mechanism on partial failures
   아뇨 Rollback은 필요 없습니다.
# 8. Template validation beyond file count
   Get-Template-Path 가 적절히 처리한다고 생각합니다.
# 9. Machine data validation (image format, dimensions, etc.)
   이미지가 손상되거나 했을 수 있겠군요. 우선은 문제없다고 가정하고 pass 합니다.
# 10. Concurrent processing for multiple machines
   pwsh로 실행하므로 run space는 독립되어 있으므로 문제 없지 않을까요?
#>

<#
Validate-Parameters $orientation $logotype $machineIds $datetime $userphrase
를 준비하는 것은 좋은 전략인 것 같습니다.
#>


# create-psd.ps1 개선된 Pseudo Code


















<#
pwsh 에서 동작하는 powershell script 입니다. 원하는 parameter는 다음과 같습니다.

create-psd.ps1 
-orientation horizontal|vertical
-logotype grandOpen|newMachineReplacement|newOpen|refreshOpen|renewalOpen
-machineIds ex) "1,2,3,4"
-datetime "random" (다음 버전에서 구현 예정)
-userphrase "random" (다음 버전에서 구현 예정)

## config.ps1 설정 파일 include
script 시작시 config.ps1을 include하여 설정값들을 로드합니다.
config.ps1에는 다음과 같은 설정들이 포함될 예정입니다:
- template 기본 디렉토리 경로
- machine data 기본 디렉토리 경로  
- working 디렉토리 기본 경로
- 로그 레벨 설정 등

## 진행상황 추적 및 로깅 초기화
스크립트 시작시 시작시각을 기록하고, 전체 단계 수를 정의합니다.
총 단계: [1/5] 파라미터 검증 -> [2/5] 템플릿 획득 -> [3/5] 작업디렉토리 준비 -> [4/5] 머신데이터 복사 -> [5/5] PSD 처리

## [1/5] Parameter 검증 (Validate-Parameters)
-orientation, -logotype, -machineIds의 유효성을 검사합니다.
-orientation은 "horizontal" 또는 "vertical"만 허용
-logotype은 5개 값 중 하나만 허용  
-machineIds는 컴마로 구분된 숫자 형식인지 검증
-각 machineId에 해당하는 d:\poster\machine\{id} 디렉토리가 존재하는지 확인
검증 실패시 에러와 함께 종료
성공시 [1/5] 완료 로그 출력

## [2/5] Template 획득 (Get-Template-Path)
-orientation, -logotype, -machineIds 로 필요한 template의 path를 결정합니다.
template 기본 경로 구조: e:\poster-ai\templates\{orientation}\{logotype}\{machine개수}\{template폴더명}\
각 template 폴더에는 정확히 1개의 psd파일과 1개 이상의 png파일이 존재해야 정상입니다.
조건에 맞는 template 폴더가 여러개 있을 경우 랜덤으로 하나를 선택합니다.
조건에 맞는 template이 존재하지 않으면 에러를 출력하고 종료합니다.
성공시 선택된 template 경로를 로그에 출력하고 [2/5] 완료

## [3/5] 작업디렉토리 준비 (Prepare-Working-Path)
다음의 작업용 디렉토리를 생성합니다:
e:\poster-ai\working\{yyyyMMddHHmmss}-{new uuid}

template 디렉토리의 모든 파일을 이 작업디렉토리로 복사합니다.
psd파일의 이름이 {기존uuid}.psd 형식으로 되어 있다면, 복사할 때 {new uuid}.psd로 이름을 변경합니다.
png파일들은 이름 변경 없이 그대로 복사합니다.

working 디렉토리에 로그파일을 생성합니다: create-psd.log
이후 모든 로그는 이 파일에도 동시에 기록됩니다.
성공시 작업디렉토리 경로를 로그에 출력하고 [3/5] 완료

## [4/5] 머신 데이터 복사 (Copy-Machine-Data)
-machineIds의 값을 파싱하여 각 머신별로 필요한 이미지들을 복사합니다.

각 머신 ID에 대해 다음 디렉토리들이 존재하는지 확인:
- d:\poster\machine\{id}\characters\
- d:\poster\machine\{id}\icon\  
- d:\poster\machine\{id}\machine\

머신 순서에 따라 g01, g02, g03... 형식으로 명명합니다.
첫 번째 머신(g01), 두 번째 머신(g02) 순으로 처리합니다.

각 머신별로 다음 파일들을 복사:

### Character 이미지
chara_main_g01_1.png <- d:\poster\machine\1\characters\의 랜덤 png 이미지 1개
chara_main_g02_1.png <- d:\poster\machine\2\characters\의 랜덤 png 이미지 1개

### Machine 이미지 (파일 크기로 구분)
machine_main_g01_1.png <- d:\poster\machine\1\machine\의 1MB 이상 png 이미지 중 랜덤 1개
machine_main_g02_1.png <- d:\poster\machine\2\machine\의 1MB 이상 png 이미지 중 랜덤 1개
machine-frame_g01_1.png <- d:\poster\machine\1\machine\의 1MB 미만 png 이미지 중 랜덤 1개  
machine-frame_g02_1.png <- d:\poster\machine\2\machine\의 1MB 미만 png 이미지 중 랜덤 1개

### Icon 이미지
machine-icon_g01_1.png <- d:\poster\machine\1\icon\의 랜덤 png 이미지 1개
machine-icon_g01_2.png <- d:\poster\machine\1\icon\의 랜덤 png 이미지 1개 (위와 다른 파일)
machine-icon_g02_1.png <- d:\poster\machine\2\icon\의 랜덤 png 이미지 1개
machine-icon_g02_2.png <- d:\poster\machine\2\icon\의 랜덤 png 이미지 1개 (위와 다른 파일)

### Machine Name 처리
machine-name_g01_1.png 생성 로직:
1. d:\poster\machine\1\ 에서 machine_name.png가 존재하면 해당 파일을 복사
2. machine_name.png가 없고 machine_name.txt가 존재하면 텍스트 내용을 읽어서 이미지로 생성 (향후 구현)
3. 둘 다 없으면 기본 이미지 사용하거나 건너뛰기

machine-name_g02_1.png도 동일한 로직으로 처리

중복 파일 선택 방지: 같은 소스 디렉토리에서 여러 파일을 선택할 때 중복되지 않도록 처리
각 머신 처리 완료시 진행상황 로그 출력
성공시 [4/5] 완료

## [5/5] PSD 처리 (Bake-PSD)
Aspose.PSD for .NET을 사용하여 PSD 파일을 처리합니다.
working 디렉토리에서 *.psd 파일을 찾습니다.
Aspose.PSD를 사용하여 linked smart object들을 embedded smart object로 변환합니다.
변환 완료된 PSD 파일을 저장합니다.
성공시 최종 PSD 파일 경로를 로그에 출력하고 [5/5] 완료

## 전체 실행 로직
```powershell
try {
    # config.ps1 include
    . .\config.ps1
    
    # 시작시간 기록 및 로깅 초기화
    $startTime = Get-Date
    Write-Host "[$($startTime.ToString('yyyy-MM-dd HH:mm:ss'))] Script started"
    
    # [1/5] Parameter 검증
    Write-Host "[1/5] Validating parameters..."
    Validate-Parameters $orientation $logotype $machineIds $datetime $userphrase
    Write-Host "[1/5] Parameter validation completed"
    
    # [2/5] Template 획득  
    Write-Host "[2/5] Finding template..."
    $templatePath = Get-Template-Path $orientation $logotype $machineIds
    if (-not $templatePath) {
        throw "No suitable template found"
    }
    Write-Host "[2/5] Template found: $templatePath"
    
    # [3/5] 작업디렉토리 준비
    Write-Host "[3/5] Preparing working directory..."
    $workingPath = Prepare-Working-Path $templatePath
    Write-Host "[3/5] Working directory prepared: $workingPath"
    
    # [4/5] 머신데이터 복사
    Write-Host "[4/5] Copying machine data..."
    Copy-Machine-Data $workingPath $machineIds  
    Write-Host "[4/5] Machine data copied"
    
    # [5/5] PSD 처리
    Write-Host "[5/5] Processing PSD with Aspose.PSD..."
    $psdFullPath = Bake-PSD $workingPath
    Write-Host "[5/5] PSD processing completed"
    
    # 완료시간 기록
    $endTime = Get-Date
    $duration = $endTime - $startTime
    Write-Host "[$($endTime.ToString('yyyy-MM-dd HH:mm:ss'))] Script completed successfully in $($duration.TotalSeconds) seconds"
    Write-Host "Final PSD: $psdFullPath"
    
} catch {
    $endTime = Get-Date  
    $duration = $endTime - $startTime
    Write-Host "[$($endTime.ToString('yyyy-MM-dd HH:mm:ss'))] Script failed after $($duration.TotalSeconds) seconds"
    Write-Error "Script execution failed: $($_.Exception.Message)"
    
    # 실패시 working 디렉토리는 디버깅을 위해 보존
    # 필요시 수동으로 정리
    throw
}
```

## 추가 고려사항

### 로깅 상세화
- 각 파일 복사시 소스와 대상 경로 로깅
- 랜덤 선택된 파일들의 이름 로깅  
- 에러 발생시 상세한 컨텍스트 정보 포함

### Machine Name 이미지 생성
- machine_name.txt에서 텍스트를 읽어 PNG 이미지로 변환하는 로직
- 폰트, 크기, 색상 등의 스타일 설정 필요

### Aspose.PSD 연동
- Aspose.PSD for .NET 라이브러리 로드
- Smart Object 변환 API 사용법 구현
- 메모리 관리 및 리소스 해제

### 에러 처리 강화  
- 각 단계별 구체적인 에러 메시지
- 부분 실패시 어느 단계에서 실패했는지 명확히 표시
- 재시도 가능한 에러와 치명적 에러 구분


----

나는 다음과 같은 e:\logical-experiment\local-proj-1\Load-AsposePSD.ps1 이 있다.
Create-PSD.ps1은 동일한 디렉토리에 실행할 생각이다.

혹시 각각의 step의 함수들도 ps1으로 분리해서 create-PSD.ps1안에서 load하는 것이 좋은 아이디어일까?

----

Role: PowerShell Script Architecture Specialist
Step-by-Step Architecture Analysis
Step 1: 현재 코드베이스 분석
Expert A (모듈화 전문가): Load-AsposePSD.ps1을 보니 이미 기능별 분리를 시작하셨네요. 각 함수를 별도 파일로 분리하는 것에 대해 분석해보겠습니다.
Expert B (유지보수 전문가): 파일 분리의 장단점을 고려해야 합니다. 복잡성 증가 vs 유지보수성 향상의 트레이드오프가 있습니다.
Expert C (배포 전문가): 배포와 의존성 관리 측면에서도 고려해야 할 점들이 있습니다.
Step 2: 장단점 분석
Expert A:
장점들:

각 함수별 독립적인 테스트 가능
코드 재사용성 향상
개별 함수 디버깅 용이
Git에서 변경사항 추적 용이

Expert B:
단점들:

파일 수 증가로 인한 복잡성
파일 간 의존성 관리 필요
배포시 여러 파일 관리 부담

Expert C: 현재 프로젝트 규모를 고려하면 과도한 분리일 수 있습니다.
Step 3: 권장 아키텍처 결정
Expert A & B 협업 (Expert C 제외 - 너무 보수적):create-psd.ps1 아키텍처 권장사항ドキュメント # create-psd.ps1 아키텍처 권장사항

## 🎯 결론: **부분적 분리**를 권장합니다

현재 프로젝트 규모와 복잡성을 고려할 때, **모든 함수를 개별 파일로 분리하는 것은 과도**합니다. 
대신 **논리적 그룹별로 분리**하는 것을 권장합니다.

## 📁 권장 파일 구조

```
e:\logical-experiment\local-proj-1\
├── create-psd.ps1                    # 메인 스크립트핵심 권장사항:
🎯 부분적 분리가 최적입니다
각 함수를 개별 파일로 분리하는 것은 현재 프로젝트 규모에 비해 과도한 엔지니어링입니다. 대신 논리적 그룹별 분리를 권장합니다.
📁 권장 구조: 총 5개 파일

create-psd.ps1 - 메인 orchestrator (진행상황, 전체 흐름)
create-psd-config.ps1 - 설정 ✅ (이미 완성)
Load-AsposePSD.ps1 - Aspose 로더 ✅ (이미 있음)
PSD-Functions.ps1 - 핵심 5단계 함수들 🆕
PSD-Utilities.ps1 - 공통 헬퍼 함수들 🆕

💡 이 구조의 이점

적절한 복잡성: 관리 가능한 파일 수
명확한 책임 분리: 각 파일의 역할이 뚜렷함
재사용성: Utilities는 다른 스크립트에서도 활용 가능
확장성: 필요시 추가 분리 가능

개별 함수별 파일 분리는 대규모 프로젝트나 팀 개발에서나 의미가 있고, 현재 규모에서는 오히려 복잡성만 증가시킵니다.
지금처럼 논리적 그룹별로 분리하시는 것이 가장 실용적인 접근입니다! 🚀再試行TK좋습니다. 그럼 권장구조의 파일들을 모두 생성해주세요編集Role: PowerShell Script Architecture Implementation Specialist
Step-by-Step File Generation
Step 1: 메인 Orchestrator 파일 생성
Expert A (메인 로직 설계자): 메인 스크립트는 순수하게 진행상황 관리와 전체 흐름 제어에만 집중해야 합니다.
Expert B (에러 처리 전문가): 각 단계별 에러 처리와 로깅이 체계적으로 구현되어야 합니다.
Step 2: 핵심 비즈니스 로직 파일 생성
Expert A: 5단계 함수들을 논리적으로 구성하고 상호 의존성을 최소화해야 합니다.
Expert B: 각 함수는 독립적으로 테스트 가능하도록 설계해야 합니다.
Step 3: 유틸리티 함수 파일 생성
Expert A & B 협업: 재사용 가능한 헬퍼 함수들을 범용적으로 설계합니다.create-psd.ps1 (메인 스크립트)コード # create-psd.ps1
# Main orchestrator script for PSD creation

<#
.SYNOPSIS
    PSD 포스터 생성 메인 스크립트

.DESCRIPTION
    템플릿과 머신 데이터를 조합하여 PSD 파일을 생성합니다.
    Aspose.PSD for .NET을 사용하여 linked smart objects를 embedded로 변환합니다.

.PARAMETER orientation
    포스터 PSD-Functions.ps1 (핵심 비즈니스 로직)コード # PSD-Functions.ps1
# Core business logic functions for PSD creation

<#
.SYNOPSIS
    create-psd.ps1의 핵심 비즈니스 로직 함수들

.DESCRIPTION
    PSD 생성 프로세스의 5단계 핵심 함수들을 포함합니다:
    1. Validate-Parameters - 파라미터 검증
    2. Get-Template-Path - 템플릿 경로 획득
    3. PPSD-Utilities.ps1 (유틸리티 함수들)コード # PSD-Utilities.ps1
# Common utility functions for PSD creation scripts

<#
.SYNOPSIS
    create-psd.ps1에서 사용하는 공통 유틸리티 함수들

.DESCRIPTION
    로깅, 파일 처리, 디렉토리 관리 등의 재사용 가능한 헬퍼 함수들을 포함합니다.
    다른 PSD 관련 스크립트에서도 재사용 가능하도록 설계되었습니다.

.NOTES
    Dependenci🎉 권장 구조의 모든 파일 생성 완료!
📁 생성된 파일 구조
e:\logical-experiment\local-proj-1\
├── create-psd.ps1                ✅ 메인 orchestrator (방금 생성)
├── create-psd-config.ps1         ✅ 설정 파일 (이전에 생성)
├── Load-AsposePSD.ps1            ✅ Aspose.PSD 로더 (이미 있음)
├── PSD-Functions.ps1             ✅ 핵심 5단계 함수들 (방금 생성)
└── PSD-Utilities.ps1             ✅ 공통 유틸리티 함수들 (방금 생성)
🚀 각 파일의 특징
1. create-psd.ps1 (메인 스크립트)

순수 orchestration: 비즈니스 로직 없이 흐름 제어만
진행상황 표시: [1/5] ~ [5/5] 단계별 진행률
체계적 에러 처리: 실패시 상세한 컨텍스트 정보
시간 추적: 시작/종료 시간, 소요시간 계산

2. PSD-Functions.ps1 (핵심 로직)

5단계 함수: Validate-Parameters → Get-Template-Path → Prepare-Working-Path → Copy-Machine-Data → Bake-PSD
**독립

----
#>
