# Test-FindReplacementFile.ps1
# Test script for Find-ReplacementFile function behavior

<#
.SYNOPSIS
    Tests the Find-ReplacementFile function against a specific PSD file
    
.DESCRIPTION
    This script loads a PSD file, extracts Smart Object layers, and tests
    the Find-ReplacementFile function to verify correct file matching behavior.
    
.PARAMETER PsdFilePath
    Path to the PSD file to test (including the working directory)
    
.EXAMPLE
    .\Test-FindReplacementFile.ps1 -PsdFilePath "e:\poster-ai\working\20250819180555-d87ef97c-ae68-4c63-bf0b-5ff7a09708f5\d87ef97c-ae68-4c63-bf0b-5ff7a09708f5.psd"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$PsdFilePath = "e:\poster-ai\working\20250819180555-d87ef97c-ae68-4c63-bf0b-5ff7a09708f5\d87ef97c-ae68-4c63-bf0b-5ff7a09708f5.psd"
)

# ================================================================================
# Initialize and Load Dependencies
# ================================================================================

Write-Host "=== Find-ReplacementFile Function Test ===" -ForegroundColor Cyan
Write-Host "PSD File: $PsdFilePath" -ForegroundColor White
Write-Host ""

try {
    Write-Host "Loading dependencies..." -ForegroundColor Yellow
    
    # Load configuration
    . "$PSScriptRoot\create-psd-config.ps1"
    Write-Host "  ✓ Configuration loaded" -ForegroundColor Green
    
    # Load Aspose.PSD
    . "$PSScriptRoot\Load-AsposePSD.ps1"
    if (-not (Load-AsposePSD)) {
        throw "Failed to load Aspose.PSD library"
    }
    Write-Host "  ✓ Aspose.PSD loaded" -ForegroundColor Green
    
    # Load core functions
    . "$PSScriptRoot\PSD-Functions.ps1"
    Write-Host "  ✓ PSD Functions loaded" -ForegroundColor Green
    
    # Load utilities
    . "$PSScriptRoot\PSD-Utilities.ps1"
    Write-Host "  ✓ Utilities loaded" -ForegroundColor Green
    
    Write-Host ""
    
} catch {
    Write-Error "Failed to load dependencies: $($_.Exception.Message)"
    exit 1
}

# ================================================================================
# Validate Input File
# ================================================================================

Write-Host "Validating input file..." -ForegroundColor Yellow

if (-not (Test-Path $PsdFilePath)) {
    Write-Error "PSD file not found: $PsdFilePath"
    exit 1
}

$psdFile = Get-Item $PsdFilePath
$workingPath = $psdFile.DirectoryName

Write-Host "  ✓ PSD File: $($psdFile.Name)" -ForegroundColor Green
Write-Host "  ✓ Working Directory: $workingPath" -ForegroundColor Green
Write-Host "  ✓ File Size: $('{0:N2}' -f ($psdFile.Length / 1MB)) MB" -ForegroundColor Green
Write-Host ""

# ================================================================================
# List Available Files in Working Directory
# ================================================================================

Write-Host "Available PNG files in working directory:" -ForegroundColor Yellow
$pngFiles = Get-ChildItem $workingPath -Filter "*.png" -File | Sort-Object Name

if ($pngFiles.Count -eq 0) {
    Write-Warning "No PNG files found in working directory!"
} else {
    foreach ($file in $pngFiles) {
        Write-Host "  - $($file.Name)" -ForegroundColor Cyan
    }
}
Write-Host ""

# ================================================================================
# Load and Analyze PSD File
# ================================================================================

Write-Host "Loading PSD file with Aspose.PSD..." -ForegroundColor Yellow

$psdImage = $null
$smartObjectLayers = @()

try {
    # Load PSD
    $psdImage = [Aspose.PSD.Image]::Load($PsdFilePath)
    
    if ($psdImage -is [Aspose.PSD.FileFormats.Psd.PsdImage]) {
        Write-Host "  ✓ PSD loaded successfully" -ForegroundColor Green
        Write-Host "  ✓ Dimensions: $($psdImage.Width) x $($psdImage.Height)" -ForegroundColor Green
        Write-Host "  ✓ Layer count: $($psdImage.Layers.Count)" -ForegroundColor Green
        Write-Host ""
        
        # Extract Smart Object layers
        Write-Host "Scanning for Smart Object layers..." -ForegroundColor Yellow
        
        foreach ($layer in $psdImage.Layers) {
            if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
                $smartObjectLayer = [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]$layer
                $smartObjectLayers += $smartObjectLayer
                
                Write-Host "  Found: $($smartObjectLayer.Name)" -ForegroundColor Cyan
                Write-Host "    Type: $($smartObjectLayer.ContentType)" -ForegroundColor Gray
                Write-Host "    Bounds: $($smartObjectLayer.Left),$($smartObjectLayer.Top) - $($smartObjectLayer.Right),$($smartObjectLayer.Bottom)" -ForegroundColor Gray
            }
        }
        
        Write-Host "  ✓ Found $($smartObjectLayers.Count) Smart Object layer(s)" -ForegroundColor Green
        Write-Host ""
        
    } else {
        throw "Failed to cast as PSD image"
    }
    
} catch {
    Write-Error "Failed to load PSD file: $($_.Exception.Message)"
    exit 1
}

# ================================================================================
# Test Find-ReplacementFile Function
# ================================================================================

Write-Host "Testing Find-ReplacementFile function..." -ForegroundColor Yellow
Write-Host ""

if ($smartObjectLayers.Count -eq 0) {
    Write-Warning "No Smart Object layers found to test!"
} else {
    
    $testResults = @()
    
    foreach ($smartObjectLayer in $smartObjectLayers) {
        Write-Host "--- Testing Smart Object: $($smartObjectLayer.Name) ---" -ForegroundColor Magenta
        
        # Get original path if available
        $originalRelativePath = ""
        try {
            $originalRelativePath = $smartObjectLayer.RelativePath
        } catch {
            # RelativePath may not be accessible
        }
        
        Write-Host "Original Relative Path: '$originalRelativePath'" -ForegroundColor Gray
        
        # Test the Find-ReplacementFile function
        Write-Host ""
        Write-Host "Calling Find-ReplacementFile..." -ForegroundColor White
        
        try {
            $result = Find-ReplacementFile -workingPath $workingPath -originalFileName $originalRelativePath -smartObjectName $smartObjectLayer.Name
            
            if ($result) {
                $resultFileName = Split-Path $result -Leaf
                Write-Host "  ✓ Result: $resultFileName" -ForegroundColor Green
                Write-Host "  ✓ Full Path: $result" -ForegroundColor Green
                
                # Verify file exists
                if (Test-Path $result) {
                    Write-Host "  ✓ File exists and is accessible" -ForegroundColor Green
                } else {
                    Write-Host "  ✗ File does not exist!" -ForegroundColor Red
                }
                
            } else {
                Write-Host "  ✗ No replacement file found" -ForegroundColor Red
            }
            
            # Expected result based on naming pattern
            $expectedPattern = ""
            if ($smartObjectLayer.Name -match '^(.+?)(\s+#(\d+))?$') {
                $baseName = $matches[1].Trim()
                $number = if ($matches[3]) { $matches[3] } else { "1" }
                $expectedPattern = "${baseName}_${number}.png"
                
                Write-Host ""
                Write-Host "Expected pattern: $expectedPattern" -ForegroundColor Yellow
                
                if ($result -and (Split-Path $result -Leaf) -eq $expectedPattern) {
                    Write-Host "  ✓ Result matches expected pattern!" -ForegroundColor Green
                } else {
                    Write-Host "  ✗ Result does not match expected pattern" -ForegroundColor Red
                }
            }
            
            # Store test result
            $testResults += [PSCustomObject]@{
                SmartObjectName = $smartObjectLayer.Name
                ExpectedFile = $expectedPattern
                ActualFile = if ($result) { Split-Path $result -Leaf } else { "None" }
                Success = if ($result -and (Split-Path $result -Leaf) -eq $expectedPattern) { $true } else { $false }
            }
            
        } catch {
            Write-Host "  ✗ Error calling Find-ReplacementFile: $($_.Exception.Message)" -ForegroundColor Red
            
            $testResults += [PSCustomObject]@{
                SmartObjectName = $smartObjectLayer.Name
                ExpectedFile = $expectedPattern
                ActualFile = "ERROR"
                Success = $false
            }
        }
        
        Write-Host ""
    }
    
    # ================================================================================
    # Summary Report
    # ================================================================================
    
    Write-Host "=== Test Results Summary ===" -ForegroundColor Cyan
    Write-Host ""
    
    $successCount = ($testResults | Where-Object { $_.Success }).Count
    $totalCount = $testResults.Count
    
    Write-Host "Total Smart Objects Tested: $totalCount" -ForegroundColor White
    Write-Host "Successful Matches: $successCount" -ForegroundColor Green
    Write-Host "Failed Matches: $($totalCount - $successCount)" -ForegroundColor Red
    Write-Host ""
    
    # Detailed results table
    Write-Host "Detailed Results:" -ForegroundColor Yellow
    Write-Host ("-" * 80) -ForegroundColor Gray
    
    $formatString = "{0,-25} {1,-25} {2,-25} {3}"
    Write-Host ($formatString -f "Smart Object", "Expected File", "Actual File", "Match") -ForegroundColor Gray
    Write-Host ("-" * 80) -ForegroundColor Gray
    
    foreach ($result in $testResults) {
        $matchText = if ($result.Success) { "✓" } else { "✗" }
        $color = if ($result.Success) { "Green" } else { "Red" }
        
        Write-Host ($formatString -f $result.SmartObjectName, $result.ExpectedFile, $result.ActualFile, $matchText) -ForegroundColor $color
    }
    
    Write-Host ("-" * 80) -ForegroundColor Gray
    
    if ($successCount -eq $totalCount) {
        Write-Host ""
        Write-Host "🎉 All tests passed! Find-ReplacementFile is working correctly." -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "⚠️  Some tests failed. The Find-ReplacementFile function may need adjustment." -ForegroundColor Yellow
    }
}

# ================================================================================
# Cleanup
# ================================================================================

try {
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host ""
        Write-Host "PSD resources cleaned up." -ForegroundColor Gray
    }
} catch {
    Write-Warning "Failed to dispose PSD resources: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "=== Test Complete ===" -ForegroundColor Cyan
