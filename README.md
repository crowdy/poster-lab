
## Get-LayerInfo.ps1

```
. ./Get-LayerInfo.ps1 .\22a573ba-7f07-432a-b655-3a612e68effa.psd
```

## result of Get-LayerInfo.ps1

```pwsh
PS D:\github\planitaicojp\logical-experiment\local-proj-1> . ./Get-LayerInfo.ps1 .\22a573ba-7f07-432a-b655-3a612e68effa.psd
PowerShell 7 + .NET 8.0 Environment:
  PowerShell Version: 7.5.2
  Edition: Core

Loading .NET 8.0 compatible libraries...
✓ System.Text.Encoding.CodePages.dll loaded
✓ Newtonsoft.Json.dll loaded
✓ System.Drawing.Common.dll loaded
✓ Aspose.Drawing.dll loaded
✓ Aspose.PSD.dll loaded
Loading PSD file: D:\github\planitaicojp\logical-experiment\local-proj-1\22a573ba-7f07-432a-b655-3a612e68effa.psd
PSD Information:
  Size: 3508 x 4967
  Color Mode: Rgb
  Bit Depth: 8
  Total Layers: 74

22a573ba-7f07-432a-b655-3a612e68effa/
text-all
Layer group: machine-name (Group)
│   ├── machine-name_g01 #1
│   ├── machine-name_g02 #1
│   └── machine-name_g03 #1
Layer group: image (Group)
│   ├── scheduled_g00 #1
│   ├── Layer group: copy (Group)
│   │   ├── copyright_g01 #1
│   │   ├── copyright_g02 #1
│   │   ├── copyright_g03 #1
│   │   └── copyright-frame_g01 #1
│   ├── Layer group: machine (Group)
│   │   ├── Layer group: g01 (Group)
│   │   │   ├── machine-icon_g01 #1
│   │   │   ├── machine-icon_g01 #2
│   │   │   ├── machine-frame_g01 #1
│   │   │   ├── smart-icon_g01 #1
│   │   │   └── machine_main_g01 #1
│   │   ├── Layer group: g02 (Group)
│   │   │   ├── machine-icon_g02 #1
│   │   │   ├── machine-icon_g02 #2
│   │   │   └── machine-frame_g02 #1
│   │   ├── Layer group: g03 (Group)
│   │   │   ├── machine-icon_g03 #1
│   │   │   ├── machine-icon_g03 #2
│   │   │   └── machine-frame_g03 #1
│   ├── Layer group: decoration (Group)
│   │   ├── decoration_g00 #1 (Screen)
│   │   ├── decoration_g00 #2 (Screen)
│   │   ├── decoration_g00 #3 (Screen)
│   │   ├── decoration_g00 #4 (Screen)
│   │   ├── decoration_g00 #5 (Screen)
│   │   ├── decoration_g00 #6 (Screen)
│   │   └── decoration_g00 #7 (Screen)
│   ├── Layer group: title (Group)
│   │   └── titlelogo-shindai-irekae_g00 #1
│   ├── Layer group: g01 (Group)
│   │   ├── chara_main_g01 #1
│   │   ├── chara_sub_g01 #1
│   │   ├── chara_sub_g01 #2
│   │   ├── decoration_g01 #1
│   │   └── clipping-mask_g01 #1
│   ├── Layer group: g02g03 (Group)
│   │   ├── chara_main_g02 #1
│   │   ├── chara_main_g03 #1
│   │   ├── chara_sub_g02 #1
│   │   └── chara_sub_g03 #1
│   ├── Layer group: decoration (Group)
│   │   ├── decoration_g00 #8 (Screen)
│   │   ├── decoration_g00 #9 (Screen)
│   │   └── decoration_g00 #10 (Screen)
│   ├── Layer group: bg (Group)
│   │   └── background_g00 #1


Layer Statistics:
  Total: 54
  Ignore: 20
  Groups: 13
  Layers: 41
```

## Get-SmartObject.ps1

```
. ./Get-SmartObject.ps1 .\22a573ba-7f07-432a-b655-3a612e68effa.psd
```

## result of Get-SmartObject.ps1
```pwsh
PS D:\github\planitaicojp\logical-experiment\local-proj-1> . ./Get-SmartObject.ps1 .\22a573ba-7f07-432a-b655-3a612e68effa.psd
No smart objects found in this PSD file.
```

