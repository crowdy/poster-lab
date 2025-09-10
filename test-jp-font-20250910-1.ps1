# Aspose.PSD for .NET 일본어 텍스트 처리 PowerShell 스크립트
# PowerShell 7.5.2에서 실행 가능, 멀티플랫폼 지원

#Requires -Version 7.0

# Load-AsposePSD.ps1 스크립트 로드 (존재하는 경우)
if (Test-Path "./Load-AsposePSD.ps1") {
    . ./Load-AsposePSD.ps1
} else {
    # 필요한 어셈블리 로드
    try {
        # Aspose.PSD 어셈블리 경로 (NuGet 패키지 설치 후 경로 조정 필요)
        $asposePsdPath = ".\packages\Aspose.PSD.24.12.0\lib\net6.0\Aspose.PSD.dll"
        
        # 어셈블리가 존재하지 않으면 다른 경로들 시도
        if (-not (Test-Path $asposePsdPath)) {
            $possiblePaths = @(
                "${env:USERPROFILE}\.nuget\packages\aspose.psd\*\lib\net6.0\Aspose.PSD.dll",
                "${env:USERPROFILE}\.nuget\packages\aspose.psd\*\lib\netstandard2.0\Aspose.PSD.dll",
                ".\Aspose.PSD.dll",
                ".\aspose-packages\Aspose.PSD.dll"
            )
            
            foreach ($path in $possiblePaths) {
                $resolved = Get-ChildItem $path -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($resolved) {
                    $asposePsdPath = $resolved.FullName
                    break
                }
            }
        }
        
        if (Test-Path $asposePsdPath) {
            Add-Type -Path $asposePsdPath
            Write-Host "✅ Aspose.PSD 어셈블리 로드 완료: $asposePsdPath" -ForegroundColor Green
        } else {
            throw "Aspose.PSD 어셈블리를 찾을 수 없습니다. NuGet으로 설치하거나 경로를 확인하세요."
        }
    } catch {
        Write-Error "어셈블리 로드 실패: $_"
        Write-Host "NuGet으로 Aspose.PSD 설치: Install-Package Aspose.PSD" -ForegroundColor Yellow
        exit 1
    }
}

# 네임스페이스 별칭 생성 (PowerShell에서 편리하게 사용)
$PsdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]
$FontSettings = [Aspose.PSD.FontSettings]
$Rectangle = [Aspose.PSD.Rectangle]
$AsposeColor = [Aspose.PSD.Color]  # 올바른 Aspose.PSD.Color 사용
$SystemColor = [System.Drawing.Color]  # System.Drawing.Color 참조용
$PngOptions = [Aspose.PSD.ImageOptions.PngOptions]
$PngColorType = [Aspose.PSD.FileFormats.Png.PngColorType]
$Image = [Aspose.PSD.Image]

# System.Drawing.Color를 Aspose.PSD.Color로 변환하는 헬퍼 함수
function ConvertTo-AsposeColor {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.Drawing.Color]$SystemColor
    )
    
    return $AsposeColor::FromArgb($SystemColor.A, $SystemColor.R, $SystemColor.G, $SystemColor.B)
}

# 함수: Aspose.PSD 색상 기능 테스트
function Test-AsposePsdColors {
    [CmdletBinding()]
    param()
    
    Write-Host "🎨 Aspose.PSD.Color 기능 테스트:" -ForegroundColor Yellow
    
    try {
        # 기본 색상들 테스트
        $colors = @{
            "White" = { $AsposeColor::White }
            "Black" = { $AsposeColor::Black }
            "Red" = { $AsposeColor::Red }
            "Blue" = { $AsposeColor::Blue }
            "Green" = { $AsposeColor::Green }
            "Transparent" = { $AsposeColor::Transparent }
        }
        
        foreach ($colorName in $colors.Keys) {
            try {
                $colorValue = & $colors[$colorName]
                Write-Host "  ✅ $colorName : $colorValue" -ForegroundColor Green
            }
            catch {
                Write-Host "  ❌ $colorName : $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        
        # FromArgb 메서드 테스트
        Write-Host "`n🛠️  FromArgb 메서드 테스트:" -ForegroundColor Cyan
        try {
            $customColor = $AsposeColor::FromArgb(255, 128, 64, 192)
            Write-Host "  ✅ FromArgb(255, 128, 64, 192): $customColor" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ FromArgb 실패: $($_.Exception.Message)" -ForegroundColor Red
        }
        
        # System.Drawing.Color 변환 테스트
        Write-Host "`n🔄 System.Drawing.Color 변환 테스트:" -ForegroundColor Cyan
        try {
            $sysWhite = $SystemColor::White
            $asposeWhite = ConvertTo-AsposeColor -SystemColor $sysWhite
            Write-Host "  ✅ 변환 성공: $sysWhite -> $asposeWhite" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ 변환 실패: $($_.Exception.Message)" -ForegroundColor Red
        }
        
    }
    catch {
        Write-Host "❌ 색상 테스트 실패: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 함수: 시스템에서 사용 가능한 폰트 목록 가져오기 (OS별)
function Get-SystemAvailableFonts {
    [CmdletBinding()]
    param()
    
    try {
        if ($IsWindows) {
            # Windows에서는 System.Drawing.Text.InstalledFontCollection 사용
            try {
                $fontCollection = [System.Drawing.Text.InstalledFontCollection]::new()
                $availableFontNames = @()
                
                foreach ($fontFamily in $fontCollection.Families) {
                    $availableFontNames += $fontFamily.Name
                }
                
                $fontCollection.Dispose()
                return $availableFontNames
            }
            catch {
                Write-Host "⚠️  Windows 폰트 컬렉션 접근 실패, 기본 목록 사용" -ForegroundColor Yellow
                return @("Arial", "Times New Roman", "Courier New", "Segoe UI", "Tahoma")
            }
        }
        elseif ($IsLinux) {
            # Linux에서는 fc-list 명령어 사용
            try {
                $fcListOutput = fc-list --format="%{family}\n" 2>/dev/null | Sort-Object | Get-Unique
                if ($fcListOutput) {
                    return $fcListOutput
                } else {
                    throw "fc-list 명령어 실행 실패"
                }
            }
            catch {
                Write-Host "⚠️  fc-list 명령어 사용 불가, 기본 Linux 폰트 목록 사용" -ForegroundColor Yellow
                return @(
                    "DejaVu Sans", "DejaVu Serif", "DejaVu Sans Mono",
                    "Liberation Sans", "Liberation Serif", "Liberation Mono",
                    "Noto Sans", "Noto Serif", "Noto Sans CJK JP", "Noto Serif CJK JP",
                    "Ubuntu", "Ubuntu Mono", "Droid Sans", "Arial", "Times New Roman"
                )
            }
        }
        elseif ($IsMacOS) {
            # macOS에서는 system_profiler 또는 기본 목록 사용
            try {
                $fontOutput = system_profiler SPFontsDataType 2>/dev/null | grep "Full Name:" | ForEach-Object { $_.Split(":")[1].Trim() }
                if ($fontOutput) {
                    return $fontOutput
                } else {
                    throw "system_profiler 실행 실패"
                }
            }
            catch {
                Write-Host "⚠️  macOS 폰트 목록 가져오기 실패, 기본 목록 사용" -ForegroundColor Yellow
                return @(
                    "Arial", "Helvetica", "Times New Roman", "Courier New",
                    "Hiragino Sans", "Hiragino Kaku Gothic ProN", "Hiragino Mincho ProN",
                    "Yu Gothic", "SF Pro Display", "SF Pro Text"
                )
            }
        }
        else {
            # 알 수 없는 OS의 경우 기본 폰트 목록
            return @("Arial", "Times New Roman", "Courier New", "Sans-serif", "Serif", "Monospace")
        }
    }
    catch {
        Write-Host "⚠️  시스템 폰트 목록을 가져오는데 실패했습니다: $($_.Exception.Message)" -ForegroundColor Yellow
        # 최소한의 기본 폰트 목록 반환
        return @("Arial", "Times New Roman", "Courier New")
    }
}

# 함수: 일본어 폰트 설정 (OS별 지원, 개선된 폰트 감지)
function Set-JapaneseFonts {
    [CmdletBinding()]
    param()
    
    try {
        Write-Host "🔧 일본어 폰트 설정 중..." -ForegroundColor Cyan
        
        # 운영체제에 따른 폰트 폴더 설정
        if ($IsWindows) {
            Write-Host "🖥️  Windows 환경 감지" -ForegroundColor Gray
            $fontFolders = @(
                "${env:WINDIR}\Fonts",                 # Windows 시스템 폰트
                "${env:USERPROFILE}\AppData\Local\Microsoft\Windows\Fonts", # 사용자 폰트
                ".\CustomFonts\Japanese"                # 사용자 지정 일본어 폰트 폴더
            )
        }
        elseif ($IsLinux) {
            Write-Host "🐧 Linux 환경 감지" -ForegroundColor Gray
            $fontFolders = @(
                "/usr/share/fonts",                     # 시스템 폰트
                "/usr/local/share/fonts",               # 로컬 시스템 폰트
                "${env:HOME}/.fonts",                   # 사용자 폰트 (레거시)
                "${env:HOME}/.local/share/fonts",       # 사용자 폰트 (표준)
                "/etc/fonts",                           # 폰트 설정
                "/var/lib/defoma/fontconfig.d/",        # Debian 폰트
                "./CustomFonts/Japanese"                # 사용자 지정 일본어 폰트 폴더
            )
        }
        elseif ($IsMacOS) {
            Write-Host "🍎 macOS 환경 감지" -ForegroundColor Gray
            $fontFolders = @(
                "/System/Library/Fonts",                # 시스템 폰트
                "/Library/Fonts",                       # 공용 폰트
                "${env:HOME}/Library/Fonts",            # 사용자 폰트
                "./CustomFonts/Japanese"                # 사용자 지정 일본어 폰트 폴더
            )
        }
        else {
            Write-Host "❓ 알 수 없는 운영체제 환경" -ForegroundColor Gray
            # 알 수 없는 OS의 경우 기본값
            $fontFolders = @(
                "./CustomFonts/Japanese"
            )
            Write-Host "⚠️  알 수 없는 운영체제입니다. 기본 폰트 폴더만 사용합니다." -ForegroundColor Yellow
        }
        
        # 존재하는 폴더만 필터링
        $existingFolders = $fontFolders | Where-Object { Test-Path $_ }
        
        if ($existingFolders.Count -gt 0) {
            $FontSettings::SetFontsFolders($existingFolders, $true)
            Write-Host "📁 폰트 폴더 설정 완료 ($($PSVersionTable.OS)): $($existingFolders -join ', ')" -ForegroundColor Green
        } else {
            Write-Host "⚠️  사용 가능한 폰트 폴더를 찾을 수 없습니다." -ForegroundColor Yellow
        }
        
        # 시스템에서 사용 가능한 폰트 목록 가져오기
        Write-Host "🔍 시스템 폰트 검색 중..." -ForegroundColor Gray
        $systemFonts = Get-SystemAvailableFonts
        
        if ($systemFonts.Count -eq 0) {
            Write-Host "⚠️  시스템 폰트를 찾을 수 없습니다. 폰트 제한을 해제합니다." -ForegroundColor Yellow
            $FontSettings::SetAllowedFonts($null)
            $FontSettings::UpdateFonts()
            return $true
        }
        
        Write-Host "📋 발견된 시스템 폰트: $($systemFonts.Count)개" -ForegroundColor Gray
        
        # 일본어를 지원할 가능성이 있는 폰트들의 후보 목록
        $japaneseFontCandidates = @(
            "Arial Unicode MS",      # 유니코드 지원 폰트
            "MS Gothic",            # 일본어 기본 폰트
            "MS Mincho",            # 일본어 명조체
            "Yu Gothic",            # 현대적인 일본어 폰트
            "Yu Gothic UI",         # Yu Gothic UI 버전
            "Meiryo",               # 일본어 UI 폰트
            "Meiryo UI",            # Meiryo UI 버전
            "Hiragino Sans",        # Mac 일본어 폰트
            "Hiragino Kaku Gothic ProN", # Mac 일본어 고딕
            "Hiragino Mincho ProN", # Mac 일본어 명조
            "NotoSansCJK-Regular",  # Google Noto 폰트
            "NotoSerifCJK-Regular", # Google Noto Serif 폰트
            "Noto Sans CJK JP",     # Google Noto Sans (일본어)
            "Noto Serif CJK JP",    # Google Noto Serif (일본어)
            "Noto Sans CJK",        # Google Noto CJK (일반)
            "Noto Serif CJK",       # Google Noto Serif CJK (일반)
            "Noto Sans",            # Google Noto Sans
            "DejaVu Sans",          # Linux 기본 폰트
            "Liberation Sans",      # Linux 대체 폰트
            "Arial",                # 기본 폰트
            "Segoe UI",             # Windows 기본 UI 폰트
            "Source Han Sans",      # Adobe Source Han Sans
            "Source Han Serif",     # Adobe Source Han Serif
            "Ubuntu",               # Ubuntu 폰트
            "Droid Sans"            # Android 폰트
        )
        
        # 실제로 시스템에 존재하는 폰트만 필터링 (대소문자 무시)
        $availableFonts = @()
        $foundJapaneseFonts = @()
        
        foreach ($candidate in $japaneseFontCandidates) {
            # 대소문자를 무시하고 부분 일치 검사
            $matchedFont = $systemFonts | Where-Object { $_ -match [regex]::Escape($candidate) -or $candidate -match [regex]::Escape($_) } | Select-Object -First 1
            
            if ($matchedFont) {
                $availableFonts += $matchedFont
                # 일본어 관련 폰트인지 확인
                if ($matchedFont -match "(Gothic|Mincho|Yu|Meiryo|Hiragino|Noto.*CJK|Source Han|Arial Unicode)") {
                    $foundJapaneseFonts += $matchedFont
                }
            }
        }
        
        # 중복 제거
        $availableFonts = $availableFonts | Sort-Object | Get-Unique
        $foundJapaneseFonts = $foundJapaneseFonts | Sort-Object | Get-Unique
        
        # 기본 폰트들도 추가 (시스템에 존재하는 경우)
        $basicFonts = @("Arial", "Times New Roman", "Helvetica", "Sans-serif", "Courier New")
        foreach ($basicFont in $basicFonts) {
            $matchedBasicFont = $systemFonts | Where-Object { $_ -match [regex]::Escape($basicFont) } | Select-Object -First 1
            if ($matchedBasicFont -and ($availableFonts -notcontains $matchedBasicFont)) {
                $availableFonts += $matchedBasicFont
            }
        }
        
        if ($availableFonts.Count -eq 0) {
            Write-Host "⚠️  적합한 폰트를 찾을 수 없습니다. 폰트 제한을 해제합니다." -ForegroundColor Yellow
            # 폰트 제한 없음
            $FontSettings::SetAllowedFonts($null)
        } else {
            $FontSettings::SetAllowedFonts($availableFonts)
            Write-Host "✅ 허용 폰트 설정 완료: $($availableFonts.Count)개 폰트" -ForegroundColor Green
            
            if ($foundJapaneseFonts.Count -gt 0) {
                Write-Host "🈯 일본어 지원 폰트 발견: $($foundJapaneseFonts -join ', ')" -ForegroundColor Green
            } else {
                Write-Host "⚠️  전용 일본어 폰트를 찾을 수 없습니다. 기본 폰트를 사용합니다." -ForegroundColor Yellow
            }
        }
        
        # 폰트 캐시 업데이트
        $FontSettings::UpdateFonts()
        Write-Host "🔄 폰트 캐시 업데이트 완료" -ForegroundColor Green
        
        return $true
    }
    catch {
        Write-Error "폰트 설정 중 오류 발생: $_"
        return $false
    }
}

# 함수: 사용 가능한 일본어 폰트 확인 (OS별)
function Get-AvailableJapaneseFonts {
    [CmdletBinding()]
    param()
    
    # 운영체제별로 확인할 폰트 목록 설정
    if ($IsWindows) {
        $commonJapaneseFonts = @(
            "MS Gothic", "MS Mincho", "MS PGothic", "MS PMincho",
            "Yu Gothic", "Yu Gothic UI", "Yu Mincho",
            "Meiryo", "Meiryo UI",
            "Arial Unicode MS"
        )
    }
    elseif ($IsLinux) {
        $commonJapaneseFonts = @(
            "Noto Sans CJK JP", "Noto Serif CJK JP",
            "NotoSansCJK-Regular", "NotoSerifCJK-Regular",
            "DejaVu Sans", "Liberation Sans",
            "MS Gothic", "Yu Gothic", "Arial Unicode MS"
        )
    }
    elseif ($IsMacOS) {
        $commonJapaneseFonts = @(
            "Hiragino Sans", "Hiragino Kaku Gothic ProN", "Hiragino Mincho ProN",
            "Yu Gothic", "Yu Gothic UI", "Yu Mincho",
            "Arial Unicode MS"
        )
    }
    else {
        $commonJapaneseFonts = @(
            "Arial Unicode MS", "DejaVu Sans", "Liberation Sans", "Arial"
        )
    }
    
    $availableFonts = @()
    foreach ($fontName in $commonJapaneseFonts) {
        if ($FontSettings::IsFontAllowed($fontName)) {
            $availableFonts += $fontName
        }
    }
    
    return $availableFonts
}

# 함수: 최적의 일본어 폰트 선택 (OS별)
function Get-BestJapaneseFont {
    [CmdletBinding()]
    param()
    
    # 운영체제별 폰트 우선순위
    if ($IsWindows) {
        $preferredFonts = @("Yu Gothic", "MS Gothic", "Meiryo", "Arial Unicode MS", "Arial")
    }
    elseif ($IsLinux) {
        $preferredFonts = @("Noto Sans CJK JP", "NotoSansCJK-Regular", "DejaVu Sans", "Liberation Sans", "Arial")
    }
    elseif ($IsMacOS) {
        $preferredFonts = @("Hiragino Kaku Gothic ProN", "Hiragino Sans", "Yu Gothic", "Arial Unicode MS", "Arial")
    }
    else {
        $preferredFonts = @("Arial", "DejaVu Sans", "Liberation Sans")
    }
    
    foreach ($fontName in $preferredFonts) {
        if ($FontSettings::IsFontAllowed($fontName)) {
            return $fontName
        }
    }
    
    return "Arial"  # 최후의 기본 폰트
}

# 함수: 일본어 문자 포함 여부 확인
function Test-ContainsJapanese {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Text
    )
    
    if ([string]::IsNullOrEmpty($Text)) {
        return $false
    }
    
    foreach ($char in $Text.ToCharArray()) {
        $code = [int][char]$char
        # 히라가나 (U+3040-U+309F), 가타카나 (U+30A0-U+30FF), CJK 통합 한자 (U+4E00-U+9FAF)
        if (($code -ge 0x3040 -and $code -le 0x309F) -or 
            ($code -ge 0x30A0 -and $code -le 0x30FF) -or 
            ($code -ge 0x4E00 -and $code -le 0x9FAF)) {
            return $true
        }
    }
    
    return $false
}

# 함수: 새 PSD 파일에 일본어 텍스트 추가
function New-PsdWithJapaneseText {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$OutputPath = "japanese_text_output.psd",
        
        [Parameter(Mandatory=$false)]
        [switch]$DebugMode
    )
    
    if ($DebugMode) {
        Test-AsposePsdColors
        Write-Host ""
    }
    
    try {
        Write-Host "📝 새 PSD 파일에 일본어 텍스트 추가 중..." -ForegroundColor Cyan
        
        # 새 PSD 이미지 생성 (800x600 픽셀)
        Write-Host "🖼️  PSD 이미지 생성 중 (800x600)..." -ForegroundColor White
        $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::new(800, 600)
        
        try {
            # 배경 색상 설정 - 올바른 Aspose.PSD.Color 사용
            Write-Host "🎨 배경 색상 설정 중..." -ForegroundColor White
            $psdImage.BackgroundColor = $AsposeColor::White
            Write-Host "✅ 배경 색상 설정 완료" -ForegroundColor Green
            
            # 일본어 텍스트들
            $japaneseTexts = @(
                "こんにちは世界",           # 안녕하세요 세계
                "日本語のテキストです",      # 일본어 텍스트입니다
                "漢字ひらがなカタカナ",      # 한자, 히라가나, 가타카나
                "プログラミング",            # 프로그래밍
                "PowerShellスクリプト"       # PowerShell 스크립트
            )
            
            $yPosition = 100
            $bestFont = Get-BestJapaneseFont
            
            Write-Host "🔤 사용할 폰트: $bestFont" -ForegroundColor Yellow
            
            foreach ($japaneseText in $japaneseTexts) {
                Write-Host "➕ 텍스트 추가: $japaneseText" -ForegroundColor White
                
                # 텍스트 레이어 추가
                $textBounds = [Aspose.PSD.Rectangle]::new(50, $yPosition, 700, 80)
                $textLayer = $psdImage.AddTextLayer($japaneseText, $textBounds)
                
                if ($textLayer -and $textLayer.TextData) {
                    # 텍스트 스타일 설정
                    $textPortion = $textLayer.TextData.Items[0]
                    $style = $textPortion.Style
                    
                    # 일본어 폰트 설정
                    $style.FontName = $bestFont
                    $style.FontSize = 24
                    $style.FillColor = $AsposeColor::Black
                    
                    Write-Host "    🎨 텍스트 설정: 폰트=$bestFont, 크기=24, 색상=Black" -ForegroundColor Gray
                    
                    # 텍스트 데이터 업데이트
                    $textLayer.TextData.UpdateLayerData()
                }
                
                $yPosition += 100
            }
            
            # PSD 파일로 저장
            $psdImage.Save($OutputPath)
            Write-Host "💾 PSD 파일 저장 완료: $OutputPath" -ForegroundColor Green
            
            # PNG로도 내보내기
            $pngPath = $OutputPath -replace '\.psd$', '.png'
            $pngOptions = [Aspose.PSD.ImageOptions.PngOptions]::new()
            $pngOptions.ColorType = $PngColorType::TruecolorWithAlpha
            $psdImage.Save($pngPath, $pngOptions)
            Write-Host "🖼️  PNG 파일 저장 완료: $pngPath" -ForegroundColor Green
            
            return @{
                Success = $true
                PsdPath = $OutputPath
                PngPath = $pngPath
            }
        }
        finally {
            $psdImage.Dispose()
        }
    }
    catch {
        Write-Error "PSD 생성 중 오류 발생: $_"
        return @{ Success = $false; Error = $_.Exception.Message }
    }
}

# 함수: 기존 PSD 파일의 텍스트 레이어를 일본어로 업데이트
function Update-PsdTextWithJapanese {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$InputPath,
        
        [Parameter(Mandatory=$false)]
        [string]$OutputPath,
        
        [Parameter(Mandatory=$false)]
        [string]$NewText = "更新された日本語テキスト"  # 업데이트된 일본어 텍스트
    )
    
    if (-not $OutputPath) {
        $OutputPath = $InputPath -replace '\.psd$', '_updated.psd'
    }
    
    try {
        Write-Host "🔄 기존 PSD 파일 업데이트 중: $InputPath" -ForegroundColor Cyan
        
        if (-not (Test-Path $InputPath)) {
            throw "입력 파일을 찾을 수 없습니다: $InputPath"
        }
        
        $psdImage = $Image::Load($InputPath) -as $PsdImage
        
        try {
            $textLayerCount = 0
            $bestFont = Get-BestJapaneseFont
            
            # 모든 레이어를 순회하며 텍스트 레이어 찾기
            foreach ($layer in $psdImage.Layers) {
                $layerTypeName = $layer.GetType().Name
                if ($layerTypeName -eq "TextLayer") {
                    $textLayer = $layer
                    $textLayerCount++
                    
                    Write-Host "📝 텍스트 레이어 '$($layer.Name)' 업데이트 중..." -ForegroundColor White
                    
                    # 일본어 텍스트로 업데이트
                    try {
                        $textLayer.UpdateText($NewText)
                        
                        # TextData를 직접 조작하여 폰트 설정
                        if ($textLayer.TextData -and $textLayer.TextData.Items.Count -gt 0) {
                            $textPortion = $textLayer.TextData.Items[0]
                            $textPortion.Text = $NewText
                            
                            # 폰트 설정
                            $textPortion.Style.FontName = $bestFont
                            $textPortion.Style.FontSize = 20
                            $textPortion.Style.FillColor = $AsposeColor::Blue
                            
                            # 변경사항 적용
                            $textLayer.TextData.UpdateLayerData()
                        }
                        
                        Write-Host "✅ 텍스트 레이어 '$($layer.Name)' 업데이트 완료" -ForegroundColor Green
                    }
                    catch {
                        Write-Warning "텍스트 레이어 '$($layer.Name)' 업데이트 실패: $($_.Exception.Message)"
                    }
                }
            }
            
            if ($textLayerCount -eq 0) {
                Write-Warning "텍스트 레이어를 찾을 수 없습니다."
            }
            
            # 저장
            $psdImage.Save($OutputPath)
            Write-Host "💾 업데이트된 파일 저장 완료: $OutputPath" -ForegroundColor Green
            
            return @{
                Success = $true
                UpdatedLayers = $textLayerCount
                OutputPath = $OutputPath
            }
        }
        finally {
            $psdImage.Dispose()
        }
    }
    catch {
        Write-Error "텍스트 업데이트 중 오류 발생: $_"
        return @{ Success = $false; Error = $_.Exception.Message }
    }
}

# 함수: 일본어 텍스트가 포함된 PSD 파일 읽기 및 분석
function Read-JapaneseTextFromPsd {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$InputPath
    )
    
    try {
        Write-Host "📖 PSD 파일에서 일본어 텍스트 정보 읽기: $InputPath" -ForegroundColor Cyan
        
        if (-not (Test-Path $InputPath)) {
            throw "입력 파일을 찾을 수 없습니다: $InputPath"
        }
        
        $psdImage = $Image::Load($InputPath) -as $PsdImage
        
        try {
            $textInfo = @()
            $textLayerCount = 0
            
            Write-Host "`n=== 일본어 텍스트 정보 분석 ===" -ForegroundColor Yellow
            
            foreach ($layer in $psdImage.Layers) {
                # 레이어 타입을 문자열로 직접 확인 - $TextLayer 변수 사용 안함
                $layerTypeName = $layer.GetType().Name
                Write-Host "`n🔍 레이어 발견: $($layer.Name) (타입: $layerTypeName)" -ForegroundColor Gray
                
                if ($layerTypeName -eq "TextLayer") {
                    $textLayer = $layer
                    $textLayerCount++
                    
                    Write-Host "`n📄 텍스트 레이어 이름: $($layer.Name)" -ForegroundColor White
                    Write-Host "  📋 레이어 타입: $layerTypeName" -ForegroundColor Gray
                    
                    # 텍스트 내용 출력
                    try {
                        if ($textLayer.TextData -and $textLayer.TextData.Items) {
                            foreach ($portion in $textLayer.TextData.Items) {
                                $isJapanese = Test-ContainsJapanese -Text $portion.Text
                                $japaneseIndicator = if ($isJapanese) { "🈯" } else { "🔤" }
                                
                                Write-Host "  $japaneseIndicator 텍스트: $($portion.Text)" -ForegroundColor Cyan
                                Write-Host "  🔤 폰트: $($portion.Style.FontName)" -ForegroundColor Gray
                                Write-Host "  📏 크기: $($portion.Style.FontSize)" -ForegroundColor Gray
                                Write-Host "  🎨 색상: $($portion.Style.FillColor)" -ForegroundColor Gray
                                Write-Host "  🌏 일본어 포함: $isJapanese" -ForegroundColor $(if ($isJapanese) { "Green" } else { "Yellow" })
                                
                                $textInfo += @{
                                    LayerName = $layer.Name
                                    Text = $portion.Text
                                    Font = $portion.Style.FontName
                                    Size = $portion.Style.FontSize
                                    Color = $portion.Style.FillColor
                                    ContainsJapanese = $isJapanese
                                }
                            }
                        } else {
                            Write-Host "  ⚠️  텍스트 데이터가 없거나 비어있음" -ForegroundColor Yellow
                        }
                    }
                    catch {
                        Write-Host "  ❌ 텍스트 데이터 읽기 실패: $($_.Exception.Message)" -ForegroundColor Red
                    }
                    
                    # 사용된 폰트 정보
                    try {
                        $fonts = $textLayer.GetFonts()
                        if ($fonts -and $fonts.Count -gt 0) {
                            Write-Host "  📚 사용된 폰트들:" -ForegroundColor Magenta
                            foreach ($font in $fonts) {
                                $fontName = if ($font.FontName) { $font.FontName } else { "(알 수 없음)" }
                                Write-Host "    - $fontName (Type: $($font.FontType))" -ForegroundColor DarkGray
                            }
                        } else {
                            Write-Host "  📚 폰트 정보 없음" -ForegroundColor Yellow
                        }
                    }
                    catch {
                        Write-Host "  📚 폰트 정보 읽기 실패: $($_.Exception.Message)" -ForegroundColor Yellow
                    }
                    
                    Write-Host "  " + ("─" * 50) -ForegroundColor DarkGray
                }
            }
            
            if ($textLayerCount -eq 0) {
                Write-Host "`n⚠️  텍스트 레이어를 찾을 수 없습니다." -ForegroundColor Yellow
                Write-Host "  전체 레이어 수: $($psdImage.Layers.Count)" -ForegroundColor Gray
                
                # 모든 레이어 타입 출력 (디버그용)
                Write-Host "  발견된 레이어 타입들:" -ForegroundColor Gray
                foreach ($layer in $psdImage.Layers) {
                    Write-Host "    - $($layer.Name): $($layer.GetType().Name)" -ForegroundColor DarkGray
                }
            }
            
            Write-Host "`n📊 분석 요약:" -ForegroundColor Yellow
            $japaneseTextCount = ($textInfo | Where-Object { $_.ContainsJapanese }).Count
            $totalTextCount = $textInfo.Count
            Write-Host "  총 레이어 수: $($psdImage.Layers.Count)" -ForegroundColor White
            Write-Host "  텍스트 레이어 수: $textLayerCount" -ForegroundColor White
            Write-Host "  총 텍스트 포션 수: $totalTextCount" -ForegroundColor White
            Write-Host "  일본어 포함 텍스트: $japaneseTextCount" -ForegroundColor Green
            
            return @{
                Success = $true
                TextInfo = $textInfo
                JapaneseTextCount = $japaneseTextCount
                TotalTextCount = $totalTextCount
                TextLayerCount = $textLayerCount
            }
        }
        finally {
            $psdImage.Dispose()
        }
    }
    catch {
        Write-Error "PSD 읽기 중 오류 발생: $_"
        return @{ Success = $false; Error = $_.Exception.Message }
    }
}

# 함수: 샘플 PSD 파일 생성
function New-SamplePsdFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$OutputPath = "sample.psd"
    )
    
    try {
        $psdImage = [Aspose.PSD.FileFormats.Psd.PsdImage]::new(400, 300)
        
        try {
            $psdImage.BackgroundColor = $AsposeColor::LightGray
            
            # 텍스트 레이어 생성을 시도하되, 실패하면 빈 PSD만 저장
            try {
                # 직접 TextLayer 생성하여 텍스트 추가
                $textContent = "Sample Text"
                $textBounds = [Aspose.PSD.Rectangle]::new(50, 100, 300, 50)
                
                # AddTextLayer 메서드를 사용하여 텍스트 레이어 추가 시도
                $textLayer = $psdImage.AddTextLayer($textContent, $textBounds)
                
                if ($textLayer) {
                    Write-Host "📄 샘플 PSD 파일 (텍스트 포함) 생성 완료: $OutputPath" -ForegroundColor Green
                } else {
                    Write-Host "📄 샘플 PSD 파일 (텍스트 없음) 생성 완료: $OutputPath" -ForegroundColor Yellow
                }
            }
            catch {
                Write-Host "📄 샘플 PSD 파일 (빈 파일) 생성 완료: $OutputPath" -ForegroundColor Yellow
                Write-Host "    텍스트 레이어 추가 실패했지만 PSD는 생성됨" -ForegroundColor Gray
            }
            
            $psdImage.Save($OutputPath)
            return $true
        }
        finally {
            $psdImage.Dispose()
        }
    }
    catch {
        Write-Error "샘플 PSD 파일 생성 실패: $_"
        return $false
    }
}

# 메인 실행 함수
function Invoke-AsposeJapaneseTextDemo {
    [CmdletBinding()]
    param()
    
    Write-Host "🚀 Aspose.PSD 일본어 텍스트 처리 데모 시작" -ForegroundColor Green
    Write-Host "PowerShell 버전: $($PSVersionTable.PSVersion)" -ForegroundColor Gray
    Write-Host "운영체제: $($PSVersionTable.OS)" -ForegroundColor Gray
    Write-Host ""
    
    # 1. 일본어 폰트 설정
    Write-Host "📋 1단계: 일본어 폰트 설정" -ForegroundColor Magenta
    if (-not (Set-JapaneseFonts)) {
        Write-Error "폰트 설정에 실패했습니다. 스크립트를 종료합니다."
        return
    }
    
    # 사용 가능한 일본어 폰트 표시
    $availableFonts = Get-AvailableJapaneseFonts
    if ($availableFonts.Count -gt 0) {
        Write-Host "✅ 사용 가능한 일본어 폰트: $($availableFonts -join ', ')" -ForegroundColor Green
    } else {
        Write-Warning "사용 가능한 일본어 폰트가 없습니다. 기본 폰트를 사용합니다."
    }
    
    Write-Host ""
    
    # 2. 새 PSD 파일에 일본어 텍스트 추가
    Write-Host "📋 2단계: 새 PSD 파일에 일본어 텍스트 추가" -ForegroundColor Magenta
    $createResult = New-PsdWithJapaneseText -OutputPath "japanese_demo.psd"
    if ($createResult.Success) {
        Write-Host "✅ 2단계 완료" -ForegroundColor Green
    } else {
        Write-Warning "2단계 실패: $($createResult.Error)"
    }
    
    Write-Host ""
    
    # 3. 기존 PSD 파일 업데이트 (샘플 파일 먼저 생성)
    Write-Host "📋 3단계: 기존 PSD 파일 텍스트 업데이트" -ForegroundColor Magenta
    $sampleFile = "sample_for_update.psd"
    if (New-SamplePsdFile -OutputPath $sampleFile) {
        $updateResult = Update-PsdTextWithJapanese -InputPath $sampleFile -NewText "更新テスト完了"
        if ($updateResult.Success) {
            if ($updateResult.UpdatedLayers -gt 0) {
                Write-Host "✅ 3단계 완료: $($updateResult.UpdatedLayers)개 레이어 업데이트" -ForegroundColor Green
            } else {
                Write-Host "⚠️  3단계 완료: 텍스트 레이어가 없어서 업데이트할 항목 없음" -ForegroundColor Yellow
            }
        } else {
            Write-Warning "3단계 실패: $($updateResult.Error)"
        }
    } else {
        Write-Warning "3단계 건너뜀: 샘플 파일 생성 실패"
    }
    
    Write-Host ""
    
    # 4. 일본어 텍스트 읽기 및 분석
    Write-Host "📋 4단계: 일본어 텍스트 읽기 및 분석" -ForegroundColor Magenta
    if (Test-Path "japanese_demo.psd") {
        $readResult = Read-JapaneseTextFromPsd -InputPath "japanese_demo.psd"
        if ($readResult.Success) {
            if ($readResult.TextLayerCount -gt 0) {
                Write-Host "✅ 4단계 완료: $($readResult.TextLayerCount)개 텍스트 레이어 분석" -ForegroundColor Green
            } else {
                Write-Host "⚠️  4단계 완료: 텍스트 레이어 없음" -ForegroundColor Yellow
            }
        } else {
            Write-Warning "4단계 실패: $($readResult.Error)"
        }
    } else {
        Write-Warning "japanese_demo.psd 파일을 찾을 수 없어 4단계를 건너뜁니다."
    }
    
    Write-Host ""
    Write-Host "🎉 Aspose.PSD 일본어 텍스트 처리 데모 완료!" -ForegroundColor Green
    Write-Host "생성된 파일들을 확인해보세요:" -ForegroundColor Yellow
    Get-ChildItem "*.psd", "*.png" | ForEach-Object {
        Write-Host "  📁 $($_.Name) ($([math]::Round($_.Length/1KB, 2)) KB)" -ForegroundColor Cyan
    }
}

# 스크립트가 직접 실행될 때 사용 가능한 함수들:
# - ConvertTo-AsposeColor (색상 변환)
# - Test-AsposePsdColors (색상 테스트)
# - Set-JapaneseFonts
# - Get-AvailableJapaneseFonts
# - Get-BestJapaneseFont
# - Test-ContainsJapanese
# - New-PsdWithJapaneseText
# - Update-PsdTextWithJapanese
# - Read-JapaneseTextFromPsd
# - New-SamplePsdFile
# - Invoke-AsposeJapaneseTextDemo

# 스크립트가 직접 실행되는 경우에만 데모 실행 (점 표기법으로 로드할 때는 실행하지 않음)
if ($MyInvocation.InvocationName -ne "." -and $MyInvocation.Line -notlike "*. *") {
    Write-Host "💡 사용법:" -ForegroundColor Yellow
    Write-Host "  전체 데모 실행: Invoke-AsposeJapaneseTextDemo" -ForegroundColor White
    Write-Host "  개별 함수 사용: New-PsdWithJapaneseText, Update-PsdTextWithJapanese, Read-JapaneseTextFromPsd" -ForegroundColor White
    Write-Host "  디버그 함수: Test-AsposePsdColors, ConvertTo-AsposeColor" -ForegroundColor White
    Write-Host ""
    
    # 사용자에게 실행 여부 확인
    $response = Read-Host "데모를 실행하시겠습니까? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Invoke-AsposeJapaneseTextDemo
    } else {
        Write-Host "스크립트가 로드되었습니다. 필요한 함수를 직접 호출하세요." -ForegroundColor Green
    }
} else {
    Write-Host "✅ 스크립트 함수들이 로드되었습니다." -ForegroundColor Green
    Write-Host "사용 가능한 함수들:" -ForegroundColor Yellow
    Write-Host "  - Test-AsposePsdColors (색상 테스트)" -ForegroundColor Cyan
    Write-Host "  - ConvertTo-AsposeColor (색상 변환)" -ForegroundColor Cyan
    Write-Host "  - Set-JapaneseFonts" -ForegroundColor Cyan
    Write-Host "  - New-PsdWithJapaneseText" -ForegroundColor Cyan
    Write-Host "  - Update-PsdTextWithJapanese" -ForegroundColor Cyan
    Write-Host "  - Read-JapaneseTextFromPsd" -ForegroundColor Cyan
    Write-Host "  - Invoke-AsposeJapaneseTextDemo" -ForegroundColor Cyan
}
