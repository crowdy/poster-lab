# Japanese text test with system font fallback
# システムフォントフォールバック付き日本語テキストテスト

. ./Load-AsposePSD.ps1

Write-Host "システムフォント確認と日本語テキストテスト" -ForegroundColor Green

# Find any PSD file
$psdFile = Get-ChildItem -Path $pwd -Filter "*.psd" -File | Select-Object -First 1
if (-not $psdFile) {
    Write-Host "PSDファイルが見つかりません" -ForegroundColor Red
    exit 1
}

$inputPath = $psdFile.FullName
$outputPath = Join-Path $pwd "font_test_fallback.psd"
$previewPath = Join-Path $pwd "font_test_fallback.png"

Write-Host "使用するPSD: $($psdFile.Name)" -ForegroundColor Yellow

try {
    # Load PSD
    $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
    $loadOptions.LoadEffectsResource = $true
    
    $img = [Aspose.PSD.Image]::Load($inputPath, $loadOptions)
    $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
    
    Write-Host "PSD読み込み完了: $($psdImage.Layers.Count) レイヤー" -ForegroundColor Yellow
    
    # Try different font approaches
    $testTexts = @(
        @{ Text = "Hello World"; Font = "Arial"; Name = "英語テスト" }
        @{ Text = "こんにちは"; Font = "Arial"; Name = "日本語-Arial" }
        @{ Text = "こんにちは"; Font = "DejaVu Sans"; Name = "日本語-DejaVu" }
        @{ Text = "こんにちは"; Font = "Liberation Sans"; Name = "日本語-Liberation" }
        @{ Text = "こんにちは"; Font = "NotoSansJP"; Name = "日本語-NotoSansJP" }
        @{ Text = "こんにちは"; Font = "Noto Sans JP"; Name = "日本語-Noto Sans JP" }
        @{ Text = "こんにちは"; Font = "sans-serif"; Name = "日本語-sans-serif" }
    )
    
    $y = 50
    $successCount = 0
    
    foreach ($test in $testTexts) {
        Write-Host "テスト中: $($test.Name) - フォント: $($test.Font)" -ForegroundColor Cyan
        
        try {
            $rect = New-Object Aspose.PSD.Rectangle(50, $y, 400, 40)
            $textLayer = $psdImage.AddTextLayer($test.Text, $rect)
            
            if ($textLayer -ne $null) {
                $textLayer.DisplayName = $test.Name
                
                if ($textLayer.TextData -ne $null -and $textLayer.TextData.Items -ne $null) {
                    foreach ($portion in $textLayer.TextData.Items) {
                        if ($portion.Style -ne $null) {
                            $portion.Style.FontName = $test.Font
                            $portion.Style.FontSize = 24
                            $portion.Style.FillColor = [Aspose.PSD.Color]::Black
                        }
                    }
                    
                    try {
                        $textLayer.TextData.UpdateLayerData()
                        Write-Host "  ✓ 成功: $($test.Name)" -ForegroundColor Green
                        $successCount++
                    } catch {
                        Write-Host "  ✗ UpdateLayerData失敗: $($_.Exception.Message)" -ForegroundColor Red
                    }
                }
            } else {
                Write-Host "  ✗ テキストレイヤー作成失敗" -ForegroundColor Red
            }
        } catch {
            Write-Host "  ✗ エラー: $($_.Exception.Message)" -ForegroundColor Red
        }
        
        $y += 50
    }
    
    Write-Host "`n成功したテスト: $successCount / $($testTexts.Count)" -ForegroundColor Yellow
    
    # Save results
    Write-Host "`n保存中..." -ForegroundColor Yellow
    
    $psdImage.Save($outputPath)
    Write-Host "PSD保存: $outputPath" -ForegroundColor Green
    
    # Save PNG with basic options
    $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
    $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
    
    $psdImage.Save($previewPath, $pngOptions)
    Write-Host "PNG保存: $previewPath" -ForegroundColor Green
    
    Write-Host "`n✓ フォントテスト完了" -ForegroundColor Green
    
} catch {
    Write-Host "`nエラー: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "詳細: $($_.Exception.StackTrace)" -ForegroundColor Red
} finally {
    if ($psdImage) { $psdImage.Dispose() }
}