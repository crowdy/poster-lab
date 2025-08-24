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
        
        # 검증 조건: 정확히 1개의 PSD, 최소 1개의 PNG
        if ($psdCount -eq $Config_MinPsdFilesPerTemplate -and 
            $psdCount -le $Config_MaxPsdFilesPerTemplate -and
            $pngCount -ge $Config_MinPngFilesPerTemplate) {
            
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
    
    return $selectedTemplate
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
    
    .OUTPUTS
        [string] 생성된 작업 디렉토리 경로
    #>
    
    param(
        [string]$TemplatePath
    )
    
    Write-PSDLog "DEBUG" "Starting working directory preparation"
    
    if (-not $TemplatePath -or -not (Test-Path $TemplatePath)) {
        throw "Invalid template path: $TemplatePath"
    }
    
    # 작업 디렉토리명 생성
    $timestamp = Get-Date -Format $Config_TimestampFormat
    $newUuid = [System.Guid]::NewGuid().ToString()
    $workingDirName = $Config_WorkingDirNamePattern -f $timestamp, $newUuid
    $workingDir = Join-Path $Config_WorkingBaseDir $workingDirName
    
    Write-PSDLog "DEBUG" "Creating working directory: $workingDir"
    
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
                $destFileName = "$newUuid$($Config_PsdExtension)"
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
    #>
    
    param(
        [string]$workingPath,
        [string]$machineIds
    )
    
    Write-PSDLog "DEBUG" "Starting machine data copying"
    
    $machineIdArray = $machineIds -split ',' | ForEach-Object { [int]$_.Trim() }
    $usedFiles = @{}  # 중복 파일 선택 방지용
    
    Write-PSDLog "INFO" "Processing $($machineIdArray.Count) machine(s): $($machineIdArray -join ', ')"
    
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
                $selectedChar = Get-UniqueRandomFile $charImages $usedFiles "characters_$machineId"
                $destPath = Join-Path $workingPath ($Config_FileNamePatterns.CharacterMain -f $gNumber)
                Copy-Item $selectedChar.FullName -Destination $destPath -Force
                Write-PSDLog "DEBUG" "Character: $($selectedChar.Name) -> $destPath"
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
        Aspose.PSD를 사용하여 PSD 파일의 linked smart objects를 embedded로 변환합니다.
    
    .PARAMETER workingPath
        작업 디렉토리 경로
    
    .OUTPUTS
        [string] 처리된 PSD 파일의 전체 경로
    #>
    
    param(
        [string]$workingPath
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
    
    $psdImage = $null
    $tempPsdPath = $null
    
    try {
        $tempPsdPath = Join-Path $workingPath "$($psdFile.BaseName)_temp$($Config_PsdExtension)"
        
        if (-not (Test-AsposePSDAvailability)) {
            throw "Aspose.PSD library is not available or not properly loaded"
        }
        
        # Aspose.PSD로 파일 로드
        Write-PSDLog "DEBUG" "Loading PSD file: $($psdFile.FullName)"
        $psdImage = [Aspose.PSD.Image]::Load($psdFile.FullName)
        
        if (-not $psdImage) {
            throw "PSD image is null after loading"
        }
        
        if ($psdImage -is [Aspose.PSD.FileFormats.Psd.PsdImage]) {
            Write-PSDLog "DEBUG" "PSD image cast successful"
            
            # ================================================================================
            # [수정된] Smart Object 처리 로직
            # ================================================================================
            if ($Config_EmbedLinkedSmartObjects) {
                Write-PSDLog "INFO" "Smart Object processing is enabled."
                
                try {
                    $processedCount = 0
                    $smartObjectLayers = $psdImage.Layers | Where-Object { $_ -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer] }

                    Write-PSDLog "DEBUG" "Found $($smartObjectLayers.Count) Smart Object layer(s)."

                    foreach ($soLayer in $smartObjectLayers) {
                        $smartObjectLayer = [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]$soLayer
                        
                        Write-PSDLog "DEBUG" "Processing layer '$($smartObjectLayer.Name)', ContentType: $($smartObjectLayer.ContentType)"

                        if ($smartObjectLayer.ContentType -eq [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectType]::AvailableLinked) {
                            Write-PSDLog "DEBUG" "Layer '$($smartObjectLayer.Name)' is a Linked Smart Object. Attempting to embed."
                            
                            try {
                                # 교체할 로컬 파일 찾기
                                $replacementFile = Find-ReplacementFile $workingPath $smartObjectLayer.RelativePath $smartObjectLayer.Name
                                
                                if ($replacementFile -and (Test-Path $replacementFile)) {
                                    Write-PSDLog "DEBUG" "Replacement file found: '$replacementFile'"
                                    
                                    # [!!! 중요 변경 사항: 안정적인 3단계 처리 !!!]
                                    
                                    # 1단계: Smart Object의 연결 경로를 새 로컬 파일로 교체(Relink)합니다.
                                    # 이 시점에서 레이어는 여전히 '연결된' 상태입니다.
                                    $smartObjectLayer.ReplaceContents($replacementFile)
                                    Write-PSDLog "DEBUG" "Step 1/3: Re-linked Smart Object to new file."

                                    # 2단계: 새로 연결된 파일을 기반으로 PSD에 포함(Embed)시킵니다.
                                    $smartObjectLayer.EmbedLinked()
                                    Write-PSDLog "DEBUG" "Step 2/3: Converted re-linked Smart Object to embedded."

                                    # 3단계: 변경된 콘텐츠를 기반으로 레이어의 시각적 표현을 업데이트합니다.
                                    $smartObjectLayer.UpdateModifiedContent()
                                    Write-PSDLog "DEBUG" "Step 3/3: Updated layer content."
                                    
                                    $processedCount++
                                } else {
                                    Write-PSDLog "WARN" "No replacement file found for '$($smartObjectLayer.Name)'. Skipping."
                                }
                            } catch {
                                Write-PSDLog "ERROR" "Failed to process Smart Object '$($smartObjectLayer.Name)': $($_.Exception.Message)"
                                Write-PSDLog "DEBUG" "Smart Object error details: $($_.Exception.ToString())"
                            }
                        }
                    }
                    Write-PSDLog "INFO" "Smart Object processing completed. Processed $processedCount layer(s)."
                } catch {
                    Write-PSDLog "ERROR" "A critical error occurred during Smart Object processing loop: $($_.Exception.Message)"
                }
            } else {
                Write-PSDLog "INFO" "Smart Object embedding is disabled in configuration."
            }
            
            # PSD 저장 옵션 설정
            $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
            $saveOptions.CompressionMethod = if ($Config_EnablePsdCompression) { 
                [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE 
            } else { 
                [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw 
            }
            
            # 임시 파일로 저장
            Write-PSDLog "DEBUG" "Attempting to save to temporary file: $tempPsdPath"
            $psdImage.Save($tempPsdPath, $saveOptions)
            
            if (-not (Test-Path $tempPsdPath)) {
                throw "Temporary file was not created after save operation."
            }
            Write-PSDLog "DEBUG" "Successfully saved to temporary file."

        } else {
            throw "Loaded image is not a PSD image. Actual type: $($psdImage.GetType().FullName)"
        }
        
    } catch {
        Write-PSDLog "ERROR" "PSD processing failed: $($_.Exception.Message)"
        throw ($Config_ErrorMessages.PsdProcessingFailed -f $_.Exception.Message)
        
    } finally {
        # 리소스 해제
        if ($psdImage) {
            try {
                $psdImage.Dispose()
                Write-PSDLog "DEBUG" "PSD image resources disposed in finally block."
            } catch {
                Write-PSDLog "WARN" "Failed to dispose PSD image in finally block: $($_.Exception.Message)"
            }
        }

        # 파일 이동 및 정리
        if ($tempPsdPath -and (Test-Path $tempPsdPath)) {
            try {
                # 원본 파일을 삭제하고 임시 파일을 최종 파일명으로 이동
                if (Test-Path $psdFile.FullName) {
                    Remove-Item $psdFile.FullName -Force
                }
                Move-Item $tempPsdPath -Destination $psdFile.FullName -Force
                Write-PSDLog "INFO" "PSD file processed and saved successfully to '$($psdFile.FullName)'"
            } catch {
                Write-PSDLog "ERROR" "Failed to move temporary file to final destination: $($_.Exception.Message)"
                # 실패 시 임시 파일 삭제
                Remove-Item $tempPsdPath -Force -ErrorAction SilentlyContinue
            }
        }
        
        # 메모리 정리
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }
    
    return $psdFile.FullName
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
