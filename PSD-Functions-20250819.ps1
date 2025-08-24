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
# [5/5] PSD 처리 함수
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
            
            # 메모리 사용량 체크 (로드 후)
            $afterLoadMemory = [System.GC]::GetTotalMemory($false) / 1MB
            Write-PSDLog "DEBUG" "Memory after loading: $([math]::Round($afterLoadMemory, 2)) MB"
            
            # TODO: Smart Object 처리 로직 구현
            if ($Config_EmbedLinkedSmartObjects) {
                Write-PSDLog "DEBUG" "Processing smart objects (placeholder - to be implemented)"
                # TODO: Smart Object 변환 로직
                # foreach ($layer in $psdImage.Layers) {
                #     if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
                #         # Convert linked to embedded
                #     }
                # }
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
                
                # 임시 파일이 실제로 생성되었는지 확인
                if (-not (Test-Path $tempPsdPath)) {
                    throw "Temporary file was not created: $tempPsdPath"
                }
                
                $tempFileSize = (Get-Item $tempPsdPath).Length
                Write-PSDLog "DEBUG" "Temporary file size: $(Format-FileSize $tempFileSize)"
                
                # 파일 교체 전에 PSD 이미지 리소스 해제 (파일 잠금 해제)
                Write-PSDLog "DEBUG" "Disposing PSD image resources before file replacement"
                if ($psdImage) {
                    $psdImage.Dispose()
                    $psdImage = $null
                    Write-PSDLog "DEBUG" "PSD image resources disposed successfully"
                }
                
                # 임시 파일을 원본 위치로 이동
                Write-PSDLog "DEBUG" "Moving temporary file to original location"
                Remove-Item $psdFile.FullName
                Move-Item $tempPsdPath $psdFile.FullName -Force
                
                Write-PSDLog "INFO" "PSD file processed and saved successfully"
                
            } catch {
                Write-PSDLog "ERROR" "Failed to save PSD file: $($_.Exception.Message)"
                Write-PSDLog "DEBUG" "Save exception details: $($_.Exception.ToString())"
                
                # 압축 없이 재시도
                if ($Config_EnablePsdCompression) {
                    Write-PSDLog "WARN" "Retrying without compression..."
                    try {
                        $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Raw
                        $psdImage.Save($tempPsdPath, $saveOptions)
                        
                        # 파일 교체 전에 PSD 이미지 리소스 해제 (파일 잠금 해제)
                        Write-PSDLog "DEBUG" "Disposing PSD image resources before file replacement (retry)"
                        if ($psdImage) {
                            $psdImage.Dispose()
                            $psdImage = $null
                            Write-PSDLog "DEBUG" "PSD image resources disposed successfully (retry)"
                        }
                        
                        Remove-Item $psdFile.FullName
                        Move-Item $tempPsdPath $psdFile.FullName -Force
                        Write-PSDLog "INFO" "PSD file saved successfully without compression"
                    } catch {
                        Write-PSDLog "ERROR" "Retry without compression also failed: $($_.Exception.Message)"
                        throw "Failed to save PSD file even without compression: $($_.Exception.Message)"
                    }
                } else {
                    throw "Failed to save PSD file: $($_.Exception.Message)"
                }
            }
            
        } else {
            throw "Failed to load as PSD image. Actual type: $($psdImage.GetType().FullName)"
        }
        
    } catch {
        Write-PSDLog "ERROR" "PSD processing failed: $($_.Exception.Message)"
        Write-PSDLog "DEBUG" "Full exception: $($_.Exception.ToString())"
        throw ($Config_ErrorMessages.PsdProcessingFailed -f $_.Exception.Message)
        
    } finally {
        # 임시 파일 정리
        if ($tempPsdPath -and (Test-Path $tempPsdPath)) {
            try {
                Remove-Item $tempPsdPath -Force
                Write-PSDLog "DEBUG" "Temporary file cleaned up: $tempPsdPath"
            } catch {
                Write-PSDLog "WARN" "Failed to clean up temporary file: $tempPsdPath"
            }
        }
        
        # 리소스 해제 (이미 해제되지 않은 경우에만)
        if ($psdImage) {
            try {
                $psdImage.Dispose()
                Write-PSDLog "DEBUG" "PSD image resources disposed in finally block"
            } catch {
                Write-PSDLog "WARN" "Failed to dispose PSD image resources in finally block: $($_.Exception.Message)"
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
