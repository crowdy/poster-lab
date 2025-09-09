# ===== Aspose.PSD Loader Function =====
# This file is an Aspose.PSD library loader commonly used across multiple PowerShell scripts.
# Usage: Use by dot-sourcing with . "$PSScriptRoot\Load-AsposePSD.ps1"

function Load-AsposePSD {
    <#
    .SYNOPSIS
    Automatically downloads and loads the Aspose.PSD library.
    
    .DESCRIPTION
    This function automatically downloads Aspose.PSD and its related dependencies and loads them into the PowerShell session.
    It uses packages for .NET 8.0, downloaded via the NuGet package manager, but is flexible in finding compatible DLLs.
    Uses a global variable to track loading state and prevent duplicate loading attempts.
    
    .OUTPUTS
    Boolean - Returns $true on successful load, $false on failure.
    
    .EXAMPLE
    if (Load-AsposePSD) {
        Write-Host "Aspose.PSD loaded successfully"
    } else {
        Write-Error "Failed to load Aspose.PSD"
        exit 1
    }
    #>
    
    # Check if Aspose.PSD is already loaded using global variable
    if ($Global:AsposePSDLoaded -eq $true) {
        Write-Host "Aspose.PSD is already loaded, skipping load process" -ForegroundColor Green
        return $true
    }
    
    # Set package directory based on the caller's script path
    $callerScriptPath = if ($MyInvocation.PSScriptRoot) { 
        $MyInvocation.PSScriptRoot 
    } elseif ($PSScriptRoot) { 
        $PSScriptRoot 
    } else { 
        Get-Location 
    }
    
    # Ensure consistent path separators for cross-platform compatibility
    $packageDir = Join-Path $callerScriptPath "aspose-packages"
    if (-not (Test-Path $packageDir)) { 
        Write-Host "Creating package directory: $packageDir" -ForegroundColor Cyan
        New-Item -ItemType Directory -Path $packageDir -Force | Out-Null 
    }

    $asposeDrawingDll = Join-Path $packageDir "Aspose.Drawing.dll"
    $asposePsdDll     = Join-Path $packageDir "Aspose.PSD.dll"

    # Define preferred target frameworks for finding DLLs - added net8.0
    $preferredFrameworks = @("net8.0", "net7.0", "net6.0", "netstandard2.0") # Prioritize more recent frameworks

    # Helper function to find a DLL with fallback frameworks
    function Find-NuGetPackageDll {
        param (
            [string]$PackageName,
            [string]$DllFileName,
            [string]$PackagesPath,
            [string[]]$Frameworks
        )
        $foundDll = $null
        foreach ($tf in $Frameworks) {
            $pattern = Join-Path $PackagesPath "$PackageName/*/lib/$tf/$DllFileName"
            Write-Host "Searching for $DllFileName for '$PackageName' using pattern: $pattern" -ForegroundColor DarkCyan
            $foundDll = Get-ChildItem $pattern -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($foundDll) {
                Write-Host "Found $DllFileName for framework $tf : $($foundDll.FullName)" -ForegroundColor DarkCyan
                return $foundDll
            }
        }
        return $null
    }

    # Copy license file to aspose-packages directory if it exists
    $licenseSourcePath = Join-Path $callerScriptPath "Aspose.PSD.NET.lic"
    $licenseDestPath = Join-Path $packageDir "Aspose.PSD.NET.lic"
    
    if (Test-Path $licenseSourcePath) {
        if (-not (Test-Path $licenseDestPath)) {
            Write-Host "Copying license file to package directory..." -ForegroundColor Cyan
            Copy-Item $licenseSourcePath $licenseDestPath -Force
        }
    }

    # Download DLLs if not present
    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages and dependencies for .NET 8.0..." -ForegroundColor Yellow
        $tempDir = Join-Path $callerScriptPath "temp-packages"
        if (Test-Path $tempDir) { 
            Write-Host "Removing existing temp directory: $tempDir" -ForegroundColor DarkYellow
            Remove-Item -Recurse -Force $tempDir 
        }
        
        $originalLocation = Get-Location
        try {
            Write-Host "Setting location to: $callerScriptPath" -ForegroundColor DarkCyan
            Set-Location $callerScriptPath
            Write-Host "Creating temporary console project in $tempDir..." -ForegroundColor DarkCyan
            dotnet new console -n TempProject -o $tempDir --force | Out-Null
            
            Write-Host "Setting location to: $tempDir" -ForegroundColor DarkCyan
            Set-Location $tempDir
            
            Write-Host "Adding Aspose.PSD package..." -ForegroundColor DarkCyan
            dotnet add package Aspose.PSD --version 24.12.0 | Out-Null
            
            Write-Host "Adding Aspose.Drawing package..." -ForegroundColor DarkCyan
            dotnet add package Aspose.Drawing --version 24.12.0 | Out-Null
            
            # Add other direct dependencies that might not be reliably pulled as transitive
            Write-Host "Adding Newtonsoft.Json package..." -ForegroundColor DarkCyan
            dotnet add package Newtonsoft.Json --version 13.0.3 | Out-Null
            
            Write-Host "Adding System.Drawing.Common package..." -ForegroundColor DarkCyan
            dotnet add package System.Drawing.Common --version 8.0.0 | Out-Null
            
            Write-Host "Adding System.Text.Encoding.CodePages package..." -ForegroundColor DarkCyan
            dotnet add package System.Text.Encoding.CodePages --version 8.0.0 | Out-Null
            
            Write-Host "Restoring NuGet packages..." -ForegroundColor DarkCyan
            dotnet restore | Out-Null

            # Determine the NuGet package path based on the operating system
            $packagesPath = $null
            if ($IsWindows) {
                $packagesPath = "$env:USERPROFILE\.nuget\packages"
            } elseif ($IsLinux) {
                $packagesPath = "$env:HOME/.nuget/packages"
            } else {
                Write-Error "Unsupported operating system. Cannot determine NuGet package path."
                return $false
            }

            if (-not $packagesPath) {
                Write-Error "NuGet packages path could not be determined."
                return $false
            }
            Write-Host "Resolved NuGet packages path: $packagesPath" -ForegroundColor Cyan
            
            # Copy Aspose.PSD DLL
            $asposePsdSource = Find-NuGetPackageDll "aspose.psd" "Aspose.PSD.dll" $packagesPath $preferredFrameworks
            if ($asposePsdSource) {
                Write-Host "Copying Aspose.PSD.dll to: $asposePsdDll" -ForegroundColor DarkCyan
                Copy-Item $asposePsdSource.FullName $asposePsdDll -Force -ErrorAction Stop | Out-Null
                if (-not (Test-Path $asposePsdDll)) {
                    throw "Failed to copy Aspose.PSD.dll to destination: $asposePsdDll"
                }
            } else {
                Write-Error "Aspose.PSD.dll not found in NuGet packages after download for any preferred framework."
                return $false
            }
            
            # Copy Aspose.Drawing DLL
            $asposeDrawingSource = Find-NuGetPackageDll "aspose.drawing" "Aspose.Drawing.dll" $packagesPath $preferredFrameworks
            if ($asposeDrawingSource) {
                Write-Host "Copying Aspose.Drawing.dll to: $asposeDrawingDll" -ForegroundColor DarkCyan
                Copy-Item $asposeDrawingSource.FullName $asposeDrawingDll -Force -ErrorAction Stop | Out-Null
                if (-not (Test-Path $asposeDrawingDll)) {
                    throw "Failed to copy Aspose.Drawing.dll to destination: $asposeDrawingDll"
                }
            } else {
                Write-Error "Aspose.Drawing.dll not found in NuGet packages after download for any preferred framework."
                return $false
            }

            # Copy dependency DLLs
            $dependenciesToCopy = @(
                @{ Package = "newtonsoft.json"; Dll = "Newtonsoft.Json.dll"; Frameworks = @("net6.0", "netstandard2.0") }, # Newtonsoft.Json is usually in net6.0
                @{ Package = "system.drawing.common"; Dll = "System.Drawing.Common.dll"; Frameworks = $preferredFrameworks },
                @{ Package = "system.text.encoding.codepages"; Dll = "System.Text.Encoding.CodePages.dll"; Frameworks = $preferredFrameworks }
            )
            
            foreach ($dep in $dependenciesToCopy) {
                $depFile = Find-NuGetPackageDll $dep.Package $dep.Dll $packagesPath $dep.Frameworks
                if ($depFile) { 
                    Write-Host "Copying dependency $($dep.Dll) to: $packageDir" -ForegroundColor DarkCyan
                    Copy-Item $depFile.FullName $packageDir -Force -ErrorAction Stop | Out-Null
                    $copiedDepPath = Join-Path $packageDir $depFile.Name
                    if (-not (Test-Path $copiedDepPath)) {
                        Write-Error "Failed to copy dependency '$($dep.Dll)' to destination: $copiedDepPath"
                    }
                } else {
                    Write-Error "Critical: Dependency '$($dep.Dll)' not found in NuGet packages for any preferred framework. This will cause runtime issues."
                    return $false # In this case, immediately fail without proceeding to the loading stage
                }
            }
            
        } catch {
            Write-Error "Failed during package download or copy: $($_.Exception.Message)"
            Set-Location $originalLocation
            return $false
        } finally {
            Set-Location $originalLocation
            if (Test-Path $tempDir) { 
                Write-Host "Cleaning up temporary directory: $tempDir" -ForegroundColor DarkYellow
                Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue | Out-Null 
            }
        }
    }

    # Load DLLs
    try {
        # Register CodePages encoding (stabilize text/effect rendering)
        Write-Host "Registering System.Text.Encoding.CodePages provider..." -ForegroundColor DarkCyan
        Add-Type -AssemblyName "System.Text.Encoding.CodePages" -ErrorAction SilentlyContinue
        [System.Text.Encoding]::RegisterProvider([System.Text.CodePagesEncodingProvider]::Instance)

        # Load dependency DLLs
        $dependencyDllsToLoad = @(
            "System.Text.Encoding.CodePages.dll",
            "Newtonsoft.Json.dll",
            "System.Drawing.Common.dll"
        )
        
        foreach ($dll in $dependencyDllsToLoad) {
            $dllPath = Join-Path $packageDir $dll
            Write-Host "Attempting to load dependency DLL: $dllPath" -ForegroundColor DarkCyan
            if (Test-Path $dllPath) { 
                Add-Type -Path $dllPath -ErrorAction SilentlyContinue 
            } else {
                # This error should have already been handled as critical in the `download` stage.
                # If we got here, either `return $false` was missing above or there's another issue.
                Write-Error "Failed to load critical dependency DLL: $dllPath. It was not found or copied correctly."
                return $false
            }
        }
        
        # Load main Aspose DLLs
        Write-Host "Attempting to load main Aspose.Drawing DLL: $asposeDrawingDll" -ForegroundColor DarkCyan
        if (-not (Test-Path $asposeDrawingDll)) {
            throw "Aspose.Drawing.dll not found at '$asposeDrawingDll' before loading."
        }
        Add-Type -Path $asposeDrawingDll
        
        Write-Host "Attempting to load main Aspose.PSD DLL: $asposePsdDll" -ForegroundColor DarkCyan
        if (-not (Test-Path $asposePsdDll)) {
            throw "Aspose.PSD.dll not found at '$asposePsdDll' before loading."
        }
        Add-Type -Path $asposePsdDll
        
        # Apply license if available
        $licenseFile = Join-Path $packageDir "Aspose.PSD.NET.lic"
        if (Test-Path $licenseFile) {
            try {
                Write-Host "Applying Aspose.PSD license..." -ForegroundColor Cyan
                $license = New-Object Aspose.PSD.License
                $license.SetLicense($licenseFile)
                Write-Host "Aspose.PSD license applied successfully" -ForegroundColor Green
            } catch {
                Write-Warning "Failed to apply Aspose.PSD license: $($_.Exception.Message)"
            }
        } else {
            Write-Warning "License file not found at: $licenseFile"
        }
        
        Write-Host "Aspose.PSD libraries loaded successfully" -ForegroundColor Green
        
        # Set global variable to indicate successful loading
        $Global:AsposePSDLoaded = $true
        return $true
        
    } catch {
        Write-Error "Error loading Aspose.PSD: $($_.Exception.Message)"
        # Ensure global variable is not set on failure
        $Global:AsposePSDLoaded = $false
        return $false
    }

    # License application (commented out as it's typically set within the main script)
    # $license = New-Object Aspose.PSD.License
    # $license.SetLicense("Aspose.PSD.NET_(2).lic.txt");
    # $license.SetLicense("Aspose.PSD.NET_(3).lic"); # e:\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.NET_(3).lic  
}

# Automatically load Aspose.PSD when this script is dot-sourced
if (-Not $Global:AsposePSDLoaded) {
    if (Load-AsposePSD) {
        Write-Host "Aspose.PSD loaded successfully from Load-AsposePSD.ps1" -ForegroundColor Green
    } else {
        Write-Error "Failed to load Aspose.PSD from Load-AsposePSD.ps1"
    }
}

# Export the function for module use (optional)
# Export-ModuleMember -Function Load-AsposePSD
