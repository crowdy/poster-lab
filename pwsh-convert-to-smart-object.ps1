Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.Drawing.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\System.Drawing.Common.dll"

$basePngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_018_machine_main_g02_#1.png"
$layerPngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_080_text-all.png"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\save-image-add-layer.psd"

$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\19ce6869-2b31-4bd7-91ef-777a19854e8d.psd"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\22a573ba-7f07-432a-b655-3a612e68effa.psd"


$license = New-Object Aspose.PSD.License
$license.SetLicense("Aspose.PSD.NET_(2).lic.txt");
#$license.IsLicensed -eq $True

$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

$img = [Aspose.PSD.Image]::Load($psdFilePath, $loadOptions)
$psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
$layers = $psd.Layers

$opt = New-Object Aspose.PSD.ImageOptions.PngOptions
$opt.CompressionLevel = 9

$layerRect = New-Object Aspose.PSD.Rectangle(0, 0, $layers[2].Width, $layers[2].Height)
$layers[2].Save("D:\github\planitaicojp\logical-experiment\test_layer_size.png", $opt, $layerRect)


<#

try {
    Write-Host "=== Method 1: Basic SmartObjectLayer Constructor ==="

    # 현재 레이어 정보 백업
    $originalLayer = $layers[2]
    $layerName = $originalLayer.Name
    $layerIndex = 2

    Write-Host "Original layer: '$layerName' - Type: $($originalLayer.GetType().Name)"

    # SmartObjectLayer 생성 시도
    $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer
    $smartLayer.Name = $layerName

    Write-Host "SmartObjectLayer created successfully"
    Write-Host "SmartObjectLayer type: $($smartLayer.GetType().Name)"

    # 레이어 교체 시도
    $psd.Layers[$layerIndex] = $smartLayer
    Write-Host "SUCCESS: Layer replaced with SmartObjectLayer"

} catch {
    Write-Host "Method 1 failed: $($_.Exception)"
}
=== Method 1: Basic SmartObjectLayer Constructor ===
Original layer: 'background_g00 #1' - Type: Layer
Method 1 failed: System.Management.Automation.PSArgumentException: A constructor was not found. Cannot find an appropriate constructor for type Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer.
   at System.Management.Automation.MshCommandRuntime.ThrowTerminatingError(ErrorRecord errorRecord)
PS C:\Users\tkim>

----

try {
    Write-Host "`n=== Method 2: Save Layer then Create SmartObject ==="

    # 임시 파일에 레이어 저장
    $tempImagePath = [System.IO.Path]::GetTempFileName() + ".png"
    Write-Host "Saving layer to temp file: $tempImagePath"

    # 이전에 성공한 방법으로 레이어 저장
    $validLeft = [Math]::Max(0, $layers[2].Left)
    $validTop = [Math]::Max(0, $layers[2].Top)
    $validWidth = $layers[2].Right - $validLeft
    $validHeight = $layers[2].Bottom - $validTop
    $rect = New-Object Aspose.PSD.Rectangle($validLeft, $validTop, $validWidth, $validHeight)

    $layers[2].Save($tempImagePath, $opt, $rect)
    Write-Host "Layer saved to temp file successfully"

    # 임시 파일로부터 SmartObjectLayer 생성 시도
    $fileStream = New-Object System.IO.FileStream($tempImagePath, [System.IO.FileMode]::Open)
    try {
        $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer($fileStream)
        $smartLayer.Name = $layers[2].Name

        Write-Host "SmartObjectLayer created from file stream"

        # 레이어 교체
        $psd.Layers[2] = $smartLayer
        Write-Host "SUCCESS: Layer replaced with SmartObjectLayer from file"

    } finally {
        $fileStream.Close()
        Remove-Item $tempImagePath -Force -ErrorAction SilentlyContinue
    }

} catch {
    Write-Host "Method 2 failed: $($_.Exception)"
}

=== Method 2: Save Layer then Create SmartObject ===
Saving layer to temp file: C:\Users\tkim\AppData\Local\Temp\2\tmphcldnp.tmp.png
Layer saved to temp file successfully
Method 2 failed: System.Management.Automation.MethodInvocationException: Exception calling ".ctor" with "1" argument(s): "Update PageNumber is supported only in licensed mode"
 ---> System.ComponentModel.LicenseException: Update PageNumber is supported only in licensed mode
   at Aspose.PSD.FileFormats.Psd.Layers.LayerResources.PlacedResource(String )
   at Aspose.PSD.FileFormats.Psd.Layers.LayerResources.PlacedResource.set_PageNumber(Int32 value)
   at Aspose.PSD.FileFormats.Psd.Layers.LayerResources.SmartResourceCreator.(PlacedResource , PlacedResource)
   at Aspose.PSD.FileFormats.Psd.Layers.LayerResources.SmartResourceCreator.GeneratePlacedResource()
   at Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer.(Guid , Rectangle)
   at Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer..ctor(Stream stream)
   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)
   at System.Reflection.MethodBaseInvoker.InvokeDirectByRefWithFewArgs(Object obj, Span`1 copyOfArgs, BindingFlags invokeAttr)
   --- End of inner exception stack trace ---
   at System.Management.Automation.DotNetAdapter.AuxiliaryConstructorInvoke(MethodInformation methodInformation, Object[] arguments, Object[] originalArguments)
   at System.Management.Automation.DotNetAdapter.ConstructorInvokeDotNet(Type type, ConstructorInfo[] constructors, Object[] arguments)
   at Microsoft.PowerShell.Commands.NewObjectCommand.CallConstructor(Type type, ConstructorInfo[] constructors, Object[] args)
PS C:\Users\tkim>

라이센스 파일을 받아 설치한 후에는 다음과 같다.

=== Method 2: Save Layer then Create SmartObject ===
Saving layer to temp file: C:\Users\tkim\AppData\Local\Temp\2\tmprhpqx0.tmp.png
Layer saved to temp file successfully
SmartObjectLayer created from file stream
SUCCESS: Layer replaced with SmartObjectLayer from file


----

🧪 방법 3: AddLayer/RemoveLayer 사용


try {
    Write-Host "`n=== Method 3: RemoveLayer + AddLayer ==="
    
    # 원본 레이어 정보 백업
    $originalLayer = $layers[2]
    $layerName = $originalLayer.Name
    $layerBounds = $originalLayer.Bounds
    
    # 임시 파일 생성
    $tempImagePath = [System.IO.Path]::GetTempFileName() + ".png"
    
    # 레이어를 이미지로 저장
    $validLeft = [Math]::Max(0, $originalLayer.Left)
    $validTop = [Math]::Max(0, $originalLayer.Top)
    $validWidth = $originalLayer.Right - $validLeft
    $validHeight = $originalLayer.Bottom - $validTop
    $rect = New-Object Aspose.PSD.Rectangle($validLeft, $validTop, $validWidth, $validHeight)
    
    $originalLayer.Save($tempImagePath, $opt, $rect)
    
    # 원본 레이어 제거
    $psd.RemoveLayer($originalLayer)
    Write-Host "Original layer removed"
    
    # 새 SmartObject 레이어 생성 및 추가
    $image = [Aspose.PSD.Image]::Load($tempImagePath)
    $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer($image)
    $smartLayer.Name = $layerName
    
    # 특정 위치에 삽입하는 대신 추가 (인덱스 조정은 나중에)
    $psd.AddLayer($smartLayer)
    Write-Host "SmartObjectLayer added to PSD"
    
    # 정리
    $image.Dispose()
    Remove-Item $tempImagePath -Force -ErrorAction SilentlyContinue
    
    Write-Host "SUCCESS: Layer replaced using RemoveLayer + AddLayer method"
    
} catch {
    Write-Host "Method 3 failed: $($_.Exception.Message)"
}

----

🧪 방법 4: 스마트 오브젝트 리소스 직접 조작

try {
    Write-Host "`n=== Method 4: Direct SmartObject Resource Manipulation ==="
    
    # SmartObjectLayer의 다른 생성자 시도
    $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer
    
    # 기본 속성 설정
    $smartLayer.Name = $layers[2].Name
    $smartLayer.Left = $layers[2].Left
    $smartLayer.Top = $layers[2].Top
    $smartLayer.Right = $layers[2].Right
    $smartLayer.Bottom = $layers[2].Bottom
    $smartLayer.IsVisible = $layers[2].IsVisible
    $smartLayer.Opacity = $layers[2].Opacity
    
    Write-Host "SmartObjectLayer properties set"
    
    # 레이어 교체
    $psd.Layers[2] = $smartLayer
    Write-Host "SUCCESS: Layer replaced with configured SmartObjectLayer"
    
} catch {
    Write-Host "Method 4 failed: $($_.Exception.Message)"
}



----

try {
    Write-Host "=== Method 1: Using ReplaceContents ==="`
    
    # Smart Object 레이어 가져오기
    $smartLayer = $psd.Layers[2]
    Write-Host "Current SmartObject: $($smartLayer.Name)"
    
    # 교체할 PNG 파일 경로
    $newPngPath = "D:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_080_text-all.png"
    
    if (-not (Test-Path $newPngPath)) {
        Write-Host "ERROR: PNG file not found: $newPngPath"
        return
    }
    
    # 새 이미지 로드
    $newImage = [Aspose.PSD.Image]::Load($newPngPath)
    Write-Host "New image loaded: $($newImage.Width)x$($newImage.Height)"
    
    # SmartObject 내용 교체
    $smartLayer.ReplaceContents($newImage)
    Write-Host "SUCCESS: SmartObject contents replaced!"
    
    # 메모리 정리
    $newImage.Dispose()
    
} catch {
    Write-Host "Method 1 failed: $($_.Exception.Message)"
}

#>

$psd.Save("d:\github\planitaicojp\logical-experiment\local-proj-1\.test-fixed\testtest.psd")


    # 임시 파일에 레이어 저장
    $tempImagePath = [System.IO.Path]::GetTempFileName() + ".png"
    Write-Host "Saving layer to temp file: $tempImagePath"

    # 이전에 성공한 방법으로 레이어 저장
    $validLeft = [Math]::Max(0, $layers[2].Left)
    $validTop = [Math]::Max(0, $layers[2].Top)
    $validWidth = $layers[2].Right - $validLeft
    $validHeight = $layers[2].Bottom - $validTop
    $rect = New-Object Aspose.PSD.Rectangle($validLeft, $validTop, $validWidth, $validHeight)

    $layers[2].Save($tempImagePath, $opt, $rect)
    Write-Host "Layer saved to temp file successfully"

    # 임시 파일로부터 SmartObjectLayer 생성 시도
    $fileStream = New-Object System.IO.FileStream($tempImagePath, [System.IO.FileMode]::Open)


        $smartLayer = New-Object Aspose.PSD.FileFormats.Psd.Layers.SmartObjects.SmartObjectLayer($fileStream)
        $smartLayer.Name = $layers[2].Name

        Write-Host "SmartObjectLayer created from file stream"

        # 레이어 교체
        $psd.Layers[2] = $smartLayer
        Write-Host "SUCCESS: Layer replaced with SmartObjectLayer from file"


        $psd.InsertLayer(2, $smartLayer)
        $psd.RemoveLayer($originalLayer)



$newPngPath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_001_background_g00_#1.png"
    $newImage = [Aspose.PSD.Image]::Load($newPngPath)
    $smartLayer = $psd.Layers[2]
     $smartLayer.ReplaceContents($newImage)
$psd.Save("d:\github\planitaicojp\logical-experiment\local-proj-1\.test-fixed\testtest2.psd")