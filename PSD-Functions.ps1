# PSD-Functions.ps1
# Core business logic functions for PSD creation

<#
.SYNOPSIS
    create-psd.ps1의 핵심 비즈니스 로직 함수들

.DESCRIPTION
    PSD 생성 프로세스의 5단계 핵심 함수들을 포함합니다:
    1. Validate-Parameters - 파라미터 검증
    2. Get-Template-Path - 템플릿 경로 획득
    3. Prepare-Working-Path - 작업 디렉토리 준비
    4. Copy-Machine-Data - 머신 데이터 복사
    5. Bake-PSD - PSD 파일 처리

.NOTES
    Dependencies: create-psd-config.ps1, PSD-Utilities.ps1
#>

# ================================================================================
# [1/5] 파라미터 검증 함수
# ================================================================================

function Validate-Parameters {
    <#
    .SYNOPSIS
        입력 파라미터들의 유효성을 검증합니다.
    
    .PARAMETER orientation
        포스터 방향
    .PARAMETER logotype  
        로고 타입
    .PARAMETER machineIds
        머신 ID 목록 (컴마 구분)
    .PARAMETER datetime
        날짜/시간 설정 (향후 구현)
    .PARAMETER userphrase
        사용자 문구 (향후 구현)
    
    .OUTPUTS
        [int[]] 검증된 머신 ID 배열
    #>
    
    param(
        [string]$orientation,
        [string]$logotype,
        [string]$machineIds,
        [string]$datetime,
        [string]$userphrase
    )
    
    Write-PSDLog "DEBUG" "Starting parameter validation"
    
    # Orientation 검증
    if ($orientation -notin $Config_ValidOrientations) {
        $validValues = $Config_ValidOrientations -join ', '
        throw ($Config_ErrorMessages.InvalidOrientation -f $validValues)
    }
    Write-PSDLog "DEBUG" "Orientation '$orientation' is valid"
    
    # Logotype 검증
    if ($logotype -notin $Config_ValidLogotypes) {
        $validValues = $Config_ValidLogotypes -join ', '
        throw ($Config_ErrorMessages.InvalidLogotype -f $validValues)
    }
    Write-PSDLog "DEBUG" "Logotype '$logotype' is valid"
    
    # MachineIds 형식 검증
    if (-not ($machineIds -match '^(\d+,)*\d+$')) {
        throw $Config_ErrorMessages.InvalidMachineIds
    }
    
    # MachineIds 파싱 및 디렉토리 존재 확인
    $machineIdArray = $machineIds -split ',' | ForEach-Object { [int]$_.Trim() }
    Write-PSDLog "DEBUG" "Parsed machine IDs: $($machineIdArray -join ', ')"
    
    foreach ($id in $machineIdArray) {
        $machinePath = Join-Path $Config_MachineDataBaseDir $id
        if (-not (Test-Path $machinePath)) {
            throw ($Config_ErrorMessages.MachineDataNotFound -f $machinePath)
        }
        
        # 필수 하위 디렉토리 존재 확인
        foreach ($subDir in $Config_RequiredMachineSubDirs) {
            $subDirPath = Join-Path $machinePath $subDir
            if (-not (Test-Path $subDirPath)) {
                throw "Required subdirectory not found: $subDirPath"
            }
        }
        Write-PSDLog "DEBUG" "Machine ID $id validation passed"
    }
    
    # Datetime, userphrase는 향후 구현 예정
    if ($datetime -ne "random") {
        Write-PSDLog "WARN" "Custom datetime is not implemented yet, using 'random'"
    }
    if ($userphrase -ne "random") {
        Write-PSDLog "WARN" "Custom userphrase is not implemented yet, using 'random'"
    }
    
    Write-PSDLog "INFO" "All parameters validated successfully"
    return $machineIdArray
}

# ================================================================================
# [2/5] 템플릿 경로 획득 함수
# ================================================================================

function Get-Template-Path {
    <#
    .SYNOPSIS
        주어진 조건에 맞는 템플릿 경로를 찾습니다.
    
    .PARAMETER orientation
        포스터 방향
    .PARAMETER logotype
        로고 타입
    .PARAMETER machineIds
        머신 ID 목록
    
    .OUTPUTS
        [string] 선택된 템플릿 디렉토리 경로, 찾지 못하면 $null
    #>
    
    param(
        [string]$orientation,
        [string]$logotype,
        [string]$machineIds
    )
    
    Write-PSDLog "DEBUG" "Starting template path resolution"
    
    # 머신 개수 계산
    $machineCount = ($machineIds -split ',').Count
    Write-PSDLog "DEBUG" "Machine count: $machineCount"
    
    # 템플릿 기본 디렉토리 구성
    # 구조: {base}\{orientation}\{logotype}\machine_{machine-count}\m{machine-count}\s[X]\[UUID]
    $templateBaseDir = Join-Path $Config_TemplateBaseDir $orientation
    $templateBaseDir = Join-Path $templateBaseDir $logotype  
    $templateBaseDir = Join-Path $templateBaseDir "machine_$($machineCount.ToString())"
    $templateBaseDir = Join-Path $templateBaseDir "m$($machineCount.ToString())"
    
    Write-PSDLog "DEBUG" "Template base directory: $templateBaseDir"
    
    if (-not (Test-Path $templateBaseDir)) {
        Write-PSDLog "ERROR" "Template base directory not found: $templateBaseDir"
        return $null
    }
    
    # s[X] 디렉토리들 찾기 (s0, s1, s2, s4 등)
    $sDirectories = Get-ChildItem $templateBaseDir -Directory | Where-Object { $_.Name -match '^s\d+$' }
    
    if ($sDirectories.Count -eq 0) {
        Write-PSDLog "ERROR" "No s[X] directories found in: $templateBaseDir"
        return $null
    }
    
    Write-PSDLog "DEBUG" "Found $($sDirectories.Count) s[X] directories: $($sDirectories.Name -join ', ')"
    
    # s[X] 디렉토리 중 랜덤 선택
    $selectedSDir = $sDirectories | Get-Random
    $sDirPath = $selectedSDir.FullName
    
    Write-PSDLog "DEBUG" "Randomly selected s[X] directory: $($selectedSDir.Name)"
    
    # 선택된 s[X] 디렉토리 안에서 UUID 패턴 디렉토리들 찾기
    $uuidDirectories = Get-ChildItem $sDirPath -Directory | Where-Object { 
        $_.Name -match $Config_UuidPattern 
    }
    
    if ($uuidDirectories.Count -eq 0) {
        Write-PSDLog "ERROR" "No UUID template directories found in: $sDirPath"
        return $null
    }
    
    Write-PSDLog "DEBUG" "Found $($uuidDirectories.Count) UUID template directories"
    
    # 유효한 템플릿 디렉토리 찾기
    $validTemplates = @()
    
    foreach ($uuidDir in $uuidDirectories) {
        Write-PSDLog "DEBUG" "Checking template directory: $($uuidDir.FullName)"
        
        # PSD 파일 개수 확인
        $psdFiles = Get-ChildItem $uuidDir.FullName -Filter "*.psd" -File
        $psdCount = $psdFiles.Count
        
        # PNG 파일 개수 확인  
        $pngFiles = Get-ChildItem $uuidDir.FullName -Filter "*.png" -File
        $pngCount = $pngFiles.Count
        
        Write-PSDLog "DEBUG" "Template '$($uuidDir.Name)': $psdCount PSD files, $pngCount PNG files"
        
        # 검증 조건: 정확히 1개의 PSD 파일만 필요 (PNG는 동적 생성)
        if ($psdCount -eq 1) {
            
            $validTemplates += $uuidDir.FullName
            Write-PSDLog "DEBUG" "Template '$($uuidDir.Name)' is valid"
        } else {
            Write-PSDLog "DEBUG" "Template '$($uuidDir.Name)' is invalid (PSD: $psdCount, PNG: $pngCount)"
        }
    }
    
    if ($validTemplates.Count -eq 0) {
        Write-PSDLog "ERROR" "No valid templates found in s[X] directory: $sDirPath"
        return $null
    }
    
    # 여러 유효한 템플릿이 있으면 랜덤 선택
    $selectedTemplate = $validTemplates | Get-Random
    Write-PSDLog "INFO" "Found $($validTemplates.Count) valid template(s), selected: $selectedTemplate"
    
    # 선택된 템플릿에서 UUID 추출
    $templateUuid = Split-Path $selectedTemplate -Leaf
    Write-PSDLog "DEBUG" "Extracted template UUID: $templateUuid"
    
    # Path와 UUID를 함께 반환
    return @{
        Path = $selectedTemplate
        UUID = $templateUuid
    }
}

# ================================================================================
# [3/5] 작업 디렉토리 준비 함수
# ================================================================================

function Prepare-Working-Path {
    <#
    .SYNOPSIS
        템플릿 파일들을 복사할 작업 디렉토리를 준비합니다.
    
    .PARAMETER TemplatePath
        템플릿 디렉토리 경로
    .PARAMETER TemplateUuid
        템플릿의 UUID (작업 디렉토리명과 PSD 파일명에 사용)
    
    .OUTPUTS
        [string] 생성된 작업 디렉토리 경로
    #>
    
    param(
        [string]$TemplatePath,
        [string]$TemplateUuid
    )
    
    Write-PSDLog "DEBUG" "Starting working directory preparation"
    
    if (-not $TemplatePath -or -not (Test-Path $TemplatePath)) {
        throw "Invalid template path: $TemplatePath"
    }
    
    # 작업 디렉토리명 생성 (전달받은 TemplateUuid 사용)
    $timestamp = Get-Date -Format $Config_TimestampFormat
    $workingDirName = $Config_WorkingDirNamePattern -f $timestamp, $TemplateUuid
    $workingDir = Join-Path $Config_WorkingBaseDir $workingDirName
    
    Write-PSDLog "DEBUG" "Creating working directory: $workingDir"
    Write-PSDLog "DEBUG" "Using template UUID: $TemplateUuid"
    
    try {
        # 작업 디렉토리 생성
        New-Item -ItemType Directory -Path $workingDir -Force | Out-Null
        Write-PSDLog "INFO" "Working directory created: $workingDir"
        
        # 템플릿 파일들 복사
        $templateFiles = Get-ChildItem $TemplatePath -File
        Write-PSDLog "DEBUG" "Found $($templateFiles.Count) files in template directory"
        
        foreach ($file in $templateFiles) {
            $destFileName = $file.Name
            
            # PSD 파일인 경우 UUID 교체 (파일명이 UUID 패턴인 경우)
            if ($file.Extension -eq $Config_PsdExtension -and 
                $file.BaseName -match $Config_UuidPattern) {
                $destFileName = "$TemplateUuid$($Config_PsdExtension)"
                Write-PSDLog "DEBUG" "Renaming PSD file: $($file.Name) -> $destFileName"
            }
            
            $destPath = Join-Path $workingDir $destFileName
            Copy-Item $file.FullName -Destination $destPath -Force
            Write-PSDLog "DEBUG" "Copied: $($file.Name) -> $destFileName"
        }
        
        Write-PSDLog "INFO" "Template files copied successfully"
        return $workingDir
        
    } catch {
        # 실패시 생성된 디렉토리 정리
        if (Test-Path $workingDir) {
            Remove-Item $workingDir -Recurse -Force -ErrorAction SilentlyContinue
        }
        throw ($Config_ErrorMessages.WorkingDirCreationFailed -f $_.Exception.Message)
    }
}

# ================================================================================
# [4/5] 머신 데이터 복사 함수  
# ================================================================================

function Copy-Machine-Data {
    <#
    .SYNOPSIS
        머신별 이미지 데이터를 작업 디렉토리에 복사합니다.
    
    .PARAMETER workingPath
        작업 디렉토리 경로
    .PARAMETER machineIds
        머신 ID 목록 (컴마 구분)
    .PARAMETER posterRecord
        poster.csv에서 읽은 해당 UUID의 레코드 데이터 (sub_character_count 정보 포함)
    #>
    
    param(
        [string]$workingPath,
        [string]$machineIds,
        $posterRecord
    )
    
    Write-PSDLog "DEBUG" "Starting machine data copying"
    
    $machineIdArray = $machineIds -split ',' | ForEach-Object { [int]$_.Trim() }
    $usedFiles = @{}  # 중복 파일 선택 방지용
    
    Write-PSDLog "INFO" "Processing $($machineIdArray.Count) machine(s): $($machineIdArray -join ', ')"
    
    # ===== 1. Sequential mapping 초기화 =====
    Write-PSDLog "INFO" "Initializing sequential mapping for character positioning"
    Initialize-MachineSequentialMapping -machineIds $machineIdArray
    
    # ===== 2. 사용 가능한 face position 확인 =====
    $availableFacePositions = Get-AvailableFacePositions -posterRecord $posterRecord
    Write-PSDLog "INFO" "Face position limits - Main: $($availableFacePositions.MainCharacterPositions), Sub: $($availableFacePositions.SubCharacterPositions), Total: $($availableFacePositions.TotalPositions)"
    
    # ===== 3. Character 파일 생성 계획 수립 =====
    $totalMachines = $machineIdArray.Count
    $mainCharactersToCreate = [Math]::Min($totalMachines, $availableFacePositions.MainCharacterPositions)
    $remainingPositions = $availableFacePositions.TotalPositions - $mainCharactersToCreate
    
    # CSV에서 sub_character_count 가져오기 (전체 합계)
    $requestedSubCharacterCount = 0
    if ($posterRecord) {
        try {
            if ($posterRecord -is [hashtable]) {
                $requestedSubCharacterCount = [int]$posterRecord["sub_character_count"]
            } else {
                $requestedSubCharacterCount = [int]$posterRecord.sub_character_count
            }
            Write-PSDLog "DEBUG" "Requested sub character count from CSV: $requestedSubCharacterCount"
        } catch {
            Write-PSDLog "WARN" "Failed to get sub_character_count from posterRecord: $($_.Exception.Message)"
            $requestedSubCharacterCount = 0
        }
    }
    
    # 실제로 생성할 sub character 개수 (제한 적용)
    $subCharactersToCreate = [Math]::Min($requestedSubCharacterCount, $remainingPositions)
    
    Write-PSDLog "INFO" "Character creation plan - Main: $mainCharactersToCreate/$totalMachines, Sub: $subCharactersToCreate/$requestedSubCharacterCount (Available positions: $($availableFacePositions.TotalPositions))"
    
    if ($subCharactersToCreate -lt $requestedSubCharacterCount) {
        Write-PSDLog "WARN" "Sub character count reduced from $requestedSubCharacterCount to $subCharactersToCreate due to face position limits"
    }
    
    for ($i = 0; $i -lt $machineIdArray.Count; $i++) {
        $machineId = $machineIdArray[$i]
        $gNumber = $Config_MachineGroupFormat -f ($i + 1)  # g01, g02, ...
        
        Write-PSDLog "INFO" "Processing machine $machineId as $gNumber"
        
        $machineBasePath = Join-Path $Config_MachineDataBaseDir $machineId
        
        try {
            # ===== Character 이미지 복사 =====
            $charactersPath = Join-Path $machineBasePath "characters"
            $charImages = Get-ChildItem $charactersPath -Filter "*.png" -File
            
            if ($charImages.Count -gt 0) {
                # ===== Main Character 생성 (제한된 개수만) =====
                if ($i -lt $mainCharactersToCreate) {
                    $selectedChar = Get-UniqueRandomFile $charImages $usedFiles "characters_main_$machineId"
                    
                    # 원본 파일명에서 얼굴 좌표 정보 추출
                    $faceCoords = Extract-FaceCoordinatesFromFilename $selectedChar.Name
                    if ($faceCoords) {
                        # 얼굴 좌표 정보를 포함한 파일명으로 복사
                        $destFileName = "chara_main_${gNumber}_1-$($faceCoords.FaceX)-$($faceCoords.FaceY)-$($faceCoords.FaceWidth)-$($faceCoords.FaceHeight).png"
                        Write-PSDLog "DEBUG" "Preserving face coordinates in filename: $destFileName"
                    } else {
                        # 얼굴 좌표 정보가 없으면 기본 패턴 사용
                        $destFileName = $Config_FileNamePatterns.CharacterMain -f $gNumber
                        Write-PSDLog "DEBUG" "No face coordinates found, using default pattern: $destFileName"
                    }
                    
                    $destPath = Join-Path $workingPath $destFileName
                    Copy-Item $selectedChar.FullName -Destination $destPath -Force
                    Write-PSDLog "INFO" "Main Character created: $($selectedChar.Name) -> $destFileName"
                } else {
                    Write-PSDLog "INFO" "Skipping main character creation for machine $machineId due to face position limits (created: $mainCharactersToCreate/$totalMachines)"
                }
                
                # ===== Sub Characters 생성 (전체 제한 적용) =====
                # 각 머신별로 균등하게 sub character를 분배
                $subCharPerMachine = if ($totalMachines -gt 0) { [Math]::Floor($subCharactersToCreate / $totalMachines) } else { 0 }
                $remainingSubChars = $subCharactersToCreate - ($subCharPerMachine * $totalMachines)
                
                # 현재 머신의 sub character 개수 계산
                $currentMachineSubCount = $subCharPerMachine
                if ($i -lt $remainingSubChars) {
                    $currentMachineSubCount++  # 나머지를 앞쪽 머신들에 분배
                }
                
                # ===== Sub Characters 생성 =====
                if ($currentMachineSubCount -gt 0) {
                    Write-PSDLog "INFO" "Creating $currentMachineSubCount sub character(s) for machine $machineId ($gNumber)"
                    
                    for ($subIndex = 1; $subIndex -le $currentMachineSubCount; $subIndex++) {
                        # 가능하면 다른 이미지 선택, 부족하면 중복 허용
                        $selectedSubChar = Get-UniqueRandomFile $charImages $usedFiles "characters_sub_${machineId}_$subIndex"
                        
                        # 원본 파일명에서 얼굴 좌표 정보 추출
                        $subFaceCoords = Extract-FaceCoordinatesFromFilename $selectedSubChar.Name
                        if ($subFaceCoords) {
                            # 얼굴 좌표 정보를 포함한 파일명으로 복사
                            $subDestFileName = "chara_sub_${gNumber}_${subIndex}-$($subFaceCoords.FaceX)-$($subFaceCoords.FaceY)-$($subFaceCoords.FaceWidth)-$($subFaceCoords.FaceHeight).png"
                            Write-PSDLog "DEBUG" "Preserving face coordinates in sub character filename: $subDestFileName"
                        } else {
                            # 얼굴 좌표 정보가 없으면 기본 패턴 사용
                            $subDestFileName = "chara_sub_${gNumber}_${subIndex}.png"
                            Write-PSDLog "DEBUG" "No face coordinates found, using default pattern: $subDestFileName"
                        }
                        
                        $subDestPath = Join-Path $workingPath $subDestFileName
                        Copy-Item $selectedSubChar.FullName -Destination $subDestPath -Force
                        Write-PSDLog "DEBUG" "Sub Character $subIndex : $($selectedSubChar.Name) -> $subDestFileName"
                    }
                } else {
                    Write-PSDLog "DEBUG" "No sub characters needed for machine $machineId (limited by face positions)"
                }
            } else {
                Write-PSDLog "WARN" "No character images found for machine $machineId"
            }
            
            # ===== Machine 이미지 복사 (크기별 분류) =====
            $machinePath = Join-Path $machineBasePath "machine"
            $machineImages = Get-ChildItem $machinePath -Filter "*.png" -File
            
            # 파일 크기로 분류 (1MB 기준)
            $largeImages = $machineImages | Where-Object { $_.Length -ge $Config_MachineSizeThreshold }
            $smallImages = $machineImages | Where-Object { $_.Length -lt $Config_MachineSizeThreshold }
            
            Write-PSDLog "DEBUG" "Machine $machineId : $($largeImages.Count) large, $($smallImages.Count) small images"
            
            # Machine Main (대형 이미지)
            if ($largeImages.Count -gt 0) {
                $selectedLarge = Get-UniqueRandomFile $largeImages $usedFiles "machine_large_$machineId"
                $destPath = Join-Path $workingPath ($Config_FileNamePatterns.MachineMain -f $gNumber)
                Copy-Item $selectedLarge.FullName -Destination $destPath -Force
                Write-PSDLog "DEBUG" "Machine Main: $($selectedLarge.Name) -> $destPath"
            } else {
                Write-PSDLog "WARN" "No large machine images found for machine $machineId"
            }
            
            # Machine Frame (소형 이미지)
            if ($smallImages.Count -gt 0) {
                $selectedSmall = Get-UniqueRandomFile $smallImages $usedFiles "machine_small_$machineId"
                $destPath = Join-Path $workingPath ($Config_FileNamePatterns.MachineFrame -f $gNumber)
                Copy-Item $selectedSmall.FullName -Destination $destPath -Force
                Write-PSDLog "DEBUG" "Machine Frame: $($selectedSmall.Name) -> $destPath"
            } else {
                Write-PSDLog "WARN" "No small machine images found for machine $machineId"
            }
            
            # ===== Icon 이미지 복사 =====
            $iconPath = Join-Path $machineBasePath "icon"
            $iconImages = Get-ChildItem $iconPath -Filter "*.png" -File
            
            Write-PSDLog "DEBUG" "Machine $machineId : $($iconImages.Count) icon images available"
            
            # Icon 1
            if ($iconImages.Count -gt 0) {
                $selectedIcon1 = Get-UniqueRandomFile $iconImages $usedFiles "icon_${machineId}_1"
                $destPath = Join-Path $workingPath ($Config_FileNamePatterns.MachineIcon1 -f $gNumber)
                Copy-Item $selectedIcon1.FullName -Destination $destPath -Force
                Write-PSDLog "DEBUG" "Machine Icon 1: $($selectedIcon1.Name) -> $destPath"
            }
            
            # Icon 2 (다른 파일 선택 시도)
            if ($iconImages.Count -gt 1) {
                $selectedIcon2 = Get-UniqueRandomFile $iconImages $usedFiles "icon_${machineId}_2"
                $destPath = Join-Path $workingPath ($Config_FileNamePatterns.MachineIcon2 -f $gNumber)
                Copy-Item $selectedIcon2.FullName -Destination $destPath -Force
                Write-PSDLog "DEBUG" "Machine Icon 2: $($selectedIcon2.Name) -> $destPath"
            } elseif ($iconImages.Count -eq 1) {
                # 하나뿐이면 동일한 파일 복사
                $destPath = Join-Path $workingPath ($Config_FileNamePatterns.MachineIcon2 -f $gNumber)
                Copy-Item $iconImages[0].FullName -Destination $destPath -Force
                Write-PSDLog "DEBUG" "Machine Icon 2: $($iconImages[0].Name) -> $destPath (duplicate)"
            } else {
                Write-PSDLog "WARN" "No icon images found for machine $machineId"
            }
            
            # ===== Machine Name 복사 =====
            $machineNameCopied = $false
            foreach ($nameFile in $Config_MachineNameFiles) {
                $nameFilePath = Join-Path $machineBasePath $nameFile
                if (Test-Path $nameFilePath) {
                    $destPath = Join-Path $workingPath ($Config_FileNamePatterns.MachineName -f $gNumber)
                    
                    if ($nameFile.EndsWith(".png")) {
                        # PNG 파일은 직접 복사
                        Copy-Item $nameFilePath -Destination $destPath -Force
                        Write-PSDLog "DEBUG" "Machine Name: $nameFile -> $destPath"
                        $machineNameCopied = $true
                        break
                    } elseif ($nameFile.EndsWith(".txt")) {
                        # TXT 파일은 향후 이미지 변환 구현 예정
                        Write-PSDLog "WARN" "Text to image conversion not implemented yet: $nameFilePath"
                        # TODO: 텍스트를 이미지로 변환하는 로직 구현
                    }
                }
            }
            
            if (-not $machineNameCopied) {
                Write-PSDLog "WARN" "No machine name file found for machine $machineId"
            }
            
            Write-PSDLog "INFO" "Machine $machineId ($gNumber) processing completed"
            
        } catch {
            throw "Failed to copy machine data for machine $machineId : $($_.Exception.Message)"
        }
    }
    
    Write-PSDLog "INFO" "All machine data copied successfully"
}

# ================================================================================
# [5/5] PSD 처리 함수 (Smart Object 처리 로직 포함)
# ================================================================================

# ================================================================================
# [5/5] PSD 처리 함수 (Smart Object 처리 로직 포함)
# ================================================================================

function Bake-PSD {
    <#
    .SYNOPSIS
        직접 레이어 교체 방식으로 PSD 파일을 처리합니다.
    
    .PARAMETER workingPath
        작업 디렉토리 경로
    .PARAMETER posterRecord
        poster.csv에서 읽은 해당 UUID의 레코드 데이터 (PSCustomObject 또는 hashtable)
    .PARAMETER psdUuid
        PSD 파일의 UUID
    .PARAMETER machineIds
        머신 ID 배열
    
    .OUTPUTS
        [string] 처리된 PSD 파일의 전체 경로
    #>
    
    param(
        [string]$workingPath,
        $posterRecord,
        [string]$psdUuid,
        [int[]]$machineIds
    )
    
    Write-PSDLog "DEBUG" "Starting PSD processing with Aspose.PSD"
    
    # 작업 디렉토리에서 PSD 파일 찾기
    $psdFiles = Get-ChildItem $workingPath -Filter "*.psd" -File
    
    if ($psdFiles.Count -eq 0) {
        throw "No PSD file found in working directory: $workingPath"
    }
    
    if ($psdFiles.Count -gt 1) {
        Write-PSDLog "WARN" "Multiple PSD files found, using the first one: $($psdFiles[0].Name)"
    }
    
    $psdFile = $psdFiles[0]
    Write-PSDLog "INFO" "Processing PSD file: $($psdFile.Name)"
    Write-PSDLog "DEBUG" "PSD file path: $($psdFile.FullName)"
    Write-PSDLog "DEBUG" "PSD file size: $(Format-FileSize $psdFile.Length)"
    
    $psdImage = $null
    $tempPsdPath = $null
    
    try {
        # 임시 파일 경로 생성 (동일 파일 덮어쓰기 방지)
        $tempPsdPath = Join-Path $workingPath "$($psdFile.BaseName)_temp$($Config_PsdExtension)"
        Write-PSDLog "DEBUG" "Temporary PSD path: $tempPsdPath"
        
        # Aspose.PSD 사용 가능 여부 확인
        if (-not (Test-AsposePSDAvailability)) {
            throw "Aspose.PSD library is not available or not properly loaded"
        }
        
        # 메모리 사용량 체크 (시작 전)
        $beforeMemory = [System.GC]::GetTotalMemory($false) / 1MB
        Write-PSDLog "DEBUG" "Memory before loading: $([math]::Round($beforeMemory, 2)) MB"
        
        # Aspose.PSD로 파일 로드
        Write-PSDLog "DEBUG" "Loading PSD file with Aspose.PSD..."
        
        try {
            $psdImage = [Aspose.PSD.Image]::Load($psdFile.FullName)
            Write-PSDLog "DEBUG" "PSD Image loaded successfully"
        } catch {
            Write-PSDLog "ERROR" "Failed to load PSD file: $($_.Exception.Message)"
            Write-PSDLog "DEBUG" "Exception details: $($_.Exception.ToString())"
            throw "Failed to load PSD file: $($_.Exception.Message)"
        }
        
        if (-not $psdImage) {
            throw "PSD image is null after loading"
        }
        
        if ($psdImage -is [Aspose.PSD.FileFormats.Psd.PsdImage]) {
            Write-PSDLog "DEBUG" "PSD image cast successful"
            Write-PSDLog "DEBUG" "Image width: $($psdImage.Width), height: $($psdImage.Height)"
            Write-PSDLog "DEBUG" "Color mode: $($psdImage.ColorMode)"
            Write-PSDLog "DEBUG" "Bits per channel: $($psdImage.BitsPerChannel)"
            Write-PSDLog "DEBUG" "Layer count: $($psdImage.Layers.Count)"
            
            $afterLoadMemory = [System.GC]::GetTotalMemory($false) / 1MB
            Write-PSDLog "DEBUG" "Memory after loading: $([math]::Round($afterLoadMemory, 2)) MB"
            
            # ================================================================================
            # DIRECT LAYER REPLACEMENT PROCESSING (NEW IMPLEMENTATION)
            # ================================================================================
            Write-PSDLog "DEBUG" "Starting direct layer replacement processing..."
            
            try {
                Write-PSDLog "INFO" "Starting direct layer replacement processing for UUID: $psdUuid"
                
                # 머신 개수 계산
                $machineCount = $machineIds.Count
                Write-PSDLog "DEBUG" "Machine count: $machineCount"
                
                # 1. 캐릭터 레이어 처리 (얼굴 좌표 기반)
                Write-PSDLog "INFO" "Processing character layers..."
                Process-CharacterLayer -psdImage $psdImage -workingPath $workingPath -posterRecord $posterRecord -psdUuid $psdUuid
                
                # 2. 머신 레이어 처리 (전체 이미지 기반)
                Write-PSDLog "INFO" "Processing machine layers..."
                Process-MachineLayer -psdImage $psdImage -workingPath $workingPath -posterRecord $posterRecord -psdUuid $psdUuid -machineIds $machineIds
                
                # 3. 아이콘 레이어 처리 (전체 이미지 기반)
                Write-PSDLog "INFO" "Processing icon layers..."
                Process-IconLayer -psdImage $psdImage -workingPath $workingPath -posterRecord $posterRecord -psdUuid $psdUuid -machineIds $machineIds
                
                Write-PSDLog "INFO" "Direct layer replacement processing completed successfully"
               
            } catch {
                Write-PSDLog "ERROR" "Direct layer replacement processing failed: $($_.Exception.Message)"
                Write-PSDLog "DEBUG" "Exception details: $($_.Exception.ToString())"
                # Continue with Smart Object processing as fallback
                throw
            }
            
            # PSD 저장 옵션 설정
            $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
            $saveOptions.CompressionMethod = if ($Config_EnablePsdCompression) { 
                Write-PSDLog "DEBUG" "Using RLE compression"
                [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE 
            } else { 
                Write-PSDLog "DEBUG" "Using Raw compression (no compression)"
                [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw 
            }
            
            Write-PSDLog "DEBUG" "Save options configured successfully"
            
            # 임시 파일로 저장 시도
            Write-PSDLog "DEBUG" "Attempting to save to temporary file: $tempPsdPath"
            
            try {
                $psdImage.Save($tempPsdPath, $saveOptions)
                Write-PSDLog "DEBUG" "Successfully saved to temporary file"
                
                if (-not (Test-Path $tempPsdPath)) {
                    throw "Temporary file was not created: $tempPsdPath"
                }
                
                $tempFileSize = (Get-Item $tempPsdPath).Length
                Write-PSDLog "DEBUG" "Temporary file size: $(Format-FileSize $tempFileSize)"
                
                # [!!! 중요 변경 사항 !!!]
                # 파일 교체(Move-Item)를 하기 전에 여기서 Dispose()를 호출하지 않습니다.
                # 리소스 해제는 모든 파일 작업이 완료된 후 finally 블록에서 수행됩니다.
                
            } catch {
                Write-PSDLog "ERROR" "Failed to save PSD file: $($_.Exception.Message)"
                Write-PSDLog "DEBUG" "Save exception details: $($_.Exception.ToString())"
                
                if ($Config_EnablePsdCompression) {
                    Write-PSDLog "WARN" "Retrying without compression..."
                    try {
                        $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw
                        $psdImage.Save($tempPsdPath, $saveOptions)
                        Write-PSDLog "INFO" "PSD file saved successfully without compression (retry)"
                    } catch {
                        Write-PSDLog "ERROR" "Retry without compression also failed: $($_.Exception.Message)"
                        throw "Failed to save PSD file even without compression: $($_.Exception.Message)"
                    }
                } else {
                    throw "Failed to save PSD file: $($_.Exception.Message)"
                }
            }

            # 임시 파일이 성공적으로 생성되었다면, 원본 파일을 교체합니다.
            if (Test-Path $tempPsdPath) {
                 # 원본 파일을 닫기 위해 Dispose()를 호출해야 안전하게 삭제/이동할 수 있습니다.
                 # 이 작업은 finally 블록으로 이동하여 일관성을 유지합니다.
            } else {
                throw "PSD save operation did not produce a file."
            }

        } else {
            throw "Failed to load as PSD image. Actual type: $($psdImage.GetType().FullName)"
        }
        
    } catch {
        Write-PSDLog "ERROR" "PSD processing failed: $($_.Exception.Message)"
        Write-PSDLog "DEBUG" "Full exception: $($_.Exception.ToString())"
        throw ($Config_ErrorMessages.PsdProcessingFailed -f $_.Exception.Message)
        
    } finally {
        # [!!! 중요 변경 사항 !!!]
        # 모든 try-catch 블록이 끝난 후, 항상 이 finally 블록이 실행됩니다.
        # 여기서 리소스를 해제하는 것이 가장 안전합니다.
        
        # Aspose.PSD 이미지 객체 리소스 해제
        if ($psdImage) {
            try {
                $psdImage.Dispose()
                Write-PSDLog "DEBUG" "PSD image resources disposed in finally block"
            } catch {
                Write-PSDLog "WARN" "Failed to dispose PSD image resources in finally block: $($_.Exception.Message)"
            }
        }

        # 임시 파일이 생성되었고, 원본 위치로 아직 이동되지 않았다면 이동/정리합니다.
        if ($tempPsdPath -and (Test-Path $tempPsdPath)) {
            try {
                # 원본 파일을 삭제하고 임시 파일을 최종 파일명으로 이동
                if (Test-Path $psdFile.FullName) {
                    Remove-Item $psdFile.FullName -Force
                }
                Move-Item $tempPsdPath -Destination $psdFile.FullName -Force
                Write-PSDLog "INFO" "PSD file processed and saved successfully to $($psdFile.FullName)"
            } catch {
                Write-PSDLog "ERROR" "Failed to move temporary file to final destination: $($_.Exception.Message)"
                # 임시 파일 정리 시도
                Remove-Item $tempPsdPath -Force -ErrorAction SilentlyContinue
            }
        }
        
        # 메모리 정리 강제 수행
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        [System.GC]::Collect()
        
        $finalMemory = [System.GC]::GetTotalMemory($false) / 1MB
        Write-PSDLog "DEBUG" "Memory after cleanup: $([math]::Round($finalMemory, 2)) MB"
    }
    
    return $psdFile.FullName
}

# ================================================================================
# NEW HELPER FUNCTIONS FOR DIRECT LAYER REPLACEMENT
# ================================================================================

# Global variable to store machine ID to sequential number mapping
$Global:MachineSequentialMapping = @{}

function Initialize-MachineSequentialMapping {
    <#
    .SYNOPSIS
        머신 ID 배열을 기반으로 G번호 → 순번 매핑 테이블을 생성합니다.
    
    .PARAMETER machineIds
        머신 ID 배열
    
    .OUTPUTS
        [void] Global 변수에 매핑 테이블 저장
    #>
    
    param(
        [int[]]$machineIds
    )
    
    Write-PSDLog "DEBUG" "Initializing machine sequential mapping"
    $Global:MachineSequentialMapping = @{}
    
    for ($i = 0; $i -lt $machineIds.Count; $i++) {
        $gNumber = $Config_MachineGroupFormat -f ($i + 1)  # g01, g02, g03, g04
        $sequentialNumber = $i + 1  # 1, 2, 3, 4
        
        $Global:MachineSequentialMapping[$gNumber] = $sequentialNumber
        Write-PSDLog "DEBUG" "Mapped: $gNumber → Sequential #$sequentialNumber (Machine ID: $($machineIds[$i]))"
    }
    
    Write-PSDLog "INFO" "Machine sequential mapping initialized with $($machineIds.Count) entries"
}

function Get-MachineSequentialNumber {
    <#
    .SYNOPSIS
        G번호를 순번으로 변환합니다.
    
    .PARAMETER gNumber
        G번호 (예: "01", "02", "03", "04")
    
    .OUTPUTS
        [int] 순번 (1, 2, 3, 4)
    #>
    
    param(
        [string]$gNumber
    )
    
    $gKey = "g$gNumber"
    if ($Global:MachineSequentialMapping.ContainsKey($gKey)) {
        return $Global:MachineSequentialMapping[$gKey]
    }
    
    Write-PSDLog "WARN" "No sequential mapping found for G number: $gNumber, defaulting to 1"
    return 1
}

function Get-AvailableFacePositions {
    <#
    .SYNOPSIS
        poster.csv에서 실제 존재하는 face position 개수를 확인합니다.
    
    .PARAMETER posterRecord
        포스터 CSV 레코드
    
    .OUTPUTS
        [hashtable] 사용 가능한 face position 정보
    #>
    
    param(
        $posterRecord
    )
    
    Write-PSDLog "DEBUG" "Checking available face positions in poster CSV"
    
    if (-not $posterRecord) {
        Write-PSDLog "WARN" "No poster record provided"
        return @{
            MainCharacterPositions = 0
            SubCharacterPositions = 0
            TotalPositions = 0
        }
    }
    
    $csvRow = $posterRecord
    $mainPositions = 0
    $subPositions = 0
    
    # Main character face positions 확인 (1_main_chara_face_xywh, 2_main_chara_face_xywh, ...)
    for ($i = 1; $i -le 10; $i++) {  # 최대 10개까지 확인
        $columnName = "${i}_main_chara_face_xywh"
        $value = $null
        
        if ($csvRow -is [hashtable]) {
            $value = $csvRow[$columnName]
        } else {
            $property = $csvRow.PSObject.Properties | Where-Object { $_.Name -eq $columnName } | Select-Object -First 1
            $value = if ($property) { $property.Value } else { $null }
        }
        
        if (-not [string]::IsNullOrEmpty($value) -and $value -ne "0" -and $value -ne "null") {
            $mainPositions++
            Write-PSDLog "DEBUG" "Found main character position $i : $value"
        }
    }
    
    # Sub character face positions 확인 (1_sub_chara_face_xywh, 2_sub_chara_face_xywh, ...)
    for ($i = 1; $i -le 10; $i++) {  # 최대 10개까지 확인
        $columnName = "${i}_sub_chara_face_xywh"
        $value = $null
        
        if ($csvRow -is [hashtable]) {
            $value = $csvRow[$columnName]
        } else {
            $property = $csvRow.PSObject.Properties | Where-Object { $_.Name -eq $columnName } | Select-Object -First 1
            $value = if ($property) { $property.Value } else { $null }
        }
        
        if (-not [string]::IsNullOrEmpty($value) -and $value -ne "0" -and $value -ne "null") {
            $subPositions++
            Write-PSDLog "DEBUG" "Found sub character position $i : $value"
        }
    }
    
    $result = @{
        MainCharacterPositions = $mainPositions
        SubCharacterPositions = $subPositions
        TotalPositions = $mainPositions + $subPositions
    }
    
    Write-PSDLog "INFO" "Available face positions - Main: $mainPositions, Sub: $subPositions, Total: $($result.TotalPositions)"
    return $result
}

function Extract-FaceCoordinatesFromFilename {
    <#
    .SYNOPSIS
        PNG 파일명에서 얼굴 좌표를 추출합니다.
    
    .PARAMETER filename
        PNG 파일명 
        지원하는 패턴:
        1. "{uuid}-{face_x}-{face_y}-{face_width}-{face_height}.png"
        2. "chara_main_g{XX}_1-{face_x}-{face_y}-{face_width}-{face_height}.png"
    
    .OUTPUTS
        [hashtable] 얼굴 좌표 정보 또는 $null
    #>
    
    param(
        [string]$filename
    )
    
    Write-PSDLog "DEBUG" "Extracting face coordinates from filename: $filename"
    
    # 패턴 1: {uuid}-{face_x}-{face_y}-{face_width}-{face_height}.png (기존 패턴)
    if ($filename -match '^([0-9a-fA-F\-]{36})-(\d+)-(\d+)-(\d+)-(\d+)\.png$') {
        $result = @{
            UUID = $matches[1]
            FaceX = [int]$matches[2]
            FaceY = [int]$matches[3]
            FaceWidth = [int]$matches[4]
            FaceHeight = [int]$matches[5]
        }
        
        Write-PSDLog "DEBUG" "Face coordinates extracted from UUID pattern: X=$($result.FaceX), Y=$($result.FaceY), W=$($result.FaceWidth), H=$($result.FaceHeight)"
        return $result
    }
    
    # 패턴 2: chara_main_g{XX}_1-{face_x}-{face_y}-{face_width}-{face_height}.png (새로운 패턴)
    if ($filename -match '^chara_main_g(\d+)_(\d+)-(\d+)-(\d+)-(\d+)-(\d+)\.png$') {
        $result = @{
            UUID = $null  # UUID는 새 패턴에서는 없음
            GNumber = $matches[1]
            FileNumber = [int]$matches[2]
            FaceX = [int]$matches[3]
            FaceY = [int]$matches[4]
            FaceWidth = [int]$matches[5]
            FaceHeight = [int]$matches[6]
        }
        
        Write-PSDLog "DEBUG" "Face coordinates extracted from character pattern: G=$($result.GNumber), X=$($result.FaceX), Y=$($result.FaceY), W=$($result.FaceWidth), H=$($result.FaceHeight)"
        return $result
    }
    
    Write-PSDLog "DEBUG" "No face coordinates found in filename"
    return $null
}

function Load-PosterCSVData {
    <#
    .SYNOPSIS
        d:\poster.csv에서 캔버스 위치 데이터를 로드합니다.
    
    .PARAMETER csvPath
        CSV 파일 경로 (기본값: "d:\poster.csv")
    
    .OUTPUTS
        [hashtable] UUID를 키로 하는 포스터 데이터
    #>
    
    param(
        [string]$csvPath = "d:\poster.csv"
    )
    
    Write-PSDLog "DEBUG" "Loading poster CSV data from: $csvPath"
    
    if (-not (Test-Path $csvPath)) {
        Write-PSDLog "ERROR" "Poster CSV file not found: $csvPath"
        return @{}
    }
    
    try {
        $csv = Import-Csv -Path $csvPath -Encoding UTF8
        $posterData = @{}
        
        foreach ($row in $csv) {
            $uuid = ""
            if ($row.FileName) {
                $uuid = [System.IO.Path]::GetFileNameWithoutExtension($row.FileName)
            }
            
            if ($uuid) {
                $posterData[$uuid] = $row
                # Write-PSDLog "DEBUG" "Loaded poster data for UUID: $uuid"
            }
        }
        
        Write-PSDLog "INFO" "Loaded poster CSV data for $($posterData.Count) UUIDs"
        return $posterData
        
    } catch {
        Write-PSDLog "ERROR" "Failed to load poster CSV: $($_.Exception.Message)"
        return @{}
    }
}

function Parse-XYWHString {
    <#
    .SYNOPSIS
        "x, y, width, height" 형식의 문자열을 파싱합니다.
    
    .PARAMETER xywhString
        좌표 문자열 (예: "711, 1625, 1007, 1539")
    
    .OUTPUTS
        [Aspose.PSD.Rectangle] 사각형 객체 또는 $null
    #>
    
    param(
        [string]$xywhString
    )
    
    if ([string]::IsNullOrEmpty($xywhString)) {
        return $null
    }
    
    try {
        $parts = $xywhString -split ',' | ForEach-Object { [int]$_.Trim() }
        if ($parts.Count -eq 4) {
            return New-Object Aspose.PSD.Rectangle($parts[0], $parts[1], $parts[2], $parts[3])
        }
    } catch {
        Write-PSDLog "WARN" "Failed to parse XYWH string: $xywhString"
    }
    
    return $null
}

function Calculate-ScaleAndPosition {
    <#
    .SYNOPSIS
        스케일링과 위치를 계산합니다.
    
    .PARAMETER sourceRect
        소스 이미지의 기준 사각형
    .PARAMETER targetRect
        타겟 캔버스의 목표 사각형
    .PARAMETER imageSize
        이미지의 전체 크기
    
    .OUTPUTS
        [hashtable] 스케일 비율과 최종 위치 정보
    #>
    
    param(
        [Aspose.PSD.Rectangle]$sourceRect,
        [Aspose.PSD.Rectangle]$targetRect,
        [System.Drawing.Size]$imageSize
    )
    
    # 스케일 비율 계산 (너비 기준)
    $scaleRatio = $targetRect.Width / $sourceRect.Width
    
    # 리사이즈된 이미지 크기
    $newWidth = [int]($imageSize.Width * $scaleRatio)
    $newHeight = [int]($imageSize.Height * $scaleRatio)
    
    # 리사이즈된 이미지에서 기준점의 새로운 위치
    $newSourceX = [int]($sourceRect.X * $scaleRatio)
    $newSourceY = [int]($sourceRect.Y * $scaleRatio)
    
    # 최종 레이어 위치 계산
    $finalLeft = $targetRect.X - $newSourceX
    $finalTop = $targetRect.Y - $newSourceY
    
    return @{
        ScaleRatio = $scaleRatio
        NewWidth = $newWidth
        NewHeight = $newHeight
        FinalLeft = $finalLeft
        FinalTop = $finalTop
    }
}

function Replace-LayerWithDirectContent {
    <#
    .SYNOPSIS
        레이어의 내용을 직접 교체합니다.
    
    .PARAMETER psdImage
        PSD 이미지 객체
    .PARAMETER targetLayer
        교체할 대상 레이어
    .PARAMETER imagePath
        교체할 이미지 파일 경로
    .PARAMETER calculation
        위치/크기 계산 결과
    #>
    
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$psdImage,
        [Aspose.PSD.FileFormats.Psd.Layers.Layer]$targetLayer,
        [string]$imagePath,
        $calculation
    )
    
    Write-PSDLog "DEBUG" "Replacing layer content: $($targetLayer.DisplayName) with $imagePath"
    
    $replaceImage = $null
    try {
        # 교체할 이미지 로드
        $replaceImage = [Aspose.PSD.Image]::Load($imagePath) -as [Aspose.PSD.RasterImage]
        if (-not $replaceImage) {
            throw "Failed to load replacement image as RasterImage"
        }
        
        # 이미지 리사이즈
        Write-PSDLog "DEBUG" "Resizing image from $($replaceImage.Width)x$($replaceImage.Height) to $($calculation.NewWidth)x$($calculation.NewHeight)"
        $replaceImage.Resize($calculation.NewWidth, $calculation.NewHeight)
        
        # 픽셀 데이터 가져오기
        $imageRect = New-Object Aspose.PSD.Rectangle(0, 0, $replaceImage.Width, $replaceImage.Height)
        $pixels = $replaceImage.LoadArgb32Pixels($imageRect)
        
        # 레이어 위치 및 크기 업데이트
        $targetLayer.Left = $calculation.FinalLeft
        $targetLayer.Top = $calculation.FinalTop
        $targetLayer.Right = $calculation.FinalLeft + $calculation.NewWidth
        $targetLayer.Bottom = $calculation.FinalTop + $calculation.NewHeight
        
        # 픽셀 데이터 저장
        $layerRect = New-Object Aspose.PSD.Rectangle(0, 0, $targetLayer.Width, $targetLayer.Height)
        $targetLayer.SaveArgb32Pixels($layerRect, $pixels)
        
        Write-PSDLog "DEBUG" "Layer content replacement completed successfully"
        
    } catch {
        Write-PSDLog "ERROR" "Failed to replace layer content: $($_.Exception.Message)"
        throw
    } finally {
        if ($replaceImage) {
            $replaceImage.Dispose()
        }
    }
}

function Process-CharacterLayer {
    <#
    .SYNOPSIS
        캐릭터 레이어를 처리합니다 (얼굴 좌표 기반).
    
    .PARAMETER psdImage
        PSD 이미지 객체
    .PARAMETER workingPath
        작업 디렉토리 경로
    .PARAMETER posterRecord
        포스터 CSV 데이터 (PSCustomObject 또는 hashtable)
    .PARAMETER psdUuid
        PSD 파일의 UUID
    #>
    
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$psdImage,
        [string]$workingPath,
        $posterRecord,
        [string]$psdUuid
    )
    
    Write-PSDLog "DEBUG" "Processing character layers"
    
    # ===== 메인 캐릭터 처리 =====
    Write-PSDLog "DEBUG" "Processing main character layers"
    $mainCharFiles = Get-ChildItem $workingPath -Filter "chara_main_g*.png"
    
    foreach ($charFile in $mainCharFiles) {
        try {
            Write-PSDLog "DEBUG" "Processing character file: $($charFile.Name)"
            
            # 파일명에서 얼굴 좌표 추출
            $faceCoords = Extract-FaceCoordinatesFromFilename $charFile.Name
            if (-not $faceCoords) {
                Write-PSDLog "WARN" "No face coordinates found in character file: $($charFile.Name)"
                continue
            }
            
            # 대응하는 레이어 찾기 (예: chara_main_g01_1.png -> chara_main_g01 #1)
            # 더 정확한 G번호 추출 (전체 파일명 패턴 매칭)
            $gNumber = $null
            if ($charFile.Name -match '^chara_main_g(\d+)_\d+') {
                $gNumber = $matches[1]
                Write-PSDLog "DEBUG" "Extracted G number '$gNumber' from filename: $($charFile.Name)"
            } else {
                Write-PSDLog "WARN" "Could not extract G number from filename: $($charFile.Name), using fallback"
                $gNumber = "01"  # 기본값
            }
            
            Write-PSDLog "DEBUG" "Processing character file: $($charFile.Name) -> G number: $gNumber"
            
            $layerName = "chara_main_g$gNumber #1"
            Write-PSDLog "DEBUG" "Looking for target layer: $layerName"
            
            $targetLayer = $psdImage.Layers | Where-Object { $_.DisplayName -eq $layerName } | Select-Object -First 1
            if (-not $targetLayer) {
                Write-PSDLog "WARN" "Target layer not found: $layerName"
                Write-PSDLog "DEBUG" "Available layer names: $($psdImage.Layers | ForEach-Object { $_.DisplayName } | Sort-Object)"
                continue
            }
            
            Write-PSDLog "DEBUG" "Found target layer: $layerName"
            
            # CSV에서 얼굴 목표 위치 가져오기
            if (-not $posterRecord) {
                Write-PSDLog "WARN" "No poster record provided"
                continue
            }
            
            $csvRow = $posterRecord
            
            # Sequential mapping 사용하여 CSV 컬럼명 생성
            $sequentialNumber = Get-MachineSequentialNumber $gNumber
            $csvColumnName = "${sequentialNumber}_main_chara_face_xywh"
            Write-PSDLog "DEBUG" "Looking for CSV column: $csvColumnName (G number: $gNumber -> Sequential number: $sequentialNumber)"
            
            $faceTargetRect = $null
            if ($csvRow -is [hashtable]) {
                $faceTargetString = $csvRow[$csvColumnName]
            } else {
                # PSCustomObject case
                $property = $csvRow.PSObject.Properties | Where-Object { $_.Name -eq $csvColumnName } | Select-Object -First 1
                $faceTargetString = if ($property) { $property.Value } else { $null }
            }
            
            Write-PSDLog "DEBUG" "Face target position (CSV): $csvColumnName = $faceTargetString"
            $faceTargetRect = Parse-XYWHString $faceTargetString
            if (-not $faceTargetRect) {
                Write-PSDLog "WARN" "No face target position found in CSV for UUID: $psdUuid, Column: $csvColumnName"
                Write-PSDLog "DEBUG" "Available CSV columns: $(if ($csvRow -is [hashtable]) { $csvRow.Keys -join ', ' } else { ($csvRow.PSObject.Properties | ForEach-Object { $_.Name }) -join ', ' })"
                continue
            }
            
            Write-PSDLog "DEBUG" "Face target rectangle: X=$($faceTargetRect.X), Y=$($faceTargetRect.Y), W=$($faceTargetRect.Width), H=$($faceTargetRect.Height)"
            
            # 스케일 및 위치 계산
            $sourceRect = New-Object Aspose.PSD.Rectangle($faceCoords.FaceX, $faceCoords.FaceY, $faceCoords.FaceWidth, $faceCoords.FaceHeight)
            Write-PSDLog "DEBUG" "Source face rectangle: X=$($sourceRect.X), Y=$($sourceRect.Y), W=$($sourceRect.Width), H=$($sourceRect.Height)"
            
            # 이미지 크기 가져오기 (Dispose 처리 포함)
            $tempImage = [System.Drawing.Image]::FromFile($charFile.FullName)
            $imageSize = New-Object System.Drawing.Size($tempImage.Width, $tempImage.Height)
            $tempImage.Dispose()
            
            Write-PSDLog "DEBUG" "Image size: W=$($imageSize.Width), H=$($imageSize.Height)"
            
            $calculation = Calculate-ScaleAndPosition $sourceRect $faceTargetRect $imageSize
            
            Write-PSDLog "DEBUG" "Scale calculation: Scale=$([math]::Round($calculation.ScaleRatio, 3)), NewSize=$($calculation.NewWidth)x$($calculation.NewHeight), FinalPos=$($calculation.FinalLeft),$($calculation.FinalTop)"
            
            # 레이어 내용 교체
            Replace-LayerWithDirectContent $psdImage $targetLayer $charFile.FullName $calculation
            
            Write-PSDLog "INFO" "Character layer processed successfully: $layerName (G$gNumber -> Face $([int]$gNumber))"
            
        } catch {
            Write-PSDLog "ERROR" "Failed to process character file $($charFile.Name): $($_.Exception.Message)"
        }
    }
    
    # ===== 서브 캐릭터 처리 =====
    Write-PSDLog "DEBUG" "Processing sub character layers"
    $subCharFiles = Get-ChildItem $workingPath -Filter "chara_sub_g*.png"
    
    foreach ($subCharFile in $subCharFiles) {
        try {
            Write-PSDLog "DEBUG" "Processing sub character file: $($subCharFile.Name)"
            
            # 파일명에서 얼굴 좌표 및 그룹/서브 번호 추출
            # 패턴: chara_sub_g01_1-978-1123-599-599.png
            if ($subCharFile.Name -match '^chara_sub_g(\d+)_(\d+)-(\d+)-(\d+)-(\d+)-(\d+)\.png$') {
                $gNumber = $matches[1]
                $subNumber = $matches[2]
                $faceCoords = @{
                    GNumber = $gNumber
                    SubNumber = [int]$subNumber
                    FaceX = [int]$matches[3]
                    FaceY = [int]$matches[4]
                    FaceWidth = [int]$matches[5]
                    FaceHeight = [int]$matches[6]
                }
                
                Write-PSDLog "DEBUG" "Sub character coordinates: G=$gNumber, Sub=$subNumber, X=$($faceCoords.FaceX), Y=$($faceCoords.FaceY), W=$($faceCoords.FaceWidth), H=$($faceCoords.FaceHeight)"
            } else {
                Write-PSDLog "WARN" "No face coordinates found in sub character file: $($subCharFile.Name)"
                continue
            }
            
            # 대응하는 레이어 찾기 (예: chara_sub_g01_1.png -> chara_sub_g01 #1)
            $layerName = "chara_sub_g$gNumber #$subNumber"
            
            $targetLayer = $psdImage.Layers | Where-Object { $_.DisplayName -eq $layerName } | Select-Object -First 1
            if (-not $targetLayer) {
                Write-PSDLog "WARN" "Target sub character layer not found: $layerName"
                continue
            }
            
            # CSV에서 서브 캐릭터의 얼굴 목표 위치 가져오기
            if (-not $posterRecord) {
                Write-PSDLog "WARN" "No poster record provided for sub character"
                continue
            }
            
            $csvRow = $posterRecord
            
            # CSV 컬럼명: {sub_number}_sub_chara_face_xywh
            $csvColumnName = "${subNumber}_sub_chara_face_xywh"
            Write-PSDLog "DEBUG" "Looking for CSV column: $csvColumnName"
            
            $subFaceTargetRect = $null
            if ($csvRow -is [hashtable]) {
                $subFaceTargetRect = Parse-XYWHString $csvRow[$csvColumnName]
            } else {
                # PSCustomObject case
                $property = $csvRow.PSObject.Properties | Where-Object { $_.Name -eq $csvColumnName } | Select-Object -First 1
                if ($property) {
                    $subFaceTargetRect = Parse-XYWHString $property.Value
                }
            }
            
            if (-not $subFaceTargetRect) {
                Write-PSDLog "WARN" "No sub character face target position found in CSV for column: $csvColumnName"
                continue
            }
            
            Write-PSDLog "DEBUG" "Sub character face target position (CSV): $($csvColumnName) = $($subFaceTargetRect.X), $($subFaceTargetRect.Y), $($subFaceTargetRect.Width), $($subFaceTargetRect.Height)"
            
            # 스케일 및 위치 계산
            $sourceRect = New-Object Aspose.PSD.Rectangle($faceCoords.FaceX, $faceCoords.FaceY, $faceCoords.FaceWidth, $faceCoords.FaceHeight)
            
            # 이미지 크기 가져오기 (Dispose 처리 포함)
            $tempImage = [System.Drawing.Image]::FromFile($subCharFile.FullName)
            $imageSize = New-Object System.Drawing.Size($tempImage.Width, $tempImage.Height)
            $tempImage.Dispose()
            
            $calculation = Calculate-ScaleAndPosition $sourceRect $subFaceTargetRect $imageSize
            
            # 레이어 내용 교체
            Replace-LayerWithDirectContent $psdImage $targetLayer $subCharFile.FullName $calculation
            
            Write-PSDLog "INFO" "Sub character layer processed successfully: $layerName"
            
        } catch {
            Write-PSDLog "ERROR" "Failed to process sub character file $($subCharFile.Name): $($_.Exception.Message)"
        }
    }
}

function Process-MachineLayer {
    <#
    .SYNOPSIS
        머신 레이어를 처리합니다 (전체 이미지 기반).
    
    .PARAMETER psdImage
        PSD 이미지 객체
    .PARAMETER workingPath
        작업 디렉토리 경로
    .PARAMETER posterRecord
        포스터 CSV 데이터 (PSCustomObject 또는 hashtable)
    .PARAMETER psdUuid
        PSD 파일의 UUID
    .PARAMETER machineIds
        머신 ID 배열
    #>
    
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$psdImage,
        [string]$workingPath,
        $posterRecord,
        [string]$psdUuid,
        [int[]]$machineIds
    )
    
    Write-PSDLog "DEBUG" "Processing machine layers for $($machineIds.Count) machines"
    
    # 머신 파일 찾기
    $machineFiles = Get-ChildItem $workingPath -Filter "machine_main_g*.png"
    
    foreach ($machineFile in $machineFiles) {
        try {
            Write-PSDLog "DEBUG" "Processing machine file: $($machineFile.Name)"
            
            # G 번호 추출
            $gNumber = if ($machineFile.Name -match 'g(\d+)') { $matches[1] } else { "01" }
            $layerName = "machine_main_g$gNumber #1"
            
            $targetLayer = $psdImage.Layers | Where-Object { $_.DisplayName -eq $layerName } | Select-Object -First 1
            if (-not $targetLayer) {
                Write-PSDLog "WARN" "Target machine layer not found: $layerName"
                continue
            }
            
            # CSV에서 머신 목표 위치 가져오기
            if (-not $posterRecord) {
                Write-PSDLog "WARN" "No poster record provided"
                continue
            }
            
            $csvRow = $posterRecord
            
            # Sequential mapping 사용하여 CSV 컬럼명 생성
            $sequentialNumber = Get-MachineSequentialNumber $gNumber
            $csvColumnName = "${sequentialNumber}_machine_xywh"
            Write-PSDLog "DEBUG" "Looking for CSV column: $csvColumnName (G number: $gNumber -> Sequential number: $sequentialNumber)"
            
            $machineTargetString = $null
            if ($csvRow -is [hashtable]) {
                $machineTargetString = $csvRow[$csvColumnName]
            } else {
                $property = $csvRow.PSObject.Properties | Where-Object { $_.Name -eq $csvColumnName } | Select-Object -First 1
                $machineTargetString = if ($property) { $property.Value } else { $null }
            }
            
            Write-PSDLog "DEBUG" "Machine target position (CSV): $csvColumnName = $machineTargetString"
            $machineTargetRect = Parse-XYWHString $machineTargetString
            if (-not $machineTargetRect) {
                Write-PSDLog "WARN" "No machine target position found in CSV for machine $gNumber, continuing to next machine"
                continue
            }
            
            # 전체 이미지 기준으로 스케일 계산
            $tempImage = [System.Drawing.Image]::FromFile($machineFile.FullName)
            $imageSize = New-Object System.Drawing.Size($tempImage.Width, $tempImage.Height)
            $tempImage.Dispose()
            
            $sourceRect = New-Object Aspose.PSD.Rectangle(0, 0, $imageSize.Width, $imageSize.Height)
            $calculation = Calculate-ScaleAndPosition $sourceRect $machineTargetRect $imageSize
            
            # 레이어 내용 교체
            Replace-LayerWithDirectContent $psdImage $targetLayer $machineFile.FullName $calculation
            
            Write-PSDLog "INFO" "Machine layer processed successfully: $layerName"
            
        } catch {
            Write-PSDLog "ERROR" "Failed to process machine file $($machineFile.Name): $($_.Exception.Message)"
        }
    }
}

function Process-IconLayer {
    <#
    .SYNOPSIS
        아이콘 레이어를 처리합니다 (전체 이미지 기반).
    
    .PARAMETER psdImage
        PSD 이미지 객체
    .PARAMETER workingPath
        작업 디렉토리 경로
    .PARAMETER posterRecord
        포스터 CSV 데이터
    .PARAMETER psdUuid
        PSD 파일의 UUID
    .PARAMETER machineIds
        머신 ID 배열
    #>
    
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$psdImage,
        [string]$workingPath,
        $posterRecord,
        [string]$psdUuid,
        [int[]]$machineIds
    )
    
    Write-PSDLog "DEBUG" "Processing icon layers for $($machineIds.Count) machines"
    
    # 아이콘 파일 찾기
    $iconFiles = Get-ChildItem $workingPath -Filter "machine-icon*_g*.png"
    
    foreach ($iconFile in $iconFiles) {
        try {
            Write-PSDLog "DEBUG" "Processing icon file: $($iconFile.Name)"
            
            # 파일명에서 G번호와 아이콘 파일 번호 추출 (예: machine-icon_g01_1.png, machine-icon_g01_2.png)
            if ($iconFile.Name -match 'machine-icon_g(\d{2})_(\d+)\.png$') {
                $gNumber = $matches[1]        # "01", "02", etc.
                $iconFileNumber = $matches[2] # "1", "2", etc.
                
                # 레이어 이름 생성: 아이콘 파일 번호에 따라 다른 레이어 선택
                $layerName = "machine-icon_g$gNumber #$iconFileNumber"
                Write-PSDLog "DEBUG" "Looking for target layer: $layerName (G: $gNumber, Icon: $iconFileNumber)"
                
                $targetLayer = $psdImage.Layers | Where-Object { $_.DisplayName -eq $layerName } | Select-Object -First 1
                if (-not $targetLayer) {
                    Write-PSDLog "WARN" "Target icon layer not found: $layerName, continuing to next icon"
                    continue
                }
                
                # CSV에서 아이콘 목표 위치 가져오기
                if (-not $posterRecord) {
                    Write-PSDLog "WARN" "No poster record provided"
                    continue
                }
                
                $csvRow = $posterRecord
                # Sequential mapping 사용하여 CSV 컬럼명 생성
                $sequentialNumber = Get-MachineSequentialNumber $gNumber
                # 아이콘 파일 번호를 그대로 사용 (1, 2, ...)
                $csvColumnName = "${sequentialNumber}_machine_icon${iconFileNumber}_xywh"
                Write-PSDLog "DEBUG" "Looking for CSV column: $csvColumnName (G number: $gNumber -> Sequential number: $sequentialNumber, Icon file: $iconFileNumber)"
                
                $iconTargetString = $null
                if ($csvRow -is [hashtable]) {
                    $iconTargetString = $csvRow[$csvColumnName]
                } else {
                    $property = $csvRow.PSObject.Properties | Where-Object { $_.Name -eq $csvColumnName } | Select-Object -First 1
                    $iconTargetString = if ($property) { $property.Value } else { $null }
                }
                
                Write-PSDLog "DEBUG" "Icon target position (CSV): $csvColumnName = $iconTargetString"
                $iconTargetRect = Parse-XYWHString $iconTargetString
                if (-not $iconTargetRect) {
                    Write-PSDLog "WARN" "No icon target position found in CSV for icon $iconFileNumber, machine $gNumber"
                    continue
                }
                
                # 전체 이미지 기준으로 스케일 계산
                $tempImage = [System.Drawing.Image]::FromFile($iconFile.FullName)
                $imageSize = New-Object System.Drawing.Size($tempImage.Width, $tempImage.Height)
                $tempImage.Dispose()
                
                $sourceRect = New-Object Aspose.PSD.Rectangle(0, 0, $imageSize.Width, $imageSize.Height)
                $calculation = Calculate-ScaleAndPosition $sourceRect $iconTargetRect $imageSize
                
                # 레이어 내용 교체
                Replace-LayerWithDirectContent $psdImage $targetLayer $iconFile.FullName $calculation
                
                Write-PSDLog "INFO" "Icon layer processed successfully: $layerName"
            } else {
                Write-PSDLog "WARN" "Could not parse icon filename pattern: $($iconFile.Name)"
            }
            
        } catch {
            Write-PSDLog "ERROR" "Failed to process icon file $($iconFile.Name): $($_.Exception.Message)"
        }
    }
}

# ================================================================================
# 헬퍼 함수들
# ================================================================================

# Smart Object 레이어 정보를 로깅하는 헬퍼 함수
function Write-SmartObjectInfo {
    param(
        [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]$smartObjectLayer
    )
    
    Write-PSDLog "DEBUG" "=== Smart Object Info ==="
    Write-PSDLog "DEBUG" "Name: $($smartObjectLayer.Name)"
    Write-PSDLog "DEBUG" "Content Type: $($smartObjectLayer.ContentType)"
    Write-PSDLog "DEBUG" "Bounds: L=$($smartObjectLayer.Left), T=$($smartObjectLayer.Top), R=$($smartObjectLayer.Right), B=$($smartObjectLayer.Bottom)"
    
    if ($smartObjectLayer.ContentsBounds) {
        Write-PSDLog "DEBUG" "Contents Bounds: L=$($smartObjectLayer.ContentsBounds.Left), T=$($smartObjectLayer.ContentsBounds.Top), R=$($smartObjectLayer.ContentsBounds.Right), B=$($smartObjectLayer.ContentsBounds.Bottom)"
    }
    
    try {
        if (-not [string]::IsNullOrEmpty($smartObjectLayer.RelativePath)) {
            Write-PSDLog "DEBUG" "Relative Path: $($smartObjectLayer.RelativePath)"
        }
        if (-not [string]::IsNullOrEmpty($smartObjectLayer.FullPath)) {
            Write-PSDLog "DEBUG" "Full Path: $($smartObjectLayer.FullPath)"
        }
    } catch {
        Write-PSDLog "DEBUG" "Could not access path properties: $($_.Exception.Message)"
    }
    
    try {
        if ($smartObjectLayer.Contents -and $smartObjectLayer.Contents.Length -gt 0) {
            Write-PSDLog "DEBUG" "Contents Size: $(Format-FileSize $smartObjectLayer.Contents.Length)"
        }
    } catch {
        Write-PSDLog "DEBUG" "Could not access contents: $($_.Exception.Message)"
    }
    
    Write-PSDLog "DEBUG" "=========================="
}

# 중복 파일 선택 방지를 위한 고유 랜덤 파일 선택 함수
function Get-UniqueRandomFile {
    <#
    .SYNOPSIS
        중복 방지를 위해 고유한 랜덤 파일을 선택합니다.
    
    .PARAMETER files
        선택할 파일 목록
    .PARAMETER usedFiles
        이미 사용된 파일 추적용 해시테이블
    .PARAMETER category
        파일 카테고리 (로깅용)
    
    .OUTPUTS
        [System.IO.FileInfo] 선택된 파일
    #>
    
    param(
        [System.IO.FileInfo[]]$files,
        $usedFiles,
        [string]$category
    )
    
    if ($files.Count -eq 0) {
        Write-PSDLog "WARN" "No files available for category: $category"
        return $null
    }
    
    # 아직 사용되지 않은 파일들 찾기
    $availableFiles = $files | Where-Object { -not $usedFiles.ContainsKey($_.FullName) }
    
    # 모든 파일이 사용되었다면 전체에서 랜덤 선택
    if ($availableFiles.Count -eq 0) {
        Write-PSDLog "DEBUG" "All files in category '$category' have been used, selecting from all files"
        $availableFiles = $files
    }
    
    # 랜덤 선택
    $selectedFile = $availableFiles | Get-Random
    
    # 사용된 파일로 표시
    $usedFiles[$selectedFile.FullName] = $true
    
    Write-PSDLog "DEBUG" "Selected file for category '$category': $($selectedFile.Name)"
    return $selectedFile
}

# 작업 디렉토리에서 적절한 교체 파일을 찾는 함수
function Find-ReplacementFile {
    param(
        [string]$workingPath,
        [string]$originalFileName,
        [string]$smartObjectName
    )
    
    Write-PSDLog "DEBUG" "Find-ReplacementFile called with smartObjectName: '$smartObjectName'"
    
    # 1. 원본 파일명과 정확히 일치하는 파일 찾기 (originalFileName이 유효한 경우)
    if (-not [string]::IsNullOrEmpty($originalFileName)) {
        $exactMatch = Join-Path $workingPath $originalFileName
        if (Test-Path $exactMatch) {
            Write-PSDLog "DEBUG" "Found exact match for original filename: $originalFileName"
            return $exactMatch
        }
        
        # 2. 확장자만 다른 파일 찾기
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($originalFileName)
        $candidateFiles = Get-ChildItem $workingPath -Filter "$baseName.*"
        if ($candidateFiles.Count -gt 0) {
            Write-PSDLog "DEBUG" "Found file with same basename: $($candidateFiles[0].Name)"
            return $candidateFiles[0].FullName
        }
    }
    
    # 3. Smart Object 이름에서 기본 이름과 번호 추출
    # 예: "machine_main_g01 #1" -> 기본이름: "machine_main_g01", 번호: "1"
    $cleanName = ""
    $number = ""
    
    if ($smartObjectName -match '^(.+?)\s*#(\d+)$') {
        $cleanName = $matches[1].Trim()
        $number = $matches[2]
        Write-PSDLog "DEBUG" "Extracted from '$smartObjectName': cleanName='$cleanName', number='$number'"
    } else {
        $cleanName = $smartObjectName.Trim()
        $number = "1"  # 기본값
        Write-PSDLog "DEBUG" "No number found in '$smartObjectName', using cleanName='$cleanName', number='$number'"
    }
    
    # 4. 직접 매칭 시도: cleanName_number.png
    $directFileName = "${cleanName}_${number}.png"
    $directPath = Join-Path $workingPath $directFileName
    Write-PSDLog "DEBUG" "Trying direct match: $directFileName"
    
    if (Test-Path $directPath) {
        Write-PSDLog "DEBUG" "Found direct match: $directFileName"
        return $directPath
    }
    
    # 5. 하이픈을 언더스코어로 변환해서 시도 (smart-icon -> smart_icon)
    $hyphenToUnderscore = $cleanName -replace '-', '_'
    if ($hyphenToUnderscore -ne $cleanName) {
        $altFileName = "${hyphenToUnderscore}_${number}.png"
        $altPath = Join-Path $workingPath $altFileName
        Write-PSDLog "DEBUG" "Trying hyphen-to-underscore match: $altFileName"
        
        if (Test-Path $altPath) {
            Write-PSDLog "DEBUG" "Found hyphen-to-underscore match: $altFileName"
            return $altPath
        }
    }
    
    # 6. 언더스코어를 하이픈으로 변환해서 시도 (machine_main -> machine-main)
    $underscoreToHyphen = $cleanName -replace '_', '-'
    if ($underscoreToHyphen -ne $cleanName) {
        $altFileName2 = "${underscoreToHyphen}_${number}.png"
        $altPath2 = Join-Path $workingPath $altFileName2
        Write-PSDLog "DEBUG" "Trying underscore-to-hyphen match: $altFileName2"
        
        if (Test-Path $altPath2) {
            Write-PSDLog "DEBUG" "Found underscore-to-hyphen match: $altFileName2"
            return $altPath2
        }
    }
    
    # 7. 패턴 기반 검색 (더 구체적인 매칭)
    $availableFiles = Get-ChildItem $workingPath -Filter "*.png" | Where-Object {
        $_.Name -match "g[0-9][0-9]_\d+" -and $_.Name -notmatch "_temp"
    }
    
    Write-PSDLog "DEBUG" "Available PNG files in working directory: $($availableFiles.Name -join ', ')"
    
    if ($availableFiles.Count -gt 0) {
        # 이름 기반 매칭 점수 계산
        $bestMatch = $null
        $highestScore = -1
        
        foreach ($file in $availableFiles) {
            $score = 0
            $fileName = $file.BaseName.ToLower()
            $cleanNameLower = $cleanName.ToLower()
            
            # 정확한 부분 매칭 점수
            if ($fileName.Contains($cleanNameLower)) {
                $score += 20
            }
            
            # 개별 구성 요소 매칭
            $cleanNameParts = $cleanNameLower -split '[-_]'
            foreach ($part in $cleanNameParts) {
                if ($part -and $fileName.Contains($part)) {
                    $score += 5
                }
            }
            
            # 번호 매칭
            if ($fileName.EndsWith("_${number}")) {
                $score += 10
            }
            
            # 타입별 매칭 보너스
            if ($cleanNameLower.Contains("chara") -and $fileName.Contains("chara")) { $score += 8 }
            if ($cleanNameLower.Contains("machine") -and $fileName.Contains("machine")) { $score += 8 }
            if ($cleanNameLower.Contains("icon") -and $fileName.Contains("icon")) { $score += 8 }
            if ($cleanNameLower.Contains("smart") -and $fileName.Contains("smart")) { $score += 8 }
            if ($cleanNameLower.Contains("frame") -and $fileName.Contains("frame")) { $score += 8 }
            if ($cleanNameLower.Contains("name") -and $fileName.Contains("name")) { $score += 8 }
            
            Write-PSDLog "DEBUG" "File '$($file.Name)' scored: $score"
            
            if ($score > $highestScore) {
                $highestScore = $score
                $bestMatch = $file
            }
        }
        
        if ($bestMatch -and $highestScore -gt 0) {
            Write-PSDLog "DEBUG" "Selected best match: $($bestMatch.Name) with score: $highestScore"
            return $bestMatch.FullName
        }
    }
    
    # 8. 마지막으로 첫 번째 사용 가능한 파일 반환
    if ($availableFiles.Count -gt 0) {
        Write-PSDLog "DEBUG" "No good match found, using first available file: $($availableFiles[0].Name)"
        return $availableFiles[0].FullName
    }
    
    Write-PSDLog "WARN" "No replacement file found for smart object: '$smartObjectName'"
    return $null
}
