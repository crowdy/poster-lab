# ===== Aspose.PSD 로더 함수 =====
# 이 파일은 여러 PowerShell 스크립트에서 공통으로 사용되는 Aspose.PSD 라이브러리 로더입니다.
# 사용법: . "$PSScriptRoot\Load-AsposePSD.ps1" 으로 dot sourcing 하여 사용

function Load-AsposePSD {
    <#
    .SYNOPSIS
    Aspose.PSD 라이브러리를 자동으로 다운로드하고 로드합니다.
    $license = New-Object Aspose.PSD.License
$license.SetLicense("Aspose.PSD.NET_(2).lic.txt");

    .DESCRIPTION
    이 함수는 Aspose.PSD와 관련 의존성을 자동으로 다운로드하고 PowerShell 세션에 로드합니다.
    .NET 8.0용 패키지를 사용하며, NuGet 패키지 관리자를 통해 다운로드합니다.
    
    .OUTPUTS
    Boolean - 로드 성공 시 $true, 실패 시 $false 반환
    
    .EXAMPLE
    if (Load-AsposePSD) {
        Write-Host "Aspose.PSD loaded successfully"
    } else {
        Write-Error "Failed to load Aspose.PSD"
        exit 1
    }
    #>
    
    # 호출자의 스크립트 경로를 기준으로 패키지 디렉토리 설정
    $callerScriptPath = if ($MyInvocation.PSScriptRoot) { 
        $MyInvocation.PSScriptRoot 
    } elseif ($PSScriptRoot) { 
        $PSScriptRoot 
    } else { 
        Get-Location 
    }
    
    $packageDir = "$callerScriptPath/aspose-packages"
    if (-not (Test-Path $packageDir)) { 
        New-Item -ItemType Directory -Path $packageDir -Force | Out-Null 
    }

    $asposeDrawingDll = "$packageDir/Aspose.Drawing.dll"
    $asposePsdDll     = "$packageDir/Aspose.PSD.dll"

    # DLL이 없으면 다운로드
    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages for .NET 8.0..." -ForegroundColor Yellow
        $tempDir = "$callerScriptPath/temp-packages"
        if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
        
        $originalLocation = Get-Location
        try {
            Set-Location $callerScriptPath
            dotnet new console -n TempProject -o $tempDir --force | Out-Null
            Set-Location $tempDir
            dotnet add package Aspose.PSD --version 24.12.0 | Out-Null
            dotnet add package Aspose.Drawing --version 24.12.0 | Out-Null
            dotnet restore | Out-Null

            $packagesPath = "$env:USERPROFILE\.nuget\packages"
            
            # Aspose.PSD DLL 복사
            $asposePsdSource = Get-ChildItem "$packagesPath/aspose.psd/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($asposePsdSource) {
                Copy-Item $asposePsdSource.FullName "$packageDir/Aspose.PSD.dll" -Force
            }
            
            # Aspose.Drawing DLL 복사
            $asposeDrawingSource = Get-ChildItem "$packagesPath/aspose.drawing/*/lib/net8.0/*.dll" -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($asposeDrawingSource) {
                Copy-Item $asposeDrawingSource.FullName "$packageDir/Aspose.Drawing.dll" -Force
            }

            # 의존성 DLL들 복사
            $dependencies = @(
                "newtonsoft.json/*/lib/net6.0/*.dll",
                "system.drawing.common/*/lib/net8.0/*.dll",
                "system.text.encoding.codepages/*/lib/net8.0/*.dll"
            )
            
            foreach ($dep in $dependencies) {
                $depFile = Get-ChildItem "$packagesPath/$dep" -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($depFile) { 
                    Copy-Item $depFile.FullName $packageDir -Force 
                }
            }
            
        } catch {
            Write-Error "Failed to download packages: $_"
            Set-Location $originalLocation
            return $false
        } finally {
            Set-Location $originalLocation
            if (Test-Path $tempDir) { 
                Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue 
            }
        }
    }

    # DLL 로드
    try {
        # CodePages 인코딩 등록 (텍스트/효과 렌더링 안정화)
        Add-Type -AssemblyName "System.Text.Encoding.CodePages" -ErrorAction SilentlyContinue
        [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)

        # 의존성 DLL들 로드
        $dependencyDlls = @(
            "System.Text.Encoding.CodePages.dll",
            "Newtonsoft.Json.dll",
            "System.Drawing.Common.dll"
        )
        
        foreach ($dll in $dependencyDlls) {
            $dllPath = Join-Path $packageDir $dll
            if (Test-Path $dllPath) { 
                Add-Type -Path $dllPath -ErrorAction SilentlyContinue 
            }
        }
        
        # 주요 Aspose DLL들 로드
        Add-Type -Path $asposeDrawingDll
        Add-Type -Path $asposePsdDll
        
        Write-Host "Aspose.PSD libraries loaded successfully" -ForegroundColor Green
        return $true
        
    } catch {
        Write-Error "Error loading Aspose.PSD: $_"
        return $false
    }

    $license = New-Object Aspose.PSD.License
    # $license.SetLicense("Aspose.PSD.NET_(2).lic.txt");
    $license.SetLicense("Aspose.PSD.NET_(3).lic"); # e:\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.NET_(3).lic  
}

# Automatically load Aspose.PSD when this script is dot-sourced
if (Load-AsposePSD) {
    Write-Host "Aspose.PSD loaded successfully from Load-AsposePSD.ps1" -ForegroundColor Green
} else {
    Write-Error "Failed to load Aspose.PSD from Load-AsposePSD.ps1"
}

# Export the function for module use (optional)
# Export-ModuleMember -Function Load-AsposePSD
