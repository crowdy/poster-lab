# Japanese text layer test script for Aspose.PSD
# 日本語テキストレイヤーのテストスクリプト

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
$outputPath = join-path ${pwd} "${baseName}_text-simple-jp.psd"
$previewPath = join-path ${pwd} "${baseName}_text-simple-jp_preview.png"

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
    
    # Text layer 1: Welcome message in Japanese
    Write-Host "`n日本語ウェルカムテキストレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect1 = New-Object Aspose.PSD.Rectangle(50, 50, 600, 100)
        $textLayer1 = $psdImage.AddTextLayer("ポスターラボへようこそ", $textRect1)
        
        if ($textLayer1 -ne $null) {
            $textLayer1.DisplayName = "ウェルカムテキスト"
            
            # Update text properties with Japanese font
            if ($textLayer1.TextData -ne $null -and $textLayer1.TextData.Items -ne $null) {
                foreach ($portion in $textLayer1.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Noto Sans JP"
                        $portion.Style.FontSize = 36
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(33, 150, 243)  # Blue
                    }
                }
                $textLayer1.TextData.UpdateLayerData()
            }
            
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
            
            # Update with different style
            if ($textLayer2.TextData -ne $null -and $textLayer2.TextData.Items -ne $null) {
                foreach ($portion in $textLayer2.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Noto Sans JP"
                        $portion.Style.FontSize = 24
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(96, 125, 139)  # Gray-blue
                    }
                }
                $textLayer2.TextData.UpdateLayerData()
            }
            
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
            
            # Bold style for CTA
            if ($textLayer3.TextData -ne $null -and $textLayer3.TextData.Items -ne $null) {
                foreach ($portion in $textLayer3.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Noto Sans JP"
                        $portion.Style.FontSize = 28
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(255, 87, 34)  # Orange-red
                    }
                }
                $textLayer3.TextData.UpdateLayerData()
            }
            
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
            
            if ($textLayer4.TextData -ne $null -and $textLayer4.TextData.Items -ne $null) {
                foreach ($portion in $textLayer4.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Noto Sans JP"
                        $portion.Style.FontSize = 20
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(76, 175, 80)  # Green
                    }
                }
                $textLayer4.TextData.UpdateLayerData()
            }
            
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
            
            if ($textLayer5.TextData -ne $null -and $textLayer5.TextData.Items -ne $null) {
                foreach ($portion in $textLayer5.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Noto Sans JP"
                        $portion.Style.FontSize = 22
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(156, 39, 176)  # Purple
                    }
                }
                $textLayer5.TextData.UpdateLayerData()
            }
            
            $textLayers += $textLayer5
            Write-Host "  作成完了: タグライン" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Text layer 6: Footer in Japanese
    Write-Host "`nフッターテキストレイヤーを作成中..." -ForegroundColor Cyan
    try {
        $textRect6 = New-Object Aspose.PSD.Rectangle(50, 470, 600, 50)
        $textLayer6 = $psdImage.AddTextLayer("© 2025 ポスターラボ | 著作権所有", $textRect6)
        
        if ($textLayer6 -ne $null) {
            $textLayer6.DisplayName = "フッター"
            
            # Small footer text
            if ($textLayer6.TextData -ne $null -and $textLayer6.TextData.Items -ne $null) {
                foreach ($portion in $textLayer6.TextData.Items) {
                    if ($portion.Style -ne $null) {
                        $portion.Style.FontName = "Noto Sans JP"
                        $portion.Style.FontSize = 14
                        $portion.Style.FillColor = [Aspose.PSD.Color]::FromArgb(158, 158, 158)  # Light gray
                    }
                }
                $textLayer6.TextData.UpdateLayerData()
            }
            
            $textLayers += $textLayer6
            Write-Host "  作成完了: フッター" -ForegroundColor Green
        }
    } catch {
        Write-Host "  エラー: $($_.Exception.Message)" -ForegroundColor Red
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
                            $portion.Style.FontName = "Noto Sans JP"
                            Write-Host "    フォントを '$originalFont' から 'Noto Sans JP' に更新しました" -ForegroundColor Gray
                        }
                    }
                }
                $existingTextLayer.TextData.UpdateLayerData()
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
    
    # Save PNG preview
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
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