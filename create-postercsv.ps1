# create-poster-csv.ps1
#
# 기능:
# 1. d:\poster-json\*.json 파일과 d:\poster\*.psd 파일을 분석합니다.
# 2. 분석된 정보를 취합하여 d:\poster.csv 파일을 생성합니다.
# 3. JSON의 'model_information' 배열 개수가 1인 경우에만, 해당 배열 첫 아이템의 'machineId'를 폴더명으로 사용하여 캐릭터 PNG를 추출합니다.
# 4. -Limit 파라미터로 처리할 파일 수를 제한할 수 있습니다.
# 5. 전체 진행률과 예상 종료 시간(ETA)을 표시합니다.
# 6. 이미지 파일이 생성될 때마다 전체 경로를 출력하고, PSD 분석 시 머신 개수를 표시합니다.

param(
    [string]$JsonDir = "d:\poster-json\",
    [string]$PsdDir = "d:\poster\",
    [string]$ImageOutputDir = "d:\poster\machine\",
    [string]$OutputPath = "d:\poster.csv",
    [int]$Limit = 0 # 처리할 파일 수를 제한합니다. 0이면 모든 파일을 처리합니다.
)

# Aspose.PSD 라이브러리 로드 스크립트 실행 (동일 경로에 있어야 함)
. ".\Load-AsposePSD.ps1"

# --- 이미지 저장을 위한 헬퍼 함수 ---
function Save-LayerByPixelData {
    param(
        $Layer,
        [string]$OutFile,
        $Options
    )
    
    try {
        $bounds = $Layer.Bounds
        if ($bounds.Width -le 0 -or $bounds.Height -le 0) {
            Write-Warning "    레이어 크기가 유효하지 않아 이미지를 저장할 수 없습니다 (Width: $($bounds.Width), Height: $($bounds.Height))."
            return $false
        }
        
        $pixels = $Layer.LoadArgb32Pixels($bounds)
        if (-not $pixels -or $pixels.Length -eq 0) {
            Write-Warning "    레이어에서 픽셀 데이터를 로드할 수 없습니다."
            return $false
        }
        
        $tempImage = New-Object Aspose.PSD.FileFormats.Psd.PsdImage($bounds.Width, $bounds.Height)
        
        try {
            $tempImage.SaveArgb32Pixels($tempImage.Bounds, $pixels)
            $tempImage.Save($OutFile, $Options)
        }
        finally {
            if ($tempImage) { $tempImage.Dispose() }
        }
        
        return $true
    } catch {
        Write-Warning "    픽셀 데이터 방식으로 이미지 저장 중 오류 발생: $($_.Exception.Message)"
        return $false
    }
}


# --- 1. 초기 설정 및 경로 확인 ---
if (-not (Test-Path $JsonDir)) { Write-Error "JSON 디렉토리를 찾을 수 없습니다: $JsonDir"; exit 1 }
if (-not (Test-Path $PsdDir)) { Write-Error "PSD 디렉토리를 찾을 수 없습니다: $PsdDir"; exit 1 }

$jsonFiles = Get-ChildItem -Path $JsonDir -Filter "*.json"
if ($jsonFiles.Count -eq 0) { Write-Warning "처리할 JSON 파일이 없습니다: $JsonDir"; exit }

# -Limit 파라미터 적용
if ($Limit -gt 0) {
    Write-Host "Limit이 적용되었습니다. 처음 $Limit 개의 파일만 처리합니다." -ForegroundColor Yellow
    $jsonFiles = $jsonFiles | Select-Object -First $Limit
}

$totalFiles = $jsonFiles.Count
Write-Host "총 $totalFiles 개의 파일을 처리합니다." -ForegroundColor Cyan

# --- 2. 메인 루프: 각 JSON/PSD 파일 처리 ---
$finalResults = @()
$processedCount = 0
$startTime = Get-Date

foreach ($jsonFile in $jsonFiles) {
    $processedCount++
    
    # --- 진행률 및 ETA 계산 ---
    $progressString = "[$processedCount/$totalFiles]"
    $elapsed = (Get-Date) - $startTime
    if ($processedCount -gt 1) {
        $avgSecondsPerFile = $elapsed.TotalSeconds / $processedCount
        $remainingFiles = $totalFiles - $processedCount
        $remainingSeconds = [int]($avgSecondsPerFile * $remainingFiles)
        $eta = [TimeSpan]::FromSeconds($remainingSeconds)
        $percentComplete = [int](($processedCount / $totalFiles) * 100)
        
        $progressString += " - $percentComplete% - ETA: $($eta.ToString('hh\:mm\:ss'))"
    }
    
    $uuid = $jsonFile.BaseName
    Write-Host "`n--- $progressString 처리 시작: $uuid ---" -ForegroundColor White
    
    # --- JSON 정보 추출 ---
    $machineCount = 0; $orientation = "unknown"; $logo_type = "unknown"; $jsonContent = $null
    try {
        $jsonContent = Get-Content -Path $jsonFile.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
        $machineCount = if ($jsonContent.model_information) { $jsonContent.model_information.Count } else { 0 }
        $orientation = if ($jsonContent.orientation) { $jsonContent.orientation } else { "unknown" }
        $logo_type = if ($jsonContent.poster_type) { $jsonContent.poster_type } else { "unknown" }
    }
    catch { Write-Warning "JSON 파일 읽기 또는 파싱 오류 ($($jsonFile.Name)): $_" }
    
    # --- PSD 정보 추출을 위한 변수 초기화 ---
    $psdData = [ordered]@{
        main_character_count = 0; sub_character_count = 0
        "1_main_chara_face_xywh" = ""; "2_main_chara_face_xywh" = ""; "3_main_chara_face_xywh" = ""; "4_main_chara_face_xywh" = ""; "5_main_chara_face_xywh" = ""; "6_main_chara_face_xywh" = ""
        "1_sub_face_xywh" = ""; "2_sub_face_xywh" = ""; "3_sub_face_xywh" = ""; "4_sub_face_xywh" = ""; "5_sub_face_xywh" = ""; "6_sub_face_xywh" = ""
    }
    1..6 | ForEach-Object {
        $psdData["${_}_machine_xywh"] = ""; $psdData["${_}_machine_icon1_xywh"] = ""; $psdData["${_}_machine_icon2_xywh"] = ""; $psdData["${_}_machine_name_xywh"] = ""; $psdData["${_}_machine_copyright_xywh"] = ""
    }
    $psdData["text-catch-1_xywh"] = ""; $psdData["scheduled_xywh"] = ""


    # --- PSD 파일 분석 및 PNG 추출 ---
    $psdPath = Join-Path $PsdDir "$uuid.psd"
    if (Test-Path $psdPath) {
        $psd = $null
        try {
            Write-Host "  PSD 분석 중... (Machine Count: $machineCount)" -ForegroundColor Gray
            $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions; $loadOptions.LoadEffectsResource = $true
            $psd = [Aspose.PSD.Image]::Load($psdPath, $loadOptions)

            $shouldSavePng = $false
            $machineIdForPath = $null
            if ($machineCount -eq 1 -and $jsonContent) {
                $machineInfo = $jsonContent.model_information[0]
                if ($machineInfo -and $machineInfo.machineId) {
                    $machineIdForPath = $machineInfo.machineId
                    $shouldSavePng = $true
                    $shouldSavePng = $false
                } else {
                    Write-Warning "MachineCount가 1이지만 JSON 'model_information' 배열의 첫 아이템에서 'machineId'를 찾을 수 없어 PNG 추출을 건너<binary data, 2 bytes, 18 bytes>니다."
                }
            }

            $mainCharaCounter = 0; $subCharaCounter = 0

            for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
                $layer = $psd.Layers[$i]; $layerName = $layer.Name
                if (-not $layerName) { continue }

                if ($shouldSavePng -and $layerName -match "^chara_(main|sub)_g(\d{2})") {
                    $charaType = $matches[1]
                    if ($charaType -eq "main") { $mainCharaCounter++ } else { $subCharaCounter++ }
                    $counter = if ($charaType -eq "main") { $mainCharaCounter } else { $subCharaCounter }

                    if ($counter -le 6 -and ($i + 1) -lt $psd.Layers.Length -and $psd.Layers[$i + 1].Name -eq "face") {
                        $faceLayer = $psd.Layers[$i + 1]
                        
                        $abs_xywh = "$($faceLayer.Left), $($faceLayer.Top), $($faceLayer.Width), $($faceLayer.Height)"
                        if ($charaType -eq "main") { $psdData["${counter}_main_chara_face_xywh"] = $abs_xywh }
                        else { $psdData["${counter}_sub_face_xywh"] = $abs_xywh }
                        
                        $rel_x = $faceLayer.Left - $layer.Left; $rel_y = $faceLayer.Top - $layer.Top
                        
                        $pngOutputDir = Join-Path $ImageOutputDir "$machineIdForPath\characters\"
                        if (-not (Test-Path $pngOutputDir)) { New-Item -Path $pngOutputDir -ItemType Directory -Force | Out-Null }
                        $pngFileName = "${uuid}-${rel_x}-${rel_y}-$($faceLayer.Width)-$($faceLayer.Height).png"
                        $pngFullPath = Join-Path $pngOutputDir $pngFileName
                        
                        # ===> 수정된 부분: 올바른 네임스페이스로 PngColorType 지정
                        $pngOptions = New-Object Aspose.PSD.ImageOptions.PngOptions
                        $pngOptions.ColorType = [Aspose.PSD.FileFormats.Png.PngColorType]::TruecolorWithAlpha
                        
                        $saveSuccess = Save-LayerByPixelData -Layer $layer -OutFile $pngFullPath -Options $pngOptions
                        
                        if ($saveSuccess) {
                            Write-Host "  -> 이미지 추출: $pngFullPath" -ForegroundColor DarkGray
                        } else {
                            Write-Warning "  -> 이미지 추출 실패: $pngFullPath"
                        }
                    }
                } 
                elseif ($layerName -match "^chara_main_") {
                    $mainCharaCounter++
                }
                elseif ($layerName -match "^chara_sub_") {
                    $subCharaCounter++
                }

                if ($layerName -match "^machine_main_g(\d{2})") { $num = [int]$matches[1]; if ($num -le 6) { $psdData["${num}_machine_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" } }
                if ($layerName -match "^machine-icon_g(\d{2}) #1") { $num = [int]$matches[1]; if ($num -le 6) { $psdData["${num}_machine_icon1_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" } }
                if ($layerName -match "^machine-icon_g(\d{2}) #2") { $num = [int]$matches[1]; if ($num -le 6) { $psdData["${num}_machine_icon2_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" } }
                if ($layerName -match "^machine-name_g(\d{2}) #1") { $num = [int]$matches[1]; if ($num -le 6) { $psdData["${num}_machine_name_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" } }
                if ($layerName -match "^copyright_g(\d{2}) #1") { $num = [int]$matches[1]; if ($num -le 6) { $psdData["${num}_machine_copyright_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" } }

                if ($layerName -eq "text-catch-1") { $psdData["text-catch-1_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" }
                if ($layerName -match "^scheduled_") { $psdData["scheduled_xywh"] = "$($layer.Left), $($layer.Top), $($layer.Width), $($layer.Height)" }
            }
            $psdData.main_character_count = $mainCharaCounter
            $psdData.sub_character_count = $subCharaCounter
        }
        catch { Write-Warning "PSD 파일 처리 중 오류 발생 ($psdPath): $_" }
        finally { if ($psd) { $psd.Dispose() } }
    }
    else { Write-Warning "PSD 파일을 찾을 수 없습니다: $psdPath" }

    # --- 최종 데이터 객체 생성 ---
    $resultObject = [PSCustomObject]@{
        FileName = $jsonFile.Name; MachineCount = $machineCount; Orientation = $orientation
        main_character_count = $psdData.main_character_count; sub_character_count = $psdData.sub_character_count
        logo_type = $logo_type
    }
    $psdData.GetEnumerator() | ForEach-Object {
        if ($_.Name -notin "main_character_count", "sub_character_count") {
            $resultObject | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
        }
    }
    $finalResults += $resultObject
}

# --- 3. CSV 파일로 저장 ---
if ($finalResults) {
    try {
        $columnOrder = "FileName","MachineCount","Orientation","main_character_count","sub_character_count","logo_type","1_main_chara_face_xywh","2_main_chara_face_xywh","3_main_chara_face_xywh","4_main_chara_face_xywh","5_main_chara_face_xywh","6_main_chara_face_xywh","1_sub_face_xywh","2_sub_face_xywh","3_sub_face_xywh","4_sub_face_xywh","5_sub_face_xywh","6_sub_face_xywh","1_machine_xywh","1_machine_icon1_xywh","1_machine_icon2_xywh","1_machine_name_xywh","1_machine_copyright_xywh","2_machine_xywh","2_machine_icon1_xywh","2_machine_icon2_xywh","2_machine_name_xywh","2_machine_copyright_xywh","3_machine_xywh","3_machine_icon1_xywh","3_machine_icon2_xywh","3_machine_name_xywh","3_machine_copyright_xywh","4_machine_xywh","4_machine_icon1_xywh","4_machine_icon2_xywh","4_machine_name_xywh","4_machine_copyright_xywh","5_machine_xywh","5_machine_icon1_xywh","5_machine_icon2_xywh","5_machine_name_xywh","5_machine_copyright_xywh","6_machine_xywh","6_machine_icon1_xywh","6_machine_icon2_xywh","6_machine_name_xywh","6_machine_copyright_xywh","text-catch-1_xywh","scheduled_xywh"
        $finalResults | Select-Object $columnOrder | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
        
        $totalTime = (Get-Date) - $startTime
        Write-Host "`n==================================================" -ForegroundColor Green
        Write-Host "작업 완료!"
        Write-Host "  - 총 처리 시간: $($totalTime.ToString('hh\:mm\:ss'))"
        Write-Host "  - CSV 출력: $OutputPath"
        Write-Host "  - 이미지 출력 경로: $ImageOutputDir"
        Write-Host "==================================================" -ForegroundColor Green
    }
    catch { Write-Error "CSV 파일 저장 중 오류가 발생했습니다: $_" }
} else { Write-Warning "처리된 데이터가 없어 CSV 파일을 생성하지 않았습니다." }