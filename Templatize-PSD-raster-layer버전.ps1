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

# ===== Aspose.PSD 로더 =====
. "$PSScriptRoot\Load-AsposePSD.ps1"

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
            if ($DebugMode) { 
                Write-Host "DEBUG: Processing row - UUID: '$($row.FileNameWithoutExtension)', MachineCount: '$($row.MachineCount)', Orientation: '$($row.Orientation)'"
            }
            
            if ($row.FileNameWithoutExtension -and $row.MachineCount) {
                $machineData[$row.FileNameWithoutExtension] = @{
                    MachineCount = [int]$row.MachineCount
                    Orientation = if ($row.Orientation) { $row.Orientation } else { "unknown" }
                }
                if ($DebugMode) { 
                    Write-Host "DEBUG: Added $($row.FileNameWithoutExtension) -> $($row.MachineCount) machines, orientation: $($machineData[$row.FileNameWithoutExtension].Orientation)"
                }
            }
        }
        
        Write-Host "Loaded machine data for $($machineData.Count) UUIDs"
        
        if ($DebugMode) {
            Write-Host "DEBUG: Machine data summary:"
            $machineData.GetEnumerator() | Sort-Object Key | ForEach-Object {
                Write-Host "  $($_.Key) = $($_.Value.MachineCount) machines, orientation: $($_.Value.Orientation)"
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
    
    $patterns = @(
        '^machine-icon_g0[1-9]\s*#[1-9]$',
        '^chara_main_g0[1-9]\s*#[1-9]$',
        '^chara_sub_g0[1-9]\s*#[1-9]$'
    )
    
    foreach ($pattern in $patterns) {
        if ($LayerName -match $pattern) {
            return $true
        }
    }
    return $false
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
            Write-Host "    Converting layer '$($Layer.Name)' to smart object..."
        }
        
        # PNG 파일 이름 생성
        $pngName = Normalize-LayerNameToPng -LayerName $Layer.Name
        $pngPath = Join-Path $OutputDir $pngName
        
        # 원본 레이어 정보 백업
        $originalName = $Layer.Name
        $originalLeft = $Layer.Left
        $originalTop = $Layer.Top
        $originalRight = $Layer.Right
        $originalBottom = $Layer.Bottom
        $originalVisible = $Layer.IsVisible
        $originalOpacity = $Layer.Opacity
        
        if ($DebugMode) {
            Write-Host "    DEBUG: Layer bounds - Left: $originalLeft, Top: $originalTop, Right: $originalRight, Bottom: $originalBottom"
        }
        
        try {
            # Extract-PNGFromPSD.ps1의 성공적인 픽셀 처리 방식 적용
            $bounds = $Layer.Bounds
            
            if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
                if ($DebugMode) { Write-Warning "    Invalid layer bounds: ${bounds.Width}x${bounds.Height}" }
                return $false
            }
            
            if ($DebugMode) {
                Write-Host "    DEBUG: Layer bounds - Width: $($bounds.Width), Height: $($bounds.Height)"
            }
            
            # 픽셀 직접 처리 방식 (Extract-PNGFromPSD.ps1 Method 6 방식)
            try {
                if ($DebugMode) { Write-Host "    DEBUG: Loading pixel data..." }
                $pixels = $Layer.LoadArgb32Pixels($bounds)
                
                if (-not $pixels -or $pixels.Length -eq 0) {
                    if ($DebugMode) { Write-Warning "    No pixel data available" }
                    return $false
                }
                
                if ($DebugMode) { Write-Host "    DEBUG: Loaded $($pixels.Length) pixels" }
                
                # System.Drawing으로 이미지 생성
                Add-Type -AssemblyName System.Drawing
                $bitmap = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
                
                try {
                    $bmpData = $bitmap.LockBits(
                        (New-Object System.Drawing.Rectangle(0, 0, $bounds.Width, $bounds.Height)),
                        [System.Drawing.Imaging.ImageLockMode]::WriteOnly,
                        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
                    )
                    
                    try {
                        # 픽셀 데이터를 비트맵에 복사
                        [System.Runtime.InteropServices.Marshal]::Copy($pixels, 0, $bmpData.Scan0, $pixels.Length)
                    } finally {
                        $bitmap.UnlockBits($bmpData)
                    }
                    
                    # PNG로 저장
                    $bitmap.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)
                    
                    if (Test-Path $pngPath) {
                        if ($DebugMode) {
                            $fileSize = (Get-Item $pngPath).Length
                            Write-Host "    DEBUG: PNG saved using pixel processing - $pngName ($([math]::Round($fileSize/1KB, 2)) KB)"
                        }
                    } else {
                        throw "PNG file was not created"
                    }
                    
                } finally {
                    $bitmap.Dispose()
                }
                
            } catch {
                if ($DebugMode) { Write-Host "    DEBUG: Pixel processing failed, trying fallback method: $($_.Exception.Message)" }
                
                # 폴백: Aspose.PSD 기본 방법
                $validLeft = [Math]::Max(0, $Layer.Left)
                $validTop = [Math]::Max(0, $Layer.Top)
                $validWidth = $Layer.Right - $validLeft
                $validHeight = $Layer.Bottom - $validTop
                
                $rect = New-Object Aspose.PSD.Rectangle($validLeft, $validTop, $validWidth, $validHeight)
                
                $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
                $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
                $pngOptions.CompressionLevel = 9
                
                $Layer.Save($pngPath, $pngOptions, $rect)
                
                if (Test-Path $pngPath) {
                    if ($DebugMode) {
                        $fileSize = (Get-Item $pngPath).Length
                        Write-Host "    DEBUG: PNG saved using fallback method - $pngName ($([math]::Round($fileSize/1KB, 2)) KB)"
                    }
                } else {
                    throw "Both pixel processing and fallback methods failed"
                }
            }
            
            # 실험 코드 Method 3: RemoveLayer + AddLayer 방식 (가장 안정적)
            try {
                if ($DebugMode) {
                    Write-Host "    DEBUG: Using RemoveLayer + AddLayer method (most reliable)"
                }
                
                # PNG 이미지 로드
                $pngImage = [Aspose.PSD.Image]::Load($pngPath)
                
                try {
                    # SmartObjectLayer 생성 (이미지 객체 사용)
                    $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer($pngImage)
                    $smartLayer.Name = $originalName
                    
                    # 원본 레이어 속성 복사 (위치와 속성)
                    $smartLayer.Left = $originalLeft
                    $smartLayer.Top = $originalTop
                    $smartLayer.Right = $originalRight
                    $smartLayer.Bottom = $originalBottom
                    $smartLayer.IsVisible = $originalVisible
                    $smartLayer.Opacity = $originalOpacity
                    
                    if ($DebugMode) {
                        Write-Host "    DEBUG: SmartObjectLayer created from PNG image"
                    }
                    
                    # 안정적인 레이어 교체: RemoveLayer + InsertLayer
                    $originalLayer = $Psd.Layers[$LayerIndex]
                    $Psd.RemoveLayer($originalLayer)
                    $Psd.InsertLayer($LayerIndex, $smartLayer)
                    
                    if ($DebugMode) {
                        Write-Host "    DEBUG: Layer replaced using RemoveLayer + InsertLayer"
                        Write-Host "    ✓ Successfully converted to smart object: $pngName"
                    }
                    
                    return $true
                    
                } finally {
                    # PNG 이미지 정리 (SmartObjectLayer가 참조를 복사한 후)
                    $pngImage.Dispose()
                }
                
            } catch {
                if ($DebugMode) {
                    Write-Host "    DEBUG: RemoveLayer + AddLayer method failed, trying file stream method"
                }
                
                # 폴백: 파일 스트림 방식 (실험 코드에서 성공한 타이밍으로)
                $fileStream = New-Object System.IO.FileStream($pngPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read)
                
                try {
                    $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer($fileStream)
                    $smartLayer.Name = $originalName
                    
                    # 원본 레이어 속성 복사
                    $smartLayer.Left = $originalLeft
                    $smartLayer.Top = $originalTop
                    $smartLayer.Right = $originalRight
                    $smartLayer.Bottom = $originalBottom
                    $smartLayer.IsVisible = $originalVisible
                    $smartLayer.Opacity = $originalOpacity
                    
                    # 레이어 교체 (먼저 교체, 그 다음 스트림 정리)
                    $Psd.Layers[$LayerIndex] = $smartLayer
                    
                    if ($DebugMode) {
                        Write-Host "    DEBUG: Fallback file stream method succeeded"
                    }
                    
                    return $true
                    
                } catch {
                    if ($DebugMode) {
                        Write-Host "    DEBUG: File stream fallback also failed: $($_.Exception.Message)"
                    }
                    return $false
                } finally {
                    # 스트림 정리 (레이어 교체 후에)
                    $fileStream.Close()
                    $fileStream.Dispose()
                }
            }
            
        } catch {
            if ($DebugMode) { 
                Write-Warning "    Failed to save layer or create smart object: $($_.Exception.Message)"
            }
            return $false
        }
        
    } catch {
        if ($DebugMode) { 
            Write-Warning "    Failed to convert layer '$($Layer.Name)': $($_.Exception.Message)"
        }
        return $false
    }
}

function Process-PsdForMachines {
    param(
        [string]$SourcePsdPath,
        [string]$UUID,
        [int]$MachineCount,
        [string]$Orientation,
        [string]$TemplateRoot,
        [switch]$WhatIfMode,
        [switch]$DebugMode
    )
    
    if ($DebugMode) { 
        Write-Host "Processing UUID: $UUID with $MachineCount machines (orientation: $Orientation)"
        Write-Host "Source PSD: $SourcePsdPath"
        $sourceFileSize = (Get-Item $SourcePsdPath).Length
        Write-Host "DEBUG: Source PSD size: $([math]::Round($sourceFileSize/1MB, 2)) MB"
    }
    
    # 각 머신별로 독립적으로 PSD 로드 및 처리 (중요: 각 머신마다 원본에서 새로 시작)
    $successCount = 0
    for ($machineNum = 1; $machineNum -le $MachineCount; $machineNum++) {
        $orientationDir = Join-Path $TemplateRoot $Orientation
        $machineDir = Join-Path $orientationDir "machine_$machineNum"
        $uuidDir = Join-Path $machineDir $UUID
        $outputPsdPath = Join-Path $uuidDir "$UUID.psd"
        
        if ($DebugMode) {
            Write-Host "  Processing machine_$machineNum"
            Write-Host "    Output: $outputPsdPath"
        }
        
        # 각 머신별로 PSD를 새로 로드 (핵심 수정!)
        $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
        $loadOptions.LoadEffectsResource = $true
        $loadOptions.UseDiskForLoadEffectsResource = $true
        
        $psd = $null
        try {
            if ($DebugMode) { Write-Host "    DEBUG: Loading fresh PSD instance for machine_$machineNum" }
            
            $img = [Aspose.PSD.Image]::Load($SourcePsdPath, $loadOptions)
            $psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
            
            if ($DebugMode) {
                Write-Host "    DEBUG: PSD loaded - Dimensions: $($psd.Width)x$($psd.Height), Layers: $($psd.Layers.Length)"
            }
            
            # 타겟 레이어들 찾기 (각 머신별로 독립적으로)
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
                if ($machineNum -eq 1) { # 첫 번째 머신에서만 경고 (중복 방지)
                    Write-Warning "No target layers found in $UUID"
                    if ($DebugMode) {
                        Write-Host "    DEBUG: All layer names in PSD:"
                        for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
                            Write-Host "      [$i] '$($psd.Layers[$i].Name)'"
                        }
                    }
                }
                continue
            }
            
            if (-not $WhatIfMode) {
                # 디렉토리 생성
                if (-not (Test-Path $uuidDir)) {
                    New-Item -ItemType Directory -Path $uuidDir -Force | Out-Null
                    if ($DebugMode) { Write-Host "    DEBUG: Created directory: $uuidDir" }
                }
                
                # 각 타겟 레이어를 Smart Object로 변환
                $convertedCount = 0
                foreach ($targetInfo in $targetLayers) {
                    if ($DebugMode) { 
                        Write-Host "    DEBUG: Converting layer '$($targetInfo.Layer.Name)' (Index: $($targetInfo.Index))"
                    }
                    
                    if (Convert-LayerToSmartObject -Psd $psd -Layer $targetInfo.Layer -LayerIndex $targetInfo.Index -OutputDir $uuidDir -DebugMode:$DebugMode) {
                        $convertedCount++
                        if ($DebugMode) { 
                            Write-Host "    DEBUG: ✓ Layer '$($targetInfo.Layer.Name)' converted successfully"
                        }
                    } else {
                        Write-Warning "    Failed to convert layer '$($targetInfo.Layer.Name)'"
                    }
                }
                
                if ($convertedCount -gt 0) {
                    # 변환된 PSD 저장
                    try {
                        if ($DebugMode) { Write-Host "    DEBUG: Saving PSD with $convertedCount converted layers" }
                        
                        $psd.Save($outputPsdPath)
                        
                        if (Test-Path $outputPsdPath) {
                            $successCount++
                            $fileSize = (Get-Item $outputPsdPath).Length
                            if ($DebugMode) {
                                Write-Host "    ✓ Saved PSD ($([math]::Round($fileSize/1MB, 2)) MB) with $convertedCount smart objects"
                            } else {
                                Write-Host "    ✓ Saved PSD for machine_$machineNum with $convertedCount smart objects"
                            }
                        } else {
                            Write-Warning "    PSD file was not created: $outputPsdPath"
                        }
                    } catch {
                        Write-Warning "    Failed to save PSD for machine_$machineNum`: $($_.Exception.Message)"
                        if ($DebugMode) {
                            Write-Host "    DEBUG: Save exception details: $($_.Exception.GetType().Name)"
                            Write-Host "    DEBUG: Stack trace: $($_.ScriptStackTrace)"
                        }
                    }
                } else {
                    Write-Warning "    No layers converted for machine_$machineNum"
                }
            } else {
                # WhatIf 모드
                Write-Host "    [SIMULATION] Would create: $outputPsdPath"
                Write-Host "    [SIMULATION] Would convert $($targetLayers.Count) layers to smart objects"
                foreach ($targetInfo in $targetLayers) {
                    Write-Host "    [SIMULATION]   - '$($targetInfo.Layer.Name)' -> $(Normalize-LayerNameToPng -LayerName $targetInfo.Layer.Name)"
                }
                $successCount++
            }
            
        } catch {
            Write-Error "Failed to process machine_$machineNum for PSD $UUID`: $($_.Exception.Message)"
            if ($DebugMode) {
                Write-Host "DEBUG: Exception details: $($_.Exception.GetType().Name)"
                Write-Host "DEBUG: Stack trace: $($_.ScriptStackTrace)"
            }
        } finally {
            # 각 머신별 PSD 인스턴스 정리
            if ($psd) { 
                $psd.Dispose()
                $psd = $null
                if ($DebugMode) { Write-Host "    DEBUG: PSD instance disposed for machine_$machineNum" }
            }
            
            # 메모리 정리
            [System.GC]::Collect()
            [System.GC]::WaitForPendingFinalizers()
        }
    }
    
    return $successCount -eq $MachineCount
}

# ===== 메인 실행 =====
$startTime = Get-Date
Write-Host "=== PSD Templatization Started at $($startTime.ToString('yyyy-MM-dd HH:mm:ss')) ==="

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
    Write-Host "[$processedCount/$($psdFiles.Count)] Processing $uuid ($machines machines, $orientation orientation)..."
    
    try {
        if (Process-PsdForMachines -SourcePsdPath $psdFile.FullName -UUID $uuid -MachineCount $machines -Orientation $orientation -TemplateRoot $templateRoot -WhatIfMode:$WhatIf -DebugMode:($Verbose -or $Debug)) {
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