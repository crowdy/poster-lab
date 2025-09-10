# Japanese text layer test script for Aspose.PSD - Improved Version
# 日本語テキストレイヤーのテストスクリプト - 改善版

# Load Aspose.PSD assembly using dot-sourcing
. ./Load-AsposePSD.ps1

# Set console encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "日本語テキスト処理を開始します..." -ForegroundColor Green

# Check if Japanese font exists
$fontPath = Join-Path $pwd "fonts/NotoSansJP.ttf"
if (-not (Test-Path $fontPath)) {
    Write-Host "Japanese font not found at $fontPath" -ForegroundColor Red
    Write-Host "Please ensure NotoSansJP.ttf is in the fonts directory" -ForegroundColor Yellow
    exit 1
}

Write-Host "Japanese font found: $fontPath" -ForegroundColor Green

# Advanced font registration with Aspose.PSD
Write-Host "Advanced font registration..." -ForegroundColor Cyan
try {
    $fontFolder = Join-Path $pwd "fonts"
    
    # Method 1: Add font folder
    $currentFolders = [Aspose.PSD.FontSettings]::GetFontsFolders()
    Write-Host "Current font folders: $($currentFolders -join ', ')" -ForegroundColor Gray
    
    $newFolders = $currentFolders + $fontFolder
    [Aspose.PSD.FontSettings]::SetFontsFolders($newFolders, $false)
    
    # Method 2: Load font directly from file
    try {
        $fontBytes = [System.IO.File]::ReadAllBytes($fontPath)
        [Aspose.PSD.FontSettings]::LoadFont($fontBytes)
        Write-Host "Font loaded directly from bytes" -ForegroundColor Green
    } catch {
        Write-Host "Warning: Direct font loading failed: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Method 3: Set font replacement
    $fontReplacements = @{
        "Arial" = "Noto Sans JP"
        "DejaVu Sans" = "Noto Sans JP"
        "Liberation Sans" = "Noto Sans JP"
    }
    
    foreach ($original in $fontReplacements.Keys) {
        try {
            [Aspose.PSD.FontSettings]::SetFontReplacements($original, @($fontReplacements[$original]))
            Write-Host "Font replacement set: $original -> $($fontReplacements[$original])" -ForegroundColor Gray
        } catch {
            Write-Host "Warning: Font replacement failed for $original" -ForegroundColor Yellow
        }
    }
    
    # Force refresh fonts cache
    [Aspose.PSD.FontSettings]::UpdateFonts()
    Write-Host "Font system updated" -ForegroundColor Green
    
} catch {
    Write-Host "Warning: Font registration error: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Find PSD files in the current directory
$psdFiles = Get-ChildItem -Path $pwd -Filter "*.psd" -File
if ($psdFiles.Count -eq 0) {
    Write-Host "現在のディレクトリにPSDファイルが見つかりません" -ForegroundColor Red
    exit 1
}

# Display found PSD files and let user select if multiple
if ($psdFiles.Count -eq 1) {
    $selectedPsd = $psdFiles[0]
    Write-Host "PSDファイルが見つかりました: $($selectedPsd.Name)" -ForegroundColor Green
} else {
    Write-Host "複数のPSDファイルが見つかりました:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $psdFiles.Count; $i++) {
        Write-Host "  [$($i+1)] $($psdFiles[$i].Name)" -ForegroundColor White
    }
    $selection = Read-Host "PSDファイル番号を選択してください (1-$($psdFiles.Count))"
    $selectedPsd = $psdFiles[[int]$selection - 1]
}

# Input and output paths
$inputPath = $selectedPsd.FullName
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($selectedPsd.Name)
$outputPath = join-path ${pwd} "${baseName}_jp_improved.psd"
$previewPath = join-path ${pwd} "${baseName}_jp_improved_preview.png"

Write-Host "`n日本語テキストレイヤー操作を開始しています..." -ForegroundColor Green

try {
    # Set up load options with better settings for text
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true
    $loadOptions.AllowWarpRepaint = $true

    # Load PSD image
    $img = [Aspose.PSD.Image]::Load($inputPath, $loadOptions)
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    
    Write-Host "$($psdImage.Layers.Count) 個のレイヤーを含むPSDを読み込みました" -ForegroundColor Yellow
    
    # Enhanced Japanese text creation function
    function Add-JapaneseTextLayer {
        param (
            [Aspose.PSD.FileFormats.Psd.PsdImage]$psdImage,
            [string]$text,
            [Aspose.PSD.Rectangle]$rect,
            [string]$layerName,
            [int]$fontSize = 24,
            [Aspose.PSD.Color]$color = [Aspose.PSD.Color]::Black
        )
        
        Write-Host "    テキストレイヤー作成中: $layerName" -ForegroundColor Cyan
        
        try {
            # Create text layer with proper encoding
            $textLayer = $psdImage.AddTextLayer($text, $rect)
            
            if ($textLayer -eq $null) {
                Write-Host "      エラー: テキストレイヤーの作成に失敗しました" -ForegroundColor Red
                return $null
            }
            
            $textLayer.DisplayName = $layerName
            
            # Enhanced text data configuration
            if ($textLayer.TextData -ne $null) {
                
                # Set text properties with multiple font attempts
                $fontNames = @("NotoSansJP", "Noto Sans JP", "NotoSansJP-Regular", "Noto Sans CJK JP", "MS UI Gothic", "Yu Gothic")
                
                foreach ($fontName in $fontNames) {
                    try {
                        if ($textLayer.TextData.Items -ne $null) {
                            foreach ($portion in $textLayer.TextData.Items) {
                                if ($portion -ne $null -and $portion.Style -ne $null) {
                                    $portion.Style.FontName = $fontName
                                    $portion.Style.FontSize = $fontSize
                                    $portion.Style.FillColor = $color
                                    
                                    # Additional Japanese text settings
                                    try {
                                        $portion.Style.IsStandardVerticalRomanAlignmentEnabled = $false
                                        $portion.Style.HorizontalAlignment = [Aspose.PSD.FileFormats.Psd.HorizontalAlignment]::Left
                                    } catch { }
                                }
                            }
                        }
                        
                        # Try to update layer data
                        $textLayer.TextData.UpdateLayerData()
                        Write-Host "      成功: フォント '$fontName' が適用されました" -ForegroundColor Green
                        break
                        
                    } catch {
                        Write-Host "      警告: フォント '$fontName' の適用に失敗: $($_.Exception.Message)" -ForegroundColor Yellow
                        continue
                    }
                }
            }
            
            return $textLayer
            
        } catch {
            Write-Host "      エラー: $($_.Exception.Message)" -ForegroundColor Red
            return $null
        }
    }
    
    # Create multiple Japanese text layers
    $textLayers = @()
    
    # Test layer 1: Simple Japanese text
    $layer1 = Add-JapaneseTextLayer -psdImage $psdImage -text "こんにちは世界" -rect (New-Object Aspose.PSD.Rectangle(50, 50, 400, 60)) -layerName "挨拶テキスト" -fontSize 32 -color ([Aspose.PSD.Color]::FromArgb(0, 100, 200))
    if ($layer1) { $textLayers += $layer1 }
    
    # Test layer 2: Complex Japanese text
    $layer2 = Add-JapaneseTextLayer -psdImage $psdImage -text "ポスターラボへようこそ！" -rect (New-Object Aspose.PSD.Rectangle(50, 120, 500, 60)) -layerName "ウェルカムメッセージ" -fontSize 28 -color ([Aspose.PSD.Color]::FromArgb(200, 50, 50))
    if ($layer2) { $textLayers += $layer2 }
    
    # Test layer 3: Mixed text
    $layer3 = Add-JapaneseTextLayer -psdImage $psdImage -text "デザイン Design 2025" -rect (New-Object Aspose.PSD.Rectangle(50, 190, 450, 60)) -layerName "ミックステキスト" -fontSize 24 -color ([Aspose.PSD.Color]::FromArgb(50, 150, 50))
    if ($layer3) { $textLayers += $layer3 }
    
    # Test layer 4: Hiragana, Katakana, Kanji
    $layer4 = Add-JapaneseTextLayer -psdImage $psdImage -text "ひらがな・カタカナ・漢字" -rect (New-Object Aspose.PSD.Rectangle(50, 260, 500, 60)) -layerName "文字体系テスト" -fontSize 22 -color ([Aspose.PSD.Color]::FromArgb(150, 50, 150))
    if ($layer4) { $textLayers += $layer4 }
    
    Write-Host "`n作成されたテキストレイヤー数: $($textLayers.Count)" -ForegroundColor Yellow
    
    # Try to process existing text layers
    Write-Host "`n既存のテキストレイヤーを処理中..." -ForegroundColor Cyan
    $existingCount = 0
    
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $existingCount++
            $existingTextLayer = [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
            
            Write-Host "  処理中: $($existingTextLayer.DisplayName)" -ForegroundColor Yellow
            
            # Update existing layers for Japanese compatibility
            if ($existingTextLayer.TextData -ne $null -and $existingTextLayer.TextData.Items -ne $null) {
                foreach ($portion in $existingTextLayer.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $originalFont = $portion.Style.FontName
                        if ($originalFont -match "Arial|DejaVu|Liberation") {
                            $portion.Style.FontName = "NotoSansJP"
                            Write-Host "    フォント更新: $originalFont -> NotoSansJP" -ForegroundColor Gray
                        }
                    }
                }
                
                try {
                    $existingTextLayer.TextData.UpdateLayerData()
                } catch {
                    Write-Host "    警告: レイヤーデータ更新エラー" -ForegroundColor Yellow
                }
            }
        }
    }
    
    Write-Host "  処理された既存レイヤー数: $existingCount" -ForegroundColor Gray
    
    # Save results with improved options
    Write-Host "`n結果を保存中..." -ForegroundColor Yellow
    
    # Save PSD
    try {
        $psdImage.Save($outputPath)
        Write-Host "  ✓ PSD保存完了: $outputPath" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ PSD保存エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Save PNG with optimized settings for Japanese text
    try {
        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
        
        # Improved rendering settings
        if ($pngOptions.VectorRasterizationOptions -ne $null) {
            $pngOptions.VectorRasterizationOptions.TextRenderingHint = [Aspose.PSD.TextRenderingHint]::ClearTypeGridFit
            $pngOptions.VectorRasterizationOptions.SmoothingMode = [Aspose.PSD.SmoothingMode]::HighQuality
        }
        
        $psdImage.Save($previewPath, $pngOptions)
        Write-Host "  ✓ PNG保存完了: $previewPath" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ PNG保存エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Final summary
    Write-Host "`n" + ("=" * 60) -ForegroundColor Magenta
    Write-Host "処理結果サマリー" -ForegroundColor Magenta
    Write-Host ("=" * 60) -ForegroundColor Magenta
    Write-Host "  新規日本語テキストレイヤー: $($textLayers.Count)" -ForegroundColor White
    Write-Host "  処理済み既存レイヤー: $existingCount" -ForegroundColor White
    Write-Host "  総レイヤー数: $($psdImage.Layers.Count)" -ForegroundColor White
    Write-Host "  出力ファイル: PSD, PNG" -ForegroundColor White
    Write-Host ("=" * 60) -ForegroundColor Magenta
    
    # Debug font information
    Write-Host "`nデバッグ情報:" -ForegroundColor Cyan
    Write-Host "  システムフォントフォルダー:" -ForegroundColor Gray
    foreach ($folder in [Aspose.PSD.FontSettings]::GetFontsFolders()) {
        Write-Host "    - $folder" -ForegroundColor Gray
    }
    
    Write-Host "`n✓ 日本語テキスト処理が完了しました！" -ForegroundColor Green
    
} catch {
    Write-Host "`n✗ エラーが発生しました:" -ForegroundColor Red
    Write-Host "メッセージ: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "場所: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "`nリソースをクリーンアップしました" -ForegroundColor Gray
    }
}