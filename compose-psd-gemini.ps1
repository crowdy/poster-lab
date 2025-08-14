<#
.SYNOPSIS
    Extract-PSD 스크립트에서 생성된 asset JSON 파일을 기반으로 여러 PNG 파일을 조합하여 단일 PSD 파일을 생성합니다.
    대용량/다량의 PNG 파일을 처리할 때 발생하는 메모리 문제를 해결하기 위해 "레이어 구워넣기(Bake-in)" 전략을 사용합니다.

.DESCRIPTION
    이 스크립트는 지정된 JSON 파일에 정의된 각 PNG 에셋을 읽어와서 Aspose.PSD 라이브러리를 사용해 PSD 레이어로 변환합니다.
    메모리 사용량이 한계에 도달하는 것을 방지하기 위해, 'BatchSize' 매개변수에 지정된 개수만큼의 레이어를 처리할 때마다
    현재까지의 작업물을 임시 PSD 파일에 저장("구워넣기")한 후, 해당 파일을 다시 불러와 작업을 계속합니다.
    이 과정을 통해 메모리 점유율을 주기적으로 초기화하여 'OutOfMemoryException' 오류 없이 매우 큰 PSD 파일도 안정적으로 생성할 수 있습니다.

.PARAMETER AssetJson
    'extract-psd.ps1' 스크립트를 통해 생성된, 에셋 목록이 포함된 JSON 파일의 경로입니다. (필수)

.PARAMETER OutputPath
    결과물로 생성될 PSD 파일의 전체 경로입니다. 지정하지 않으면 입력 JSON 파일과 동일한 디렉토리에 생성됩니다. (선택)

.PARAMETER BatchSize
    메모리 관리를 위해 레이어를 임시 파일에 "구워넣기"할 배치 크기입니다. 
    시스템 사양에 따라 이 값을 조절할 수 있습니다. (기본값: 20)

.PARAMETER Silent
    스크립트 실행 중 상세한 진행 상황 출력을 생략하고, 최종 결과 JSON 파일의 경로만 출력합니다.

.PARAMETER LowMemoryMode
    메모리 최적화를 더욱 공격적으로 수행합니다. 현재는 'BatchSize' 사용과 동일한 효과를 냅니다.

.EXAMPLE
    .\compose-psd-optimized.ps1 -AssetJson "C:\project\assets_v2.json" -OutputPath "C:\project\final_composed.psd" -BatchSize 30
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$AssetJson,                 # Path to the asset JSON file from extract-psd

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,                # Output path for the composed PSD file (optional)

    [Parameter(Mandatory = $false)]
    [int]$BatchSize = 20,                # Number of layers to process before baking them into a temp file

    [switch]$Silent,                    # Silent mode - only output result JSON file path
    
    [switch]$LowMemoryMode              # Enable aggressive memory optimization
)

# PowerShell Core 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

#region ===== Aspose.PSD 로더 =====
# .NET 패키지를 다운로드하고 필요한 DLL을 로드하는 함수입니다.
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
#endregion

#region ===== Helper Functions =====
# 파일 크기를 가져오는 함수
function Get-FileSize {
    param([string]$FilePath)
    if (Test-Path $FilePath) { return (Get-Item $FilePath).Length }
    return 0
}

# 파일 크기를 읽기 쉬운 형식(KB, MB, GB)으로 변환하는 함수
function Format-FileSize {
    param([long]$Size)
    if ($Size -ge 1GB) { return "{0:N2} GB" -f ($Size / 1GB) }
    elseif ($Size -ge 1MB) { return "{0:N2} MB" -f ($Size / 1MB) }
    elseif ($Size -ge 1KB) { return "{0:N2} KB" -f ($Size / 1KB) }
    else { return "{0:N0} bytes" -f $Size }
}

# .NET 가비지 컬렉터를 호출하여 메모리를 정리하는 함수
function Clear-Memory {
    param([switch]$Force)
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    if ($Force) {
        # 강제 모드는 더 깊고 공격적인 메모리 정리를 수행합니다.
        [System.GC]::Collect(2, [System.GCCollectionMode]::Forced, $true, $true)
    }
}

# 메모리 효율적인 스트림 방식을 사용하여 PNG 파일로부터 Aspose.PSD 레이어를 생성하는 함수
function Create-LayerFromPNG-Stream {
    param(
        [string]$PngFilePath,
        [string]$LayerName,
        $Bounds,
        [switch]$DebugMode
    )
    
    try {
        if (-not (Test-Path $PngFilePath)) {
            if ($DebugMode) { Write-Warning "PNG file not found: $PngFilePath" }
            return $null
        }
        
        # 파일을 스트림으로 엽니다. 이렇게 하면 파일 전체를 메모리에 로드하지 않아도 됩니다.
        $stream = [System.IO.File]::OpenRead($PngFilePath)
        $layer = New-Object Aspose.PSD.FileFormats.Psd.Layers.Layer($stream)
        $layer.Name = $LayerName
        $layer.DisplayName = $LayerName
        
        if ($Bounds) {
            $layer.Left = $Bounds.Left
            $layer.Top = $Bounds.Top
            $layer.Right = $Bounds.Right
            $layer.Bottom = $Bounds.Bottom
        }
            
        # 중요: 스트림은 레이어가 PSD에 완전히 기록된 후에 닫아야 합니다.
        # 따라서 레이어 객체와 스트림 객체를 함께 반환하여 호출자가 관리하도록 합니다.
        return @{ Layer = $layer; Stream = $stream }
        
    } catch {
        if ($DebugMode) { Write-Error "Failed to create layer from PNG (stream) '$PngFilePath': $($_.Exception.Message)" }
        return $null
    }
}
#endregion

# ===== Main Script Body =====
$startTime = Get-Date

if (-not $Silent) {
    Write-Host "Starting PSD composition at $startTime" -ForegroundColor Cyan
    if ($LowMemoryMode) {
        Write-Host "Low Memory Mode: ENABLED"
        Write-Host "Batch Size for bake-in: $BatchSize layers"
    }
}

# 입력 파일 검증 및 라이브러리 로드
if (-not (Test-Path $AssetJson)) { Write-Error "Asset JSON file not found: $AssetJson"; exit 1 }
if (-not (Load-AsposePSD)) { Write-Error "Failed to load Aspose.PSD libraries"; exit 1 }

# 결과 기록을 위한 객체 초기화
$result = [ordered]@{
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
    MemoryMode = "Optimized (Bake-in)"
}

# "구워넣기"를 위한 임시 파일 경로 설정
$tempPsdPath = Join-Path ([System.IO.Path]::GetTempPath()) "temp_composition_$(Get-Random).psd"

try {
    # Asset JSON 파일 로드
    $assetContent = Get-Content -LiteralPath $AssetJson -Raw -Encoding UTF8
    $assetData = $assetContent | ConvertFrom-Json
    
    if (-not $assetData.ExtractedLayers -or $assetData.ExtractedLayers.Count -eq 0) {
        Write-Error "No extracted layers found in asset JSON"; exit 1
    }
    
    $result.TotalAssetsProcessed = $assetData.ExtractedLayers.Count
    
    # 출력 파일 경로 결정
    if (-not [string]::IsNullOrEmpty($OutputPath)) {
        $outputFilePath = $OutputPath
    } else {
        $assetJsonDir = Split-Path -Parent $AssetJson
        if ([string]::IsNullOrEmpty($assetJsonDir)) { $assetJsonDir = Get-Location }
        $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($AssetJson)
        $outputFileName = "{0}_composed_{1}.psd" -f $baseName, $timestamp
        $outputFilePath = Join-Path $assetJsonDir $outputFileName
    }
    
    $result.OutputFile = (Resolve-Path -LiteralPath $outputFilePath).Path
    $outputDir = Split-Path -Parent $outputFilePath
    if (-not [string]::IsNullOrEmpty($outputDir) -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    # Canvas 크기 결정
    $canvasWidth = 1920
    $canvasHeight = 1080
    if ($assetData.PSObject.Properties.Name -contains "CanvasWidth" -and $assetData.CanvasWidth -gt 0) { $canvasWidth = $assetData.CanvasWidth }
    if ($assetData.PSObject.Properties.Name -contains "CanvasHeight" -and $assetData.CanvasHeight -gt 0) { $canvasHeight = $assetData.CanvasHeight }
    
    # 빈 PSD 이미지 생성으로 작업 시작
    if (-not $Silent) { Write-Host "Creating new PSD canvas: ${canvasWidth}x${canvasHeight}" }
    $composedImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($canvasWidth, $canvasHeight)
    
    try {
        $processedCount = 0
        $totalLayers = $assetData.ExtractedLayers.Count
        # 파일 핸들(스트림) 누수를 막기 위해 열린 스트림 목록을 관리합니다.
        $streamsToClose = [System.Collections.Generic.List[System.IO.Stream]]::new()

        # JSON에 명시된 모든 PNG 에셋을 순회하며 레이어로 추가
        foreach ($extractedLayer in $assetData.ExtractedLayers) {
            $processedCount++
            try {
                # 에셋 파일의 절대 경로 확인
                $assetFilePath = $extractedLayer.FilePath
                if (-not [System.IO.Path]::IsPathRooted($assetFilePath)) {
                    $assetDir = Split-Path -Parent $AssetJson
                    if ([string]::IsNullOrEmpty($assetDir)) { $assetDir = Get-Location }
                    $assetFilePath = Join-Path $assetDir $assetFilePath
                }
                
                if (-not (Test-Path $assetFilePath)) {
                    if (-not $Silent) { Write-Warning "Asset file not found: $assetFilePath" }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - file not found: $assetFilePath"; $result.FailedCompositions++; continue
                }
                
                if (-not $Silent) { Write-Host "($processedCount/$totalLayers) Processing: $($extractedLayer.Name)" }
                
                # 스트림 방식으로 PNG에서 레이어 생성
                $layerInfo = Create-LayerFromPNG-Stream -PngFilePath $assetFilePath -LayerName $extractedLayer.Name -Bounds $extractedLayer.Bounds -DebugMode:(-not $Silent)
                
                if ($layerInfo) {
                    $composedImage.AddLayer($layerInfo.Layer)
                    $streamsToClose.Add($layerInfo.Stream) # 나중에 닫기 위해 스트림을 목록에 추가
                    $result.ProcessedAssets += "Layer '$($extractedLayer.Name)' - successfully added"
                    $result.SuccessfulCompositions++
                } else {
                    if (-not $Silent) { Write-Warning "Failed to create layer from PNG: $($extractedLayer.Name)" }
                    $result.FailedAssets += "Asset '$($extractedLayer.Name)' - failed to create layer from PNG"; $result.FailedCompositions++; continue
                }
                
                # ★★★ 핵심 전략: 배치 처리 및 "레이어 구워넣기" ★★★
                # BatchSize에 도달했고, 마지막 레이어가 아닐 경우 실행합니다.
                if (($processedCount % $BatchSize -eq 0) -and ($processedCount -lt $totalLayers)) {
                    if (-not $Silent) { Write-Host "Baking in $processedCount layers to manage memory..." -ForegroundColor Yellow }
                    
                    # 1. 열려있는 모든 파일 스트림을 닫아서 파일 저장이 가능하도록 합니다.
                    $streamsToClose | ForEach-Object { $_.Close(); $_.Dispose() }
                    $streamsToClose.Clear()

                    # 2. 현재까지의 레이어를 임시 PSD 파일로 저장합니다.
                    $saveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
                    $saveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Rle
                    $composedImage.Save($tempPsdPath, $saveOptions)
                    
                    # 3. 기존 이미지 객체를 메모리에서 완전히 해제합니다.
                    $composedImage.Dispose()
                    $composedImage = $null
                    Clear-Memory -Force
                    
                    # 4. 저장했던 임시 PSD 파일을 다시 로드하여 작업을 이어갑니다.
                    # 이 과정에서 메모리가 재설정되고 최적화됩니다.
                    $composedImage = [Aspose.PSD.Image]::Load($tempPsdPath) -as [Aspose.PSD.FileFormats.Psd.PsdImage]
                    if (-not $Silent) { Write-Host "  ...Bake-in complete. Resuming composition." -ForegroundColor Green }
                }

            } catch {
                $errorMsg = $_.Exception.Message
                if (-not $Silent) { Write-Error "Failed to process PNG asset '$($extractedLayer.Name)': $errorMsg" }
                $result.FailedAssets += "Asset '$($extractedLayer.Name)' - $errorMsg"; $result.FailedCompositions++
            }
        }
        
        # 루프 종료 후, 마지막 배치에 남아있던 스트림들을 모두 닫습니다.
        $streamsToClose | ForEach-Object { $_.Close(); $_.Dispose() }
        
        # 모든 레이어 추가 후 최종 PSD 파일 저장
        if (-not $Silent) { Write-Host "Performing final save to: $outputFilePath" }
        if (Test-Path $outputFilePath) { Remove-Item -Path $outputFilePath -Force }

        $finalSaveOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions
        $finalSaveOptions.CompressionMethod = [Aspose.PSD.FileFormats.Psd.CompressionMethod]::Rle
        $composedImage.Save($outputFilePath, $finalSaveOptions)
        
        if (-not $Silent) {
            if (Test-Path $outputFilePath) {
                $composedFileSize = Get-FileSize -FilePath $outputFilePath
                Write-Host "✓ PSD composition completed successfully. File size: $(Format-FileSize -Size $composedFileSize)" -ForegroundColor Green
            }
        }
        $result.Status = "Success"
        
    } finally {
        # 스크립트 실행 중 오류가 발생하더라도 이 블록은 항상 실행됩니다.
        if ($composedImage) { $composedImage.Dispose(); $composedImage = $null }
        # 생성된 임시 파일을 깨끗하게 삭제합니다.
        if (Test-Path $tempPsdPath) { Remove-Item -Path $tempPsdPath -Force }
    }
    
} catch {
    $errorMsg = $_.Exception.Message
    Write-Error "A critical error occurred during PSD composition: $errorMsg"
    $result.Status = "Failed"
    $result.FailedAssets += "Critical composition error: $errorMsg"
} finally {
    # 스크립트의 성공/실패와 관계없이 최종 정리 및 결과 보고를 수행합니다.
    $endTime = Get-Date
    $result.EndTime = $endTime.ToString("o")
    $result.Duration = ($endTime - $startTime).ToString()
    
    if (-not $Silent) {
        Write-Host "Composition finished at $endTime. Duration: $($result.Duration)"
        Write-Host "--- Summary ---"
        Write-Host "  - Total PNG Assets: $($result.TotalAssetsProcessed)"
        Write-Host "  - Successfully Composed: $($result.SuccessfulCompositions)"
        Write-Host "  - Failed: $($result.FailedCompositions)"
        
        if ($result.FailedCompositions -gt 0) {
            Write-Warning "Failed assets details:"
            foreach ($failedAsset in $result.FailedAssets) {
                Write-Warning "  - $failedAsset"
            }
        }
    }
    
    # 결과 요약 정보를 JSON 파일로 저장합니다.
    $jsonOutput = $result | ConvertTo-Json -Depth 8
    $timestamp = $startTime.ToString("yyyyMMdd_HHmmss")
    $jsonFileName = "composition_result_$timestamp.json"
    $jsonDir = if ($result.OutputFile) { Split-Path -Parent $result.OutputFile } else { Get-Location }
    $jsonFilePath = Join-Path $jsonDir $jsonFileName
    
    try {
        $jsonOutput | Set-Content -LiteralPath $jsonFilePath -Encoding UTF8 -Force
        if (-not $Silent) {
            Write-Host "Composition result saved to: $jsonFilePath"
        }
    } catch {
        Write-Error "Failed to save result JSON file: $_"
    }
    
    # Silent 모드에 따라 최종 출력을 결정합니다.
    if ($Silent) {
        Write-Output $jsonFilePath
    } else {
        # 결과를 콘솔에도 예쁘게 출력합니다.
        Write-Output $jsonOutput
    }
    
    # 마지막으로 메모리를 정리합니다.
    Clear-Memory -Force
}
