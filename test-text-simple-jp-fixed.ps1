# Japanese text layer test script for Aspose.PSD - Fixed Version
# 日本語テキストレイヤーのテストスクリプト - 修正版

# Load Aspose.PSD assembly using dot-sourcing
. ./Load-AsposePSD.ps1

# Check if Japanese font exists
$fontPath = Join-Path $pwd "fonts/NotoSansJP.ttf"
if (-not (Test-Path $fontPath)) {
    Write-Host "Japanese font not found at $fontPath" -ForegroundColor Red
    Write-Host "Please ensure NotoSansJP.ttf is in the fonts directory" -ForegroundColor Yellow
    exit 1
}

Write-Host "Japanese font found: $fontPath" -ForegroundColor Green

# Register custom font folder with Aspose.PSD
Write-Host "Registering custom font folder..." -ForegroundColor Cyan
try {
    $fontFolder = Join-Path $pwd "fonts"
    
    # Get current font folders
    $currentFolders = [Aspose.PSD.FontSettings]::GetFontsFolders()
    Write-Host "Current font folders: $($currentFolders -join ', ')" -ForegroundColor Gray
    
    # Add our custom font folder
    $newFolders = $currentFolders + $fontFolder
    [Aspose.PSD.FontSettings]::SetFontsFolders($newFolders, $false)
    
    Write-Host "Font folder registered successfully: $fontFolder" -ForegroundColor Green
    
    # Force refresh fonts cache
    [Aspose.PSD.FontSettings]::UpdateFonts()
    Write-Host "Font cache updated" -ForegroundColor Green
} catch {
    Write-Host "Warning: Could not register font folder: $($_.Exception.Message)" -ForegroundColor Yellow
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
$outputPath = join-path ${pwd} "${baseName}_text-simple-jp-fixed.psd"
$previewPath = join-path ${pwd} "${baseName}_text-simple-jp-fixed_preview.png"

Write-Host "`n日本語テキストレイヤー操作を開始しています..." -ForegroundColor Green

try {
    # Set up load options
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    $loadOptions.UseDiskForLoadEffectsResource = $true

    # Load PSD image
    $img = [Aspose.PSD.Image]::Load($inputPath, $loadOptions)
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    
    Write-Host "$($psdImage.Layers.Count) 個のレイヤーを含むPSDを読み込みました" -ForegroundColor Yellow
    
    # Add multiple Japanese text layers with different styles
    $textLayers = @()
    
    # Helper function to properly set Japanese text
    function Set-JapaneseText {
        param (
            [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$textLayer,
            [string]$fontName,
            [int]$fontSize,
            [Aspose.PSD.Color]$color
        )
        
        if ($textLayer -eq $null) {
            Write-Host "    Warning: TextLayer is null" -ForegroundColor Yellow
            return
        }
        
        if ($textLayer.TextData -eq $null) {
            Write-Host "    Warning: TextData is null" -ForegroundColor Yellow
            return
        }
        
        # Get the text data
        $textData = $textLayer.TextData
        
        # Update default style
        if ($textData.ProducedByDefaultText -ne $null) {
            $textData.ProducedByDefaultText = $false
        }
        
        # Update items (portions)
        if ($textData.Items -ne $null -and $textData.Items.Length -gt 0) {
            foreach ($portion in $textData.Items) {
                if ($portion -ne $null -and $portion.Style -ne $null) {
                    # Set font properties
                    $portion.Style.FontName = $fontName
                    $portion.Style.FontSize = $fontSize
                    $portion.Style.FillColor = $color
                    
                    # Set text direction for proper rendering
                    try {
                        $portion.Style.IsStandardVerticalRomanAlignmentEnabled = $false
                    } catch {
                        # This property might not be available in all versions
                    }
                }
            }
        }
        
        # Force update layer data
        try {
            $textData.UpdateLayerData()
            Write-Host "    Text data updated successfully" -ForegroundColor Gray
        } catch {
            Write-Host "    Warning during UpdateLayerData: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
    
    # Text layer 1: Welcome message in Japanese
    Write-Host "`n日本語ウェルカムテキストレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect1 = New-Object Aspose.PSD.Rectangle(50, 50, 600, 100)
        $textLayer1 = $psdImage.AddTextLayer("ポスターラボへようこそ", $textRect1)
        
        if ($textLayer1 -ne $null) {
            $textLayer1.DisplayName = "ウェルカムテキスト"
            
            # Use proper font name variations
            Set-JapaneseText -textLayer $textLayer1 -fontName "Noto Sans JP" -fontSize 36 -color ([Aspose.PSD.Color]::FromArgb(33, 150, 243))
            
            $textLayers += $textLayer1
            Write-Host "  作成完了: ウェルカムテキスト" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 2: Subtitle in Japanese
    Write-Host "`nサブタイトルテキストレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect2 = New-Object Aspose.PSD.Rectangle(50, 150, 600, 80)
        $textLayer2 = $psdImage.AddTextLayer("プロフェッショナルデザインソリューション", $textRect2)
        
        if ($textLayer2 -ne $null) {
            $textLayer2.DisplayName = "サブタイトル"
            
            Set-JapaneseText -textLayer $textLayer2 -fontName "Noto Sans JP" -fontSize 24 -color ([Aspose.PSD.Color]::FromArgb(96, 125, 139))
            
            $textLayers += $textLayer2
            Write-Host "  作成完了: サブタイトル" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 3: Call to action in Japanese
    Write-Host "`nCTAテキストレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect3 = New-Object Aspose.PSD.Rectangle(50, 250, 500, 60)
        $textLayer3 = $psdImage.AddTextLayer("今すぐ始めましょう！", $textRect3)
        
        if ($textLayer3 -ne $null) {
            $textLayer3.DisplayName = "CTAボタンテキスト"
            
            Set-JapaneseText -textLayer $textLayer3 -fontName "Noto Sans JP" -fontSize 28 -color ([Aspose.PSD.Color]::FromArgb(255, 87, 34))
            
            $textLayers += $textLayer3
            Write-Host "  作成完了: CTAボタンテキスト" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 4: Additional Japanese phrases
    Write-Host "`n追加の日本語フレーズレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect4 = New-Object Aspose.PSD.Rectangle(50, 330, 600, 60)
        $textLayer4 = $psdImage.AddTextLayer("最高品質のデザインをお届けします", $textRect4)
        
        if ($textLayer4 -ne $null) {
            $textLayer4.DisplayName = "品質メッセージ"
            
            Set-JapaneseText -textLayer $textLayer4 -fontName "Noto Sans JP" -fontSize 20 -color ([Aspose.PSD.Color]::FromArgb(76, 175, 80))
            
            $textLayers += $textLayer4
            Write-Host "  作成完了: 品質メッセージ" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 5: Japanese tagline
    Write-Host "`nタグラインレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect5 = New-Object Aspose.PSD.Rectangle(50, 400, 600, 60)
        $textLayer5 = $psdImage.AddTextLayer("創造性と革新の融合", $textRect5)
        
        if ($textLayer5 -ne $null) {
            $textLayer5.DisplayName = "タグライン"
            
            Set-JapaneseText -textLayer $textLayer5 -fontName "Noto Sans JP" -fontSize 22 -color ([Aspose.PSD.Color]::FromArgb(156, 39, 176))
            
            $textLayers += $textLayer5
            Write-Host "  作成完了: タグライン" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 6: Footer in Japanese (using plain ASCII characters for copyright symbol)
    Write-Host "`nフッターテキストレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect6 = New-Object Aspose.PSD.Rectangle(50, 470, 600, 50)
        $textLayer6 = $psdImage.AddTextLayer("(C) 2025 ポスターラボ - 著作権所有", $textRect6)
        
        if ($textLayer6 -ne $null) {
            $textLayer6.DisplayName = "フッター"
            
            Set-JapaneseText -textLayer $textLayer6 -fontName "Noto Sans JP" -fontSize 14 -color ([Aspose.PSD.Color]::FromArgb(158, 158, 158))
            
            $textLayers += $textLayer6
            Write-Host "  作成完了: フッター" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Alternative approach: Try using system fonts if custom fonts fail
    Write-Host "`n代替フォントアプローチを試行中..." -ForegroundColor Cyan
    
    # Create a simple test layer with basic settings
    try {
        $testRect = New-Object Aspose.PSD.Rectangle(50, 550, 600, 50)
        $testLayer = $psdImage.AddTextLayer("テストテキスト - Test Text 123", $testRect)
        
        if ($testLayer -ne $null) {
            $testLayer.DisplayName = "テストレイヤー"
            
            # Try multiple font name variations
            $fontNames = @("NotoSansJP", "Noto Sans JP", "NotoSansJP-Regular", "Noto Sans CJK JP")
            
            foreach ($fontName in $fontNames) {
                Write-Host "  Trying font: $fontName" -ForegroundColor Gray
                try {
                    if ($testLayer.TextData -ne $null -and $testLayer.TextData.Items -ne $null) {
                        foreach ($portion in $testLayer.TextData.Items) {
                            if ($portion.Style -ne $null) {
                                $portion.Style.FontName = $fontName
                                $portion.Style.FontSize = 18
                                $portion.Style.FillColor = [Aspose.PSD.Color]::Black
                            }
                        }
                        $testLayer.TextData.UpdateLayerData()
                        Write-Host "    Font '$fontName' applied" -ForegroundColor Green
                        break
                    }
                } catch {
                    Write-Host "    Font '$fontName' failed: $($_.Exception.Message)" -ForegroundColor Yellow
                    continue
                }
            }
            
            $textLayers += $testLayer
        }
    } catch {
        Write-Host "  Test layer error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Update existing text layers in the document
    Write-Host "`n既存のテキストレイヤーを確認中..." -ForegroundColor Cyan
    $existingTextCount = 0
    
    foreach ($layer in $psdImage.Layers) {
        if ($layer -is [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]) {
            $existingTextCount++
            $existingTextLayer = [Aspose.PSD.FileFormats.Psd.Layers.TextLayer]$layer
            
            Write-Host "  発見: $($existingTextLayer.DisplayName)" -ForegroundColor Yellow
            
            # Ensure font compatibility for Japanese
            if ($existingTextLayer.TextData -ne $null -and $existingTextLayer.TextData.Items -ne $null) {
                foreach ($portion in $existingTextLayer.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        # Update to Japanese font if using DejaVu or Arial
                        if ($portion.Style.FontName -match "DejaVu|Arial") {
                            $originalFont = $portion.Style.FontName
                            $portion.Style.FontName = "NotoSansJP"
                            Write-Host "    フォントを '$originalFont' から 'NotoSansJP' に更新しました" -ForegroundColor Gray
                        }
                    }
                }
                try {
                    $existingTextLayer.TextData.UpdateLayerData()
                } catch {
                    Write-Host "    Warning during update: $($_.Exception.Message)" -ForegroundColor Yellow
                }
            }
        }
    }
    
    if ($existingTextCount -gt 0) {
        Write-Host "  $existingTextCount 個の既存テキストレイヤーを更新しました" -ForegroundColor Green
    } else {
        Write-Host "  既存のテキストレイヤーが見つかりませんでした" -ForegroundColor Gray
    }
    
    # Save results
    Write-Host "`n結果を保存中..." -ForegroundColor Yellow
    
    # Save as PSD
    $psdImage.Save($outputPath)
    Write-Host "  PSDを保存しました: $outputPath" -ForegroundColor Green
    
    # Save PNG preview with better options for Japanese text
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    
    # Try to improve rendering quality
    if ($pngOptions.VectorRasterizationOptions -ne $null) {
        $pngOptions.VectorRasterizationOptions.TextRenderingHint = [Aspose.PSD.TextRenderingHint]::AntiAlias
        $pngOptions.VectorRasterizationOptions.SmoothingMode = [Aspose.PSD.SmoothingMode]::HighQuality
    }
    
    $psdImage.Save($previewPath, $pngOptions)
    Write-Host "  PNGを保存しました: $previewPath" -ForegroundColor Green
    
    # Summary
    Write-Host "`n" + ("=" * 60) -ForegroundColor Magenta
    Write-Host "操作サマリー" -ForegroundColor Magenta
    Write-Host ("=" * 60) -ForegroundColor Magenta
    Write-Host "  新規作成した日本語テキストレイヤー: $($textLayers.Count)" -ForegroundColor White
    Write-Host "  更新した既存レイヤー: $existingTextCount" -ForegroundColor White
    Write-Host "  PSD内の総レイヤー数: $($psdImage.Layers.Count)" -ForegroundColor White
    Write-Host "  生成された出力ファイル: 2" -ForegroundColor White
    Write-Host ("=" * 60) -ForegroundColor Magenta
    
    Write-Host "`n日本語テキスト操作が正常に完了しました！" -ForegroundColor Green
    
    # Debug information
    Write-Host "`nデバッグ情報:" -ForegroundColor Cyan
    Write-Host "  Font folders: $([Aspose.PSD.FontSettings]::GetFontsFolders() -join ', ')" -ForegroundColor Gray
    
} catch {
    Write-Host "`nエラー: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "スタックトレース: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    # Clean up resources
    if ($psdImage) {
        $psdImage.Dispose()
        Write-Host "`nリソースをクリーンアップしました" -ForegroundColor Gray
    }
}