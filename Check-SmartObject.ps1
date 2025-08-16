param(
    [Parameter(Mandatory=$true)]
    [string]$PsdFile,
    
    [Parameter(Mandatory=$false)]
    [string]$Out
)

# PowerShell 버전 확인
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Error "이 스크립트는 PowerShell 7 (Core)에서 실행해야 합니다."
    Write-Host "PowerShell 7을 실행하려면 'pwsh' 명령을 사용하세요." -ForegroundColor Yellow
    exit 1
}

# ===== Aspose.PSD 로더 (공통 함수 사용) =====
. "$PSScriptRoot\Load-AsposePSD.ps1"

# 레이어를 무시해야 하는지 확인
function Should-IgnoreLayer {
    param ($Layer)
    
    try {
        # 보이지 않거나, 불투명도가 0이거나, 이미지가 없는 경우 무시
        $hasNoImage = ($Layer.Bounds.Width -le 0) -or ($Layer.Bounds.Height -le 0)
        return (-not $Layer.IsVisible) -or ($Layer.Opacity -eq 0) -or $hasNoImage
    } catch {
        return $false
    }
}

# 블렌드 모드 확인
function Get-BlendMode {
    param ($Layer)
    
    try {
        if ($Layer.BlendModeKey) {
            $blendMode = $Layer.BlendModeKey.ToString()
            if ($blendMode -ne "Normal" -and $blendMode -ne "PassThrough") {
                return " ($blendMode)"
            }
        }
        return ""
    } catch {
        return ""
    }
}

# 레이어 타입 확인
function Get-LayerType {
    param ($Layer)
    
    try {
        $typeName = $Layer.GetType().FullName
        
        if ($typeName -like "*LayerGroup*") {
            return "Group"
        }
        if ($typeName -like "*SmartObjectLayer*") {
            return "Smart Object"
        }
        if ($typeName -like "*TextLayer*" -or $Layer -is [Aspose.PSD.Layers.TextLayer]) {
            return "Text"
        }
        if ($typeName -like "*AdjustmentLayer*") {
            return "Adjustment"
        }
        if ($typeName -like "*FillLayer*") {
            return "Fill"
        }
        
        return ""
    } catch {
        return ""
    }
}

# 레이어 트리 출력 (직접 처리 - 중복 제거)
function Print-LayerTree {
    param (
        [Array]$Layers,
        [Array]$AllLayers = $null,
        [string]$Indent = "",
        [bool]$IsRoot = $true,
        [System.Collections.Generic.HashSet[int]]$ProcessedLayers = $null
    )
    
    if ($null -eq $ProcessedLayers) {
        $ProcessedLayers = [System.Collections.Generic.HashSet[int]]::new()
    }
    
    $result = ""
    
    # 레이어를 역순으로 처리 (상위 레이어가 먼저 오도록)
    for ($i = $Layers.Length - 1; $i -ge 0; $i--) {
        $layer = $Layers[$i]
        
        # 이미 처리된 레이어는 건너뛰기
        $layerId = $layer.GetHashCode()
        if ($ProcessedLayers.Contains($layerId)) {
            continue
        }
        [void]$ProcessedLayers.Add($layerId)
        
        # 무시해야 할 레이어는 건너뛰기
        if (Should-IgnoreLayer $layer) {
            continue
        }
        
        $isLast = ($i -eq 0)
        $prefix = if ($IsRoot) { "" } else { $Indent + $(if ($isLast) { "└── " } else { "├── " }) }
        
        # 레이어 인덱스 찾기
        $layerIndex = -1
        if ($AllLayers) {
            for ($j = 0; $j -lt $AllLayers.Count; $j++) {
                if ($AllLayers[$j].GetHashCode() -eq $layer.GetHashCode()) {
                    $layerIndex = $j
                    break
                }
            }
        }
        
        # 레이어 정보 구성
        $layerName = $layer.DisplayName
        if ([string]::IsNullOrWhiteSpace($layerName)) {
            $layerName = "(Unnamed Layer)"
        }
        
        # 레이어 타입 정보 추가
        $layerType = Get-LayerType $layer
        if ($layerType -eq "Group") {
            $layerName += " (Group)"
        } elseif ($layerType -and $layerType -ne "") {
            $layerName += " ($layerType)"
        }
        
        # 블렌드 모드 추가
        $blendMode = Get-BlendMode $layer
        if ($blendMode) {
            $layerName += $blendMode
        }
        
        # 가시성 정보 추가
        if (-not $layer.IsVisible) {
            $layerName += " [Hidden]"
        }
        
        # 인덱스와 함께 출력
        $indexPrefix = if ($layerIndex -ge 0) { "[$layerIndex] " } else { "" }
        $result += "$prefix$indexPrefix$layerName`n"
        
        # 그룹인 경우 하위 레이어 처리
        if ($layer.GetType().FullName -like "*LayerGroup*") {
            try {
                $groupLayers = $layer.Layers
                if ($groupLayers -and $groupLayers.Count -gt 0) {
                    $newIndent = $Indent + $(if ($isLast) { "    " } else { "│   " })
                    $result += Print-LayerTree -Layers $groupLayers -AllLayers $AllLayers -Indent $newIndent -IsRoot $false -ProcessedLayers $ProcessedLayers
                }
            } catch {
                # Layers 속성에 접근할 수 없는 경우 무시
            }
        }
    }
    
    return $result
}

# 통계 수집 (중복 제거)
function Get-LayerStats {
    param ([Array]$Layers)
    
    $stats = @{
        Total = 0
        Ignore = 0
        Groups = 0
        Layer = 0
    }
    
    $processedIds = [System.Collections.Generic.HashSet[int]]::new()
    
    function Count-Layers {
        param ([Array]$LayerList)
        
        foreach ($layer in $LayerList) {
            # 이미 처리된 레이어는 건너뛰기
            $layerId = $layer.GetHashCode()
            if ($processedIds.Contains($layerId)) {
                continue
            }
            [void]$processedIds.Add($layerId)
            
            if (Should-IgnoreLayer $layer) {
                $script:stats.Ignore++
                continue
            }
            
            $script:stats.Total++
            
            if ($layer.GetType().FullName -like "*LayerGroup*") {
                $script:stats.Groups++
                
                # 그룹 내 레이어들도 카운트
                try {
                    $groupLayers = $layer.Layers
                    if ($groupLayers) {
                        Count-Layers -LayerList $groupLayers
                    }
                } catch {}
            } else {
                $script:stats.Layers++
            }
        }
    }
    
    $script:stats = $stats
    Count-Layers -LayerList $Layers
    return $script:stats
}

# 실제 고유 레이어 수 계산
function Get-UniqueLayerCount {
    param ([Array]$Layers)
    
    $uniqueLayers = [System.Collections.Generic.HashSet[int]]::new()
    
    function Collect-UniqueIds {
        param ([Array]$LayerList)
        
        foreach ($layer in $LayerList) {
            $layerId = $layer.GetHashCode()
            [void]$uniqueLayers.Add($layerId)
            
            # 그룹인 경우 하위 레이어도 수집
            if ($layer.GetType().FullName -like "*LayerGroup*") {
                try {
                    $groupLayers = $layer.Layers
                    if ($groupLayers) {
                        Collect-UniqueIds -LayerList $groupLayers
                    }
                } catch {}
            }
        }
    }
    
    Collect-UniqueIds -LayerList $Layers
    return $uniqueLayers.Count
}

# 메인 처리 함수
function Main {
    if (-not (Test-Path $PsdFile)) {
        Write-Error "File not found: $PsdFile"
        exit 1
    }
    
    $absolutePath = (Resolve-Path $PsdFile).Path
    $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($absolutePath)
    
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "PSD Smart Object Checker" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Analyzing: $fileName"
    Write-Host "Path: $absolutePath"
    Write-Host ""
    
    Write-Host "PowerShell 7 + .NET 8.0 Environment:" -ForegroundColor Green
    Write-Host "  PowerShell Version: $($PSVersionTable.PSVersion)"
    Write-Host "  Edition: $($PSVersionTable.PSEdition)"
    Write-Host ""
    
    $loadResult = Load-AsposePSD
    if (-not $loadResult) {
        Write-Error "Failed to load Aspose.PSD libraries"
        exit 1
    }
    
    try {
        Write-Host "Loading PSD file: $absolutePath"
        $psdImage = [Aspose.PSD.Image]::Load($absolutePath)
        
        Write-Host "PSD Information:" -ForegroundColor Green
        Write-Host "  Size: $($psdImage.Width) x $($psdImage.Height)"
        try {
            Write-Host "  Color Mode: $($psdImage.ColorMode)"
            Write-Host "  Bit Depth: $($psdImage.BitsPerChannel)"
        } catch {
            Write-Host "  Color Mode: Unknown"
        }
        
        # 파일 크기 정보
        $fileInfo = Get-Item $absolutePath
        $fileSize = "{0:N2} MB" -f ($fileInfo.Length / 1MB)
        
        # 스마트 오브젝트 검색
        $smartObjects = @()
        $layerCount = $psdImage.Layers.Length
        
        foreach ($layer in $psdImage.Layers) {
            if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
                $smartObjectInfo = @{
                    Name = $layer.Name
                    IsVisible = $layer.IsVisible
                    Bounds = "$($layer.Width)x$($layer.Height) at ($($layer.Left),$($layer.Top))"
                    Type = "Embedded"
                }
                
                try {
                    if ($layer.Contents) {
                        $smartObjectInfo.ContentSize = $layer.Contents.Length
                        $smartObjectInfo.Type = "Embedded"
                    } else {
                        $smartObjectInfo.Type = "Linked"
                        $smartObjectInfo.ContentSize = 0
                    }
                } catch {
                    $smartObjectInfo.Type = "Unknown"
                    $smartObjectInfo.ContentSize = 0
                }
                
                $smartObjects += $smartObjectInfo
            }
        }
        
        # 실제 고유 레이어 수 계산
        $uniqueCount = Get-UniqueLayerCount -Layers $psdImage.Layers
        Write-Host "  Total Layers: $uniqueCount"
        
        # 스마트 오브젝트 분석 결과 표시
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "Analysis Result" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "File Size: $fileSize"
        Write-Host "Total Layers: $layerCount"
        Write-Host "Contains Smart Object: $(if ($smartObjects.Count -gt 0) { 'Yes' } else { 'No' })"
        
        if ($smartObjects.Count -gt 0) {
            Write-Host ""
            Write-Host "Smart Objects Found: $($smartObjects.Count)" -ForegroundColor Cyan
            Write-Host "------------------------------------------------"
            foreach ($so in $smartObjects) {
                Write-Host "  Name: $($so.Name)"
                Write-Host "  Type: $($so.Type)"
                Write-Host "  Visible: $(if ($so.IsVisible) { 'Yes' } else { 'No' })"
                Write-Host "  Bounds: $($so.Bounds)"
                if ($so.ContentSize -gt 0) {
                    $sizeInMB = "{0:N2} MB" -f ($so.ContentSize / 1MB)
                    Write-Host "  Content Size: $sizeInMB"
                }
                Write-Host ""
            }
        }
        
        # 레이어 트리 표시
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Yellow
        Write-Host "Layer Tree" -ForegroundColor Yellow
        Write-Host "================================================" -ForegroundColor Yellow
        Write-Host ""
        
        # 트리 출력 (최상위 레이어만)
        $treeHeader = "$fileNameWithoutExt/"
        $treeString = Print-LayerTree -Layers $psdImage.Layers -AllLayers $psdImage.Layers -Indent "" -IsRoot $true
        
        $output = "$treeHeader`n$treeString"
        
        # 출력 처리
        if ($Out) {
            $output | Out-File -FilePath $Out -Encoding UTF8
            Write-Host "Layer tree saved to: $Out" -ForegroundColor Green
        } else {
            Write-Output $output
        }
        
        # 통계 정보
        $stats = Get-LayerStats -Layers $psdImage.Layers
        
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "Layer Statistics" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "  Visible Layers: $($stats.Total) / $layerCount"
        Write-Host "  Groups: $($stats.Groups)"
        Write-Host "  Raster Layers: $($stats.Layers)"
        Write-Host "  Text Layers: 0"
        Write-Host "  Smart Objects: $($smartObjects.Count)"
        Write-Host ""
        
        # 결과를 JSON으로 저장
        $result = @{
            FileName = [System.IO.Path]::GetFileName($absolutePath)
            FileSize = $fileSize
            AnalysisDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            TotalLayers = $layerCount
            ContainsSmartObject = $smartObjects.Count -gt 0
            SmartObjects = $smartObjects
            Statistics = @{
                VisibleLayers = $stats.Total
                Groups = $stats.Groups
                RasterLayers = $stats.Layers
                TextLayers = 0
                SmartObjects = $smartObjects.Count
            }
        }
        
        $jsonPath = Join-Path $PSScriptRoot "${fileNameWithoutExt}_analysis.json"
        $result | ConvertTo-Json -Depth 10 | Out-File -FilePath $jsonPath -Encoding UTF8
        Write-Host "Analysis result saved to: $jsonPath" -ForegroundColor Green
        
        $psdImage.Dispose()
        
    } catch {
        Write-Error "Error analyzing PSD file: $_"
        Write-Host "Error details: $($_.Exception.Message)"
        Write-Host "Stack trace: $($_.Exception.StackTrace)"
        exit 1
    }
}

# 실행
Main
