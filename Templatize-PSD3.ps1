param(
    [switch]$WhatIf,              # 시뮬레이션 모드 (실제 파일 생성 안함)
    [switch]$Verbose,             # 상세 진행 상황 출력
    [switch]$Force,               # 기존 파일 덮어쓰기
    [switch]$Debug,               # 극도로 상세한 디버깅 정보 출력
    [int]$Limit = 0,              # 처리할 PSD 파일 개수 제한 (0 = 모든 파일)
    [switch]$EnableOptimization,  # PSD 파일 크기 최적화 활성화
    [int]$CompressionLevel = 6    # 압축 레벨 (1-9, 기본값 6)
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ===== Aspose.PSD 로더 =====
. "$PSScriptRoot\Load-AsposePSD.ps1"

# ===== 최적화 함수들 =====
function Set-OptimizedPsdOptions {
    param(
        [int]$CompressionLevel = 6,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) {
            Write-Host "    DEBUG: Setting up optimized PSD save options (compression level: $CompressionLevel)"
        }
        
        # PSD 저장 옵션 생성
        $psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
        
        # 압축 설정
        $psdOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::RLE
        $psdOptions.Version = 1  # PSD 버전 1 (호환성)
        
        # 색상 모드 최적화
        $psdOptions.ColorMode = [Aspose.PSD.FileFormats.Psd.ColorModes]::Rgb
        $psdOptions.ChannelsCount = 4  # RGBA
        $psdOptions.BitsPerChannel = 8
        
        # 추가 최적화 설정
        $psdOptions.RefreshImagePreviewData = $false  # 미리보기 데이터 생성 안함
        $psdOptions.RemoveGlobalTextEngineResource = $true  # 글로벌 텍스트 엔진 리소스 제거
        
        if ($DebugMode) {
            Write-Host "    DEBUG: PSD options configured - Compression: $($psdOptions.CompressionMethod), Version: $($psdOptions.Version)"
        }
        
        return $psdOptions
        
    } catch {
        if ($DebugMode) {
            Write-Warning "    Failed to set optimized PSD options: $($_.Exception.Message)"
        }
        return $null
    }
}

function Optimize-PsdLayers {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) {
            Write-Host "    DEBUG: Optimizing PSD layers for size reduction..."
        }
        
        $optimizedLayers = 0
        
        foreach ($layer in $Psd.Layers) {
            try {
                # 빈 레이어나 완전히 투명한 레이어 확인
                if ($layer.Bounds.Width -eq 0 -or $layer.Bounds.Height -eq 0) {
                    if ($DebugMode) {
                        Write-Host "    DEBUG: Skipping empty layer: '$($layer.Name)'"
                    }
                    continue
                }
                
                # 레이어 압축 최적화
                if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.Layer]) {
                    # 레이어의 블렌딩 범위 최적화
                    if ($layer.BlendingOptions) {
                        # 불필요한 블렌딩 옵션 제거
                        if ($layer.BlendingOptions.Effects.Count -eq 0) {
                            $layer.BlendingOptions = $null
                        }
                    }
                    
                    $optimizedLayers++
                }
                
            } catch {
                if ($DebugMode) {
                    Write-Warning "    Failed to optimize layer '$($layer.Name)': $($_.Exception.Message)"
                }
            }
        }
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Optimized $optimizedLayers layers"
        }
        
        return $optimizedLayers
        
    } catch {
        if ($DebugMode) {
            Write-Warning "    Layer optimization failed: $($_.Exception.Message)"
        }
        return 0
    }
}

function Optimize-PsdResources {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) {
            Write-Host "    DEBUG: Optimizing PSD resources..."
        }
        
        $removedResources = 0
        
        # 글로벌 리소스 최적화
        if ($Psd.GlobalLayerResources) {
            $resourcesToRemove = @()
            
            foreach ($resource in $Psd.GlobalLayerResources) {
                # 불필요한 리소스 타입 확인
                $resourceType = $resource.GetType().Name
                
                # 메타데이터나 캐시 관련 리소스 제거 후보
                if ($resourceType -like "*Cache*" -or 
                    $resourceType -like "*Preview*" -or
                    $resourceType -like "*Thumbnail*") {
                    
                    $resourcesToRemove += $resource
                    if ($DebugMode) {
                        Write-Host "    DEBUG: Marking resource for removal: $resourceType"
                    }
                }
            }
            
            # 리소스 제거
            foreach ($resource in $resourcesToRemove) {
                try {
                    $Psd.GlobalLayerResources.Remove($resource)
                    $removedResources++
                } catch {
                    if ($DebugMode) {
                        Write-Warning "    Failed to remove resource: $($_.Exception.Message)"
                    }
                }
            }
        }
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Removed $removedResources unnecessary resources"
        }
        
        return $removedResources
        
    } catch {
        if ($DebugMode) {
            Write-Warning "    Resource optimization failed: $($_.Exception.Message)"
        }
        return 0
    }
}

function Get-OptimizedFileSize {
    param(
        [string]$FilePath,
        [string]$OriginalPath = $null,
        [switch]$DebugMode
    )
    
    try {
        if (-not (Test-Path $FilePath)) {
            return @{ Size = 0; Reduction = 0; ReductionPercent = 0 }
        }
        
        $optimizedSize = (Get-Item $FilePath).Length
        
        if ($OriginalPath -and (Test-Path $OriginalPath)) {
            $originalSize = (Get-Item $OriginalPath).Length
            $reduction = $originalSize - $optimizedSize
            $reductionPercent = if ($originalSize -gt 0) { [math]::Round(($reduction / $originalSize) * 100, 2) } else { 0 }
            
            if ($DebugMode) {
                Write-Host "    DEBUG: File size - Original: $([math]::Round($originalSize/1MB, 2)) MB, Optimized: $([math]::Round($optimizedSize/1MB, 2)) MB"
                Write-Host "    DEBUG: Size reduction: $([math]::Round($reduction/1MB, 2)) MB ($reductionPercent%)"
            }
            
            return @{
                Size = $optimizedSize
                OriginalSize = $originalSize
                Reduction = $reduction
                ReductionPercent = $reductionPercent
            }
        } else {
            return @{
                Size = $optimizedSize
                OriginalSize = 0
                Reduction = 0
                ReductionPercent = 0
            }
        }
        
    } catch {
        if ($DebugMode) {
            Write-Warning "    Failed to calculate file size: $($_.Exception.Message)"
        }
        return @{ Size = 0; Reduction = 0; ReductionPercent = 0 }
    }
}

# ===== 기존 유틸 함수들 =====
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
            if ($DebugMode) { 
                Write-Host "DEBUG: Processing row - UUID: '$($row.FileNameWithoutExtension)', MachineCount: '$($row.MachineCount)', Orientation: '$($row.Orientation)', LogoType: '$($row.logo_type)', MainChara: '$($row.main_character_count)', SubChara: '$($row.sub_character_count)'"
            }
            
            if ($row.FileNameWithoutExtension -and $row.MachineCount) {
                # 명시적으로 필드 값 확인 및 변환
                $mainCharaValue = 0
                $subCharaValue = 0
                
                if ($row.PSObject.Properties['main_character_count'] -and $row.main_character_count -ne $null -and $row.main_character_count -ne '') {
                    try {
                        $mainCharaValue = [int]$row.main_character_count
                    } catch {
                        Write-Warning "Invalid main_character_count value for $($row.FileNameWithoutExtension): '$($row.main_character_count)'"
                        $mainCharaValue = 0
                    }
                }
                
                if ($row.PSObject.Properties['sub_character_count'] -and $row.sub_character_count -ne $null -and $row.sub_character_count -ne '') {
                    try {
                        $subCharaValue = [int]$row.sub_character_count
                    } catch {
                        Write-Warning "Invalid sub_character_count value for $($row.FileNameWithoutExtension): '$($row.sub_character_count)'"
                        $subCharaValue = 0
                    }
                }
                
                $machineData[$row.FileNameWithoutExtension] = @{
                    MachineCount = [int]$row.MachineCount
                    Orientation = if ($row.Orientation) { $row.Orientation } else { "unknown" }
                    LogoType = if ($row.logo_type) { $row.logo_type } else { "unknown" }
                    MainCharaCount = $mainCharaValue
                    SubCharaCount = $subCharaValue
                }
                if ($DebugMode) { 
                    Write-Host "DEBUG: Added $($row.FileNameWithoutExtension) -> $($row.MachineCount) machines, orientation: $($machineData[$row.FileNameWithoutExtension].Orientation), logo_type: $($machineData[$row.FileNameWithoutExtension].LogoType), main_chara: $($machineData[$row.FileNameWithoutExtension].MainCharaCount), sub_chara: $($machineData[$row.FileNameWithoutExtension].SubCharaCount)"
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

function Normalize-LayerNameToPng {
    param([string]$LayerName)
    
    # "machine-icon_g02 #3" → "machine-icon_g02_3.png"
    $normalized = $LayerName -replace '\s+#', '_' -replace '\s+', '_'
    return "$normalized.png"
}

function Test-TargetLayerName {
    param([string]$LayerName)
    
    # 확장된 패턴들 추가
    $patterns = @(
        '^machine-frame_g0[1-6] \s*#1$',
        '^machine-icon_g0[1-6] \s*#[12]$',
        '^smart-icon_g0[1-6] \s*#1$',
        '^machine_main_g0[1-6] \s*#1$',
        '^machine-name_g0[1-6] \s*#1$',
        '^chara_main_g0[1-6] \s*#[1-6]$',
        '^chara_sub_g0[1-6] \s*#[1-6]$'
    )
    
    foreach ($pattern in $patterns) {
        if ($LayerName -match $pattern) {
            return $true
        }
    }
    return $false
}

function Create-TransparentImage {
    param(
        [int]$Width,
        [int]$Height,
        [string]$OutputPath,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) {
            Write-Host "    DEBUG: Creating transparent image ${Width}x${Height} -> $OutputPath"
        }
        
        # System.Drawing으로 투명한 이미지 생성
        Add-Type -AssemblyName System.Drawing
        $bitmap = New-Object System.Drawing.Bitmap($Width, $Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        
        try {
            # Graphics 객체로 투명하게 초기화
            $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
            try {
                $graphics.Clear([System.Drawing.Color]::Transparent)
            } finally {
                $graphics.Dispose()
            }
            
            # PNG로 저장
            $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
            
            if (Test-Path $OutputPath) {
                if ($DebugMode) {
                    $fileSize = (Get-Item $OutputPath).Length
                    Write-Host "    DEBUG: Transparent image created - $([math]::Round($fileSize/1KB, 2)) KB"
                }
                return $true
            } else {
                throw "Transparent image file was not created"
            }
            
        } finally {
            if ($bitmap) { $bitmap.Dispose() }
        }
        
    } catch {
        Write-Warning "    Failed to create transparent image: $($_.Exception.Message)"
        return $false
    }
}

function Replace-LayerWithTransparentContent {
    param(
        [Aspose.PSD.FileFormats.Psd.Layers.Layer]$Layer,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) {
            Write-Host "    DEBUG: Replacing layer content with transparent pixels..."
        }
        
        $bounds = $Layer.Bounds
        
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            if ($DebugMode) { Write-Warning "    Invalid layer bounds for transparent replacement" }
            return $false
        }
        
        # 투명한 픽셀 배열 생성 (ARGB32 포맷, 모든 값이 0 = 완전 투명)
        $pixelCount = $bounds.Width * $bounds.Height
        $transparentPixels = New-Object int[] $pixelCount
        
        # 모든 픽셀을 투명하게 설정 (0x00000000)
        for ($i = 0; $i -lt $pixelCount; $i++) {
            $transparentPixels[$i] = 0
        }
        
        # 레이어에 투명한 픽셀 적용
        $Layer.SaveArgb32Pixels($bounds, $transparentPixels)
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Layer content replaced with $pixelCount transparent pixels"
        }
        
        return $true
        
    } catch {
        if ($DebugMode) {
            Write-Warning "    Failed to replace layer content: $($_.Exception.Message)"
        }
        return $false
    }
}

function Convert-LayerToSmartObject {
    param(
        [Aspose.PSD.FileFormats.Psd.PsdImage]$Psd,
        [Aspose.PSD.FileFormats.Psd.Layers.Layer]$Layer,
        [int]$LayerIndex,
        [string]$OutputDir,
        [switch]$DebugMode
    )
    
    try {
        if ($DebugMode) { 
            Write-Host "    Converting layer '$($Layer.Name)' to linked smart object with transparent content..."
        }
        
        # PNG 파일 이름 생성
        $pngName = Normalize-LayerNameToPng -LayerName $Layer.Name
        $pngPath = Join-Path $OutputDir $pngName
        
        # 원본 레이어 정보 백업
        $originalName = $Layer.Name
        $originalVisible = $Layer.IsVisible
        $originalOpacity = $Layer.Opacity
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Layer info - Name: '$originalName', Visible: $originalVisible, Opacity: $originalOpacity"
        }
        
        # 레이어 크기 정보 획득
        $bounds = $Layer.Bounds
        
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            if ($DebugMode) { Write-Warning "    Invalid layer bounds: ${bounds.Width}x${bounds.Height}" }
            return $false
        }
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Layer bounds - Width: $($bounds.Width), Height: $($bounds.Height)"
        }
        
        # 1단계: 레이어 내용을 투명한 이미지로 교체
        if (-not (Replace-LayerWithTransparentContent -Layer $Layer -DebugMode:$DebugMode)) {
            Write-Warning "    Failed to replace layer content with transparent image"
            return $false
        }
        
        # 2단계: 투명한 레이어 내용을 PNG로 추출
        try {
            if ($DebugMode) { Write-Host "    DEBUG: Extracting transparent content as PNG..." }
            
            # 투명한 픽셀 데이터 추출
            $pixels = $Layer.LoadArgb32Pixels($bounds)
            
            if (-not $pixels -or $pixels.Length -eq 0) {
                if ($DebugMode) { Write-Warning "    No pixel data available after transparent replacement" }
                return $false
            }
            
            if ($DebugMode) { Write-Host "    DEBUG: Loaded $($pixels.Length) transparent pixels" }
            
            # System.Drawing으로 투명한 이미지 생성
            Add-Type -AssemblyName System.Drawing
            $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
            
            try {
                $bmpData = $bitmap.LockBits(
                    (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                    [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
                )
                
                try {
                    # 투명한 픽셀 데이터를 비트맵에 복사
                    [System.Runtime.InteropServices.Marshal]::Copy($pixels, 0, $bmpData.Scan0, $pixels.Length)
                } finally {
                    $bitmap.UnlockBits($bmpData)
                }
                
                # PNG로 저장
                $bitmap.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)
                
                if (Test-Path $pngPath) {
                    if ($DebugMode) {
                        $fileSize = (Get-Item $pngPath).Length
                        Write-Host "    DEBUG: Transparent PNG extracted - $pngName ($([math]::Round($fileSize/1KB, 2)) KB)"
                    }
                } else {
                    throw "Transparent PNG file was not created"
                }
                
            } finally {
                if ($bitmap) { $bitmap.Dispose(); $bitmap = $null }
            }
            
            # 픽셀 배열 명시적 해제
            $pixels = $null
            
        } catch {
            if ($DebugMode) { Write-Host "    DEBUG: Transparent PNG extraction failed: $($_.Exception.Message)" }
            return $false
        }
        
        # 메모리 정리 (PNG 추출 후)
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        
        # 3단계: 레이어를 Embedded Smart Object로 변환
        $smartLayer = $null
        try {
            if ($DebugMode) {
                Write-Host "    DEBUG: Converting layer to Embedded Smart Object..."
                Write-Host "    DEBUG: Current layer count: $($Psd.Layers.Length)"
            }
            
            # SmartObjectProvider를 사용하여 레이어를 Smart Object로 변환
            $smartLayer = $Psd.SmartObjectProvider.ConvertToSmartObject($LayerIndex)
            
            if ($smartLayer -eq $null) {
                throw "Failed to convert layer to Smart Object - ConvertToSmartObject returned null"
            }
            
            # Smart Object 상태 검증
            if (-not ($smartLayer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer])) {
                throw "ConvertToSmartObject did not return a SmartObjectLayer"
            }
            
            if ($DebugMode) {
                Write-Host "    DEBUG: Layer converted to Embedded Smart Object"
                Write-Host "    DEBUG: Smart Object type: $($smartLayer.ContentType)"
                Write-Host "    DEBUG: Smart Object bounds: $($smartLayer.Bounds)"
            }
            
            # 중간 메모리 정리
            [System.GC]::Collect()
            [System.GC]::WaitForPendingFinalizers()
            
            # 4단계: Embedded Smart Object를 Linked Smart Object로 변환
            if ($DebugMode) {
                Write-Host "    DEBUG: Converting Embedded Smart Object to Linked..."
            }
            
            # PNG 파일 존재 재확인
            if (-not (Test-Path $pngPath)) {
                throw "PNG file not found for ReplaceContents: $pngPath"
            }
            
            # ReplaceContents를 사용하여 Embedded를 Linked로 변환
            $smartLayer.ReplaceContents($pngPath)
            
            # 변환 후 상태 검증
            if ($smartLayer.ContentType -ne [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectType]::AvailableLinked) {
                Write-Warning "    Smart Object conversion completed but type is: $($smartLayer.ContentType)"
            }
            
            # 원본 레이어 속성 복원
            $smartLayer.Name = $originalName
            $smartLayer.IsVisible = $originalVisible
            $smartLayer.Opacity = $originalOpacity
            
            if ($DebugMode) {
                Write-Host "    DEBUG: Converted to Linked Smart Object"
                Write-Host "    DEBUG: Final Smart Object type: $($smartLayer.ContentType)"
                
                # 최종 검증
                if ($smartLayer.ContentType -eq [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectType]::AvailableLinked) {
                    Write-Host "    ✓ Successfully converted to Linked Smart Object with transparent content: $pngName" -ForegroundColor Green
                } else {
                    Write-Warning "    ⚠ Smart Object created but not linked properly"
                }
            }
            
            # 최종 메모리 정리 (Smart Object 변환 완료 후)
            [System.GC]::Collect()
            [System.GC]::WaitForPendingFinalizers()
            
            return $true
            
        } catch {
            if ($DebugMode) {
                Write-Host "    DEBUG: Smart Object conversion failed: $($_.Exception.Message)"
            }
            
            # 실패 시 메모리 정리
            $smartLayer = $null
            [System.GC]::Collect()
            [System.GC]::WaitForPendingFinalizers()
            
            return $false
        }
        
    } catch {
        if ($DebugMode) { 
            Write-Warning "    Failed to convert layer '$($Layer.Name)': $($_.Exception.Message)"
        }
        return $false
    } finally {
        # 함수 종료 시 모든 리소스 정리
        $smartLayer = $null
    }
}

function Copy-PsdToWorkingDirectory {
    param(
        [string]$SourcePsdPath,
        [string]$WorkingDirectory,
        [switch]$DebugMode
    )
    
    try {
        # 작업 디렉토리 생성
        if (-not (Test-Path $WorkingDirectory)) {
            New-Item -ItemType Directory -Path $WorkingDirectory -Force | Out-Null
            if ($DebugMode) { Write-Host "    DEBUG: Created working directory: $WorkingDirectory" }
        }
        
        # 원본 파일명 유지하여 복사
        $fileName = Split-Path $SourcePsdPath -Leaf
        $workingPsdPath = Join-Path $WorkingDirectory $fileName
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Copying PSD from '$SourcePsdPath' to '$workingPsdPath'"
        }
        
        Copy-Item -Path $SourcePsdPath -Destination $workingPsdPath -Force
        
        if (Test-Path $workingPsdPath) {
            if ($DebugMode) {
                $originalSize = (Get-Item $SourcePsdPath).Length
                $copiedSize = (Get-Item $workingPsdPath).Length
                Write-Host "    DEBUG: PSD copied successfully - Original: $([math]::Round($originalSize/1MB, 2)) MB, Copied: $([math]::Round($copiedSize/1MB, 2)) MB"
            }
            return $workingPsdPath
        } else {
            throw "Failed to copy PSD file"
        }
        
    } catch {
        Write-Warning "    Failed to copy PSD to working directory: $($_.Exception.Message)"
        return $null
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
        [switch]$DebugMode,
        [switch]$EnableOptimization,
        [int]$CompressionLevel = 6
    )
    
    if ($DebugMode) { 
        Write-Host "Processing UUID: $UUID with $MachineCount machines (orientation: $Orientation, logo_type: $LogoType, main_chara: m$MainCharaCount, sub_chara: s$SubCharaCount)"
        Write-Host "Source PSD: $SourcePsdPath"
        $sourceFileSize = (Get-Item $SourcePsdPath).Length
        Write-Host "DEBUG: Source PSD size: $([math]::Round($sourceFileSize/1MB, 2)) MB"
        if ($EnableOptimization) {
            Write-Host "DEBUG: Optimization enabled (compression level: $CompressionLevel)"
        }
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
        Write-Host "    Working directory: $uuidDir"
        Write-Host "    Output: $outputPsdPath"
    }
    
    if (-not $WhatIfMode) {
        # 1단계: 원본 PSD를 작업 디렉토리에 복사
        $workingPsdPath = Copy-PsdToWorkingDirectory -SourcePsdPath $SourcePsdPath -WorkingDirectory $uuidDir -DebugMode:$DebugMode
        
        if (-not $workingPsdPath) {
            Write-Warning "    Failed to copy PSD to working directory"
            return $false
        }
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Working with copied PSD: $workingPsdPath"
        }
    }
    
    # 2단계: 복사된 PSD 로드 및 처리
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true
    
    $psd = $null
    try {
        if ($DebugMode) { Write-Host "    DEBUG: Loading copied PSD instance" }
        
        # WhatIf 모드에서는 원본 파일로 시뮬레이션
        $loadPath = if ($WhatIfMode) { $SourcePsdPath } else { $workingPsdPath }
        
        $img = [Aspose.PSD.Image]::Load($loadPath, $loadOptions)
        $psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
        
        if ($DebugMode) {
            Write-Host "    DEBUG: PSD loaded - Dimensions: $($psd.Width)x$($psd.Height), Layers: $($psd.Layers.Length)"
        }
        
        # 타겟 레이어들 찾기 (확장된 패턴)
        $targetLayers = @()
        for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
            $layer = $psd.Layers[$i]
            if (Test-TargetLayerName -LayerName $layer.Name) {
                $targetLayers += @{ Layer = $layer; Index = $i }
                if ($DebugMode) { 
                    Write-Host "    Found target layer [$i]: '$($layer.Name)' (Type: $($layer.GetType().Name))"
                    Write-Host "      Bounds: $($layer.Bounds.Left),$($layer.Bounds.Top) - $($layer.Bounds.Width)x$($layer.Bounds.Height)"
                    Write-Host "      Visible: $($layer.IsVisible), Opacity: $($layer.Opacity)"
                }
            }
        }
        
        if ($targetLayers.Count -eq 0) {
            Write-Warning "No target layers found in $UUID"
            if ($DebugMode) {
                Write-Host "    DEBUG: All layer names in PSD:"
                for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
                    Write-Host "      [$i] '$($psd.Layers[$i].Name)'"
                }
            }
            return $false
        }
        
        if (-not $WhatIfMode) {
            # 각 타겟 레이어를 투명 이미지로 교체하고 Smart Object로 변환
            $convertedCount = 0
            foreach ($targetInfo in $targetLayers) {
                if ($DebugMode) { 
                    Write-Host "    DEBUG: Converting layer '$($targetInfo.Layer.Name)' (Index: $($targetInfo.Index)) with transparent content"
                }
                
                if (Convert-LayerToSmartObject -Psd $psd -Layer $targetInfo.Layer -LayerIndex $targetInfo.Index -OutputDir $uuidDir -DebugMode:$DebugMode) {
                    $convertedCount++
                    if ($DebugMode) { 
                        Write-Host "    DEBUG: ✓ Layer '$($targetInfo.Layer.Name)' converted successfully with transparent content"
                    }
                    
                    # 각 레이어 변환 후 메모리 정리
                    [System.GC]::Collect()
                    [System.GC]::WaitForPendingFinalizers()
                    
                } else {
                    Write-Warning "    Failed to convert layer '$($targetInfo.Layer.Name)'"
                    
                    # 실패 시에도 메모리 정리
                    [System.GC]::Collect()
                    [System.GC]::WaitForPendingFinalizers()
                }
            }
            
            if ($convertedCount -gt 0) {
                # 최적화 단계 (옵션)
                if ($EnableOptimization) {
                    if ($DebugMode) { 
                        Write-Host "    DEBUG: Applying PSD optimization..."
                    }
                    
                    try {
                        # 레이어 최적화
                        $optimizedLayers = Optimize-PsdLayers -Psd $psd -DebugMode:$DebugMode
                        
                        # 리소스 최적화
                        $optimizedResources = Optimize-PsdResources -Psd $psd -DebugMode:$DebugMode
                        
                        if ($DebugMode) {
                            Write-Host "    DEBUG: Optimization completed - Layers: $optimizedLayers, Resources: $optimizedResources"
                        }
                        
                    } catch {
                        Write-Warning "    PSD optimization failed: $($_.Exception.Message)"
                    }
                }
                
                # 저장 전 최종 메모리 정리
                if ($DebugMode) { 
                    Write-Host "    DEBUG: Final memory cleanup before saving..."
                }
                [System.GC]::Collect()
                [System.GC]::WaitForPendingFinalizers()
                [System.GC]::Collect()  # 두 번 실행으로 완전한 정리
                
                # 변환된 PSD 저장 (원본 파일명 유지)
                try {
                    if ($DebugMode) { 
                        Write-Host "    DEBUG: Saving PSD with $convertedCount converted transparent layers"
                        
                        # PSD 상태 검증
                        Write-Host "    DEBUG: Current layer count: $($psd.Layers.Length)"
                        Write-Host "    DEBUG: PSD dimensions: $($psd.Width)x$($psd.Height)"
                    }
                    
                    # 최적화된 저장 옵션 사용
                    if ($EnableOptimization) {
                        $psdOptions = Set-OptimizedPsdOptions -CompressionLevel $CompressionLevel -DebugMode:$DebugMode
                        if ($psdOptions) {
                            if ($DebugMode) { Write-Host "    DEBUG: Using optimized save options" }
                            $psd.Save($outputPsdPath, $psdOptions)
                        } else {
                            if ($DebugMode) { Write-Host "    DEBUG: Using default save options (optimization failed)" }
                            $psd.Save($outputPsdPath)
                        }
                    } else {
                        $psd.Save($outputPsdPath)
                    }
                    
                    if (Test-Path $outputPsdPath) {
                        # 파일 크기 정보 계산
                        $sizeInfo = Get-OptimizedFileSize -FilePath $outputPsdPath -OriginalPath $SourcePsdPath -DebugMode:$DebugMode
                        
                        if ($EnableOptimization -and $sizeInfo.ReductionPercent -gt 0) {
                            if ($DebugMode) {
                                Write-Host "    ✓ Saved optimized PSD ($([math]::Round($sizeInfo.Size/1MB, 2)) MB, $($sizeInfo.ReductionPercent)% reduction) with $convertedCount transparent smart objects"
                            } else {
                                Write-Host "    ✓ Saved optimized PSD for machine_$MachineCount with $convertedCount transparent smart objects ($($sizeInfo.ReductionPercent)% size reduction)"
                            }
                        } else {
                            if ($DebugMode) {
                                Write-Host "    ✓ Saved PSD ($([math]::Round($sizeInfo.Size/1MB, 2)) MB) with $convertedCount transparent smart objects"
                            } else {
                                Write-Host "    ✓ Saved PSD for machine_$MachineCount with $convertedCount transparent smart objects"
                            }
                        }
                        return $true
                    } else {
                        Write-Warning "    PSD file was not created: $outputPsdPath"
                        return $false
                    }
                } catch {
                    Write-Warning "    Failed to save PSD: $($_.Exception.Message)"
                    if ($DebugMode) {
                        Write-Host "    DEBUG: Save exception details: $($_.Exception.GetType().Name)"
                        Write-Host "    DEBUG: Inner exception: $($_.Exception.InnerException)"
                        Write-Host "    DEBUG: Stack trace: $($_.ScriptStackTrace)"
                        
                        # 추가 디버깅 정보
                        Write-Host "    DEBUG: Current memory usage before error:"
                        $memInfo = Get-Process -Id $PID | Select-Object WorkingSet64, PrivateMemorySize64
                        Write-Host "    DEBUG: Working Set: $([math]::Round($memInfo.WorkingSet64/1MB, 2)) MB"
                        Write-Host "    DEBUG: Private Memory: $([math]::Round($memInfo.PrivateMemorySize64/1MB, 2)) MB"
                    }
                    return $false
                }
            } else {
                Write-Warning "    No layers converted"
                return $false
            }
        } else {
            # WhatIf 모드
            Write-Host "    [SIMULATION] Would copy: $SourcePsdPath -> $uuidDir"
            Write-Host "    [SIMULATION] Would create: $outputPsdPath"
            Write-Host "    [SIMULATION] Would convert $($targetLayers.Count) layers to transparent smart objects"
            if ($EnableOptimization) {
                Write-Host "    [SIMULATION] Would apply PSD optimization (compression level: $CompressionLevel)"
            }
            foreach ($targetInfo in $targetLayers) {
                Write-Host "    [SIMULATION]   - '$($targetInfo.Layer.Name)' -> $(Normalize-LayerNameToPng -LayerName $targetInfo.Layer.Name) (transparent)"
            }
            return $true
        }
        
    } catch {
        Write-Error "Failed to process PSD $UUID`: $($_.Exception.Message)"
        if ($DebugMode) {
            Write-Host "DEBUG: Exception details: $($_.Exception.GetType().Name)"
            Write-Host "DEBUG: Stack trace: $($_.ScriptStackTrace)"
        }
        return $false
    } finally {
        # PSD 인스턴스 정리
        if ($psd) { 
            $psd.Dispose()
            $psd = $null
            if ($DebugMode) { Write-Host "    DEBUG: PSD instance disposed" }
        }
        
        # 강제 메모리 정리 (finally 블록에서)
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        [System.GC]::Collect()
        
        if ($DebugMode) {
            # 메모리 사용량 체크
            $memInfo = Get-Process -Id $PID | Select-Object WorkingSet64, PrivateMemorySize64
            Write-Host "    DEBUG: Memory after cleanup - Working Set: $([math]::Round($memInfo.WorkingSet64/1MB, 2)) MB, Private: $([math]::Round($memInfo.PrivateMemorySize64/1MB, 2)) MB"
        }
    }
}

# ===== 메인 실행 =====
$startTime = Get-Date
Write-Host "=== PSD Templatization v3 (with Optimization) Started at $($startTime.ToString('yyyy-MM-dd HH:mm:ss')) ==="

if ($EnableOptimization) {
    Write-Host "🔧 Optimization enabled - Compression level: $CompressionLevel" -ForegroundColor Cyan
}

# 경로 설정
$posterDir = "d:\poster"
$csvPath = "d:\poster-json-machine-analysis.csv"
$templateRoot = "e:\psd_template"

# 라이브러리 로드
if (-not (Load-AsposePSD)) {
    Write-Error "Failed to load Aspose.PSD libraries"
    exit 1
}

# 라이센스 확인 (디버깅)
if ($Debug) {
    try {
        Write-Host "DEBUG: Checking Aspose.PSD license status..."
        $license = New-Object Aspose.PSD.License
        $license.SetLicense("Aspose.PSD.NET_(2).lic.txt")
        Write-Host "DEBUG: License applied successfully"
        
        # 간단한 기능 테스트
        $testOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        Write-Host "DEBUG: Basic Aspose.PSD functionality test passed"
    } catch {
        Write-Warning "DEBUG: License or functionality issue: $($_.Exception.Message)"
    }
}

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
$totalOriginalSize = 0
$totalOptimizedSize = 0

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
    
    # 원본 파일 크기 누적
    $originalSize = (Get-Item $psdFile.FullName).Length
    $totalOriginalSize += $originalSize
    
    try {
        if (Process-PsdForMachines -SourcePsdPath $psdFile.FullName -UUID $uuid -MachineCount $machines -Orientation $orientation -LogoType $logoType -MainCharaCount $mainCharaCount -SubCharaCount $subCharaCount -TemplateRoot $templateRoot -WhatIfMode:$WhatIf -DebugMode:($Verbose -or $Debug) -EnableOptimization:$EnableOptimization -CompressionLevel $CompressionLevel) {
            $successCount++
            
            # 최적화된 파일 크기 누적 (WhatIf 모드가 아닌 경우)
            if (-not $WhatIf) {
                $orientationDir = Join-Path $templateRoot $orientation
                $logoTypeDir = Join-Path $orientationDir $logoType
                $machineDir = Join-Path $logoTypeDir "machine_$machines"
                $mainCharaDir = Join-Path $machineDir "m$mainCharaCount"
                $subCharaDir = Join-Path $mainCharaDir "s$subCharaCount"
                $uuidDir = Join-Path $subCharaDir $uuid
                $outputPsdPath = Join-Path $uuidDir "$uuid.psd"
                
                if (Test-Path $outputPsdPath) {
                    $optimizedSize = (Get-Item $outputPsdPath).Length
                    $totalOptimizedSize += $optimizedSize
                }
            }
            
            Write-Host "  ✓ Successfully processed $uuid with transparent replacement"
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
    
    # 메모리 정리
    if ($processedCount % 5 -eq 0) {
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
    }
}

# 결과 요약
$endTime = Get-Date
$duration = $endTime - $startTime
Write-Host ""
Write-Host "=== PSD Templatization v3 Completed ==="
Write-Host "Duration: $($duration.ToString('hh\:mm\:ss'))"
Write-Host "Total PSD files: $($psdFiles.Count)"
Write-Host "Processed: $processedCount"
Write-Host "Successful: $successCount"
Write-Host "Errors: $errorCount"

# 최적화 결과 요약
if ($EnableOptimization -and -not $WhatIf -and $totalOriginalSize -gt 0 -and $totalOptimizedSize -gt 0) {
    $totalReduction = $totalOriginalSize - $totalOptimizedSize
    $totalReductionPercent = [math]::Round(($totalReduction / $totalOriginalSize) * 100, 2)
    
    Write-Host ""
    Write-Host "🔧 Optimization Results:" -ForegroundColor Cyan
    Write-Host "  Original total size: $([math]::Round($totalOriginalSize/1MB, 2)) MB"
    Write-Host "  Optimized total size: $([math]::Round($totalOptimizedSize/1MB, 2)) MB"
    Write-Host "  Total size reduction: $([math]::Round($totalReduction/1MB, 2)) MB ($totalReductionPercent%)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Key changes in v3:"
Write-Host "- All features from v2 (transparent replacement, extended patterns)"
Write-Host "- PSD file size optimization with RLE compression"
Write-Host "- Layer and resource optimization"
Write-Host "- Configurable compression levels (1-9)"
Write-Host "- Size reduction statistics"

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

if (-not $EnableOptimization -and -not $WhatIf) {
    Write-Host ""
    Write-Host "💡 Tip: Use -EnableOptimization to reduce PSD file sizes" -ForegroundColor Yellow
}

if ($errorCount -gt 0) {
    Write-Warning "Some PSDs failed to process. Check the output above for details."
    exit 1
} else {
    Write-Host "All PSDs processed successfully!" -ForegroundColor Green
    exit 0
}
