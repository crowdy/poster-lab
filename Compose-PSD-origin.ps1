param(
    [Parameter(Mandatory = $true)]
    [string]$AnalysisJson,              # Path to the PSD analysis JSON file

    [Parameter(Mandatory = $true)]
    [string]$AssetJson,                 # Path to the asset JSON file from extract-psd

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,                # Output path for the composed PSD file (optional)

    [switch]$Silent,                    # Silent mode - only output result JSON file path
    [switch]$Compact                    # Compact mode - remove unnecessary information to reduce file size
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ===== Aspose.PSD 로더 =====
function Load-AsposePSD {
    $packageDir = "$PSScriptRoot/aspose-packages"
    if (-not (Test-Path $packageDir)) { New-Item -ItemType Directory -Path $packageDir -Force | Out-Null }

    $asposeDrawingDll = "$packageDir/Aspose.Drawing.dll"
    $asposePsdDll     = "$packageDir/Aspose.PSD.dll"

    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages for .NET 8.0..."
        $tempDir = "$PSScriptRoot/temp-packages"
        if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
        try {
            Set-Location $PSScriptRoot
            dotnet new console -n TempProject -o $tempDir --force | Out-Null
            Set-Location $tempDir
            dotnet add package Aspose.PSD --version 24.12.0 | Out-Null
            dotnet add package Aspose.Drawing --version 24.12.0 | Out-Null
            dotnet restore | Out-Null

            $packagesPath = "$env:USERPROFILE\.nuget\packages"
            (Get-ChildItem "$packagesPath/aspose.psd/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1).FullName | ForEach-Object { Copy-Item $_ "$packageDir/Aspose.PSD.dll" -Force }
            (Get-ChildItem "$packagesPath/aspose.drawing/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1).FullName | ForEach-Object { Copy-Item $_ "$packageDir/Aspose.Drawing.dll" -Force }

            foreach ($dep in @(
                "newtonsoft.json/*/lib/net6.0/*.dll",
                "system.drawing.common/*/lib/net8.0/*.dll",
                "system.text.encoding.codepages/*/lib/net8.0/*.dll"
            )) {
                $p = Get-ChildItem "$packagesPath/$dep" -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($p) { Copy-Item $p.FullName $packageDir -Force }
            }
        } catch {
            Write-Error "Failed to download packages: $_"
            Set-Location $PSScriptRoot
            return $false
        } finally {
            Set-Location $PSScriptRoot
            if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue }
        }
    }

    try {
        # CodePages 인코딩 등록 (텍스트/효과 렌더링 안정화)
        Add-Type -AssemblyName "System.Text.Encoding.CodePages" -ErrorAction SilentlyContinue
        [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)

        foreach ($dep in @("System.Text.Encoding.CodePages.dll","Newtonsoft.Json.dll","System.Drawing.Common.dll")) {
            $p = Join-Path $packageDir $dep
            if (Test-Path $p) { Add-Type -Path $p -ErrorAction SilentlyContinue }
        }
        Add-Type -Path $asposeDrawingDll
        Add-Type -Path $asposePsdDll
        return $true
    } catch {
        Write-Error "Error loading Aspose.PSD: $_"
        return $false
    }
}

# ===== Helper Functions =====
function Find-LayerInHierarchy {
    param(
        [array]$Layers,
        [string]$LayerName
    )
    
    foreach ($layer in $Layers) {
        if ($layer.name -eq $LayerName) {
            return $layer
        }
        
        # 레이어 그룹인 경우 하위 레이어에서 검색
        if ($layer.layers -and $layer.layers.Count -gt 0) {
            $foundLayer = Find-LayerInHierarchy -Layers $layer.layers -LayerName $LayerName
            if ($foundLayer) {
                return $foundLayer
            }
        }
    }
    
    return $null
}

function Get-FileSize {
    param([string]$FilePath)
    
    if (Test-Path $FilePath) {
        $fileInfo = Get-Item $FilePath
        return $fileInfo.Length
    }
    return 0
}

function Format-FileSize {
    param([long]$Size)
    
    if ($Size -ge 1GB) {
        return "{0:N2} GB" -f ($Size / 1GB)
    } elseif ($Size -ge 1MB) {
        return "{0:N2} MB" -f ($Size / 1MB)
    } elseif ($Size -ge 1KB) {
        return "{0:N2} KB" -f ($Size / 1KB)
    } else {
        return "{0:N0} bytes" -f $Size
    }
}

# ===== Main =====
$startTime = Get-Date

if (-not $Silent) {
    Write-Host "Starting PSD composition at $startTime"
    Write-Host "Current directory: $(Get-Location)"
}

# 입력 파일 검증
if (-not (Test-Path $AnalysisJson)) {
    Write-Error "Analysis JSON file not found: $AnalysisJson"
    exit 1
}

if (-not (Test-Path $AssetJson)) {
    Write-Error "Asset JSON file not found: $AssetJson"
    exit 1
}

# Aspose.PSD 로드
if (-not (Load-AsposePSD)) {
    Write-Error "Failed to load Aspose.PSD libraries"
    exit 1
}

# 결과 객체 초기화
$result = [ordered]@{
    InputAnalysisFile = (Resolve-Path -LiteralPath $AnalysisJson).Path
    InputAssetFile = (Resolve-Path -LiteralPath $AssetJson).Path
    OutputFile = ""
    StartTime = $startTime.ToString("o")
    EndTime = $null
    Duration = $null
    TotalAssetsProcessed = 0
    SuccessfulCompositions = 0
    FailedCompositions = 0
    ProcessedAssets = @()
    FailedAssets = @()
    Status = ""
}

try {
    # JSON 파일들 로드
    if (-not $Silent) {
        Write-Host "Loading analysis data from: $AnalysisJson"
    }
    
    $analysisContent = Get-Content -LiteralPath $AnalysisJson -Raw -Encoding UTF8
    $analysisData = $analysisContent | ConvertFrom-Json
    
    if (-not $analysisData) {
        Write-Error "Failed to parse analysis JSON file"
        exit 1
    }
    
    # 버전 확인
    if ([string]::IsNullOrEmpty($analysisData.version) -or $analysisData.version -ne "v2") {
        if (-not $Silent) {
            Write-Warning "Input JSON version is not v2. This may cause issues with layer group processing."
        }
    } else {
        if (-not $Silent) {
            Write-Host "Input JSON version: $($analysisData.version)"
        }
    }
    
    if (-not $Silent) {
        Write-Host "Loading asset data from: $AssetJson"
    }
    
    $assetContent = Get-Content -LiteralPath $AssetJson -Raw -Encoding UTF8
    $assetData = $assetContent | ConvertFrom-Json
    
    if (-not $assetData) {
        Write-Error "Failed to parse asset JSON file"
        exit 1
    }
    
    # 출력 파일 경로 결정
    if (-not [string]::IsNullOrEmpty($OutputPath)) {
        $outputFilePath = $OutputPath
    } else {
        # analysis JSON과 같은 디렉토리에 저장
        $analysisDir = Split-Path -Parent $AnalysisJson
        if ([string]::IsNullOrEmpty($analysisDir)) {
            $analysisDir = Get-Location
        }
        $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($analysisData.filename)
        $outputFileName = "{0}_composed_{1}.psd" -f $baseName, $timestamp
        $outputFilePath = Join-Path $analysisDir $outputFileName
    }
    
    # 출력 디렉토리 생성
    $outputDir = Split-Path -Parent $outputFilePath
    if (-not [string]::IsNullOrEmpty($outputDir) -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        if (-not $Silent) {
            Write-Host "Created output directory: $outputDir"
        }
    }
    
    $result.OutputFile = [System.IO.Path]::GetFullPath($outputFilePath)
    $result.TotalAssetsProcessed = $assetData.ExtractedLayers.Count
    
    if (-not $Silent) {
        Write-Host "Creating composed PSD with dimensions: $($analysisData.width)x$($analysisData.height)"
        Write-Host "Total layers to process: $($analysisData.layers.Count)"
        Write-Host "Total assets to process: $($assetData.ExtractedLayers.Count)"
        Write-Host "Composition mode: $(if ($Compact) { 'Compact (reduced file size)' } else { 'Full (preserve all information)' })"
    }
    
    # 원본 PSD 파일 로드
    $analysisJsonDir = Split-Path -Parent $AnalysisJson
    if ([string]::IsNullOrEmpty($analysisJsonDir)) {
        $analysisJsonDir = Get-Location
    }
    $originalPsdPath = Join-Path $analysisJsonDir $analysisData.filename
    
    if (-not (Test-Path $originalPsdPath)) {
        Write-Error "Original PSD file not found: $originalPsdPath"
        $result.Status = "Failed"
        $result.FailedAssets += "Original PSD file not found: $originalPsdPath"
        exit 1
    }
    
    if (-not $Silent) {
        Write-Host "Loading original PSD file: $originalPsdPath"
    }
    
    # 원본 PSD 파일을 기반으로 새로운 PSD 생성
    $originalImage = [Aspose.PSD.Image]::Load($originalPsdPath)
    $originalPsd = [Aspose.PSD.FileFormats.Psd.PsdImage]$originalImage
    
    try {
        # 새로운 PSD 이미지 생성
        $composedImage = $null
        
        if ($Compact) {
            # Compact 모드: 새로운 빈 PSD 생성
            if (-not $Silent) {
                Write-Host "Creating new PSD in compact mode"
            }
            $composedImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($originalPsd.Width, $originalPsd.Height)
        } else {
            # Full 모드: 원본 PSD를 복사하여 모든 정보 보존
            if (-not $Silent) {
                Write-Host "Creating PSD in full mode (preserving all information)"
            }
            
            # 원본 이미지를 메모리 스트림으로 저장한 후 다시 로드하여 복사본 생성
            $memoryStream = New-Object System.IO.MemoryStream
            try {
                $originalPsd.Save($memoryStream)
                $memoryStream.Position = 0
                $composedImage = [Aspose.PSD.Image]::Load($memoryStream)
                $composedImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$composedImage
            } finally {
                $memoryStream.Dispose()
            }
        }
        
        try {
            # 각 에셋을 레이어로 추가
            if ($assetData.ExtractedLayers.Count -gt 0) {
                foreach ($extractedLayer in $assetData.ExtractedLayers) {
                    try {
                        if (-not (Test-Path $extractedLayer.FilePath)) {
                            if (-not $Silent) {
                                Write-Warning "Asset file not found: $($extractedLayer.FilePath)"
                            }
                            $result.FailedAssets += "Asset '$($extractedLayer.Name)' - file not found: $($extractedLayer.FilePath)"
                            $result.FailedCompositions++
                            continue
                        }
                        
                        if (-not $Silent) {
                            Write-Host "Processing asset: $($extractedLayer.Name) from $($extractedLayer.FilePath)"
                        }
                        
                        # 원본 레이어 찾기
                        $originalLayer = $originalPsd.Layers | Where-Object { $_.DisplayName -eq $extractedLayer.Name } | Select-Object -First 1
                        
                        if ($originalLayer) {
                            # 원본 레이어를 복사하여 새로운 이미지에 추가
                            $layerCopy = $originalLayer.ShallowCopy()
                            $composedImage.AddLayer($layerCopy)
                            
                            # 원본 분석 데이터에서 해당 레이어의 속성 적용
                            $analysisLayer = Find-LayerInHierarchy -Layers $analysisData.layers -LayerName $extractedLayer.Name
                            if ($analysisLayer) {
                                $layerCopy.IsVisible = $analysisLayer.visible
                                $layerCopy.Opacity = $analysisLayer.opacity
                                if (-not $Silent) {
                                    Write-Host "Applied original layer properties - Visible: $($analysisLayer.visible), Opacity: $($analysisLayer.opacity)"
                                }
                            }
                            
                            $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - successfully added"
                            $result.SuccessfulCompositions++
                        } else {
                            if (-not $Silent) {
                                Write-Warning "Original layer not found for asset: $($extractedLayer.Name)"
                            }
                            $result.FailedAssets += "Asset '$($extractedLayer.Name)' - original layer not found"
                            $result.FailedCompositions++
                        }
                    } catch {
                        $errorMsg = $_.Exception.Message
                        if (-not $Silent) {
                            Write-Error "Failed to process asset '$($extractedLayer.Name)': $errorMsg"
                        }
                        $result.FailedAssets += "Asset '$($extractedLayer.Name)' - $errorMsg"
                        $result.FailedCompositions++
                    }
                }
            } else {
                if (-not $Silent) {
                    Write-Host "No extracted assets to process. Using original PSD structure."
                }
                
                # 에셋이 없는 경우, compact 모드에서는 원본 레이어들을 복사
                if ($Compact) {
                    if (-not $Silent) {
                        Write-Host "Copying original layers in compact mode"
                    }
                    
                    foreach ($originalLayer in $originalPsd.Layers) {
                        try {
                            $layerCopy = $originalLayer.ShallowCopy()
                            $composedImage.AddLayer($layerCopy)
                            
                            # 원본 분석 데이터에서 해당 레이어의 속성 적용
                            $analysisLayer = Find-LayerInHierarchy -Layers $analysisData.layers -LayerName $originalLayer.DisplayName
                            if ($analysisLayer) {
                                $layerCopy.IsVisible = $analysisLayer.visible
                                $layerCopy.Opacity = $analysisLayer.opacity
                            }
                            
                            $result.ProcessedAssets += "Original layer '$($originalLayer.DisplayName)' - copied"
                            $result.SuccessfulCompositions++
                        } catch {
                            $errorMsg = $_.Exception.Message
                            if (-not $Silent) {
                                Write-Error "Failed to copy original layer '$($originalLayer.DisplayName)': $errorMsg"
                            }
                            $result.FailedAssets += "Original layer '$($originalLayer.DisplayName)' - $errorMsg"
                            $result.FailedCompositions++
                        }
                    }
                }
            }
            
            # 조합된 PSD 파일 저장
            if (-not $Silent) {
                Write-Host "Saving composed PSD to: $outputFilePath"
                
                # 파일 저장 전 원본 크기 확인
                $originalFileSize = Get-FileSize -FilePath $originalPsdPath
                Write-Host "Original file size: $(Format-FileSize -Size $originalFileSize)"
            }
            
            $composedImage.Save($outputFilePath)
            
            if (-not $Silent) {
                # 저장된 파일 크기 확인
                $composedFileSize = Get-FileSize -FilePath $outputFilePath
                Write-Host "Composed file size: $(Format-FileSize -Size $composedFileSize)"
                
                if ($originalFileSize -gt 0) {
                    $sizeReduction = (($originalFileSize - $composedFileSize) / $originalFileSize) * 100
                    if ($sizeReduction -gt 0) {
                        Write-Host "File size reduced by {0:F1}%" -f $sizeReduction
                    } elseif ($sizeReduction -lt 0) {
                        Write-Host "File size increased by {0:F1}%" -f [Math]::Abs($sizeReduction)
                    } else {
                        Write-Host "File size remained the same"
                    }
                }
                
                Write-Host "PSD composition completed successfully"
            }
            
            $result.Status = "Success"
            
        } finally {
            if ($composedImage) {
                $composedImage.Dispose()
            }
        }
        
    } finally {
        $originalPsd.Dispose()
    }
    
} catch {
    $errorMsg = $_.Exception.Message
    Write-Error "Error during PSD composition: $errorMsg"
    $result.Status = "Failed"
    $result.FailedAssets += "Composition error: $errorMsg"
} finally {
    # 처리 완료 시간 기록
    $endTime = Get-Date
    $result.EndTime = $endTime.ToString("o")
    $result.Duration = ($endTime - $startTime).ToString()
    
    if (-not $Silent) {
        Write-Host "Composition completed at $endTime. Duration: $($result.Duration)"
        Write-Host "Summary - Total Assets: $($result.TotalAssetsProcessed), Successful: $($result.SuccessfulCompositions), Failed: $($result.FailedCompositions)"
        
        # 실패한 에셋들 상세 정보 표시
        if ($result.FailedCompositions -gt 0) {
            Write-Host "Failed assets details:"
            foreach ($failedAsset in $result.FailedAssets) {
                Write-Host "  - $failedAsset"
            }
        }
    }
    
    # JSON 출력 생성
    $jsonOutput = $result | ConvertTo-Json -Depth 8
    
    # JSON 파일 저장
    $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
    $jsonFileName = "composition_result_$timestamp.json"
    $jsonDir = if ($result.OutputFile) { Split-Path -Parent $result.OutputFile } else { Get-Location }
    $jsonFilePath = Join-Path $jsonDir $jsonFileName
    
    $jsonOutput | Set-Content -LiteralPath $jsonFilePath -Encoding UTF8
    
    if (-not $Silent) {
        Write-Host "Composition result saved to: $jsonFilePath"
    }
    
    # 출력 모드에 따른 콘솔 출력
    if ($Silent) {
        Write-Output $jsonFilePath
    } else {
        Write-Output $jsonOutput
    }
    
    # 메모리 정리
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
}