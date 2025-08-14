<# 
.SYNOPSIS
  PSD를 PNG로 변환합니다. (Aspose.PSD 사용)

.PARAMETER InputFile
  입력 PSD 파일 경로 (필수)

.PARAMETER OutputFileFile
  출력 PNG 파일 경로 (선택, 미지정 시 입력 경로의 확장자를 .png로 변경)

.PARAMETER CompressionLevel
  PNG 압축 레벨 (0~9, 기본 6)

.PARAMETER Silent
  true면 콘솔에 JSON 내용을 찍지 않고 JSON 파일 경로만 출력
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,

    [Parameter(Mandatory = $false)]
    [string]$OutputFile,

    [Parameter(Mandatory = $false)]
    [ValidateRange(0,9)]
    [int]$CompressionLevel = 6,

    [Parameter(Mandatory = $false)]
    [bool]$Silent = $false
)

# ----- 기본 환경 체크 -----
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다. 'pwsh'로 실행하세요."
    exit 1
}

# ----- Aspose.PSD 로더 (PowerShell용) -----
function Load-AsposePSD {
    $packageDir = "$PSScriptRoot/aspose-packages"
    if (-not (Test-Path $packageDir)) {
        New-Item -ItemType Directory -Path $packageDir -Force | Out-Null
    }

    $asposeDrawingDll = Join-Path $packageDir "Aspose.Drawing.dll"
    $asposePsdDll     = Join-Path $packageDir "Aspose.PSD.dll"

    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages for .NET 8.0..."

        $tempDir = "$PSScriptRoot/temp-packages"
        if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }

        try {
            Set-Location $PSScriptRoot
            dotnet new console -n TempProject -o $tempDir --force | Out-Null
            Set-Location $tempDir

            # 버전은 사용 중 코드에 맞춰 고정
            dotnet add package Aspose.PSD --version 24.12.0 | Out-Null
            dotnet add package Aspose.Drawing --version 24.12.0 | Out-Null
            dotnet restore | Out-Null

            $packagesPath = "$env:USERPROFILE\.nuget\packages"

            $asposePsdPath = Get-ChildItem "$packagesPath/aspose.psd/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($asposePsdPath) { Copy-Item $asposePsdPath.FullName $asposePsdDll -Force; Write-Host "✓ Aspose.PSD.dll copied" }

            $asposeDrawingPath = Get-ChildItem "$packagesPath/aspose.drawing/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($asposeDrawingPath) { Copy-Item $asposeDrawingPath.FullName $asposeDrawingDll -Force; Write-Host "✓ Aspose.Drawing.dll copied" }

            $dependencies = @(
                "newtonsoft.json/*/lib/net6.0/*.dll",
                "system.drawing.common/*/lib/net8.0/*.dll",
                "system.text.encoding.codepages/*/lib/net8.0/*.dll"
            )
            foreach ($dep in $dependencies) {
                $depPath = Get-ChildItem "$packagesPath/$dep" -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($depPath) { Copy-Item $depPath.FullName $packageDir -Force; Write-Host "✓ $($depPath.Name) copied" }
            }

            Set-Location $PSScriptRoot
            Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
            Write-Host "Aspose.PSD packages downloaded successfully."
        } catch {
            Write-Error "Failed to download packages: $_"
            Set-Location $PSScriptRoot
            return $false
        }
    }

    try {
        Write-Host "Loading .NET 8.0 compatible libraries..."

        foreach ($dep in @(
            "System.Text.Encoding.CodePages.dll",
            "Newtonsoft.Json.dll",
            "System.Drawing.Common.dll"
        )) {
            $depPath = Join-Path $packageDir $dep
            if (Test-Path $depPath) {
                Add-Type -Path $depPath -ErrorAction SilentlyContinue
                Write-Host "✓ $dep loaded"
            }
        }

        Add-Type -Path $asposeDrawingDll
        Write-Host "✓ Aspose.Drawing.dll loaded"

        Add-Type -Path $asposePsdDll
        Write-Host "✓ Aspose.PSD.dll loaded"

        return $true
    } catch {
        Write-Error "Error loading Aspose.PSD: $_"
        return $false
    }
}

# ----- 레이어 필터링 로직 (C#과 동일한 기준) -----
function Should-IgnoreLayer {
    param($Layer)
    try {
        $hasNoImage = ($Layer.Bounds.Width -le 0) -or ($Layer.Bounds.Height -le 0)
        return (-not $Layer.IsVisible) -or ($Layer.Opacity -eq 0) -or $hasNoImage
    } catch {
        return $false
    }
}

function Process-LayerVisibility {
    param([Array]$Layers)
    foreach ($layer in $Layers) {
        # 그룹은 하위 레이어 먼저 처리
        if ($layer.GetType().FullName -like "*LayerGroup*") {
            try {
                if ($layer.Layers) {
                    Process-LayerVisibility -Layers $layer.Layers
                }
            } catch { }
        }
        if (Should-IgnoreLayer $layer) {
            try { $layer.IsVisible = $false } catch { }
        }
    }
}

# ----- 메인 로직 -----
$startTime = Get-Date
Write-Host "Starting PSD to PNG conversion at $startTime"

try {
    if (-not (Test-Path $InputFile)) {
        Write-Error "InputFile PSD file not found: $InputFile"
        exit 1
    }

    if (-not (Load-AsposePSD)) {
        Write-Error "Aspose.PSD 로드 실패"
        exit 1
    }

    # 출력 경로 결정 (절대 경로로 변환)
    $outputPath = if ([string]::IsNullOrWhiteSpace($OutputFile)) {
        [IO.Path]::ChangeExtension((Resolve-Path $InputFile).Path, ".png")
    } else {
        # 상대 경로를 절대 경로로 변환
        if ([IO.Path]::IsPathRooted($OutputFile)) {
            $OutputFile
        } else {
            Join-Path (Get-Location).Path $OutputFile
        }
    }
    
    # 절대 경로로 해결
    $outputPath = [IO.Path]::GetFullPath($outputPath)

    # 출력 디렉토리 생성
    $outDir = [IO.Path]::GetDirectoryName($outputPath)
    if (-not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
        Write-Host "Created output directory: $outDir"
    }

    # 결과 객체 (C# ConversionResult 대응)
    $result = [ordered]@{
        InputFile   = (Resolve-Path $InputFile).Path
        OutputFile  = $outputPath
        StartTime   = $startTime
        EndTime     = $null
        Duration    = $null
        Width       = 0
        Height      = 0
        LayerCount  = 0
        Status      = "Processing"
        ErrorMessage = $null
    }

    try {
        # PSD 로드
        $image = [Aspose.PSD.Image]::Load($result.InputFile)
        $result.Width      = $image.Width
        $result.Height     = $image.Height
        $result.LayerCount = $image.Layers.Count

        Write-Host ("PSD loaded. Size: {0}x{1}, Layers: {2}" -f $result.Width, $result.Height, $result.LayerCount)

        # 레이어 가시성 처리 (보이지 않음/불투명/이미지없음 → 숨김)
        Process-LayerVisibility -Layers $image.Layers
        Write-Host "Processed layer visibility (ignored invisible/empty layers)"

        # PNG 옵션
        $pngOptions = [Aspose.PSD.ImageOptions.PngOptions]::new()
        $pngOptions.CompressionLevel = $CompressionLevel  # 0~9

        # 저장
        Write-Host "Converting PSD to PNG..."
        $image.Save($outputPath, $pngOptions)

        # 저장 검증/로그
        if (Test-Path -LiteralPath $outputPath) {
            Write-Host "PSD successfully converted to PNG: $outputPath"
        } else {
            Write-Warning "Save reported success but file not found at: $outputPath"
        }

        $result.Status = "Success"
        $image.Dispose()
    } catch {
        $result.Status = "Failed"
        $result.ErrorMessage = $_.Exception.Message
        Write-Error "Error converting PSD: $($_.Exception.Message)"
        if ($image) { try { $image.Dispose() } catch {} }
    } finally {
        $endTime = Get-Date
        $result.EndTime = $endTime
        $result.Duration = ($endTime - $startTime)
    }

    # 결과 JSON 저장/출력
    $InputFileName = [IO.Path]::GetFileNameWithoutExtension($result.InputFile)
    $timestamp = (Get-Date $startTime -Format "yyyyMMdd_HHmmss")
    $jsonName  = "conversion_result_{0}_{1}.json" -f $InputFileName, $timestamp
    $jsonPath  = Join-Path $outDir $jsonName

    $json = $result | ConvertTo-Json -Depth 5
    Set-Content -LiteralPath $jsonPath -Value $json -Encoding UTF8
    Write-Host "Conversion result saved to: $jsonPath"

    if ($Silent) {
        # 조용 모드: JSON 파일 경로만 출력
        Write-Output $jsonPath
    } else {
        # 일반 모드: JSON 내용 출력
        Write-Output $json
    }

    if ($result.Status -eq "Failed") { exit 1 } else { exit 0 }

} catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 1
}
