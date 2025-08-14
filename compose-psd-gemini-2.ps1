<#
.SYNOPSIS
    asset JSON 파일을 기반으로 여러 PNG 파일을 조합하여 단일 PSD 파일을 생성합니다.
    "핑퐁 버퍼를 이용한 레이어 구워넣기" 및 "올바른 스트림 생명주기 관리" 전략을 통해
    대용량 파일 처리 시 발생하는 메모리, 파일 잠금, 객체 폐기 오류를 모두 해결합니다.

.DESCRIPTION
    이 스크립트는 안정성을 극대화하기 위해 설계되었습니다. 각 PNG 에셋은 파일 스트림을 통해
    메모리 효율적으로 레이어로 변환됩니다. 'BatchSize'에 도달하면, 현재까지 작업한 내용을
    두 개의 임시 파일 중 하나에 번갈아 저장(핑퐁)하여 파일 잠금 문제를 방지합니다.
    가장 중요한 점은, 레이어 데이터가 필요한 .Save() 메소드가 완료된 직후에만 파일 스트림을 닫아
    'Cannot access a disposed object' 오류를 원천적으로 차단합니다.

.PARAMETER AssetJson
    'extract-psd.ps1' 스크립트를 통해 생성된, 에셋 목록이 포함된 JSON 파일의 경로입니다. (필수)

.PARAMETER OutputPath
    결과물로 생성될 PSD 파일의 전체 경로입니다. 지정하지 않으면 입력 JSON 파일과 동일한 디렉토리에 생성됩니다. (선택)

.PARAMETER BatchSize
    메모리 관리를 위해 레이어를 임시 파일에 "구워넣기"할 배치 크기입니다. 
    값이 작을수록 메모리 사용은 줄지만 파일 I/O가 잦아져 속도가 느려질 수 있습니다. (기본값: 20)

.PARAMETER Silent
    스크립트 실행 중 상세한 진행 상황 출력을 생략하고, 최종 결과 JSON 파일의 경로만 출력합니다.

.EXAMPLE
    .\compose-psd-final.ps1 -AssetJson "C:\project\assets.json" -BatchSize 25
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$AssetJson,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,

    [Parameter(Mandatory = $false)]
    [int]$BatchSize = 20,

    [switch]$Silent
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

#region ===== Aspose.PSD 로더 및 Helper Functions (변경 없음) =====
function Load-AsposePSD {
    $packageDir = "$PSScriptRoot/aspose-packages"
    if (-not (Test-Path $packageDir)) { New-Item -ItemType Directory -Path $packageDir -Force | Out-Null }
    $asposePsdDll = "$packageDir/Aspose.PSD.dll"
    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages..."
        $tempDir = "$PSScriptRoot/temp-packages"; if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
        try {
            Set-Location $PSScriptRoot; dotnet new console -n TempProject -o $tempDir --force | Out-Null; Set-Location $tempDir
            dotnet add package Aspose.PSD --version 24.12.0 | Out-Null; dotnet add package Aspose.Drawing --version 24.12.0 | Out-Null; dotnet restore | Out-Null
            $packagesPath = "$env:USERPROFILE\.nuget\packages"
            (Get-ChildItem "$packagesPath/aspose.psd/*/lib/net8.0/*.dll" -EA SilentlyContinue | Select-Object -First 1).FullName | ForEach-Object { Copy-Item $_ "$packageDir/Aspose.PSD.dll" -Force }
            (Get-ChildItem "$packagesPath/aspose.drawing/*/lib/net8.0/*.dll" -EA SilentlyContinue | Select-Object -First 1).FullName | ForEach-Object { Copy-Item $_ "$packageDir/Aspose.Drawing.dll" -Force }
            foreach ($dep in @("newtonsoft.json/*/lib/net6.0/*.dll","system.drawing.common/*/lib/net8.0/*.dll","system.text.encoding.codepages/*/lib/net8.0/*.dll")) {
                $p = Get-ChildItem "$packagesPath/$dep" -EA SilentlyContinue | Select-Object -First 1; if ($p) { Copy-Item $p.FullName $packageDir -Force }
            }
        } catch { Write-Error "Failed to download packages: $_"; Set-Location $PSScriptRoot; return $false }
        finally { Set-Location $PSScriptRoot; if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir -EA SilentlyContinue } }
    }
    try {
        Add-Type -AssemblyName "System.Text.Encoding.CodePages" -EA SilentlyContinue; [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)
        foreach ($dep in @("System.Text.Encoding.CodePages.dll","Newtonsoft.Json.dll","System.Drawing.Common.dll")) {
            $p = Join-Path $packageDir $dep; if (Test-Path $p) { Add-Type -Path $p -EA SilentlyContinue }
        }
        Add-Type -Path "$packageDir/Aspose.Drawing.dll"; Add-Type -Path $asposePsdDll; return $true
    } catch { Write-Error "Error loading Aspose.PSD: $_"; return $false }
}

function Clear-Memory {
    param([switch]$Force)
    [System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers()
    if ($Force) { [System.GC]::Collect(2, [System.GCCollectionMode]::Forced, $true, $true) }
}

function Create-LayerFromPNG-Stream {
    param([string]$PngFilePath, [string]$LayerName, $Bounds)
    try {
        if (-not (Test-Path $PngFilePath)) { return $null }
        $stream = [System.IO.File]::OpenRead($PngFilePath)
        $layer = New-Object Aspose.PSD.FileFormats.Psd.Layers.Layer($stream)
        $layer.Name = $LayerName; $layer.DisplayName = $LayerName
        if ($Bounds) {
            $layer.Left = $Bounds.Left; $layer.Top = $Bounds.Top; $layer.Right = $Bounds.Right; $layer.Bottom = $Bounds.Bottom
        }
        return @{ Layer = $layer; Stream = $stream }
    } catch { return $null }
}
#endregion

# ===== Main Script Body =====
$startTime = Get-Date

if (-not $Silent) {
    Write-Host "Starting PSD composition at $startTime" -ForegroundColor Cyan
    Write-Host "Using robust Ping-Pong Buffer strategy for bake-in. BatchSize: $BatchSize"
}

if (-not (Test-Path $AssetJson)) { Write-Error "Asset JSON file not found: $AssetJson"; exit 1 }
if (-not (Load-AsposePSD)) { Write-Error "Failed to load Aspose.PSD libraries"; exit 1 }

$result = [ordered]@{
    InputAssetFile = (Resolve-Path -LiteralPath $AssetJson).Path; OutputFile = ""; StartTime = $startTime.ToString("o")
    EndTime = $null; Duration = $null; TotalAssetsProcessed = 0; SuccessfulCompositions = 0; FailedCompositions = 0
    ProcessedAssets = @(); FailedAssets = @(); Status = ""; MemoryMode = "Robust (Ping-Pong Bake-in)"
}

# 핑퐁 버퍼를 위한 두 개의 고유한 임시 파일 경로 생성
$guid = (Get-Random).ToString()
$tempPsdPathA = Join-Path ([System.IO.Path]::GetTempPath()) "temp_comp_A_$guid.psd"
$tempPsdPathB = Join-Path ([System.IO.Path]::GetTempPath()) "temp_comp_B_$guid.psd"
$currentTempSourceFile = $null

try {
    $assetContent = Get-Content -LiteralPath $AssetJson -Raw -Encoding UTF8
    $assetData = $assetContent | ConvertFrom-Json
    
    if (-not $assetData.ExtractedLayers -or $assetData.ExtractedLayers.Count -eq 0) {
        Write-Error "No extracted layers found in asset JSON"; exit 1
    }
    $result.TotalAssetsProcessed = $assetData.ExtractedLayers.Count
    
    # 출력 파일 경로 결정
    if (-not [string]::IsNullOrEmpty($OutputPath)) { $outputFilePath = $OutputPath } 
    else {
        $assetJsonDir = Split-Path -Parent $AssetJson; if ([string]::IsNullOrEmpty($assetJsonDir)) { $assetJsonDir = Get-Location }
        $timestamp = $startTime.ToString("yyyyMMdd_HHmmss"); $baseName = [System.IO.Path]::GetFileNameWithoutExtension($AssetJson)
        $outputFilePath = Join-Path $assetJsonDir ("{0}_composed_{1}.psd" -f $baseName, $timestamp)
    }
    
    $result.OutputFile = [System.IO.Path]::GetFullPath($outputFilePath)
    $outputDir = Split-Path -Parent $outputFilePath
    if (-not [string]::IsNullOrEmpty($outputDir) -and -not (Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir -Force | Out-Null }

    # Canvas 크기 결정
    $canvasWidth = 1920; $canvasHeight = 1080
    if ($assetData.PSObject.Properties.Name -contains "CanvasWidth" -and $assetData.CanvasWidth -gt 0) { $canvasWidth = $assetData.CanvasWidth }
    if ($assetData.PSObject.Properties.Name -contains "CanvasHeight" -and $assetData.CanvasHeight -gt 0) { $canvasHeight = $assetData.CanvasHeight }
    
    if (-not $Silent) { Write-Host "Creating new PSD canvas: ${canvasWidth}x${canvasHeight}" }
    $composedImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($canvasWidth, $canvasHeight)
    
    try {
        $processedCount = 0; $totalLayers = $assetData.ExtractedLayers.Count
        # ★ 핵심: 현재 배치에서 활성화된 스트림 목록. 이 스트림들은 배치가 저장된 후에만 닫힙니다.
        $activeStreams = [System.Collections.Generic.List[System.IO.Stream]]::new()

        foreach ($extractedLayer in $assetData.ExtractedLayers) {
            $processedCount++
            try {
                $assetFilePath = $extractedLayer.FilePath
                if (-not [System.IO.Path]::IsPathRooted($assetFilePath)) {
                    $assetDir = Split-Path -Parent $AssetJson; if ([string]::IsNullOrEmpty($assetDir)) { $assetDir = Get-Location }
                    $assetFilePath = Join-Path $assetDir $assetFilePath
                }
                
                if (-not (Test-Path $assetFilePath)) {
                    if (-not $Silent) { Write-Warning "Asset file not found: $assetFilePath" }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - file not found: $assetFilePath"; $result.FailedCompositions++; continue
                }
                
                if (-not $Silent) { Write-Host "($processedCount/$totalLayers) Processing: $($extractedLayer.Name)" }
                
                $layerInfo = Create-LayerFromPNG-Stream -PngFilePath $assetFilePath -LayerName $extractedLayer.Name -Bounds $extractedLayer.Bounds
                
                if ($layerInfo) {
                    $composedImage.AddLayer($layerInfo.Layer)
                    $activeStreams.Add($layerInfo.Stream) # 스트림을 닫지 않고 활성 목록에 추가
                    $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - added to batch"
                    $result.SuccessfulCompositions++
                } else {
                    if (-not $Silent) { Write-Warning "Failed to create layer from PNG: $($extractedLayer.Name)" }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - failed to create layer from PNG"; $result.FailedCompositions++; continue
                }
                
                # 배치 처리 조건: BatchSize에 도달했고, 마지막 레이어가 아닐 경우
                if (($processedCount % $BatchSize -eq 0) -and ($processedCount -lt $totalLayers)) {
                    if (-not $Silent) { Write-Host "Baking in batch of $BatchSize layers..." -ForegroundColor Yellow }
                    
                    # 1. 핑퐁: 다음 저장할 대상 임시 파일을 결정합니다. (A -> B, B -> A)
                    $targetTempFile = if ($currentTempSourceFile -eq $tempPsdPathA) { $tempPsdPathB } else { $tempPsdPathA }
                    
                    # 2. 결정된 대상 파일에 저장합니다. 이 시점에 .Save()는 모든 활성 스트림에 접근할 수 있습니다.
                    $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
                    $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Rle
                    $composedImage.Save($targetTempFile, $saveOptions)
                    
                    # 3. ★ 중요: 저장이 완료된 후, 이번 배치에 사용된 모든 스트림을 닫습니다.
                    $activeStreams | ForEach-Object { $_.Close(); $_.Dispose() }; $activeStreams.Clear()
                    
                    # 4. 기존 이미지 객체 폐기 및 메모리 정리
                    $composedImage.Dispose(); $composedImage = $null; Clear-Memory -Force
                    
                    # 5. 다음 단계를 위해 소스 파일을 방금 저장한 파일로 업데이트하고, 다시 로드합니다.
                    $currentTempSourceFile = $targetTempFile
                    $composedImage = [Aspose.PSD.Image]::Load($currentTempSourceFile) -as [Aspose.PSD.FileFormats.Psd.PsdImage]
                    if (-not $Silent) { Write-Host "  ...Bake-in complete. Resuming from '$((Split-Path $currentTempSourceFile -Leaf))'." -ForegroundColor Green }
                }

            } catch {
                $errorMsg = $_.Exception.ToString()
                if (-not $Silent) { Write-Error "Failed to process layer '$($extractedLayer.Name)': $errorMsg" }
                $result.FailedAssets += "Layer '$($extractedLayer.Name)' - $errorMsg"; $result.FailedCompositions++;
            }
        }
        
        # 모든 루프가 끝난 후, 최종적으로 PSD 파일 저장
        if (-not $Silent) { Write-Host "Performing final save to: $outputFilePath" }
        if (Test-Path $outputFilePath) { Remove-Item -Path $outputFilePath -Force }

        $finalSaveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
        $finalSaveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Rle
        $composedImage.Save($outputFilePath, $finalSaveOptions)
        
        # ★ 중요: 최종 저장이 끝난 후, 마지막 배치에 속해있던 스트림들을 모두 닫습니다.
        $activeStreams | ForEach-Object { $_.Close(); $_.Dispose() }; $activeStreams.Clear()
        
        if (-not $Silent) {
            $composedFileSize = (Get-Item $outputFilePath).Length
            Write-Host "✓ PSD composition completed successfully. File size: $(Format-FileSize $composedFileSize)" -ForegroundColor Green
        }
        $result.Status = "Success"
        
    } finally {
        if ($composedImage) { $composedImage.Dispose(); $composedImage = $null }
        # 두 개의 임시 파일을 모두 정리합니다.
        if (Test-Path $tempPsdPathA) { Remove-Item -Path $tempPsdPathA -Force -EA SilentlyContinue }
        if (Test-Path $tempPsdPathB) { Remove-Item -Path $tempPsdPathB -Force -EA SilentlyContinue }
    }
    
} catch {
    $errorMsg = $_.Exception.ToString()
    Write-Error "A critical error occurred during PSD composition: $errorMsg"
    $result.Status = "Failed"; $result.FailedAssets += "Critical error: $errorMsg"
} finally {
    $endTime = Get-Date; $result.EndTime = $endTime.ToString("o"); $result.Duration = ($endTime - $startTime).ToString()
    
    if (-not $Silent) {
        Write-Host "Composition finished at $endTime. Duration: $($result.Duration)"
        Write-Host "--- Summary ---"; Write-Host "  - Total Assets: $($result.TotalAssetsProcessed)"; Write-Host "  - Successful: $($result.SuccessfulCompositions)"; Write-Host "  - Failed: $($result.FailedCompositions)"
        if ($result.FailedCompositions -gt 0) {
            Write-Warning "Failed assets details:"; foreach ($failedAsset in $result.FailedAssets) { Write-Warning "  - $failedAsset" }
        }
    }
    
    $jsonOutput = $result | ConvertTo-Json -Depth 8
    $jsonDir = Split-Path $result.OutputFile -Parent; if (-not (Test-Path $jsonDir)) { $jsonDir = Get-Location }
    $jsonFilePath = Join-Path $jsonDir ("composition_result_{0}.json" -f $startTime.ToString("yyyyMMdd_HHmmss"))
    
    try {
        $jsonOutput | Set-Content -LiteralPath $jsonFilePath -Encoding UTF8 -Force
        if (-not $Silent) { Write-Host "Composition result saved to: $jsonFilePath" }
    } catch { Write-Error "Failed to save result JSON file: $_" }
    
    if ($Silent) { Write-Output $jsonFilePath } else { Write-Output $jsonOutput }
    
    Clear-Memory -Force
}