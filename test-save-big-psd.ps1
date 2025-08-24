Add-Type -Path aspose-packages\Aspose.PSD.dll
Add-Type -Path aspose-packages\Aspose.Drawing.dll
$license = New-Object Aspose.PSD.License
$license.SetLicense("Aspose.PSD.NET_(3).lic") # no error
$PsdPath = "e:\psd_template\horizontal\renewalOpen\machine_1\m1\s1\001708ff-86d1-419b-bc19-2dd530b087c6\001708ff-86d1-419b-bc19-2dd530b087c6.psd"
$loadOptions = New-Object Aspose.PSD.ImageLoadOptions.PsdLoadOptions
$loadOptions.LoadEffectsResource = $true
$loadOptions.UseDiskForLoadEffectsResource = $true
$psd = [Aspose.PSD.Image]::Load($PsdPath)
$psdOptions = New-Object Aspose.PSD.ImageOptions.PsdOptions($psd)
$psd.Save("test_output.psd", $psdOptions)
