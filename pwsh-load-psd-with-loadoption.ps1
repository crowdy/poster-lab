Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.PSD.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\Aspose.Drawing.dll"
Add-Type -Path "d:\github\planitaicojp\logical-experiment\local-proj-1\aspose-packages\System.Drawing.Common.dll"

$basePngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_018_machine_main_g02_#1.png"
$layerPngFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\layer_080_text-all.png"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\.test-method2\save-image-add-layer.psd"

$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\19ce6869-2b31-4bd7-91ef-777a19854e8d.psd"
$psdFilePath = "d:\github\planitaicojp\logical-experiment\local-proj-1\22a573ba-7f07-432a-b655-3a612e68effa.psd"

$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true

$img = [Aspose.PSD.Image]::Load($psdFilePath, $loadOptions)
$psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
$layers = $psd.Layers

$opt = New-Object Aspose.PSD.ImageOptions.PngOptions
$opt.CompressionLevel = 9

# $layers[2].Save("D:\github\planitaicojp\logical-experiment\test.png", $opt) # Exception calling "Save" with "2" argument(s): "Image saving failed."
# try {$layers[2].Save("D:\github\planitaicojp\logical-experiment\test.png", $opt) } catch { $_.Exception } # The processing area left must be positive. (Parameter 'areaToProcess')
$layerRect = New-Object Aspose.PSD.Rectangle(0, 0, $layers[2].Width, $layers[2].Height)
$layers[2].Save("D:\github\planitaicojp\logical-experiment\test_layer_size.png", $opt, $layerRect)

<#
$layers[2]

PS C:\Users\tkim> $layers[2]

Resources                : {background_g00 #1, 1819896164, 1668047468, 1768842872…}
HasAlpha                 : True
Name                     : background_g00 #1
BlendingOptions          : Aspose.PSD.FileFormats.Psd.Layers.LayerEffects.BlendingOptions
DisplayName              : background_g00 #1
FillOpacity              : 100
LayerCreationDateTime    : 2025/02/19 14:20:22
SheetColorHighlight      : NoColor
Top                      : -17
Left                     : -17
Bottom                   : 4985
Right                    : 3526
ChannelsCount            : 4
ChannelInformation       : {-1, 0, 1, 2}
BlendModeSignature       : 943868237
BlendModeKey             : Normal
Opacity                  : 255
Clipping                 : 0
Flags                    : HasUsefulInformation
Filler                   : 0
Length                   : 48884218
ExtraLength              : 328
LayerMaskData            : Aspose.PSD.FileFormats.Psd.Layers.LayerMaskDataFull
LayerBlendingRangesData  :
BitsPerPixel             :
Height                   : 5002
Width                    : 3543
LayerOptions             :
IsVisible                : True
IsVisibleInGroup         : True
LayerLock                : None
BlendClippedElements     : True
IsCached                 : False
PremultiplyComponents    : False
UseRawData               : True
UpdateXmpData            : False
XmpData                  :
RawIndexedColorConverter :
RawCustomColorConverter  :
RawFallbackIndex         : 0
RawDataSettings          : Aspose.PSD.RawDataSettings
RawDataFormat            : RgbIndexed1Bpp, used channels: 1
RawLineSize              : 0
IsRawDataAvailable       : False
HorizontalResolution     : 96
VerticalResolution       : 96
HasTransparentColor      : False
TransparentColor         : Color [Empty]
ImageOpacity             : 1
Bounds                   : {X=0, Y=0, Width=3543, Height=5002}
Container                : Aspose.PSD.FileFormats.Psd.PsdImage
Palette                  :
UsePalette               : False
Size                     : {Width=3543, Height=5002}
InterruptMonitor         :
BufferSizeHint           : 0
AutoAdjustPalette        : False
HasBackgroundColor       : False
FileFormat               : Undefined
BackgroundColor          : Color [White]
DataStreamContainer      :
Disposed                 : False

PS C:\Users\tkim>




----



# 레이어 정보를 안전하게 직렬화하는 함수
function Get-SerializableLayerInfo {
    param(
        $Layer,
        [switch]$IncludePixelData,
        [switch]$DeepScan
    )
    
    $layerInfo = [ordered]@{}
    
    try {
        # === 기본 정보 ===
        $layerInfo.BasicInfo = [ordered]@{
            Name = if ($Layer.Name) { $Layer.Name } else { $null }
            DisplayName = if ($Layer.DisplayName) { $Layer.DisplayName } else { $null }
            IsVisible = $Layer.IsVisible
            IsVisibleInGroup = $Layer.IsVisibleInGroup
            Opacity = $Layer.Opacity
            FillOpacity = if ($Layer.GetType().GetProperty("FillOpacity")) { $Layer.FillOpacity } else { $null }
        }
        
        # === 위치 및 크기 정보 ===
        $layerInfo.Geometry = [ordered]@{
            Top = $Layer.Top
            Left = $Layer.Left
            Bottom = $Layer.Bottom
            Right = $Layer.Right
            Width = $Layer.Width
            Height = $Layer.Height
            Bounds = [ordered]@{
                X = $Layer.Bounds.X
                Y = $Layer.Bounds.Y
                Width = $Layer.Bounds.Width
                Height = $Layer.Bounds.Height
            }
            Size = [ordered]@{
                Width = $Layer.Size.Width
                Height = $Layer.Size.Height
            }
        }
        
        # === 블렌딩 정보 ===
        $layerInfo.Blending = [ordered]@{
            BlendModeKey = if ($Layer.BlendModeKey) { $Layer.BlendModeKey.ToString() } else { $null }
            BlendModeSignature = $Layer.BlendModeSignature
            BlendClippedElements = $Layer.BlendClippedElements
            Clipping = $Layer.Clipping
        }
        
        # === 채널 정보 ===
        $layerInfo.Channels = [ordered]@{
            ChannelsCount = $Layer.ChannelsCount
            ChannelInformation = if ($Layer.ChannelInformation) { @($Layer.ChannelInformation) } else { @() }
            HasAlpha = $Layer.HasAlpha
            BitsPerPixel = $Layer.BitsPerPixel
        }
        
        # === 색상 정보 ===
        $layerInfo.Color = [ordered]@{
            SheetColorHighlight = if ($Layer.SheetColorHighlight) { $Layer.SheetColorHighlight.ToString() } else { $null }
            HasTransparentColor = $Layer.HasTransparentColor
            TransparentColor = if ($Layer.TransparentColor -and -not $Layer.TransparentColor.IsEmpty) {
                [ordered]@{
                    R = $Layer.TransparentColor.R
                    G = $Layer.TransparentColor.G
                    B = $Layer.TransparentColor.B
                    A = $Layer.TransparentColor.A
                    Name = $Layer.TransparentColor.Name
                }
            } else { $null }
            BackgroundColor = if ($Layer.BackgroundColor -and -not $Layer.BackgroundColor.IsEmpty) {
                [ordered]@{
                    R = $Layer.BackgroundColor.R
                    G = $Layer.BackgroundColor.G
                    B = $Layer.BackgroundColor.B
                    A = $Layer.BackgroundColor.A
                    Name = $Layer.BackgroundColor.Name
                }
            } else { $null }
            HasBackgroundColor = $Layer.HasBackgroundColor
        }
        
        # === 해상도 정보 ===
        $layerInfo.Resolution = [ordered]@{
            HorizontalResolution = $Layer.HorizontalResolution
            VerticalResolution = $Layer.VerticalResolution
        }
        
        # === 타임스탬프 정보 ===
        $layerInfo.Timestamp = [ordered]@{
            LayerCreationDateTime = if ($Layer.LayerCreationDateTime) { $Layer.LayerCreationDateTime.ToString("o") } else { $null }
        }
        
        # === 플래그 및 상태 ===
        $layerInfo.Flags = [ordered]@{
            Flags = $Layer.Flags
            LayerLock = if ($Layer.LayerLock) { $Layer.LayerLock.ToString() } else { $null }
            Filler = $Layer.Filler
            Length = $Layer.Length
            ExtraLength = $Layer.ExtraLength
            IsCached = $Layer.IsCached
            PremultiplyComponents = $Layer.PremultiplyComponents
            UseRawData = $Layer.UseRawData
            UpdateXmpData = $Layer.UpdateXmpData
            AutoAdjustPalette = $Layer.AutoAdjustPalette
            UsePalette = $Layer.UsePalette
            ImageOpacity = $Layer.ImageOpacity
            FileFormat = if ($Layer.FileFormat) { $Layer.FileFormat.ToString() } else { $null }
        }
        
        # === Raw Data 정보 ===
        $layerInfo.RawData = [ordered]@{
            IsRawDataAvailable = $Layer.IsRawDataAvailable
            RawFallbackIndex = $Layer.RawFallbackIndex
            RawLineSize = $Layer.RawLineSize
            RawDataFormat = if ($Layer.RawDataFormat) { $Layer.RawDataFormat.ToString() } else { $null }
        }
        
        # === 레이어 마스크 정보 ===
        $layerInfo.Mask = [ordered]@{}
        try {
            if ($Layer.LayerMaskData) {
                $maskData = $Layer.LayerMaskData
                $layerInfo.Mask = [ordered]@{
                    HasMask = $true
                    Type = $maskData.GetType().Name
                }
                
                # 마스크 세부 정보 추출
                if ($maskData.GetType().GetProperty("Left")) { $layerInfo.Mask.Left = $maskData.Left }
                if ($maskData.GetType().GetProperty("Top")) { $layerInfo.Mask.Top = $maskData.Top }
                if ($maskData.GetType().GetProperty("Right")) { $layerInfo.Mask.Right = $maskData.Right }
                if ($maskData.GetType().GetProperty("Bottom")) { $layerInfo.Mask.Bottom = $maskData.Bottom }
                if ($maskData.GetType().GetProperty("DefaultColor")) { $layerInfo.Mask.DefaultColor = $maskData.DefaultColor }
                if ($maskData.GetType().GetProperty("Flags")) { $layerInfo.Mask.Flags = $maskData.Flags }
            } else {
                $layerInfo.Mask.HasMask = $false
            }
        } catch {
            $layerInfo.Mask.HasMask = $false
            $layerInfo.Mask.Error = $_.Exception.Message
        }
        
        # === 블렌딩 옵션 및 효과 ===
        $layerInfo.Effects = [ordered]@{}
        try {
            if ($Layer.BlendingOptions) {
                $blendingOptions = $Layer.BlendingOptions
                $layerInfo.Effects = [ordered]@{
                    HasBlendingOptions = $true
                    EffectCount = if ($blendingOptions.Effects) { $blendingOptions.Effects.Count } else { 0 }
                    Effects = @()
                }
                
                if ($blendingOptions.Effects -and $blendingOptions.Effects.Count -gt 0) {
                    foreach ($effect in $blendingOptions.Effects) {
                        $effectInfo = [ordered]@{
                            Type = $effect.GetType().Name
                            IsVisible = if ($effect.GetType().GetProperty("IsVisible")) { $effect.IsVisible } else { $null }
                            BlendMode = if ($effect.GetType().GetProperty("BlendMode")) { $effect.BlendMode.ToString() } else { $null }
                            Opacity = if ($effect.GetType().GetProperty("Opacity")) { $effect.Opacity } else { $null }
                        }
                        $layerInfo.Effects.Effects += $effectInfo
                    }
                }
            } else {
                $layerInfo.Effects.HasBlendingOptions = $false
            }
        } catch {
            $layerInfo.Effects.HasBlendingOptions = $false
            $layerInfo.Effects.Error = $_.Exception.Message
        }
        
        # === 리소스 정보 ===
        $layerInfo.Resources = [ordered]@{}
        try {
            if ($Layer.Resources) {
                $layerInfo.Resources = [ordered]@{
                    HasResources = $true
                    ResourceCount = $Layer.Resources.Count
                    ResourceTypes = @()
                }
                
                foreach ($resource in $Layer.Resources) {
                    $resourceInfo = [ordered]@{
                        Type = $resource.GetType().Name
                        Signature = if ($resource.GetType().GetProperty("Signature")) { $resource.Signature } else { $null }
                        Key = if ($resource.GetType().GetProperty("Key")) { $resource.Key } else { $null }
                        Length = if ($resource.GetType().GetProperty("Length")) { $resource.Length } else { $null }
                    }
                    $layerInfo.Resources.ResourceTypes += $resourceInfo
                }
            } else {
                $layerInfo.Resources.HasResources = $false
            }
        } catch {
            $layerInfo.Resources.HasResources = $false
            $layerInfo.Resources.Error = $_.Exception.Message
        }
        
        # === 고급 정보 (DeepScan 모드) ===
        if ($DeepScan) {
            $layerInfo.Advanced = [ordered]@{}
            
            # 모든 속성 스캔
            $properties = $Layer.GetType().GetProperties() | Where-Object { $_.CanRead }
            foreach ($prop in $properties) {
                try {
                    $propName = $prop.Name
                    # 이미 처리된 속성들은 스킵
                    if ($propName -in @("Container", "DataStreamContainer", "Disposed", "InterruptMonitor", "Palette", "XmpData", "RawCustomColorConverter", "RawIndexedColorConverter", "RawDataSettings")) {
                        continue
                    }
                    
                    $value = $prop.GetValue($Layer)
                    if ($value -ne $null) {
                        $layerInfo.Advanced.$propName = $value.ToString()
                    }
                } catch {
                    # 속성 읽기 실패시 무시
                }
            }
        }
        
        # === 픽셀 데이터 (옵션) ===
        if ($IncludePixelData) {
            $layerInfo.PixelData = [ordered]@{}
            try {
                $bounds = $Layer.Bounds
                if ($bounds.Width -gt 0 -and $bounds.Height -gt 0 -and $bounds.Width -le 1000 -and $bounds.Height -le 1000) {
                    # 작은 이미지만 픽셀 데이터 포함 (메모리 보호)
                    $pixels = $Layer.LoadArgb32Pixels($bounds)
                    if ($pixels) {
                        $layerInfo.PixelData = [ordered]@{
                            HasPixelData = $true
                            PixelCount = $pixels.Length
                            SamplePixels = @($pixels[0..([Math]::Min(99, $pixels.Length-1))])  # 첫 100개 픽셀만 샘플로
                        }
                    } else {
                        $layerInfo.PixelData.HasPixelData = $false
                    }
                } else {
                    $layerInfo.PixelData = [ordered]@{
                        HasPixelData = $false
                        Reason = "Image too large or invalid dimensions"
                        Dimensions = "$($bounds.Width)x$($bounds.Height)"
                    }
                }
            } catch {
                $layerInfo.PixelData = [ordered]@{
                    HasPixelData = $false
                    Error = $_.Exception.Message
                }
            }
        }
        
        return $layerInfo
        
    } catch {
        return [ordered]@{
            Error = "Failed to serialize layer info: $($_.Exception.Message)"
            LayerType = $Layer.GetType().Name
            LayerName = if ($Layer.Name) { $Layer.Name } else { "Unknown" }
        }
    }
}

# 사용 예제 함수
function Export-AllLayersInfo {
    param(
        [string]$PsdPath,
        [string]$OutputJsonPath,
        [switch]$IncludePixelData,
        [switch]$DeepScan
    )
    
    try {
        $loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
        $loadOptions.LoadEffectsResource = $true
        $loadOptions.UseDiskForLoadEffectsResource = $true
        
        $img = [Aspose.PSD.Image]::Load($PsdPath, $loadOptions)
        $psd = [Aspose.PSD.FileFormats.Psd.PsdImage]$img
        
        $result = [ordered]@{
            PsdInfo = [ordered]@{
                FilePath = $PsdPath
                Width = $psd.Width
                Height = $psd.Height
                LayerCount = $psd.Layers.Length
                ExportTime = (Get-Date).ToString("o")
            }
            Layers = @()
        }
        
        Write-Host "Serializing $($psd.Layers.Length) layers..."
        
        for ($i = 0; $i -lt $psd.Layers.Length; $i++) {
            Write-Host "Processing layer $($i+1)/$($psd.Layers.Length): $($psd.Layers[$i].Name)"
            
            $layerInfo = Get-SerializableLayerInfo -Layer $psd.Layers[$i] -IncludePixelData:$IncludePixelData -DeepScan:$DeepScan
            $layerInfo.LayerIndex = $i
            
            $result.Layers += $layerInfo
        }
        
        # JSON으로 저장
        $jsonContent = $result | ConvertTo-Json -Depth 10
        $jsonContent | Set-Content -Path $OutputJsonPath -Encoding UTF8
        
        Write-Host "Layer information exported to: $OutputJsonPath"
        Write-Host "File size: $([Math]::Round((Get-Item $OutputJsonPath).Length / 1MB, 2)) MB"
        
        $psd.Dispose()
        
    } catch {
        Write-Error "Failed to export layer information: $_"
    }
}

# 실제 사용법:
# Export-AllLayersInfo -PsdPath "your-file.psd" -OutputJsonPath "layers-info.json" -DeepScan
# Export-AllLayersInfo -PsdPath "your-file.psd" -OutputJsonPath "layers-info-with-pixels.json" -IncludePixelData -DeepScan

#>

