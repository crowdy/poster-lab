param(
    [Parameter(Mandatory=$true)]
    [string]$PsdFile
)

# DLLの自動ダウンロードと読み込み
function Load-AsposePSD {
    $packageDir = "$PSScriptRoot/aspose-packages"
    $asposeDrawingDll = "$packageDir/Aspose.Drawing.dll"
    $asposePsdDll = "$packageDir/Aspose.PSD.dll"
    
    if (-not (Test-Path $asposePsdDll)) {
        Write-Host "Downloading Aspose.PSD packages..." -ForegroundColor Yellow
        
        # NuGet.exeを使用してダウンロード
        $nugetPath = "$PSScriptRoot/nuget.exe"
        if (-not (Test-Path $nugetPath)) {
            Write-Host "Downloading NuGet.exe..." -ForegroundColor Yellow
            Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile $nugetPath
        }
        
        # パッケージをダウンロード
        & $nugetPath install Aspose.PSD -OutputDirectory "$PSScriptRoot/temp-packages" -Verbosity quiet
        & $nugetPath install Aspose.Drawing -OutputDirectory "$PSScriptRoot/temp-packages" -Verbosity quiet
        & $nugetPath install Newtonsoft.Json -OutputDirectory "$PSScriptRoot/temp-packages" -Verbosity quiet
        
        # DLLを簡単な場所にコピー
        New-Item -ItemType Directory -Path $packageDir -Force | Out-Null
        Get-ChildItem "$PSScriptRoot/temp-packages/Aspose.PSD.*/lib/net8.0/*.dll" | Copy-Item -Destination $packageDir/
        Get-ChildItem "$PSScriptRoot/temp-packages/Aspose.Drawing.*/lib/net8.0/*.dll" | Copy-Item -Destination $packageDir/
        Get-ChildItem "$PSScriptRoot/temp-packages/Newtonsoft.Json.*/lib/netstandard2.0/*.dll" | Copy-Item -Destination $packageDir/ -ErrorAction SilentlyContinue
        
        # 一時フォルダを削除
        Remove-Item -Recurse -Force "$PSScriptRoot/temp-packages"
        
        Write-Host "Aspose.PSD packages downloaded successfully." -ForegroundColor Green
    }
    
    # DLLを読み込み
    try {
        Add-Type -Path $asposeDrawingDll -ErrorAction SilentlyContinue
        Add-Type -Path $asposePsdDll
        Write-Host "Aspose.PSD loaded successfully." -ForegroundColor Green
    } catch {
        Write-Host "Error loading Aspose.PSD: $_" -ForegroundColor Red
        exit 1
    }
}

# レイヤーツリーを作成する関数
function Get-LayerTree {
    param (
        [Array]$Layers,
        [int]$Indent = 0
    )
    
    $tree = ""
    $prefix = if ($Indent -eq 0) { "" } else { "│   " * ($Indent - 1) }
    
    for ($i = 0; $i -lt $Layers.Count; $i++) {
        $layer = $Layers[$i]
        $isLast = ($i -eq $Layers.Count - 1)
        
        # グループ終端マーカーをスキップ
        if ($layer.Name -like "</*") {
            continue
        }
        
        # 接続線
        $connector = if ($isLast) { "└── " } else { "├── " }
        
        # アイコンを設定
        $icon = ""
        $layerType = Get-LayerType $layer
        switch ($layerType) {
            "Smart Object" { $icon = "[S] " }
            "Group" { $icon = "[G] " }
            "Text" { $icon = "[T] " }
            "Adjustment" { $icon = "[A] " }
            "Fill" { $icon = "[F] " }
            default { $icon = "" }
        }
        
        # 可視性
        $visibility = if ($layer.IsVisible) { "👁 " } else { "  " }
        
        # レイヤー情報
        $layerInfo = "$visibility$icon$($layer.Name)"
        if ($layerType -eq "Smart Object") {
            $layerInfo = "$layerInfo (Smart Object)"
        }
        
        $tree += "$prefix$connector$layerInfo`n"
        
        # グループの場合、子レイヤーを処理（簡易的な実装）
        if ($layerType -eq "Group" -and $i + 1 -lt $Layers.Count) {
            # 次のレイヤーがグループでない場合、インデントを増やす
            # （本来は適切なグループ構造解析が必要だが、簡易版として）
        }
    }
    
    return $tree
}

# レイヤータイプを判定する関数
function Get-LayerType {
    param ($Layer)
    
    if ($Layer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
        return "Smart Object"
    }
    if ($Layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
        return "Text"
    }
    if ($Layer -is [Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers.AdjustmentLayer]) {
        return "Adjustment"
    }
    if ($Layer -is [Aspose.PSD.FileFormats.Psd.Layers.LayerGroup]) {
        return "Group"
    }
    if ($Layer -is [Aspose.PSD.FileFormats.Psd.Layers.FillLayers.FillLayer]) {
        return "Fill"
    }
    return "Raster"
}

# メイン処理
function Main {
    # ファイルの存在確認
    if (-not (Test-Path $PsdFile)) {
        Write-Host "Error: File not found - $PsdFile" -ForegroundColor Red
        exit 1
    }
    
    $absolutePath = (Resolve-Path $PsdFile).Path
    $fileName = [System.IO.Path]::GetFileName($absolutePath)
    $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($absolutePath)
    
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "PSD Smart Object Checker" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Analyzing: $fileName"
    Write-Host "Path: $absolutePath"
    Write-Host ""
    
    # Aspose.PSDを読み込み
    Load-AsposePSD
    
    try {
        # PSDファイルを読み込み
        $psdImage = [Aspose.PSD.Image]::Load($absolutePath)
        
        # ファイルサイズを取得
        $fileInfo = Get-Item $absolutePath
        $fileSize = "{0:N2} MB" -f ($fileInfo.Length / 1MB)
        
        # スマートオブジェクトを検索
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
        
        # 結果を表示
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
        
        # レイヤーツリーを表示
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Yellow
        Write-Host "Layer Tree" -ForegroundColor Yellow
        Write-Host "================================================" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "$fileNameWithoutExt/" -ForegroundColor Cyan
        
        # レイヤーツリーを生成
        $tree = Get-LayerTree -Layers $psdImage.Layers -Indent 1
        Write-Host $tree
        
        # レイヤー統計
        $visibleCount = 0
        $groupCount = 0
        $rasterCount = 0
        $textCount = 0
        
        foreach ($layer in $psdImage.Layers) {
            if ($layer.IsVisible) { $visibleCount++ }
            $type = Get-LayerType $layer
            switch ($type) {
                "Group" { $groupCount++ }
                "Text" { $textCount++ }
                "Raster" { $rasterCount++ }
            }
        }
        
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "Layer Statistics" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "  Visible Layers: $visibleCount / $layerCount"
        Write-Host "  Groups: $groupCount"
        Write-Host "  Raster Layers: $rasterCount"
        Write-Host "  Text Layers: $textCount"
        Write-Host "  Smart Objects: $($smartObjects.Count)"
        Write-Host ""
        
        # 結果をJSONとして保存
        $result = @{
            FileName = $fileName
            FileSize = $fileSize
            AnalysisDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            TotalLayers = $layerCount
            ContainsSmartObject = $smartObjects.Count -gt 0
            SmartObjects = $smartObjects
            Statistics = @{
                VisibleLayers = $visibleCount
                Groups = $groupCount
                RasterLayers = $rasterCount
                TextLayers = $textCount
            }
        }
        
        $jsonPath = Join-Path $PSScriptRoot "${fileNameWithoutExt}_analysis.json"
        $result | ConvertTo-Json -Depth 10 | Out-File -FilePath $jsonPath -Encoding UTF8
        Write-Host "Analysis result saved to: $jsonPath" -ForegroundColor Green
        
        # リソースを解放
        $psdImage.Dispose()
        
    } catch {
        Write-Host "Error analyzing PSD file: $_" -ForegroundColor Red
        exit 1
    }
}

# 実行
Main
