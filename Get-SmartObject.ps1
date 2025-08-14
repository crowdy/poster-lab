param(
    [Parameter(Mandatory=$true)]
    [string]$PsdFile
)

# DLL読み込み関数
function Load-AsposePSD {
    $packageDir = "$PSScriptRoot/aspose-packages"
    $asposeDrawingDll = "$packageDir/Aspose.Drawing.dll"
    $asposePsdDll = "$packageDir/Aspose.PSD.dll"
    
    if (-not (Test-Path $asposePsdDll)) {
        Write-Error "Aspose.PSD.dll not found at: $asposePsdDll"
        exit 1
    }
    
    # DLLを読み込み
    try {
        Add-Type -Path $asposeDrawingDll -ErrorAction SilentlyContinue
        Add-Type -Path $asposePsdDll
    } catch {
        Write-Error "Error loading Aspose.PSD: $_"
        exit 1
    }
}

# メイン処理
function Main {
    # ファイルの存在確認
    if (-not (Test-Path $PsdFile)) {
        Write-Error "File not found: $PsdFile"
        exit 1
    }
    
    $absolutePath = (Resolve-Path $PsdFile).Path
    
    # Aspose.PSDを読み込み
    Load-AsposePSD
    
    try {
        # PSDファイルを読み込み
        $psdImage = [Aspose.PSD.Image]::Load($absolutePath)
        
        # スマートオブジェクトを検索
        $smartObjects = @()
        
        foreach ($layer in $psdImage.Layers) {
            if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer]) {
                $smartObjectInfo = @{
                    Name = $layer.Name
                    IsVisible = $layer.IsVisible
                    Width = $layer.Width
                    Height = $layer.Height
                    Left = $layer.Left
                    Top = $layer.Top
                    Type = "Unknown"
                }
                
                try {
                    if ($layer.Contents) {
                        $smartObjectInfo.Type = "Embedded"
                        $smartObjectInfo.ContentSize = $layer.Contents.Length
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
        
        # 結果を出力
        if ($smartObjects.Count -gt 0) {
            Write-Output "Smart Objects Found: $($smartObjects.Count)"
            Write-Output "----------------------------------------"
            foreach ($so in $smartObjects) {
                Write-Output "Name: $($so.Name)"
                Write-Output "Type: $($so.Type)"
                Write-Output "Visible: $(if ($so.IsVisible) { 'Yes' } else { 'No' })"
                Write-Output "Size: $($so.Width)x$($so.Height)"
                Write-Output "Position: ($($so.Left), $($so.Top))"
                if ($so.ContentSize -gt 0) {
                    $sizeInKB = [math]::Round($so.ContentSize / 1KB, 2)
                    Write-Output "Content Size: $sizeInKB KB"
                }
                Write-Output ""
            }
        } else {
            Write-Output "No smart objects found in this PSD file."
        }
        
        # リソースを解放
        $psdImage.Dispose()
        
    } catch {
        Write-Error "Error analyzing PSD file: $_"
        exit 1
    }
}

# 実行
Main
