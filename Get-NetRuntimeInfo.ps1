# 현재 PowerShell 및 .NET 환경 정보 상세 확인
Write-Host "=== PowerShell 및 .NET 환경 정보 ===" -ForegroundColor Yellow

# 1. PowerShell 기본 정보
Write-Host "`n1. PowerShell 정보:" -ForegroundColor Green
Write-Host "   PowerShell 버전: $($PSVersionTable.PSVersion)"
Write-Host "   PowerShell 에디션: $($PSVersionTable.PSEdition)"
Write-Host "   실행 파일 경로: $PSHOME"

# 2. .NET 런타임 정보
Write-Host "`n2. .NET 런타임 정보:" -ForegroundColor Green
try {
    Write-Host "   .NET 버전: $([System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription)"
    Write-Host "   .NET 위치: $([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory())"
} catch {
    Write-Host "   .NET 정보 조회 실패: $($_.Exception.Message)"
}

# 3. System.Drawing 사용 가능성 테스트
Write-Host "`n3. System.Drawing 호환성 테스트:" -ForegroundColor Green
try {
    Add-Type -AssemblyName System.Drawing
    Write-Host "   ✅ System.Drawing 로드: 성공"
    
    # 기본 Bitmap 생성 테스트
    try {
        $testBmp = New-Object System.Drawing.Bitmap(10, 10)
        Write-Host "   ✅ Bitmap 생성: 성공"
        
        # LockBits 테스트 (문제의 원인)
        try {
            $rect = New-Object System.Drawing.Rectangle(0, 0, 10, 10)
            $bmpData = $testBmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
            $testBmp.UnlockBits($bmpData)
            Write-Host "   ✅ LockBits 메서드: 사용 가능" -ForegroundColor Green
        } catch {
            Write-Host "   ❌ LockBits 메서드: 사용 불가 - $($_.Exception.Message)" -ForegroundColor Red
        }
        
        $testBmp.Dispose()
    } catch {
        Write-Host "   ❌ Bitmap 생성: 실패 - $($_.Exception.Message)" -ForegroundColor Red
    }
} catch {
    Write-Host "   ❌ System.Drawing 로드: 실패 - $($_.Exception.Message)" -ForegroundColor Red
}

# 4. 설치된 .NET 버전들 확인
Write-Host "`n4. 설치된 .NET 버전들:" -ForegroundColor Green
try {
    # .NET Framework 버전 확인
    $dotnetFrameworkVersions = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP" -Recurse | 
        Get-ItemProperty -Name Version -ErrorAction SilentlyContinue | 
        Where-Object { $_.Version } | 
        Select-Object @{Name="Framework";Expression={$_.PSPath.Split('\')[-1]}}, Version
    
    if ($dotnetFrameworkVersions) {
        Write-Host "   .NET Framework 버전들:"
        $dotnetFrameworkVersions | ForEach-Object { Write-Host "     - $($_.Framework): $($_.Version)" }
    }
} catch {
    Write-Host "   .NET Framework 버전 조회 실패"
}

try {
    # .NET Core/.NET 5+ 버전 확인
    $dotnetCommand = Get-Command dotnet -ErrorAction SilentlyContinue
    if ($dotnetCommand) {
        Write-Host "   설치된 .NET 런타임들:"
        $runtimes = & dotnet --list-runtimes 2>$null
        if ($runtimes) {
            $runtimes | ForEach-Object { Write-Host "     - $_" }
        }
        
        Write-Host "   설치된 .NET SDK들:"
        $sdks = & dotnet --list-sdks 2>$null
        if ($sdks) {
            $sdks | ForEach-Object { Write-Host "     - $_" }
        }
    } else {
        Write-Host "   dotnet 명령어를 찾을 수 없음"
    }
} catch {
    Write-Host "   .NET Core/.NET 5+ 버전 조회 실패"
}

# 5. OS 정보
Write-Host "`n5. 운영체제 정보:" -ForegroundColor Green
Write-Host "   OS: $($PSVersionTable.OS)"
Write-Host "   플랫폼: $($PSVersionTable.Platform)"

# 6. PowerShell 실행 방법 확인
Write-Host "`n6. 현재 실행 정보:" -ForegroundColor Green
Write-Host "   현재 프로세스: $($PID)"
Write-Host "   실행 명령어: $(if ($PSVersionTable.PSEdition -eq 'Core') { 'pwsh' } else { 'powershell' })"

Write-Host "`n=== 요약 ===" -ForegroundColor Yellow
if ($PSVersionTable.PSEdition -eq 'Core') {
    Write-Host "현재 PowerShell Core(pwsh)를 사용 중입니다." -ForegroundColor Cyan
    Write-Host "이는 .NET Core/.NET 5+ 기반이며, .NET Framework와는 별개입니다." -ForegroundColor Cyan
} else {
    Write-Host "현재 Windows PowerShell을 사용 중입니다." -ForegroundColor Cyan
    Write-Host "이는 .NET Framework 기반입니다." -ForegroundColor Cyan
}