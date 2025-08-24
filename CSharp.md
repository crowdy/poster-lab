--- START OF FILE CSharp/App.config ---
﻿<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <startup> 
        <supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.6.1" />
    </startup>
</configuration>
--- END OF FILE CSharp/App.config ---

--- START OF FILE CSharp/Aspose.PSD.Examples.NetStandard.csproj ---
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net6.0</TargetFramework>
        <ImplicitUsings>enable</ImplicitUsings>
        <Nullable>enable</Nullable>
    </PropertyGroup>
    
    <PropertyGroup>
    <!-- Disabled because of mannualy created at '/CSharp/Properties/AssemblyInfo.cs' -->
      <GenerateAssemblyInfo>false</GenerateAssemblyInfo>
    </PropertyGroup>

    <ItemGroup>
      <PackageReference Include="Aspose.PSD">
        <Version>25.8.0</Version>
      </PackageReference>

    </ItemGroup>
</Project>
--- END OF FILE CSharp/Aspose.PSD.Examples.NetStandard.csproj ---

--- START OF FILE CSharp/Aspose.PSD.Examples.csproj ---
﻿<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="14.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')" />
  <PropertyGroup>
    <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
    <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
    <ProjectGuid>{7F50D54C-3DC5-46F1-B38E-E74A36D5BB32}</ProjectGuid>
    <OutputType>Exe</OutputType>
    <AppDesignerFolder>Properties</AppDesignerFolder>
    <RootNamespace>Aspose.PSD.Examples</RootNamespace>
    <AssemblyName>Aspose.PSD.Examples</AssemblyName>
    <TargetFrameworkVersion>v4.7.2</TargetFrameworkVersion>
    <FileAlignment>512</FileAlignment>
    <AutoGenerateBindingRedirects>true</AutoGenerateBindingRedirects>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
    <PlatformTarget>AnyCPU</PlatformTarget>
    <DebugSymbols>true</DebugSymbols>
    <DebugType>full</DebugType>
    <Optimize>false</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
    <PlatformTarget>AnyCPU</PlatformTarget>
    <DebugType>pdbonly</DebugType>
    <Optimize>true</Optimize>
    <OutputPath>bin\Release\</OutputPath>
    <DefineConstants>TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="System" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="Aspose\Ai\SupportAiImagePageCountProperty.cs" />
    <Compile Include="Aspose\Ai\SupportOfActivePageIndex.cs" />
    <Compile Include="Aspose\Ai\SupportOfLayersInAi.cs" />
    <Compile Include="Aspose\Animation\SupportExportToGifImage.cs" />
    <Compile Include="Aspose\Animation\SupportOfAnimatedDataSection.cs" />
    <Compile Include="Aspose\Animation\SupportOfLayerStateEffects.cs" />
    <Compile Include="Aspose\Animation\SupportOfMlstResource.cs" />
    <Compile Include="Aspose\Animation\SupportOfPsdImageTimelineProperty.cs" />
    <Compile Include="Aspose\Animation\SupportOfTimeLine.cs" />
    <Compile Include="Aspose\Conversion\ConversionPSDToGrayscaleRgbCmyk.cs" />
    <Compile Include="Aspose\Conversion\RenderTextWithDifferentColorsInTextLayer.cs" />
    <Compile Include="Aspose\Conversion\ColorConversionUsingDefaultProfiles.cs" />
    <Compile Include="Aspose\Conversion\ColorConversionUsingICCProfiles.cs" />
    <Compile Include="Aspose\Conversion\CropPSDFile.cs" />
    <Compile Include="Aspose\Conversion\LoadingFromStream.cs" />
    <Compile Include="Aspose\Conversion\SaveImageWorker.cs" />
    <Compile Include="Aspose\Conversion\SavingtoStream.cs" />
    <Compile Include="Aspose\Conversion\SettingforReplacingMissingFonts.cs" />
    <Compile Include="Aspose\Conversion\SupportForInterruptMonitor.cs" />
    <Compile Include="Aspose\Conversion\SyncRoot.cs" />
    <Compile Include="Aspose\Conversion\ExportImagesinMultiThreadEnv.cs" />
    <Compile Include="Aspose\Conversion\ApplyMotionWienerFilters.cs" />
    <Compile Include="Aspose\Conversion\ApplyGausWienerFiltersForColorImage.cs" />
    <Compile Include="Aspose\Conversion\ApplyGausWienerFilters.cs" />
    <Compile Include="Aspose\Conversion\ApplyMedianAndWienerFilters.cs" />
    <Compile Include="Aspose\Conversion\BinarizationWithOtsuThreshold.cs" />
    <Compile Include="Aspose\Conversion\BinarizationWithFixedThreshold.cs" />
    <Compile Include="Aspose\Conversion\CMYKPSDtoCMYKTiff.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\AddEffectAtRunTime.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ColorBalanceAdjustment.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ColorOverLayEffect.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\FontReplacement.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ForceFontCache.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ImplementBicubicResampler.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ImplementLossyGIFCompressor.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\InvertAdjustmentLayer.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\PixelDataManipulation.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\RawColorClass.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\RemoveFontCacheFile.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\RenderingColorEffect.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\RenderingDropShadow.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportBlendModes.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportOfMeSaSignature.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportOfObArAndUnFlSignatures.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportOfOuterGlowEffect.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportShadowEffect.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportShadowEffectOpacity.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\VerifyImageTransparency.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\BluranImage.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\AdjustingGamma.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\AdjustingContrast.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\AdjustingBrightness.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ResizeImageProportionally.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\DitheringforRasterImages.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\RotatinganImageonaSpecificAngle.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\RotatinganImage.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\CroppingbyRectangle.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\CreatingUsingStream.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\CreatingbySettingPath.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\CreateXMPMetadata.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\ExpandandCropImages.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\CombiningImages.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportOfAreEffectsEnabledProperty.cs" />
    <Compile Include="Aspose\DrawingAndFormattingImages\SupportOfExportLayerWithEffects.cs" />
    <Compile Include="Aspose\Conversion\GIFImageLayersToTIFF.cs" />
    <Compile Include="Aspose\Conversion\Grayscaling.cs" />
    <Compile Include="Aspose\FillLayers\RotatePatternSupport.cs" />
    <Compile Include="Aspose\FillLayers\AddingFillLayerAtRuntime.cs" />
    <Compile Include="Aspose\GlobalResources\SupportOfBackgroundColorResource.cs" />
    <Compile Include="Aspose\GlobalResources\SupportOfBorderInformationResource.cs" />
    <Compile Include="Aspose\GlobalResources\SupportOfWorkingPathResource.cs" />
    <Compile Include="Aspose\LayerEffects\AddStrokeEffect.cs" />
    <Compile Include="Aspose\LayerEffects\RenderingOfGradientOverlayEffect.cs" />
    <Compile Include="Aspose\LayerEffects\SupportOfGradientOverlayEffect.cs" />
    <Compile Include="Aspose\LayerEffects\SupportOfGradientPropery.cs" />
    <Compile Include="Aspose\LayerResources\Structures\SupportOfNameStructure.cs" />
    <Compile Include="Aspose\LayerResources\SupportForImfxResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfArtBResourceArtDResourceLyvrResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfFXidResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfGrdmResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfLMskResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfLnk2AndLnk3Resource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfBritResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfLclrResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfLnkEResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfNvrtResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfPlacedResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfPlLdResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfSoLdResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfVectorShapeTransformOfVogkResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfVibAResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfVogkResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfVogkResourceProperties.cs" />
    <Compile Include="Aspose\LayerResources\SupportOfVstkResource.cs" />
    <Compile Include="Aspose\LayerResources\VsmsResourceLengthRecordSupport.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToPDF.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToPDFA1a.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\SupportOfAiFormatVersion8.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\SupportOfAiImageXmpDataProperty.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\SupportOfHasMultiLayerMasksAndColorIndexProperties.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\SupportOfRasterImagesInAI.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSB\PSBToJPG.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSB\PSBToPDF.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSB\PSBToPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddBlackAndWhiteAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddGradientMapAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddTextLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddVibranceAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ColorFillLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ConvertPsdToPdf.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ConvertPsdToPng.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ConvertPsdToJpg.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\CreateLayerGroups.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PSDToPDFWithAdjustmentLayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PSDToPDFWithClippingMask.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ExtractLayerName.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\GetTextPropertiesFromTextLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\GradientFillLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\GradientFillLayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\LoadPSDWithReadOnlyMode.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PSDToPDFWithSelectableText.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PSDToPSB.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PSDToPDF.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingOfDifferentStylesInOneTextLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingOfPosterizeAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingOfRotatedTextLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ResizePSDFile.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\Saving16BitGrayscalePsdTo8BitRgb.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\Saving16BitGrayscalePsdTo8BitGrayscale.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\Saving16BitGrayscalePsdImage.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SetTextLayerPosition.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\StrokeEffectWithColorFill.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfBlendClippedElementsProperty.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfCMYKColorMode16bit.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfEditFontNameInTextPortionStyle.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfEffectTypeProperty.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfGdFlResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfInnerShadowLayerEffect.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfITextStyleProperties.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfLeadingTypeInTextPortion.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfLinkedLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfPosterizeAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfPostResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfPsdOptionsBackgroundContentsProperty.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfScaleProperty.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfSelectiveColorAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfSoCoResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfThresholdAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfUpdatingLinkedSmartObjects.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfVmskResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfLayerVectorMask.cs" />
    <Compile Include="Aspose\Conversion\Bradleythreshold.cs" />
    <Compile Include="Aspose\Conversion\CroppingPSDWhenConvertingToPNG.cs" />
    <Compile Include="Aspose\Conversion\PSDToRasterImageFormats.cs" />
    <Compile Include="Aspose\DrawingImages\AddNewRegularLayerToPSD.cs" />
    <Compile Include="Aspose\DrawingImages\AddPatternEffects.cs" />
    <Compile Include="Aspose\DrawingImages\AddGradientEffects.cs" />
    <Compile Include="Aspose\DrawingImages\AddStrokeLayer_Color.cs" />
    <Compile Include="Aspose\DrawingImages\AddStrokeLayer_Gradient.cs" />
    <Compile Include="Aspose\DrawingImages\AddStrokeLayer_Pattern.cs" />
    <Compile Include="Aspose\DrawingImages\AddSignatureToImage.cs" />
    <Compile Include="Aspose\DrawingImages\CoreDrawingFeatures.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingArc.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingBezier.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingEllipse.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingLines.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingRectangle.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingUsingGraphics.cs" />
    <Compile Include="Aspose\DrawingImages\DrawingUsingGraphicsPath.cs" />
    <Compile Include="Aspose\Licensing\MeteredLicensing.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToGIF.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToJPG.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToPNG.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\AI\AIToTIFF.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\AddThumbnailToEXIFSegment.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\AddThumbnailToJFIFSegment.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ColorTypeAndCompressionType.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ExtractThumbnailFromJFIF.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ExtractThumbnailFromPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ReadAllEXIFTagList.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ReadAllEXIFTags.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ReadandModifyJpegEXIFTags.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\ReadSpecificEXIFTagsInformation.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\SupportFor2-7BitsJPEG.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\SupportForJPEG_LSWithCMYK.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\JPEG\WritingAndModifyingEXIFData.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PNG\ApplyFilterMethod.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PNG\ChangeBackgroundColor.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PNG\CompressingFiles.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PNG\SettingResolution.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PNG\SpecifyBitDepth.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PNG\SpecifyTransparency.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\InterruptMonitorTest.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\LoadImageToPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ManageBrightnessContrastAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ManageExposureAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ManageChannelMixerAdjusmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingExportOfChannelMixerAdjusmentLyer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ManagePhotoFilterAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddTextLayerOnRuntime.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfAdjusmentLayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfLayerMask.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfClippingMask.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingExposureAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddHueSaturationAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddCurvesAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddChannelMixerAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddLevelAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingOfLevelAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\RenderingOfCurvesAdjustmentLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PatternFillLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfPtFlResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfVscgResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfVsmsResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\FillOpacityOfLayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\PossibilityToFlattenLayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\LayerEffectsForPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddIopaResource.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfRGBColorModeWith16BitPerChannel.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportOfRotateLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportTextOrientationPropertyEdit.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportTextStyleJustificationMode.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\TextLayerBoundBox.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\MergeOnePSDlayerToOther.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SheetColorHighlighting.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\LayerCreationDateTime.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddDiagnolWatermark.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\AddWatermark.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ColorReplacementInPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ControllCacheReallocation.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\CreateIndexedPSDFiles.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\CreateThumbnailsFromPSDFiles.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\DetectFlattenedPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ExportImageToPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ExportPSDLayerToRasterImage.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\ImportImageToPSDLayer.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\MergePSDlayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\SupportLayerForPSD.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\UncompressedImageStreamObject.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\UncompressedImageUsingFile.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\UpdateTextLayerInPSDFile.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\UsingAdjustmentLayers.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\UsingDocumentConversionProgressHandler.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\WorkingWithMasks.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\TIFF\CompressingTiff.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\TIFF\ExportToMultiPageTiff.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\TIFF\TiffOptionsConfiguration.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\TIFF\TIFFwithAdobeDeflateCompression.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\TIFF\TIFFwithDeflateCompression.cs" />
    <Compile Include="Aspose\Opening\LoadingImageFromStream.cs" />
    <Compile Include="Aspose\ModifyingAndConvertingImages\PSD\GetPropertiesOfInlineFormattingOfTextLayer.cs" />
    <Compile Include="Aspose\Opening\SupportOfAllowNonChangedLayerRepaint.cs" />
    <Compile Include="Aspose\SmartFilters\DirectlyApplySmartFilter.cs" />
    <Compile Include="Aspose\SmartFilters\ManipulatingSmartFiltersInSmartObjects.cs" />
    <Compile Include="Aspose\SmartFilters\SupportAccessToSmartFilters.cs" />
    <Compile Include="Aspose\SmartFilters\SupportCustomSmartFilterRenderer.cs" />
    <Compile Include="Aspose\SmartFilters\SupportSharpenSmartFilter.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfConvertingLayerToSmartObject.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfCopyingOfSmartObjectLayers.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfEmbeddedSmartObjects.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfExportContentsFromSmartObject.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfReplaceContentsByLink.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfReplaceContentsInSmartObjects.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfWarpTransformationToSmartObject.cs" />
    <Compile Include="Aspose\SmartObjects\WarpSettingsForSmartObjectLayerAndTextLayer.cs" />
    <Compile Include="Aspose\SmartObjects\SupportOfProcessingAreaProperty.cs" />
    <Compile Include="Aspose\WorkingWithPSD\ChangingGroupVisibility.cs" />
    <Compile Include="Aspose\LayerResources\SupportForBlwhResource.cs" />
    <Compile Include="Aspose\WorkingWithPSD\ExportLayerGroupToImage.cs" />
    <Compile Include="Aspose\LayerResources\SupportForInfxResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportForLspfResource.cs" />
    <Compile Include="Aspose\LayerResources\SupportForClblResource.cs" />
    <Compile Include="Aspose\WorkingWithPSD\GettingUniqueHashForSimilarLayers.cs" />
    <Compile Include="Aspose\WorkingWithPSD\LayerGroupIsOpenSupport.cs" />
    <Compile Include="Aspose\WorkingWithPSD\SupportEditingGlobalFontList.cs" />
    <Compile Include="Aspose\WorkingWithPSD\SupportOfApplyLayerMask.cs" />
    <Compile Include="Aspose\WorkingWithPSD\SupportOfArtboardLayer.cs" />
    <Compile Include="Aspose\WorkingWithPSD\SupportOfPassThroughBlendingMode.cs" />
    <Compile Include="Aspose\WorkingWithPSD\SupportOfSectionDividerLayer.cs" />
    <Compile Include="Aspose\WorkingWithPSD\UpdatingCreatorToolInPSDFile.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\AddShapeLayer.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\ClassesToManipulateVectorPathObjects.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\ResizeLayersWithVectorPaths.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\ResizeLayersWithVogkResourceAndVectorPaths.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\ShapeLayerManipulation.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\SupportIPathToManipulateVectorPathObjects.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\SupportOfShapeLayer.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\SupportOfShapeLayerRendering.cs" />
    <Compile Include="Aspose\WorkingWithVectorPaths\SupportShapeLayerFillProperty.cs" />
    <Compile Include="ExamplesPaths.cs" />
    <Compile Include="Runner\ExamplesRunner.cs" />
    <Compile Include="RunExamples.cs" />
    <Compile Include="Properties\AssemblyInfo.cs" />
    <Compile Include="Runner\ExamplesMainSection.cs" />
    <Compile Include="Runner\ExamplesSubSectionPsd.cs" />
  </ItemGroup>
  <ItemGroup>
    <None Include="App.config" />
  </ItemGroup>
  <ItemGroup>
    <PackageReference Include="Aspose.PSD">
      <Version>25.8.0</Version>
    </PackageReference>
  </ItemGroup>
  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" />
  <PropertyGroup>
    <PreBuildEvent>
    </PreBuildEvent>
  </PropertyGroup>
  <!-- To modify your build process, add your task inside one of the targets below and uncomment it. 
       Other similar extension points exist, see Microsoft.Common.targets.
  <Target Name="BeforeBuild">
  </Target>
  <Target Name="AfterBuild">
  </Target>
  -->
</Project>
--- END OF FILE CSharp/Aspose.PSD.Examples.csproj ---

--- START OF FILE CSharp/Aspose.PSD.Examples.csproj.user ---
﻿<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="14.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <ProjectView>ProjectFiles</ProjectView>
  </PropertyGroup>
</Project>
--- END OF FILE CSharp/Aspose.PSD.Examples.csproj.user ---

--- START OF FILE CSharp/Aspose/Ai/SupportAiImagePageCountProperty.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Ai
{
    public class SupportAiImagePageCountProperty
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportAiImagePageCountProperty
            //ExSummary:The following code demonstrates support of AiImage property for number of pages AiImage.PageCount.
            
            string sourceFile = Path.Combine(baseDir, "2241.ai");
            string[] outputFiles = new string[3]
            {
                Path.Combine(outputDir, "2241_pageNumber_0.png"),
                Path.Combine(outputDir, "2241_pageNumber_1.png"),
                Path.Combine(outputDir, "2241_pageNumber_2.png"),
            };

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            using (AiImage image = (AiImage)Image.Load(sourceFile))
            {
                AssertAreEqual(image.PageCount, 3);

                for (int i = 0; i < image.PageCount; i++)
                {
                    image.ActivePageIndex = i;
                    image.Save(outputFiles[i], new PngOptions());
                }
            }
            
            //ExEnd:SupportAiImagePageCountProperty

            Console.WriteLine("SupportAiImagePageCountProperty executed successfully");

            for (int i = 0; i < outputFiles.Length; i++)
            {
                File.Delete(outputFiles[i]);   
            }
        }
    }
}
--- END OF FILE CSharp/Aspose/Ai/SupportAiImagePageCountProperty.cs ---

--- START OF FILE CSharp/Aspose/Ai/SupportOfActivePageIndex.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Ai
{
    public class SupportOfActivePageIndex
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfActivePageIndex
            //ExSummary:The following code demonstrates support of ability to change active page in Ai images.
            
            string sourceFile = Path.Combine(baseDir, "threePages.ai");
            string firstPageOutputPng = Path.Combine(outputDir, "firstPageOutput.png");
            string secondPageOutputPng = Path.Combine(outputDir, "secondPageOutput.png");
            string thirdPageOutputPng = Path.Combine(outputDir, "thirdPageOutput.png");

            // Load the AI image.
            using (AiImage image = (AiImage)Image.Load(sourceFile))
            {
                // By default, the ActivePageIndex is 0.
                // So if you save the AI image without changing this property, the first page will be rendered and saved.
                image.Save(firstPageOutputPng, new PngOptions());

                // Change the active page index to the second page.
                image.ActivePageIndex = 1;

                // Save the second page of the AI image as a PNG image.
                image.Save(secondPageOutputPng, new PngOptions());

                // Change the active page index to the third page.
                image.ActivePageIndex = 2;

                // Save the third page of the AI image as a PNG image.
                image.Save(thirdPageOutputPng, new PngOptions());
            }

            //ExEnd:SupportOfActivePageIndex
            
            File.Delete(firstPageOutputPng);
            File.Delete(secondPageOutputPng);
            File.Delete(thirdPageOutputPng);

            Console.WriteLine("SupportOfActivePageIndex executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Ai/SupportOfActivePageIndex.cs ---

--- START OF FILE CSharp/Aspose/Ai/SupportOfLayersInAi.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.ImageOptions;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.Ai
{
    class SupportOfLayersInAi
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_AI();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart
            //ExSummary:The following example demonstrates support of layers in AI format files.

            string sourceFilePath = Path.Combine(dataDir, "form_8_2l3_7.ai");
            string outputFilePath = Path.Combine(OutputDir, "form_8_2l3_7_export");

            void AssertIsTrue(bool condition, string message)
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            using (AiImage image = (AiImage)Image.Load(sourceFilePath))
            {
                AiLayerSection layer0 = image.Layers[0];
                AssertIsTrue(layer0 != null, "Layer 0 should be not null.");
                AssertIsTrue(layer0.Name == "Layer 4", "The Name property of the layer 0 should be `Layer 4`");
                AssertIsTrue(!layer0.IsTemplate, "The IsTemplate property of the layer 0 should be false.");
                AssertIsTrue(layer0.IsLocked, "The IsLocked property of the layer 0 should be true.");
                AssertIsTrue(layer0.IsShown, "The IsShown property of the layer 0 should be true.");
                AssertIsTrue(layer0.IsPrinted, "The IsPrinted property of the layer 0 should be true.");
                AssertIsTrue(!layer0.IsPreview, "The IsPreview property of the layer 0 should be false.");
                AssertIsTrue(layer0.IsImagesDimmed, "The IsImagesDimmed property of the layer 0 should be true.");
                AssertIsTrue(layer0.DimValue == 51, "The DimValue property of the layer 0 should be 51.");
                AssertIsTrue(layer0.ColorNumber == 0, "The ColorNumber property of the layer 0 should be 0.");
                AssertIsTrue(layer0.Red == 79, "The Red property of the layer 0 should be 79.");
                AssertIsTrue(layer0.Green == 128, "The Green property of the layer 0 should be 128.");
                AssertIsTrue(layer0.Blue == 255, "The Blue property of the layer 0 should be 255.");
                AssertIsTrue(layer0.RasterImages.Length == 0, "The pixels length property of the raster image in the layer 0 should equals 0.");

                AiLayerSection layer1 = image.Layers[1];
                AssertIsTrue(layer1 != null, "Layer 1 should be not null.");
                AssertIsTrue(layer1.Name == "Layer 1", "The Name property of the layer 1 should be `Layer 1`");
                AssertIsTrue(layer1.RasterImages.Length == 1, "The length property of the raster images in the layer 1 should equals 1.");

                AiRasterImageSection rasterImage = layer1.RasterImages[0];
                AssertIsTrue(rasterImage != null, "The raster image in the layer 1 should be not null.");
                AssertIsTrue(rasterImage.Pixels != null, "The pixels property of the raster image in the layer 1 should be not null.");
                AssertIsTrue(string.Empty == rasterImage.Name, "The Name property of the raster image in the layer 1 should be empty");
                AssertIsTrue(rasterImage.Pixels.Length == 100, "The pixels length property of the raster image in the layer 1 should equals 100.");

                image.Save(outputFilePath + ".psd", new PsdOptions());
                image.Save(outputFilePath + ".png", new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd
        }
    }
}
--- END OF FILE CSharp/Aspose/Ai/SupportOfLayersInAi.cs ---

--- START OF FILE CSharp/Aspose/Animation/SupportExportToGifImage.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Animation
{
    public class SupportExportToGifImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportExportToGifImage
            //ExSummary:The following code demonstrates the support of export Timeline to a Gif image.
            
            string sourceFile = Path.Combine(baseDir, "4GIF_animated.psd");
            string outputGif = Path.Combine(outputDir, "out_4_animated.psd.gif");

            using (var psdImage = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                psdImage.Timeline.Save(outputGif, new GifOptions());
            }
            
            //ExEnd:SupportExportToGifImage

            File.Delete(outputGif);

            Console.WriteLine("SupportExportToGifImage executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Animation/SupportExportToGifImage.cs ---

--- START OF FILE CSharp/Aspose/Animation/SupportOfAnimatedDataSection.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.FileFormats.Psd.Resources;

namespace Aspose.PSD.Examples.Aspose.Animation
{
    public class SupportOfAnimatedDataSection
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfAnimatedDataSection
            //ExSummary:The following code demonstrates how to set/update delay time in the timeline frame of animated data.
            
            string sourceFile = Path.Combine(baseDir, "3_animated.psd");
            string outputPsd = Path.Combine(outputDir, "output_3_animated.psd");

            T FindStructure<T>(IEnumerable<OSTypeStructure> structures, string keyName) where T : OSTypeStructure
            {
                foreach (var structure in structures)
                {
                    if (structure.KeyName.ClassName == keyName)
                    {
                        return structure as T;
                    }
                }

                return null;
            }

            OSTypeStructure[] AddOrReplaceStructure(IEnumerable<OSTypeStructure> structures, OSTypeStructure newStructure)
            {
                List<OSTypeStructure> listOfStructures = new List<OSTypeStructure>(structures);

                for (int i = 0; i < listOfStructures.Count; i++)
                {
                    OSTypeStructure structure = listOfStructures[i];
                    if (structure.KeyName.ClassName == newStructure.KeyName.ClassName)
                    {
                        listOfStructures.RemoveAt(i);
                        break;
                    }
                }

                listOfStructures.Add(newStructure);

                return listOfStructures.ToArray();
            }

            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                foreach (var imageResource in image.ImageResources)
                {
                    if (imageResource is AnimatedDataSectionResource)
                    {
                        var animatedData =
                            (AnimatedDataSectionStructure) (imageResource as AnimatedDataSectionResource).AnimatedDataSection;
                        var framesList = FindStructure<ListStructure>(animatedData.Items, "FrIn");

                        var frame1 = (DescriptorStructure)framesList.Types[1];

                        // Creates the frame delay record with value 100 centi-second that is equal to 1 second.
                        var frameDelay = new IntegerStructure(new ClassID("FrDl"));
                        frameDelay.Value = 100; // set time in centi-seconds.

                        frame1.Structures = AddOrReplaceStructure(frame1.Structures, frameDelay);

                        break;
                    }
                }

                image.Save(outputPsd);
            }
            
            //ExEnd:SupportOfAnimatedDataSection
            
            File.Delete(outputPsd);
            
            Console.WriteLine("SupportOfAnimatedDataSection executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Animation/SupportOfAnimatedDataSection.cs ---

--- START OF FILE CSharp/Aspose/Animation/SupportOfLayerStateEffects.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.Animation;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;

namespace Aspose.PSD.Examples.Aspose.Animation
{
    public class SupportOfLayerStateEffects
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfLayerStateEffects
            //ExSummary:The following code demonstrates support of effects in Timeline frames.

            string sourceFile = Path.Combine(baseDir, "4_animated.psd");
            string outputFile = Path.Combine(outputDir, "output.psd");

            using (var psdImage = (PsdImage)Image.Load(sourceFile))
            {
                Timeline timeline = psdImage.Timeline;

                var layerStateEffects11 = timeline.Frames[1].LayerStates[1].StateEffects;

                layerStateEffects11.AddDropShadow();
                layerStateEffects11.AddGradientOverlay();

                var layerStateEffects21 = timeline.Frames[2].LayerStates[1].StateEffects;
                layerStateEffects21.AddStroke(FillType.Color);
                layerStateEffects21.IsVisible = false;

                psdImage.Save(outputFile);
            }

            //ExEnd:SupportOfLayerStateEffects

            File.Delete(outputFile);

            Console.WriteLine("SupportOfLayerStateEffects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Animation/SupportOfLayerStateEffects.cs ---

--- START OF FILE CSharp/Aspose/Animation/SupportOfMlstResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;

namespace Aspose.PSD.Examples.Aspose.Animation
{
    public class SupportOfMlstResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfMlstResource
            //ExSummary:The following code demonstrates support of MlstResource resource that gives a low-level mechanism to manipulate the layer states.
            
            string sourceFile = Path.Combine(baseDir, "image1219.psd");
            string outputPsd = Path.Combine(outputDir, "output_image1219.psd");

            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                Layer layer1 = image.Layers[1];
                ShmdResource shmdResource = (ShmdResource)layer1.Resources[8];
                MlstResource mlstResource = (MlstResource)shmdResource.SubResources[0];
            
                ListStructure layerStatesList = (ListStructure)mlstResource.Items[1];
                DescriptorStructure layersStateOnFrame1 = (DescriptorStructure)layerStatesList.Types[1];
                BooleanStructure layerEnabled = (BooleanStructure)layersStateOnFrame1.Structures[0];
            
                // Disable layer 1 on frame 1
                layerEnabled.Value = false;
            
                image.Save(outputPsd);
            }
            
            //ExEnd:SupportOfMlstResource
            
            File.Delete(outputPsd);
            
            Console.WriteLine("SupportOfMlstResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Animation/SupportOfMlstResource.cs ---

--- START OF FILE CSharp/Aspose/Animation/SupportOfPsdImageTimelineProperty.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.Animation;

namespace Aspose.PSD.Examples.Aspose.Animation
{
    public class SupportOfPsdImageTimelineProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPsdImageTimelineProperty
            //ExSummary:The following code demonstrates a new approach to work with the Timeline.
            
            string sourceFile = Path.Combine(baseDir, "4_animated.psd");
            string outputFile = Path.Combine(outputDir, "output_edited.psd");

            using (var psdImage = (PsdImage)Image.Load(sourceFile))
            {
                Timeline timeline = psdImage.Timeline;
    
                // Add one more frame
                List<Frame> frames = new List<Frame>(timeline.Frames);
                frames.Add(new Frame());
                timeline.Frames = frames.ToArray();

                timeline.SwitchActiveFrame(4);

                psdImage.Save(outputFile);
            }
            
            //ExEnd:SupportOfPsdImageTimelineProperty

            File.Delete(outputFile);

            Console.WriteLine("SupportOfPsdImageTimelineProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Animation/SupportOfPsdImageTimelineProperty.cs ---

--- START OF FILE CSharp/Aspose/Animation/SupportOfTimeLine.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.Animation;

namespace Aspose.PSD.Examples.Aspose.Animation
{
    public class SupportOfTimeLine
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfTimeLine
            //ExSummary:The Timeline class gives a high-level ability to manipulate the timeline of PsdImage, like changing frame delay or editing layer state on a specific frame.
            
            string sourceFile = Path.Combine(baseDir, "image1219.psd");
            string outputPsd = Path.Combine(outputDir, "output_image800.psd");

            using (PsdImage psdImage = (PsdImage)Image.Load(sourceFile))
            {
                Timeline timeline = psdImage.Timeline;

                // Change dispose method of frame 1
                timeline.Frames[0].DisposalMethod = FrameDisposalMethod.DoNotDispose;

                // Change delay of frame 2
                timeline.Frames[1].Delay = 15;

                // Change opacity of 'Layer 1' on frame 2
                LayerState layerState11 = timeline.Frames[1].LayerStates[1];
                layerState11.Opacity = 50;

                // move 'Layer 1' to left-bottom corner on frame 3
                LayerState layerState21 = timeline.Frames[2].LayerStates[1];
                layerState21.PositionOffset = new Point(-50, 230);

                // Adds new frame
                List<Frame> frames = new List<Frame>(timeline.Frames);
                frames.Add(new Frame());
                timeline.Frames = frames.ToArray();

                // Change blendMode of 'Layer 1' on frame 4
                LayerState layerState31 = timeline.Frames[3].LayerStates[1];
                layerState31.BlendMode = BlendMode.Dissolve;

                // Apply changes back to PsdImage instance
                psdImage.Save(outputPsd);
            }
            
            //ExEnd:SupportOfTimeLine
            
            File.Delete(outputPsd);
            
            Console.WriteLine("SupportOfTimeLine executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Animation/SupportOfTimeLine.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ApplyGausWienerFilters.cs ---
﻿using Aspose.PSD.ImageFilters.FilterOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ApplyGausWienerFilters
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ApplyGausWienerFilters

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"gauss_wiener_out.gif";

            // Load the noisy image 
            using (Image image = Image.Load(sourceFile))
            {
                RasterImage rasterImage = image as RasterImage;
                if (rasterImage == null)
                {
                    return;
                }

                // Create an instance of GaussWienerFilterOptions class and set the radius size and smooth value.
                GaussWienerFilterOptions options = new GaussWienerFilterOptions(12, 3);
                options.Grayscale = true;

                // Apply MedianFilterOptions filter to RasterImage object and Save the resultant image
                rasterImage.Filter(image.Bounds, options);
                image.Save(destName, new GifOptions());

            }
            //ExEnd:ApplyGausWienerFilters

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ApplyGausWienerFilters.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ApplyGausWienerFiltersForColorImage.cs ---
﻿using Aspose.PSD.ImageFilters.FilterOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ApplyGausWienerFiltersForColorImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ApplyGausWienerFiltersForColorImage

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"gauss_wiener_color_out.gif";

            // Load the noisy image 
            using (Image image = Image.Load(sourceFile))
            {
                // Cast the image into RasterImage
                RasterImage rasterImage = image as RasterImage;
                if (rasterImage == null)
                {
                    return;
                }

                // Create an instance of GaussWienerFilterOptions class and set the radius size and smooth value.
                GaussWienerFilterOptions options = new GaussWienerFilterOptions(5, 1.5);
                options.Brightness = 1;

                // Apply MedianFilterOptions filter to RasterImage object and Save the resultant image
                rasterImage.Filter(image.Bounds, options);
                image.Save(destName, new GifOptions());

            }
            //ExEnd:ApplyGausWienerFiltersForColorImage

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ApplyGausWienerFiltersForColorImage.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ApplyMedianAndWienerFilters.cs ---
﻿using Aspose.PSD.ImageFilters.FilterOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ApplyMedianAndWienerFilters
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ApplyMedianAndWienerFilters

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"median_test_denoise_out.gif";

            // Load the noisy image 
            using (Image image = Image.Load(sourceFile))
            {
                // Cast the image into RasterImage
                RasterImage rasterImage = image as RasterImage;
                if (rasterImage == null)
                {
                    return;
                }

                // Create an instance of MedianFilterOptions class and set the size, Apply MedianFilterOptions filter to RasterImage object and Save the resultant image
                MedianFilterOptions options = new MedianFilterOptions(4);
                rasterImage.Filter(image.Bounds, options);
                image.Save(destName, new GifOptions());
            }
            //ExEnd:ApplyMedianAndWienerFilters

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ApplyMedianAndWienerFilters.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ApplyMotionWienerFilters.cs ---
﻿using Aspose.PSD.ImageFilters.FilterOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ApplyMotionWienerFilters
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ApplyMotionWienerFilters

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"motion_filter_out.gif";

            // Load the noisy image 
            using (Image image = Image.Load(sourceFile))
            {
                // Cast the image into RasterImage
                RasterImage rasterImage = image as RasterImage;
                if (rasterImage == null)
                {
                    return;
                }

                // Create an instance of MotionWienerFilterOptions class and set the length, smooth value and angle.
                MotionWienerFilterOptions options = new MotionWienerFilterOptions(50, 9, 90);
                options.Grayscale = true;

                // Apply MedianFilterOptions filter to RasterImage object and  Save the resultant image
                rasterImage.Filter(image.Bounds, options);
                image.Save(destName, new GifOptions());

            }
            //ExEnd:ApplyMotionWienerFilters

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ApplyMotionWienerFilters.cs ---

--- START OF FILE CSharp/Aspose/Conversion/BinarizationWithFixedThreshold.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class BinarizationWithFixedThreshold
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:BinarizationWithFixedThreshold

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"BinarizationWithFixedThreshold_out.jpg";

            // Load an image
            using (Image image = Image.Load(sourceFile))
            {
                // Cast the image to RasterCachedImage and Check if image is cached
                RasterCachedImage rasterCachedImage = (RasterCachedImage)image;
                if (!rasterCachedImage.IsCached)
                {
                    // Cache image if not already cached
                    rasterCachedImage.CacheData();
                }

                // Binarize image with predefined fixed threshold and Save the resultant image
                rasterCachedImage.BinarizeFixed(100);
                rasterCachedImage.Save(destName, new JpegOptions());
            }

            //ExEnd:BinarizationWithFixedThreshold

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/BinarizationWithFixedThreshold.cs ---

--- START OF FILE CSharp/Aspose/Conversion/BinarizationWithOtsuThreshold.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class BinarizationWithOtsuThreshold
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:BinarizationWithOtsuThreshold

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"BinarizationWithOtsuThreshold_out.jpg";

            // Load an image
            using (Image image = Image.Load(sourceFile))
            {
                // Cast the image to RasterCachedImage and Check if image is cached
                RasterCachedImage rasterCachedImage = (RasterCachedImage)image;
                if (!rasterCachedImage.IsCached)
                {
                    // Cache image if not already cached
                    rasterCachedImage.CacheData();
                }

                // Binarize image with Otsu Thresholding and Save the resultant image                
                rasterCachedImage.BinarizeOtsu();

                rasterCachedImage.Save(destName, new JpegOptions());
            }

            //ExEnd:BinarizationWithOtsuThreshold

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/BinarizationWithOtsuThreshold.cs ---

--- START OF FILE CSharp/Aspose/Conversion/Bradleythreshold.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class Bradleythreshold
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:Bradleythreshold

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"binarized_out.png";

            // Load the noisy image 
            // Load an image
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                // Define threshold value, Call BinarizeBradley method and pass the threshold value as parameter and Save the output image
                double threshold = 0.15;
                image.BinarizeBradley(threshold);
                image.Save(destName, new PngOptions());
            }

            //ExEnd:Bradleythreshold

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/Bradleythreshold.cs ---

--- START OF FILE CSharp/Aspose/Conversion/CMYKPSDtoCMYKTiff.cs ---
﻿using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class CMYKPSDtoCMYKTiff
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_ModifyingAndConvertingImages();

            //ExStart:CMYKPSDtoCMYKTiff

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"output.tiff";

            using (Image image = Image.Load(sourceFile))
            {
                image.Save(destName, new TiffOptions(TiffExpectedFormat.TiffLzwCmyk));
            }

            //ExEnd:CMYKPSDtoCMYKTiff

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/CMYKPSDtoCMYKTiff.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ColorConversionUsingDefaultProfiles.cs ---
﻿using Aspose.PSD.FileFormats.Jpeg;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ColorConversionUsingDefaultProfiles
    {
        public static void Run()
        {

            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_ModifyingAndConvertingImages();

            //ExStart:ColorConversionUsingDefaultProfiles

            // Create a new Image.
            using (PsdImage image = new PsdImage(500, 500))
            {
                // Fill image data.
                int count = image.Width * image.Height;
                int[] pixels = new int[count];
                int r = 0;
                int g = 0;
                int b = 0;
                int channel = 0;
                for (int i = 0; i < count; i++)
                {
                    if (channel % 3 == 0)
                    {
                        r++;
                        if (r == 256)
                        {
                            r = 0;
                            channel++;
                        }
                    }
                    else if (channel % 3 == 1)
                    {
                        g++;
                        if (g == 256)
                        {
                            g = 0;
                            channel++;
                        }
                    }
                    else
                    {
                        b++;
                        if (b == 256)
                        {
                            b = 0;
                            channel++;
                        }
                    }

                    pixels[i] = Color.FromArgb(r, g, b).ToArgb();
                }

                // Save the newly created pixels.
                image.SaveArgb32Pixels(image.Bounds, pixels);

                // Save the newly created image.
                image.Save(dataDir + "Default.jpg", new JpegOptions());

                // Update color profile.
                StreamSource rgbprofile = new StreamSource(File.OpenRead(dataDir + "eciRGB_v2.icc"));
                StreamSource cmykprofile = new StreamSource(File.OpenRead(dataDir + "ISOcoated_v2_FullGamut4.icc"));
                image.RgbColorProfile = rgbprofile;
                image.CmykColorProfile = cmykprofile;

                // Save the resultant image with new YCCK profiles. You will notice differences in color values if compare the images.
                JpegOptions options = new JpegOptions();
                options.ColorType = JpegCompressionColorMode.Cmyk;
                image.Save(dataDir + "Cmyk_Default_profiles.jpg", options);
            }


            //ExEnd:ColorConversionUsingDefaultProfiles
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ColorConversionUsingDefaultProfiles.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ColorConversionUsingICCProfiles.cs ---
﻿using Aspose.PSD.FileFormats.Jpeg;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ColorConversionUsingICCProfiles
    {
        public static void Run()
        {

            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_ModifyingAndConvertingImages();

            //ExStart:ColorConversionUsingICCProfiles

            // Create a new Image.
            using (PsdImage image = new PsdImage(500, 500))
            {
                // Fill image data.
                int count = image.Width * image.Height;
                int[] pixels = new int[count];
                int r = 0;
                int g = 0;
                int b = 0;
                int channel = 0;
                for (int i = 0; i < count; i++)
                {
                    if (channel % 3 == 0)
                    {
                        r++;
                        if (r == 256)
                        {
                            r = 0;
                            channel++;
                        }
                    }
                    else if (channel % 3 == 1)
                    {
                        g++;
                        if (g == 256)
                        {
                            g = 0;
                            channel++;
                        }
                    }
                    else
                    {
                        b++;
                        if (b == 256)
                        {
                            b = 0;
                            channel++;
                        }
                    }

                    pixels[i] = Color.FromArgb(r, g, b).ToArgb();
                }

                // Save the newly created pixels.
                image.SaveArgb32Pixels(image.Bounds, pixels);

                // Save the resultant image with default Icc profiles.
                image.Save(dataDir + "Default_profiles.jpg", new JpegOptions());

                // Update color profile.
                StreamSource rgbprofile = new StreamSource(File.OpenRead(dataDir + "eciRGB_v2.icc"));
                StreamSource cmykprofile = new StreamSource(File.OpenRead(dataDir + "ISOcoated_v2_FullGamut4.icc"));
                image.RgbColorProfile = rgbprofile;
                image.CmykColorProfile = cmykprofile;

                // Save the resultant image with new YCCK profiles. You will notice differences in color values if compare the images.
                JpegOptions options = new JpegOptions();
                options.ColorType = JpegCompressionColorMode.Ycck;
                image.Save(dataDir + "Ycck_profiles.jpg", options);
            }


            //ExEnd:ColorConversionUsingICCProfiles
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ColorConversionUsingICCProfiles.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ConversionPSDToGrayscaleRgbCmyk.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ConversionPSDToGrayscaleRgbCmyk
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:ConversionPSDToGrayscaleRgbCmyk
            //ExSummary:These examples demonstrate conversion of the PSD image format to other Color Modes/BitDepth.

            string dataDir = baseFolder;
            string outputDir = output;

            // These examples demonstrate conversion of the PSD image format to other Color Modes/BitDepth.
            ImageConversion(ColorModes.Grayscale, 16, 2);
            ImageConversion(ColorModes.Grayscale, 8, 2);
            ImageConversion(ColorModes.Grayscale, 8, 1);
            ImageConversion(ColorModes.Rgb, 8, 4);
            ImageConversion(ColorModes.Rgb, 16, 4);
            ImageConversion(ColorModes.Cmyk, 8, 5);
            ImageConversion(ColorModes.Cmyk, 16, 5);

            void ImageConversion(ColorModes colorMode, short channelBitsCount, short channelsCount)
            {
                var compression = channelBitsCount > 8 ? CompressionMethod.Raw : CompressionMethod.RLE;
                SaveToPsdThenLoadAndSaveToPng(
                    "SheetColorHighlightExample",
                    colorMode,
                    channelBitsCount,
                    channelsCount,
                    compression,
                    1);
                SaveToPsdThenLoadAndSaveToPng(
                    "FillOpacitySample",
                    colorMode,
                    channelBitsCount,
                    channelsCount,
                    compression,
                    2);
                SaveToPsdThenLoadAndSaveToPng(
                    "ClippingMaskRegular",
                    colorMode,
                    channelBitsCount,
                    channelsCount,
                    compression,
                    3);
            }

            // Saves to PSD then loads the saved file and saves to PNG.
            void SaveToPsdThenLoadAndSaveToPng(
                string file,
                ColorModes colorMode,
                short channelBitsCount,
                short channelsCount,
                CompressionMethod compression,
                int layerNumber)
            {
                string srcFile = dataDir + file + ".psd";
                string postfix = colorMode.ToString() + channelBitsCount + "bits" + channelsCount + "channels" +
                                 compression;
                string fileName = file + "_" + postfix + ".psd";
                string exportPath = outputDir + fileName;
                PsdOptions psdOptions = new PsdOptions()
                {
                    ColorMode = colorMode,
                    ChannelBitsCount = channelBitsCount,
                    ChannelsCount = channelsCount,
                    CompressionMethod = compression
                };
                using (var image = (PsdImage)Image.Load(srcFile))
                {
                    image.Convert(psdOptions);

                    RasterCachedImage raster = image.Layers.Length > 0 && layerNumber >= 0
                        ? (RasterCachedImage)image.Layers[layerNumber]
                        : image;
                    Graphics graphics = new Graphics(raster);
                    int width = raster.Width;
                    int height = raster.Height;
                    Rectangle rect = new Rectangle(
                        width / 3,
                        height / 3,
                        width - (2 * (width / 3)) - 1,
                        height - (2 * (height / 3)) - 1);
                    graphics.DrawRectangle(new Pen(Color.DarkGray, 1), rect);

                    image.Save(exportPath);
                }

                string pngExportPath = Path.ChangeExtension(exportPath, "png");
                using (PsdImage image = (PsdImage)Image.Load(exportPath))
                {
                    image.Save(pngExportPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }
            //ExEnd:ConversionPSDToGrayscaleRgbCmyk

            Console.WriteLine("ConversionPSDToGrayscaleRgbCmyk executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ConversionPSDToGrayscaleRgbCmyk.cs ---

--- START OF FILE CSharp/Aspose/Conversion/CropPSDFile.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class CropPSDFile
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CropPSDFile
            // Implement correct Crop method for PSD files.
            string sourceFileName = dataDir + "1.psd";
            string exportPathPsd = dataDir + "CropTest.psd";
            string exportPathPng = dataDir + "CropTest.png";
            using (RasterImage image = Image.Load(sourceFileName) as RasterImage)
            {
                image.Crop(new Rectangle(10, 30, 100, 100));
                image.Save(exportPathPsd, new PsdOptions());
                image.Save(exportPathPng, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }


            //ExEnd:CropPSDFile

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/CropPSDFile.cs ---

--- START OF FILE CSharp/Aspose/Conversion/CroppingPSDWhenConvertingToPNG.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class CroppingPSDWhenConvertingToPNG
    {

        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CroppingPSDWhenConvertingToPNG

            string srcPath = dataDir + @"sample.psd";
            string destName = dataDir + @"export.png";

            // Load an existing PSD image
            using (RasterImage image = (RasterImage)Image.Load(srcPath))
            {
                // Create an instance of Rectangle class by passing x,y and width,height 
                // Call the crop method of Image class and pass the rectangle class instance
                image.Crop(new Rectangle(0, 0, 350, 450));

                // Create an instance of PngOptions class
                PngOptions pngOptions = new PngOptions();

                // Call the save method, provide output path and PngOptions to convert the PSD file to PNG and save the output
                image.Save(destName, pngOptions);
            }

            //ExEnd:CroppingPSDWhenConvertingToPNG
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/CroppingPSDWhenConvertingToPNG.cs ---

--- START OF FILE CSharp/Aspose/Conversion/ExportImagesinMultiThreadEnv.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class ExportImagesinMultiThreadEnv
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_Output();

            //ExStart:ExportImagesinMultiThreadEnv

            string imageDataPath = dataDir + @"sample.psd";

            try
            {

                // Create the stream of the existing image file.   
                using (System.IO.FileStream fileStream = System.IO.File.Create(imageDataPath))
                {

                    // Create an instance of PSD image option class.
                    using (PsdOptions psdOptions = new PsdOptions())
                    {
                        // Set the source property of the imaging option class object.
                        psdOptions.Source = new Sources.StreamSource(fileStream);

                        // DO PROCESSING. 
                        // Following is the sample processing on the image. Un-comment to use it.
                        //using (RasterImage image = (RasterImage)Image.Create(psdOptions, 10, 10))
                        //{
                        //    Color[] pixels = new Color[4];
                        //    for (int i = 0; i < 4; ++i)
                        //    {
                        //        pixels[i] = Color.FromArgb(40, 30, 20, 10);
                        //    }
                        //    image.SavePixels(new Rectangle(0, 0, 2, 2), pixels);
                        //    image.Save();
                        //}
                    }
                }
            }
            finally
            {
                // Delete the file. This statement is in the final block because in any case this statement should execute to make it sure that resource is properly disposed off.
                System.IO.File.Delete(imageDataPath);
            }

            //ExEnd:ExportImagesinMultiThreadEnv

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/ExportImagesinMultiThreadEnv.cs ---

--- START OF FILE CSharp/Aspose/Conversion/GIFImageLayersToTIFF.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class GIFImageLayersToTIFF
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_ModifyingAndConvertingImages();

            //ExStart:GIFImageLayersToTIFF

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"output";

            // Load a PSD image and Convert the image's layers to Tiff images.
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                // Iterate through array of PSD layers
                for (int i = 0; i < image.Layers.Length; i++)
                {
                    // Get PSD layer.
                    Layer layer = image.Layers[i];

                    // Create an instance of TIFF Option class and Save the PSD layer as TIFF image
                    TiffOptions objTiff = new TiffOptions(TiffExpectedFormat.TiffDeflateRgb);
                    layer.Save("output" + i + "_out.tif", objTiff);
                }
            }

            //ExEnd:GIFImageLayersToTIFF

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/GIFImageLayersToTIFF.cs ---

--- START OF FILE CSharp/Aspose/Conversion/Grayscaling.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class Grayscaling
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:Garysacling

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"Grayscaling_out.jpg";

            // Load an image in an instance of Image
            using (Image image = Image.Load(sourceFile))
            {
                // Cast the image to RasterCachedImage and Check if image is cached
                RasterCachedImage rasterCachedImage = (RasterCachedImage)image;
                if (!rasterCachedImage.IsCached)
                {
                    // Cache image if not already cached
                    rasterCachedImage.CacheData();
                }

                // Transform image to its grayscale representation and Save the resultant image
                rasterCachedImage.Grayscale();
                rasterCachedImage.Save(destName, new JpegOptions());
            }


            //ExEnd:Garysacling

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/Grayscaling.cs ---

--- START OF FILE CSharp/Aspose/Conversion/LoadingFromStream.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class LoadingFromStream
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:LoadingFromStream

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + "result.png";

            FileStream fStream = new FileStream(sourceFile, FileMode.Open);
            fStream.Position = 0;

            // load PSD image and replace the non found fonts.
            using (Image image = Image.Load(fStream))
            {
                PsdImage psdImage = (PsdImage)image;
                MemoryStream stream = new MemoryStream();
                psdImage.Save(stream, new PngOptions());
            }

            //ExEnd:LoadingFromStream

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/LoadingFromStream.cs ---

--- START OF FILE CSharp/Aspose/Conversion/PSDToRasterImageFormats.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class PSDToRasterImageFormats
    {

        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PSDToRasterImageFormats

            string srcPath = dataDir + @"sample.psd";
            string destName = dataDir + @"export";

            // Load an existing PSD image as Image
            using (Image image = Image.Load(srcPath))
            {
                // Create an instance of PngOptions class
                PngOptions pngOptions = new PngOptions();

                // Create an instance of BmpOptions class
                BmpOptions bmpOptions = new BmpOptions();

                // Create an instance of TiffOptions class
                TiffOptions tiffOptions = new TiffOptions(FileFormats.Tiff.Enums.TiffExpectedFormat.Default);

                // Create an instance of GifOptions class
                GifOptions gifOptions = new GifOptions();

                // Create an instance of JpegOptions class
                JpegOptions jpegOptions = new JpegOptions();

                // Create an instance of Jpeg2000Options class
                Jpeg2000Options jpeg2000Options = new Jpeg2000Options();

                // Call the save method, provide output path and export options to convert PSD file to various raster file formats.
                image.Save(destName + ".png", pngOptions);
                image.Save(destName + ".bmp", bmpOptions);
                image.Save(destName + ".tiff", tiffOptions);
                image.Save(destName + ".gif", gifOptions);
                image.Save(destName + ".jpeg", jpegOptions);
                image.Save(destName + ".jp2", jpeg2000Options);
            }

            //ExEnd:PSDToRasterImageFormats
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/PSDToRasterImageFormats.cs ---

--- START OF FILE CSharp/Aspose/Conversion/RenderTextWithDifferentColorsInTextLayer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageOptions;
using System;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class RenderTextWithDifferentColorsInTextLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:1
            string sourceFile = SourceDir + @"text_ethalon_different_colors.psd";
            string destName = OutputDir + @"RenderTextWithDifferentColorsInTextLayer_out.png";

            // Load the noisy image 
            using (var psdImage = (PsdImage)Image.Load(sourceFile))
            {
                var txtLayer = (TextLayer)psdImage.Layers[1];
                txtLayer.TextData.UpdateLayerData();
                PngOptions pngOptions = new PngOptions();
                pngOptions.ColorType = PngColorType.TruecolorWithAlpha;
                psdImage.Save(destName, pngOptions);
            }
            //ExEnd:1

            Console.WriteLine("RenderTextWithDifferentColorsInTextLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/RenderTextWithDifferentColorsInTextLayer.cs ---

--- START OF FILE CSharp/Aspose/Conversion/SaveImageWorker.cs ---
﻿using Aspose.PSD.CoreExceptions;
using Aspose.PSD.Multithreading;
using System;
using System.Threading;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    //ExStart:SaveImageWorker
    class SaveImageWorker
    {
        /// <summary>
        /// The path to the input image.
        /// </summary>
        private readonly string inputPath;

        /// <summary>
        /// The path to the output image.
        /// </summary>
        private readonly string outputPath;

        /// <summary>
        /// The interrupt monitor.
        /// </summary>
        private readonly InterruptMonitor monitor;

        /// <summary>
        /// The save options.
        /// </summary>
        private readonly ImageOptionsBase saveOptions;

        /// <summary>
        /// Initializes a new instance of the <see cref="SaveImageWorker" /> class.
        /// </summary>
        /// <param name="inputPath">The path to the input image.</param>
        /// <param name="outputPath">The path to the output image.</param>
        /// <param name="saveOptions">The save options.</param>
        /// <param name="monitor">The interrupt monitor.</param>
        public SaveImageWorker(string inputPath, string outputPath, ImageOptionsBase saveOptions, InterruptMonitor monitor)
        {
            this.inputPath = inputPath;
            this.outputPath = outputPath;
            this.saveOptions = saveOptions;
            this.monitor = monitor;
        }

        /// <summary>
        /// Tries to convert image from one format to another. Handles interruption.
        /// </summary>
        public void ThreadProc()
        {
            using (Image image = Image.Load(this.inputPath))
            {
                InterruptMonitor.ThreadLocalInstance = this.monitor;

                try
                {
                    image.Save(this.outputPath, this.saveOptions);
                }
                catch (OperationInterruptedException e)
                {
                    Console.WriteLine("The save thread #{0} finishes at {1}", Thread.CurrentThread.ManagedThreadId, DateTime.Now);
                    Console.WriteLine(e);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
                finally
                {
                    InterruptMonitor.ThreadLocalInstance = null;
                }
            }
        }
    }
    //ExEnd:SaveImageWorker
}
--- END OF FILE CSharp/Aspose/Conversion/SaveImageWorker.cs ---

--- START OF FILE CSharp/Aspose/Conversion/SavingtoStream.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class SavingtoStream
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SavingtoStream

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + "result.png";

            // load PSD image and replace the non found fonts.
            using (Image image = Image.Load(sourceFile))
            {
                PsdImage psdImage = (PsdImage)image;
                MemoryStream stream = new MemoryStream();
                psdImage.Save(stream, new PngOptions());
            }

            //ExEnd:SavingtoStream

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/SavingtoStream.cs ---

--- START OF FILE CSharp/Aspose/Conversion/SettingforReplacingMissingFonts.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class SettingforReplacingMissingFonts
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output(); ;

            //ExStart:SettingforReplacingMissingFonts

            string sourceFileName = Path.Combine(dataDir, "sample_konstanting.psd");

            string[] outputs = new string[]
            {
                "replacedfont0.tiff",
                "replacedfont1.png",
                "replacedfont2.jpg"
            };

            using (PsdImage image = (PsdImage)Image.Load(sourceFileName, new PsdLoadOptions() { AllowNonChangedLayerRepaint = true }))
            {
                // This way you can use different fonts for different outputs 
                image.Save(Path.Combine(outputFolder, outputs[0]), new TiffOptions(TiffExpectedFormat.TiffJpegRgb) { DefaultReplacementFont = "Arial" });
                image.Save(Path.Combine(outputFolder, outputs[1]), new PngOptions { DefaultReplacementFont = "Verdana" });
                image.Save(Path.Combine(outputFolder, outputs[2]), new JpegOptions { DefaultReplacementFont = "Times New Roman" });
            }
            //ExEnd:SettingforReplacingMissingFonts

            Console.WriteLine("SettingforReplacingMissingFonts executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/SettingforReplacingMissingFonts.cs ---

--- START OF FILE CSharp/Aspose/Conversion/SupportForInterruptMonitor.cs ---
﻿using Aspose.PSD.ImageOptions;
using Aspose.PSD.Multithreading;
using System;
using System.IO;
using System.Threading;

namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class SupportForInterruptMonitor
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PNG();

            //ExStart:SupportForInterruptMonitor

            ImageOptionsBase saveOptions = new PngOptions();
            InterruptMonitor monitor = new InterruptMonitor();
            string source = Path.Combine(dataDir, "big2.psb");
            string output = Path.Combine(dataDir, "big_out.png");
            SaveImageWorker worker = new SaveImageWorker(source, output, saveOptions, monitor);

            Thread thread = new Thread(new ThreadStart(worker.ThreadProc));

            try
            {
                thread.Start();

                // The timeout should be less than the time required for full image conversion (without interruption).
                Thread.Sleep(3000);

                // Interrupt the process
                monitor.Interrupt();
                Console.WriteLine("Interrupting the save thread #{0} at {1}", thread.ManagedThreadId, System.DateTime.Now);

                // Wait for interruption...
                thread.Join();
            }
            finally
            {
                // Delete the output file.
                if (File.Exists(output))
                {
                    File.Delete(output);
                }
            }

            //ExEnd:SupportForInterruptMonitor
        }


    }


}
--- END OF FILE CSharp/Aspose/Conversion/SupportForInterruptMonitor.cs ---

--- START OF FILE CSharp/Aspose/Conversion/SyncRoot.cs ---
﻿namespace Aspose.PSD.Examples.Aspose.Conversion
{
    class SyncRoot
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SyncRoot

            // Create an instance of Memory stream class.
            using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
            {
                // Create an instance of Stream container class and assign memory stream object.
                using (StreamContainer streamContainer = new StreamContainer(memoryStream))
                {
                    // check if the access to the stream source is synchronized.
                    lock (streamContainer.SyncRoot)
                    {
                        // do work
                        // now access to source MemoryStream is synchronized
                    }
                }
            }

            //ExEnd:SyncRoot

        }
    }
}
--- END OF FILE CSharp/Aspose/Conversion/SyncRoot.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/AddEffectAtRunTime.cs ---
﻿using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class AddEffectAtRunTime
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();
            //ExStart:AddEffectAtRunTime

            // Add color overlay layer effect at runtime
            string sourceFileName = dataDir + "ThreeRegularLayers.psd";
            string exportPath = dataDir + "ThreeRegularLayersChanged.psd";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var effect = im.Layers[1].BlendingOptions.AddColorOverlay();
                effect.Color = Color.Green;
                effect.Opacity = 128;
                effect.BlendMode = BlendMode.Normal;

                im.Save(exportPath);
            }
            //ExEnd:AddEffectAtRunTime
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/AddEffectAtRunTime.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/AdjustingBrightness.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class AdjustingBrightness
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AdjustingBrightness

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"AdjustBrightness_out.tiff";

            using (var image = (PsdImage)Image.Load(sourceFile))
            {
                RasterCachedImage rasterImage = image;

                // Set the brightness value. The accepted values of brightness are in the range [-255, 255].
                rasterImage.AdjustBrightness(-50);

                TiffOptions tiffOptions = new TiffOptions(TiffExpectedFormat.Default);
                rasterImage.Save(destName, tiffOptions);
            }

            //ExEnd:AdjustingBrightness

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/AdjustingBrightness.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/AdjustingContrast.cs ---
﻿using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class AdjustingContrast
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AdjustingContrast

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"AdjustContrast_out.tiff";

            // Load an existing image into an instance of RasterImage class
            using (var image = Image.Load(sourceFile))
            {
                // Cast object of Image to RasterImage
                RasterImage rasterImage = (RasterImage)image;
                // Check if RasterImage is cached and Cache RasterImage for better performance
                if (!rasterImage.IsCached)
                {
                    rasterImage.CacheData();
                }

                // Adjust the contrast
                rasterImage.AdjustContrast(50);

                // Create an instance of TiffOptions for the resultant image, Set various properties for the object of TiffOptions and Save the resultant image to TIFF format
                TiffOptions tiffOptions = new TiffOptions(TiffExpectedFormat.Default);
                tiffOptions.BitsPerSample = new ushort[] { 8, 8, 8 };
                tiffOptions.Photometric = TiffPhotometrics.Rgb;
                rasterImage.Save(destName, tiffOptions);
            }


            //ExEnd:AdjustingContrast

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/AdjustingContrast.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/AdjustingGamma.cs ---
﻿using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class AdjustingGamma
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AdjustingGamma

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"AdjustGamma_out.tiff";

            // Load an existing image into an instance of RasterImage class
            using (var image = Image.Load(sourceFile))
            {
                // Cast object of Image to RasterImage
                RasterImage rasterImage = (RasterImage)image;

                // Check if RasterImage is cached and Cache RasterImage for better performance
                if (!rasterImage.IsCached)
                {
                    rasterImage.CacheData();
                }

                // Adjust the gamma
                rasterImage.AdjustGamma(2.2f, 2.2f, 2.2f);

                // Create an instance of TiffOptions for the resultant image,  Set various properties for the object of TiffOptions and Save the resultant image to TIFF format
                TiffOptions tiffOptions = new TiffOptions(TiffExpectedFormat.Default);
                tiffOptions.BitsPerSample = new ushort[] { 8, 8, 8 };
                tiffOptions.Photometric = TiffPhotometrics.Rgb;
                rasterImage.Save(destName, tiffOptions);

            }

            //ExEnd:AdjustingGamma

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/AdjustingGamma.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/BluranImage.cs ---
﻿using Aspose.PSD.ImageFilters.FilterOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class BluranImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:BluranImage

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"BlurAnImage_out.gif";

            // Load an existing image into an instance of RasterImage class
            using (var image = Image.Load(sourceFile))
            {
                // Convert the image into RasterImage, 
                //Pass Bounds[rectangle] of image and GaussianBlurFilterOptions instance to Filter method and Save the results
                RasterImage rasterImage = (RasterImage)image;

                rasterImage.Filter(rasterImage.Bounds, new GaussianBlurFilterOptions(15, 15));

                rasterImage.Save(destName, new GifOptions());
            }
            //ExEnd:BluranImage

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/BluranImage.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ColorBalanceAdjustment.cs ---
﻿using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ColorBalanceAdjustment
    {
        public static void Run()
        {
            // Add color overlay layer effect at runtime
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ColorBalanceAdjustmentLayer
            var filePath = dataDir + "ColorBalance.psd";
            var outputPath = dataDir + "ColorBalance_out.psd";
            using (var im = (FileFormats.Psd.PsdImage)Image.Load(filePath))
            {
                foreach (var layer in im.Layers)
                {
                    var cbLayer = layer as ColorBalanceAdjustmentLayer;
                    if (cbLayer != null)
                    {
                        cbLayer.ShadowsCyanRedBalance = 30;
                        cbLayer.ShadowsMagentaGreenBalance = -15;
                        cbLayer.ShadowsYellowBlueBalance = 40;
                        cbLayer.MidtonesCyanRedBalance = -90;
                        cbLayer.MidtonesMagentaGreenBalance = -25;
                        cbLayer.MidtonesYellowBlueBalance = 20;
                        cbLayer.HighlightsCyanRedBalance = -30;
                        cbLayer.HighlightsMagentaGreenBalance = 67;
                        cbLayer.HighlightsYellowBlueBalance = -95;
                        cbLayer.PreserveLuminosity = true;
                    }
                }

                im.Save(outputPath);
            }

            //ExEnd:ColorBalanceAdjustmentLayer

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ColorBalanceAdjustment.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ColorOverLayEffect.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ColorOverLayEffect
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ColorOverLayEffect

            // ColorOverlay effect editing
            string sourceFileName = dataDir + "ColorOverlay.psd";
            string psdPathAfterChange = dataDir + "ColorOverlayChanged.psd";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {

                var colorOverlay = (ColorOverlayEffect)(im.Layers[1].BlendingOptions.Effects[0]);

                if (colorOverlay.Color != Color.Red ||
                    colorOverlay.Opacity != 153)
                {
                    throw new Exception("Color overlay read wrong");
                }

                colorOverlay.Color = Color.Green;
                colorOverlay.Opacity = 128;

                im.Save(psdPathAfterChange);
            }
            //ExEnd:ColorOverLayEffect
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ColorOverLayEffect.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/CombiningImages.cs ---
﻿using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class CombiningImages
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_DrawingAndFormattingImages();

            //ExStart:CombiningImages

            // Create an instance of PsdOptions and set its various properties
            PsdOptions imageOptions = new PsdOptions();

            // Create an instance of FileCreateSource and assign it to Source property
            imageOptions.Source = new FileCreateSource(dataDir + "Two_images_result_out.psd", false);

            // Create an instance of Image and define canvas size
            using (var image = Image.Create(imageOptions, 600, 600))
            {
                // Create and initialize an instance of Graphics, Clear the image surface with white color and Draw Image
                var graphics = new Graphics(image);
                graphics.Clear(Color.White);
                graphics.DrawImage(Image.Load(dataDir + "example1.psd"), 0, 0, 300, 600);
                graphics.DrawImage(Image.Load(dataDir + "example2.psd"), 300, 0, 300, 600);
                image.Save();
            }


            //ExEnd:CombiningImages

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/CombiningImages.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/CreateXMPMetadata.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.Xmp;
using Aspose.PSD.Xmp.Schemas.DublinCore;
using Aspose.PSD.Xmp.Schemas.Photoshop;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class CreateXMPMetadata
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_DrawingAndFormattingImages();

            //ExStart:CreateXMPMetadata

            // Specify the size of image by defining a Rectangle 
            Rectangle rect = new Rectangle(0, 0, 100, 200);

            // Create the brand new image just for sample purposes
            using (var image = new PsdImage(rect.Width, rect.Height))
            {
                // Create an instance of XMP-Header
                XmpHeaderPi xmpHeader = new XmpHeaderPi(Guid.NewGuid().ToString());

                // Create an instance of Xmp-TrailerPi, XMPmeta class to set different attributes
                XmpTrailerPi xmpTrailer = new XmpTrailerPi(true);
                XmpMeta xmpMeta = new XmpMeta();
                xmpMeta.AddAttribute("Author", "Mr Smith");
                xmpMeta.AddAttribute("Description", "The fake metadata value");

                // Create an instance of XmpPacketWrapper that contains all metadata
                XmpPacketWrapper xmpData = new XmpPacketWrapper(xmpHeader, xmpTrailer, xmpMeta);

                // Create an instacne of Photoshop package and set photoshop attributes
                PhotoshopPackage photoshopPackage = new PhotoshopPackage();
                photoshopPackage.SetCity("London");
                photoshopPackage.SetCountry("England");
                photoshopPackage.SetColorMode(ColorMode.Rgb);
                photoshopPackage.SetCreatedDate(DateTime.UtcNow);

                // Add photoshop package into XMP metadata
                xmpData.AddPackage(photoshopPackage);

                // Create an instacne of DublinCore package and set dublinCore attributes
                DublinCorePackage dublinCorePackage = new DublinCorePackage();
                dublinCorePackage.SetAuthor("Mudassir Fayyaz");
                dublinCorePackage.SetTitle("Confessions of a Man Insane Enough to Live With the Beasts");
                dublinCorePackage.AddValue("dc:movie", "Barfly");

                // Add dublinCore Package into XMP metadata
                xmpData.AddPackage(dublinCorePackage);

                using (var ms = new MemoryStream())
                {
                    // Update XMP metadata into image and Save image on the disk or in memory stream
                    image.XmpData = xmpData;
                    image.Save(ms);
                    image.Save(dataDir + "ee.psd");
                    ms.Seek(0, System.IO.SeekOrigin.Begin);

                    // Load the image from memory stream or from disk to read/get the metadata
                    using (var img = (PsdImage)Image.Load(ms))
                    {
                        // Getting the XMP metadata
                        XmpPacketWrapper imgXmpData = img.XmpData;
                        foreach (XmpPackage package in imgXmpData.Packages)
                        {
                            // Use package data ...
                        }
                    }
                }
            }

            //ExEnd:CreateXMPMetadata

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/CreateXMPMetadata.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/CreatingUsingStream.cs ---
﻿using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class CreatingUsingStream
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_DrawingAndFormattingImages();

            //ExStart:CreatingUsingStream

            string desName = dataDir + "CreatingImageUsingStream_out.bmp";
            // Creates an instance of BmpOptions and set its various properties
            BmpOptions ImageOptions = new BmpOptions();
            ImageOptions.BitsPerPixel = 24;

            // Create an instance of System.IO.Stream
            Stream stream = new FileStream(dataDir + "sample_out.bmp", FileMode.Create);

            // Define the source property for the instance of BmpOptions Second boolean parameter determines if the Stream is disposed once get out of scope
            ImageOptions.Source = new StreamSource(stream, true);

            // Creates an instance of Image and call Create method by passing the BmpOptions object
            using (Image image = Image.Create(ImageOptions, 500, 500))
            {
                // Do some image processing
                image.Save(desName);
            }

            //ExEnd:CreatingUsingStream

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/CreatingUsingStream.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/CreatingbySettingPath.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class CreatingbySettingPath
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CreatingbySettingPath
            string desName = dataDir + "CreatingAnImageBySettingPath_out.psd";

            // Creates an instance of PsdOptions and set its various properties
            PsdOptions psdOptions = new PsdOptions();
            psdOptions.CompressionMethod = CompressionMethod.RLE;

            // Define the source property for the instance of PsdOptions. Second boolean parameter determines if the file is temporal or not
            psdOptions.Source = new FileCreateSource(desName, false);

            // Creates an instance of Image and call Create method by passing the PsdOptions object
            using (Image image = Image.Create(psdOptions, 500, 500))
            {
                image.Save();
            }

            //ExEnd:CreatingbySettingPath

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/CreatingbySettingPath.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/CroppingbyRectangle.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class CroppingbyRectangle
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CroppingbyRectangle

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"CroppingByRectangle_out.jpg";

            // Load an existing image into an instance of RasterImage class
            using (RasterImage rasterImage = (RasterImage)Image.Load(sourceFile))
            {
                if (!rasterImage.IsCached)
                {
                    rasterImage.CacheData();
                }

                // Create an instance of Rectangle class with desired size, 
                //Perform the crop operation on object of Rectangle class and Save the results to disk
                Rectangle rectangle = new Rectangle(20, 20, 20, 20);

                rasterImage.Crop(rectangle);
                rasterImage.Save(destName, new JpegOptions());
            }

            //ExEnd:CroppingbyRectangle

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/CroppingbyRectangle.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/DitheringforRasterImages.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class DitheringforRasterImages
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DitheringforRasterImages

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"SampleImage_out.bmp";

            // Load an existing image into an instance of RasterImage class
            using (var image = (PsdImage)Image.Load(sourceFile))
            {
                // Peform Floyd Steinberg dithering on the current image and Save the resultant image
                image.Dither(DitheringMethod.ThresholdDithering, 4);
                image.Save(destName, new BmpOptions());
            }

            //ExEnd:DitheringforRasterImages

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/DitheringforRasterImages.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ExpandandCropImages.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ExpandandCropImages
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_DrawingAndFormattingImages();

            //ExStart:ExpandandCropImages

            string sourceFile = dataDir + @"example1.psd";
            string destName = dataDir + @"jpeg_out.jpg";

            // Load an image in an instance of Image and Setting for image data to be cashed
            using (RasterImage rasterImage = (RasterImage)Image.Load(sourceFile))
            {
                rasterImage.CacheData();
                // Create an instance of Rectangle class and define X,Y and Width, height of the rectangle, and Save output image
                Rectangle destRect = new Rectangle { X = -200, Y = -200, Width = 300, Height = 300 };
                rasterImage.Save(destName, new JpegOptions(), destRect);
            }

            //ExEnd:ExpandandCropImages

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ExpandandCropImages.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/FontReplacement.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class FontReplacement
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output();

            //ExStart:FontReplacement

            string sourceFileName = Path.Combine(dataDir, "sample_konstanting.psd");

            string[] outputs = new string[]
            {
                "replacedfont0.tiff",
                "replacedfont1.png",
                "replacedfont2.jpg"
            };

            using (PsdImage image = (PsdImage)Image.Load(sourceFileName, new PsdLoadOptions() { AllowNonChangedLayerRepaint = true }))
            {
                // This way you can use different fonts for different outputs 
                image.Save(Path.Combine(outputFolder, outputs[0]), new TiffOptions(TiffExpectedFormat.TiffJpegRgb) { DefaultReplacementFont = "Arial" });
                image.Save(Path.Combine(outputFolder, outputs[1]), new PngOptions { DefaultReplacementFont = "Verdana" });
                image.Save(Path.Combine(outputFolder, outputs[2]), new JpegOptions { DefaultReplacementFont = "Times New Roman" });
            }
            //ExEnd:FontReplacement

            Console.WriteLine("FontReplacement executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/FontReplacement.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ForceFontCache.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using System;
using System.Threading;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ForceFontCache
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ForceFontCache
            // The path to the documents directory.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                image.Save("NoFont.psd");
            }

            Console.WriteLine("You have 2 minutes to install the font");
            Thread.Sleep(TimeSpan.FromMinutes(2));
            OpenTypeFontsCache.UpdateCache();

            using (PsdImage image = (PsdImage)Image.Load(dataDir + @"sample.psd"))
            {
                image.Save(dataDir + "HasFont.psd");
            }
            //ExEnd:ForceFontCache

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ForceFontCache.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ImplementBicubicResampler.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ImplementBicubicResampler
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:ImplementBicubicResampler
            string sourceFile = baseDir + "sample_bicubic.psd";
            string destNameCubicConvolution = outputDir + "ResamplerCubicConvolutionStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.CubicConvolution);
                image.Save(destNameCubicConvolution, new PsdOptions(image));
            }


            string destNameCatmullRom = outputDir + "ResamplerCatmullRomStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.CatmullRom);
                image.Save(destNameCatmullRom, new PsdOptions(image));
            }


            string destNameMitchell = outputDir + "ResamplerMitchellStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.Mitchell);
                image.Save(destNameMitchell, new PsdOptions(image));
            }


            string destNameCubicBSpline = outputDir + "ResamplerCubicBSplineStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.CubicBSpline);
                image.Save(destNameCubicBSpline, new PsdOptions(image));
            }


            string destNameSinC = outputDir + "ResamplerSinCStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.SinC);
                image.Save(destNameSinC, new PsdOptions(image));
            }


            string destNameBell = outputDir + "ResamplerBellStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.Bell);
                image.Save(destNameBell, new PsdOptions(image));
            }


            string destNameLanczos = outputDir + "ResamplerLanczosStripes_after.psd";

            // Load an existing image into an instance of PsdImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                image.Resize(300, 300, ResizeType.LanczosResample);
                image.Save(destNameLanczos, new PsdOptions(image));
            }


            //ExEnd:ImplementBicubicResampler
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ImplementBicubicResampler.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ImplementLossyGIFCompressor.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ImplementLossyGIFCompressor
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ImplementLossyGIFCompressor

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"anim_lossy-200.gif";

            GifOptions gifExport = new GifOptions();

            // Load an existing image into an instance of RasterImage class
            using (var image = Image.Load(sourceFile))
            {
                gifExport.MaxDiff = 80;
                image.Save("anim_lossy-80.gif", gifExport);
                gifExport.MaxDiff = 200;
                image.Save(destName, gifExport);
            }

            //ExEnd:ImplementLossyGIFCompressor

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ImplementLossyGIFCompressor.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/InvertAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class InvertAdjustmentLayer
    {
        public static void Run()
        {
            // Add color overlay layer effect at runtime
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:InvertARunExamples.er
            var filePath = dataDir + "InvertStripes_before.psd";
            var outputPath = dataDir + "InvertStripes_after.psd";
            using (var im = (PsdImage)Image.Load(filePath))
            {
                im.AddInvertAdjustmentLayer();
                im.Save(outputPath);
            }
            //ExEnd:InvertAdjustmentLayer


        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/InvertAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/PixelDataManipulation.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class PixelDataManipulation
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:PixelDataManipulation
            // Define input and output file paths
            string inputFile = Path.Combine(baseDir, "input.psd");
            string outputFile = Path.Combine(outputDir, "output.psd");
   
            // Open the input file as a stream
            using (FileStream stream = new FileStream(inputFile, FileMode.Open, FileAccess.Read))
            {
                // Load the PSD image
                using (PsdImage psdImage = (PsdImage)Image.Load(stream))
                {
                    // Create a new layer and add it to the PSD image
                    Layer layer = new Layer(psdImage);
                    psdImage.AddLayer(layer);
   
                    // Manipulate the pixel data
                    int[] pixels = layer.LoadArgb32Pixels(layer.Bounds);
                    for (int i = 0; i < pixels.Length; i++)
                    {
                        if (i % 5 == 0)
                        {
                            pixels[i] = 0xFF0000; // Example manipulation
                        }
                    }
                    layer.SaveArgb32Pixels(layer.Bounds, pixels);
   
                    // Save the PSD image
                    psdImage.Save(outputFile);
                }
            }
            //ExEnd:PixelDataManipulation

            File.Delete(outputFile);

            Console.WriteLine("PixelDataManipulation executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/PixelDataManipulation.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/RawColorClass.cs ---
using System;
using Aspose.PSD.FileFormats.Psd.Core.RawColor;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class RawColorClass
    {
        public static void Run()
        {
            //ExStart:RawColorClass
            //ExSummary:The following code demonstrates the support of RawColor class instead of obsolete Color struct.

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            var color = new RawColor(PixelDataFormat.Rgba32Bpp);
            var oldColor = Color.FromArgb(5, 1, 2, 3);

            var argbValue = oldColor.ToArgb();
            color.SetAsInt(argbValue);

            AssertAreEqual("ARGB", color.GetColorModeName());
            AssertAreEqual(32, color.GetBitDepth());
            AssertAreEqual("A Alpha", color.Components[0].FullName);
            AssertAreEqual(5, (int)color.Components[0].Value);
            AssertAreEqual("R Red", color.Components[1].FullName);
            AssertAreEqual(1, (int)color.Components[1].Value);
            AssertAreEqual("G Green", color.Components[2].FullName);
            AssertAreEqual(2, (int)color.Components[2].Value);
            AssertAreEqual("B Blue", color.Components[3].FullName);
            AssertAreEqual(3, (int)color.Components[3].Value);

            AssertAreEqual(argbValue, color.GetAsInt());


            //ExEnd:RawColorClass

            Console.WriteLine("RawColorClass executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/RawColorClass.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/RemoveFontCacheFile.cs ---
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class RemoveFontCacheFile
    {
        public static void Run()
        {
            //ExStart:RemoveFontCacheFile
            //ExSummary:The following code demonstrates method for removing file with cache of loaded fonts.
            
            FontSettings.RemoveFontCacheFile();

            //ExEnd:RemoveFontCacheFile

            Console.WriteLine("RemoveFontCacheFile executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/RemoveFontCacheFile.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/RenderingColorEffect.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class RenderingColorEffect
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingColorEffect
            string sourceFileName = dataDir + "ColorOverlay.psd";
            string pngExportPath = dataDir + "ColorOverlayresult.png";
            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            //using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                var colorOverlay = (ColorOverlayEffect)(im.Layers[1].BlendingOptions.Effects[0]);

                if (colorOverlay.Color != Color.Red ||
                    colorOverlay.Opacity != 153)
                {
                    throw new Exception("Color overlay read wrong");
                }

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }
        }
        //ExEnd:RenderingColorEffect
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/RenderingColorEffect.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/RenderingDropShadow.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class RenderingDropShadow
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingDropShadow
            string sourceFileName = dataDir + "Shadow.psd";
            string pngExportPath = dataDir + "Shadowchanged1.png";
            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))

            {
                var shadowEffect = (DropShadowEffect)(im.Layers[1].BlendingOptions.Effects[0]);

                if ((shadowEffect.Color != Color.Black) ||
                    (shadowEffect.Opacity != 255) ||
                    (shadowEffect.Distance != 3) ||
                    (shadowEffect.Size != 7) ||
                    (shadowEffect.UseGlobalLight != true) ||
                    (shadowEffect.Angle != 90) ||
                    (shadowEffect.Spread != 0) ||
                    (shadowEffect.Noise != 0))
                {
                    throw new Exception("Shadow Effect properties were read wrong");
                }

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }
        }
        //ExEnd:RenderingDropShadow
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/RenderingDropShadow.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/ResizeImageProportionally.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class ResizeImageProportionally
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ResizeImageProportionally

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"SimpleResizeImageProportionally_out.png";

            // Load an existing image into an instance of RasterImage class
            using (Image image = Image.Load(sourceFile))
            {
                if (!image.IsCached)
                {
                    image.CacheData();
                }
                // Specifying width and height
                int newWidth = image.Width / 2;
                image.ResizeWidthProportionally(newWidth);
                int newHeight = image.Height / 2;
                image.ResizeHeightProportionally(newHeight);
                image.Save(destName, new PngOptions());
            }


            //ExEnd:ResizeImageProportionally

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/ResizeImageProportionally.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/RotatinganImage.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class RotatinganImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RotatinganImage

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"RotatingAnImage_out.jpg";

            // Load an existing image into an instance of RasterImage class
            using (Image image = Image.Load(sourceFile))
            {
                image.RotateFlip(RotateFlipType.Rotate270FlipNone);
                image.Save(destName, new JpegOptions());
            }

            //ExEnd:RotatinganImage

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/RotatinganImage.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/RotatinganImageonaSpecificAngle.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class RotatinganImageonaSpecificAngle
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RotatinganImageonaSpecificAngle

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"RotatingImageOnSpecificAngle_out.jpg";

            // Load an image to be rotated in an instance of RasterImage
            using (RasterImage image = (RasterImage)Image.Load(sourceFile))
            {
                // Before rotation, the image should be cached for better performance
                if (!image.IsCached)
                {
                    image.CacheData();
                }
                // Perform the rotation on 20 degree while keeping the image size proportional with red background color and Save the result to a new file
                image.Rotate(20f, true, Color.Red);
                image.Save(destName, new JpegOptions());
            }

            //ExEnd:RotatinganImageonaSpecificAngle

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/RotatinganImageonaSpecificAngle.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportBlendModes.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class SupportBlendModes
    {

        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportBlendModes
            var files = new string[]
      {
           "Normal",
           "Dissolve",
           "Darken",
           "Multiply",
           "ColorBurn",
           "LinearBurn",
           "DarkerColor",
           "Lighten",
           "Screen",
           "ColorDodge",
           "LinearDodgeAdd",
           "LightenColor",
           "Overlay",
           "SoftLight",
           "HardLight",
           "VividLight",
           "LinearLight",
           "PinLight",
           "HardMix",
           "Difference",
           "Exclusion",
           "Subtract",
           "Divide",
            "Hue",
           "Saturation",
            "Color",
           "Luminosity",
            };

            foreach (var fileName in files)
            {

                using (var im = (PsdImage)Image.Load(dataDir + fileName + ".psd"))
                {
                    // Export to PNG
                    var saveOptions = new PngOptions();
                    saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                    var pngExportPath100 = "BlendMode" + fileName + "_Test100.png";
                    im.Save(pngExportPath100, saveOptions);

                    // Set opacity 50%
                    im.Layers[1].Opacity = 127;
                    var pngExportPath50 = "BlendMode" + fileName + "_Test50.png";
                    im.Save(pngExportPath50, saveOptions);
                }
            }
        }
        //ExEnd:SupportBlendModes

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportBlendModes.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfAreEffectsEnabledProperty.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class SupportOfAreEffectsEnabledProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfAreEffectsEnabledProperty
            //ExSummary:Demonstrates how to enable or disable layer effects using AreEffectsEnabled property.

            string srcFile = Path.Combine(baseDir, "2485.psd");
            string outputOnFile = Path.Combine(outputDir, "on_2485.png");
            string outputOffFile = Path.Combine(outputDir, "off_2485.png");

            using (var psdImage = (PsdImage)Image.Load(srcFile, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                psdImage.Save(outputOnFile);

                psdImage.Layers[1].BlendingOptions.AreEffectsEnabled = false;

                psdImage.Save(outputOffFile);
            }

            //ExEnd:SupportOfAreEffectsEnabledProperty

            File.Delete(outputOnFile);
            File.Delete(outputOffFile);

            Console.WriteLine("SupportOfAreEffectsEnabledProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfAreEffectsEnabledProperty.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfExportLayerWithEffects.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class SupportOfExportLayerWithEffects
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfExportLayerWithEffects
            //ExSummary:Demonstrates how to get a layer’s bounds with effects and export it with the correct size.

            string srcFile = Path.Combine(baseDir, "1958.psd");
            string outputFile = Path.Combine(outputDir, "out_1958.png");

            using (var psdImage = (PsdImage)Image.Load(srcFile, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                var layer1 = psdImage.Layers[1];

                var layerBoudns = layer1.Bounds;
                foreach (var effect in layer1.BlendingOptions.Effects)
                {
                    layerBoudns = Rectangle.Union(
                        layerBoudns,
                        effect.GetEffectBounds(layer1.Bounds, psdImage.GlobalAngle));
                }

                Rectangle boundsToExport = Rectangle.Empty; // The default value is to save only the layer with effects.
                // boundsToExport = psdImage.Bounds; // To save within the PsdImage bounds at the original layer location

                layer1.Save(
                    outputFile,
                    new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha },
                    boundsToExport);

                using (var imgStream = new FileStream(outputFile, FileMode.Open))
                {
                    var loadedLayer = new Layer(imgStream);
                    if (loadedLayer.Size == layerBoudns.Size)
                    {
                        System.Console.WriteLine("The size is calculated correctly.");
                    }
                }
            }

            //ExEnd:SupportOfExportLayerWithEffects

            File.Delete(outputFile);

            Console.WriteLine("SupportOfExportLayerWithEffects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfExportLayerWithEffects.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfMeSaSignature.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class SupportOfMeSaSignature
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfMeSaSignature
            //ExSummary:The next code example demonstrates ability to correct load and save PSD files with resources with MeSa signature.

            void AreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Values are not equal.");
                }
            }

            string srcFile = baseFolder + "GST-CHALLAN(2)1..psd";
            string output = outputFolder + "output.psd";

            using (PsdImage psdImage = (PsdImage)Image.Load(srcFile))
            {
                AreEqual(ResourceBlock.ResouceBlockMeSaSignature, psdImage.ImageResources[23].Signature);
                AreEqual(ResourceBlock.ResouceBlockMeSaSignature, psdImage.ImageResources[24].Signature);
                psdImage.Save(output);
            }

            //ExEnd:SupportOfMeSaSignature

            Console.WriteLine("SupportOfMeSaSignature executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfMeSaSignature.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfObArAndUnFlSignatures.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class SupportOfObArAndUnFlSignatures
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfObArAndUnFlSignatures
            //ExSummary:The following code demonstrates the support of the ObAr and UnFl signatures.

            void AssertAreEqual(object actual, object expected)
            {
                if (!object.Equals(actual, expected))
                {
                    throw new FormatException(string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            var sourceFilePath = baseFolder + "LayeredSmartObjects8bit2.psd";
            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
            {
                UnitArrayStructure verticalStructure = null;
                foreach (Layer imageLayer in image.Layers)
                {
                    foreach (var imageResource in imageLayer.Resources)
                    {
                        var resource = imageResource as PlLdResource;
                        if (resource != null && resource.IsCustom)
                        {
                            foreach (OSTypeStructure structure in resource.Items)
                            {
                                if (structure.KeyName.ClassName == "customEnvelopeWarp")
                                {
                                    AssertAreEqual(typeof(DescriptorStructure), structure.GetType());
                                    var custom = (DescriptorStructure)structure;
                                    AssertAreEqual(custom.Structures.Length, 1);
                                    var mesh = custom.Structures[0];
                                    AssertAreEqual(typeof(ObjectArrayStructure), mesh.GetType());
                                    var meshObjectArray = (ObjectArrayStructure)mesh;
                                    AssertAreEqual(meshObjectArray.Structures.Length, 2);
                                    var vertical = meshObjectArray.Structures[1];
                                    AssertAreEqual(typeof(UnitArrayStructure), vertical.GetType());
                                    verticalStructure = (UnitArrayStructure)vertical;
                                    AssertAreEqual(verticalStructure.UnitType, UnitTypes.Pixels);
                                    AssertAreEqual(verticalStructure.ValueCount, 16);

                                    break;
                                }
                            }
                        }
                    }
                }

                AssertAreEqual(true, verticalStructure != null);
            }

            //ExEnd:SupportOfObArAndUnFlSignatures

            Console.WriteLine("SupportOfObArAndUnFlSignatures executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfObArAndUnFlSignatures.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfOuterGlowEffect.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class SupportOfOuterGlowEffect
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfOuterGlowEffect
            //ExSummary:The following code demonstrates the OuterGlowEffect support.

            string src = Path.Combine(baseDir, "GreenLayer.psd");
            string outputPng = Path.Combine(outputDir, "output261.png");

            using (var image = (PsdImage)Image.Load(src))
            {
                OuterGlowEffect effect = image.Layers[1].BlendingOptions.AddOuterGlow();
                effect.Range = 10;
                effect.Spread = 10;
                ((IColorFillSettings)effect.FillColor).Color = Color.Red;
                effect.Opacity = 128;
                effect.BlendMode = BlendMode.Normal;

                image.Save(outputPng, new PngOptions());
            }

            //ExEnd:SupportOfOuterGlowEffect
            
            File.Delete(outputPng);
            
            Console.WriteLine("SupportOfOuterGlowEffect executed successfully");
        }
        
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportOfOuterGlowEffect.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportShadowEffect.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class SupportShadowEffect
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportShadowEffect
            string sourceFileName = dataDir + "Shadow.psd";
            string psdPathAfterChange = dataDir + "ShadowChanged.psd";
            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var shadowEffect = (DropShadowEffect)(im.Layers[1].BlendingOptions.Effects[0]);

                if ((shadowEffect.Color != Color.Black) ||
                    (shadowEffect.Opacity != 255) ||
                    (shadowEffect.Distance != 3) ||
                    (shadowEffect.Size != 7) ||
                    (shadowEffect.UseGlobalLight != true) ||
                    (shadowEffect.Angle != 90) ||
                    (shadowEffect.Spread != 0) ||
                    (shadowEffect.Noise != 0))
                {
                    throw new Exception("Shadow Effect was read wrong");
                }

                shadowEffect.Color = Color.Green;
                shadowEffect.Opacity = 128;
                shadowEffect.Distance = 11;
                shadowEffect.UseGlobalLight = false;
                shadowEffect.Size = 9;
                shadowEffect.Angle = 45;
                shadowEffect.Spread = 3;
                shadowEffect.Noise = 50;

                im.Save(psdPathAfterChange);
            }
            
            //ExEnd:SupportShadowEffect
            
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportShadowEffect.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportShadowEffectOpacity.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    public class SupportShadowEffectOpacity
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportShadowEffectOpacity
            //ExSummary:The following code demonstrates using the Opacity property of DropShadowEffect.
            
            string inputFile = Path.Combine(baseDir, "input.psd");
            string outputImage20 = Path.Combine(outputDir, "outputImage20.png");
            string outputImage200 = Path.Combine(outputDir, "outputImage200.png");

            using (PsdImage psdImage = (PsdImage)Image.Load(inputFile, new LoadOptions()))
            {
                Layer workLayer = psdImage.Layers[1];

                DropShadowEffect dropShadowEffect = workLayer.BlendingOptions.AddDropShadow();
                dropShadowEffect.Distance = 0;
                dropShadowEffect.Size = 8;

                // Example with Opacity = 20
                dropShadowEffect.Opacity = 20;
                psdImage.Save(outputImage20, new PngOptions());

                // Example with Opacity = 200
                dropShadowEffect.Opacity = 200;
                psdImage.Save(outputImage200, new PngOptions());
            }
            
            //ExEnd:SupportShadowEffectOpacity
            
            File.Delete(outputImage20);
            File.Delete(outputImage200);
            
            Console.WriteLine("SupportShadowEffectOpacity executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/SupportShadowEffectOpacity.cs ---

--- START OF FILE CSharp/Aspose/DrawingAndFormattingImages/VerifyImageTransparency.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages
{
    class VerifyImageTransparency
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:VerifyImageTransparency

            string sourceFile = dataDir + @"sample.psd";
            string destName = dataDir + @"AdjustBrightness_out.tiff";

            // Load an existing image into an instance of RasterImage class
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                float opacity = image.ImageOpacity;
                Console.WriteLine(opacity);
                if (opacity == 0)
                {
                    // The image is fully transparent.
                }
            }

            //ExEnd:VerifyImageTransparency

        }

    }
}
--- END OF FILE CSharp/Aspose/DrawingAndFormattingImages/VerifyImageTransparency.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddGradientEffects.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddGradientEffects
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddGradientEffects
            void AssertIsTrue(bool condition, string message = "Assertion fails")
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            // Gradient overlay effect. Example
            string sourceFileName = Path.Combine(SourceDir, "GradientOverlay.psd");
            string exportPath = Path.Combine(OutputDir, "GradientOverlayChanged.psd");

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var gradientOverlay = (GradientOverlayEffect)im.Layers[1].BlendingOptions.Effects[0];

                AssertIsTrue(gradientOverlay.BlendMode == BlendMode.Normal);
                AssertIsTrue(gradientOverlay.Opacity == 255);
                AssertIsTrue(gradientOverlay.IsVisible == true);

                var settings = (GradientFillSettings)gradientOverlay.Settings;
                var solidGradient = (SolidGradient)gradientOverlay.Settings.Gradient;
                AssertIsTrue(Color.Empty == solidGradient.Color);
                AssertIsTrue(settings.FillType == FillType.Gradient);
                AssertIsTrue(settings.AlignWithLayer == true);
                AssertIsTrue(settings.GradientType == GradientType.Linear);
                AssertIsTrue(Math.Abs(33 - settings.Angle) < 0.001, "Angle is incorrect");
                AssertIsTrue(settings.Dither == false);
                AssertIsTrue(Math.Abs(129 - settings.HorizontalOffset) < 0.001, "Horizontal offset is incorrect");
                AssertIsTrue(Math.Abs(156 - settings.VerticalOffset) < 0.001, "Vertical offset is incorrect");
                AssertIsTrue(settings.Reverse == false);

                // Color Points
                var colorPoints = solidGradient.ColorPoints;
                AssertIsTrue(colorPoints.Length == 3);

                AssertIsTrue(colorPoints[0].Color == Color.FromArgb(9, 0, 178));
                AssertIsTrue(colorPoints[0].Location == 0);
                AssertIsTrue(colorPoints[0].MedianPointLocation == 50);

                AssertIsTrue(colorPoints[1].Color == Color.Red);
                AssertIsTrue(colorPoints[1].Location == 2048);
                AssertIsTrue(colorPoints[1].MedianPointLocation == 50);

                AssertIsTrue(colorPoints[2].Color == Color.FromArgb(255, 252, 0));
                AssertIsTrue(colorPoints[2].Location == 4096);
                AssertIsTrue(colorPoints[2].MedianPointLocation == 50);

                // Transparency points
                var transparencyPoints = solidGradient.TransparencyPoints;
                AssertIsTrue(transparencyPoints.Length == 2);

                AssertIsTrue(transparencyPoints[0].Location == 0);
                AssertIsTrue(transparencyPoints[0].MedianPointLocation == 50);
                AssertIsTrue(transparencyPoints[0].Opacity == 100);

                AssertIsTrue(transparencyPoints[1].Location == 4096);
                AssertIsTrue(transparencyPoints[1].MedianPointLocation == 50);
                AssertIsTrue(transparencyPoints[1].Opacity == 100);

                // Test editing
                solidGradient.Color = Color.Green;

                gradientOverlay.Opacity = 193;
                gradientOverlay.BlendMode = BlendMode.Lighten;

                settings.AlignWithLayer = false;
                settings.GradientType = GradientType.Radial;
                settings.Angle = 45;
                settings.Dither = true;
                settings.HorizontalOffset = 15;
                settings.VerticalOffset = 11;
                settings.Reverse = true;

                // Add new color point
                var colorPoint = solidGradient.AddColorPoint();
                colorPoint.Color = Color.Green;
                colorPoint.Location = 4096;
                colorPoint.MedianPointLocation = 75;

                // Change location of previous point
                solidGradient.ColorPoints[2].Location = 3000;

                // Add new transparency point
                var transparencyPoint = solidGradient.AddTransparencyPoint();
                transparencyPoint.Opacity = 25;
                transparencyPoint.MedianPointLocation = 25;
                transparencyPoint.Location = 4096;

                // Change location of previous transparency point
                solidGradient.TransparencyPoints[1].Location = 2315;
                im.Save(exportPath);
            }

            // Test file after edit
            using (var im = (PsdImage)Image.Load(exportPath, loadOptions))
            {
                var gradientOverlay = (GradientOverlayEffect)im.Layers[1].BlendingOptions.Effects[0];
                try
                {
                    AssertIsTrue(gradientOverlay.BlendMode == BlendMode.Lighten);
                    AssertIsTrue(gradientOverlay.Opacity == 193);
                    AssertIsTrue(gradientOverlay.IsVisible == true);

                    var fillSettings = (GradientFillSettings)gradientOverlay.Settings;
                    var solidGradient = (SolidGradient)gradientOverlay.Settings.Gradient;

                    AssertIsTrue(Color.Empty == solidGradient.Color);

                    AssertIsTrue(fillSettings.FillType == FillType.Gradient);

                    // Check color points
                    AssertIsTrue(solidGradient.ColorPoints.Length == 4);

                    var point = solidGradient.ColorPoints[0];
                    AssertIsTrue(point.MedianPointLocation == 50);
                    AssertIsTrue(point.Color == Color.FromArgb(9, 0, 178));
                    AssertIsTrue(point.Location == 0);

                    point = solidGradient.ColorPoints[1];
                    AssertIsTrue(point.MedianPointLocation == 50);
                    AssertIsTrue(point.Color == Color.Red);
                    AssertIsTrue(point.Location == 2048);

                    point = solidGradient.ColorPoints[2];
                    AssertIsTrue(point.MedianPointLocation == 50);
                    AssertIsTrue(point.Color == Color.FromArgb(255, 252, 0));
                    AssertIsTrue(point.Location == 3000);

                    point = solidGradient.ColorPoints[3];
                    AssertIsTrue(point.MedianPointLocation == 75);
                    AssertIsTrue(point.Color == Color.Green);
                    AssertIsTrue(point.Location == 4096);

                    // Check transparent points
                    AssertIsTrue(solidGradient.TransparencyPoints.Length == 3);

                    var transparencyPoint = solidGradient.TransparencyPoints[0];
                    AssertIsTrue(transparencyPoint.MedianPointLocation == 50);
                    AssertIsTrue(transparencyPoint.Opacity == 100.0);
                    AssertIsTrue(transparencyPoint.Location == 0);

                    transparencyPoint = solidGradient.TransparencyPoints[1];
                    AssertIsTrue(transparencyPoint.MedianPointLocation == 50);
                    AssertIsTrue(transparencyPoint.Opacity == 100.0);
                    AssertIsTrue(transparencyPoint.Location == 2315);

                    transparencyPoint = solidGradient.TransparencyPoints[2];
                    AssertIsTrue(transparencyPoint.MedianPointLocation == 25);
                    AssertIsTrue(transparencyPoint.Opacity == 25.0);
                    AssertIsTrue(transparencyPoint.Location == 4096);
                }
                catch (Exception e)
                {
                    string ex = e.StackTrace;
                }
            }
            //ExEnd:AddGradientEffects

            File.Delete(exportPath);
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddGradientEffects.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddNewRegularLayerToPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddNewRegularLayerToPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddNewRegularLayerToPSD

            // Make ability to add the newly generated regular layer to PsdImage
            string sourceFileName = dataDir + "OneLayer.psd";
            string exportPath = dataDir + "OneLayerEdited.psd";
            string exportPathPng = dataDir + "OneLayerEdited.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                // Preparing two int arrays
                var data1 = new int[2500];
                var data2 = new int[2500];

                var rect1 = new Rectangle(0, 0, 50, 50);
                var rect2 = new Rectangle(0, 0, 100, 25);

                for (int i = 0; i < 2500; i++)
                {
                    data1[i] = -10000000;
                    data2[i] = -10000000;
                }

                var layer1 = im.AddRegularLayer();
                layer1.Left = 25;
                layer1.Top = 25;
                layer1.Right = 75;
                layer1.Bottom = 75;
                layer1.SaveArgb32Pixels(rect1, data1);

                var layer2 = im.AddRegularLayer();
                layer2.Left = 25;
                layer2.Top = 150;
                layer2.Right = 125;
                layer2.Bottom = 175;
                layer2.SaveArgb32Pixels(rect2, data2);

                // Save psd
                im.Save(exportPath, new PsdOptions());

                // Save png
                im.Save(exportPathPng, new PngOptions());
            }
            //ExEnd:AddNewRegularLayerToPSD
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddNewRegularLayerToPSD.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddPatternEffects.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageLoadOptions;
using System;
using Aspose.PSD.FileFormats.Core.Blending;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddPatternEffects
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddPatternEffects

            // Pattern overlay effect. Example
            string sourceFileName = Path.Combine(SourceDir, "PatternOverlay.psd");
            string exportPath = Path.Combine(OutputDir, "PatternOverlayChanged.psd");

            var newPattern = new int[]
            {
                 Color.Aqua.ToArgb(), Color.Red.ToArgb(), Color.Red.ToArgb(), Color.Aqua.ToArgb(),
                 Color.Aqua.ToArgb(), Color.White.ToArgb(), Color.White.ToArgb(), Color.Aqua.ToArgb(),
            };

            var newPatternBounds = new Rectangle(0, 0, 4, 2);
            var guid = Guid.NewGuid();
            var newPatternName = "$$$/Presets/Patterns/Pattern=Some new pattern name\0";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var patternOverlay = (PatternOverlayEffect)im.Layers[1].BlendingOptions.Effects[0];

                if ((patternOverlay.BlendMode != BlendMode.Normal) ||
                    (patternOverlay.Opacity != 127) ||
                    (patternOverlay.IsVisible != true)
                    )
                {
                    throw new Exception("Pattern overlay effect properties were read wrong");
                }

                var settings = patternOverlay.Settings;

                if ((settings.Color != Color.Empty) ||
                    (settings.FillType != FillType.Pattern) ||
                    (settings.PatternId != "85163837-EB9E-5B43-86FB-E6D5963EA29A".ToUpperInvariant()) ||
                    (settings.PatternName != "$$$/Presets/Patterns/OpticalSquares=Optical Squares") ||
                    (settings.PointType != null) ||
                    (Math.Abs(settings.Scale - 100) > 0.001) ||
                    (settings.Linked != true) ||
                    (Math.Abs(0 - settings.HorizontalOffset) > 0.001) ||
                    (Math.Abs(0 - settings.VerticalOffset) > 0.001))
                {
                    throw new Exception("Pattern overlay effect settings were read wrong");
                }

                // Test editing
                settings.Color = Color.Green;

                patternOverlay.Opacity = 193;
                patternOverlay.BlendMode = BlendMode.Difference;
                settings.HorizontalOffset = 15;
                settings.VerticalOffset = 11;

                settings.PatternName = newPatternName;
                settings.PatternId = guid.ToString();
                settings.PatternData = newPattern;
                settings.PatternWidth = newPatternBounds.Width;
                settings.PatternHeight = newPatternBounds.Height;
                
                im.Save(exportPath);
            }

            // Test file after edit
            using (var im = (PsdImage)Image.Load(exportPath, loadOptions))
            {
                var patternOverlay = (PatternOverlayEffect)im.Layers[1].BlendingOptions.Effects[0];
                try
                {
                    if ((patternOverlay.BlendMode != BlendMode.Difference) ||
                        (patternOverlay.Opacity != 193) ||
                        (patternOverlay.IsVisible != true))
                    {
                        throw new Exception("Pattern overlay effect properties were read wrong");
                    }

                    var fillSettings = patternOverlay.Settings;

                    if ((fillSettings.Color != Color.Empty) ||
                        (fillSettings.FillType != FillType.Pattern))
                    {
                        throw new Exception("Pattern overlay effect settings were read wrong");
                    }

                    PattResource resource = null;
                    foreach (var globalLayerResource in im.GlobalLayerResources)
                    {
                        if (globalLayerResource is PattResource)
                        {
                            resource = (PattResource)globalLayerResource;
                            break;
                        }
                    }

                    if (resource == null)
                    {
                        throw new Exception("PattResource not found");
                    }

                    // Check the pattern data
                    var patternData = resource.Patterns[1];

                    if ((newPatternBounds != new Rectangle(0, 0, patternData.Width, patternData.Height)) ||
                        (patternData.PatternId != guid.ToString().ToUpperInvariant()) ||
                        ((patternData.Name + "\0") != newPatternName)
                        )
                    {
                        throw new Exception("Pattern was set wrong");
                    }
                }
                catch (Exception e)
                {
                    string ex = e.StackTrace;
                }
            }
            //ExEnd:AddPatternEffects

            File.Delete(exportPath);
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddPatternEffects.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddSignatureToImage.cs ---
﻿using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddSignatureToImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddSignatureToImage

            // Create an instance of Image and load the primary image
            using (Image canvas = Image.Load(dataDir + "layers.psd"))
            {
                // Create another instance of Image and load the secondary image containing the signature graphics
                using (Image signature = Image.Load(dataDir + "sample.psd"))
                {
                    // Create an instance of Graphics class and initialize it using the object of the primary image
                    Graphics graphics = new Graphics(canvas);

                    // Call the DrawImage method while passing the instance of secondary image and appropriate location. The following snippet tries to draw the secondary image at the right bottom of the primary image
                    graphics.DrawImage(signature, new Point(canvas.Height - signature.Height, canvas.Width - signature.Width));
                    canvas.Save(dataDir + "AddSignatureToImage_out.png", new PngOptions());
                }
            }

            //ExEnd:AddSignatureToImage
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddSignatureToImage.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddStrokeLayer_Color.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using System;
using Aspose.PSD.FileFormats.Core.Blending;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddStrokeLayer_Color
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddStrokeLayer_Color

            // Stroke effect. FillType - Color. Example
            string sourceFileName = dataDir + "Stroke.psd";
            string exportPath = dataDir + "StrokeGradientChanged.psd";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var colorStroke = (StrokeEffect)im.Layers[1].BlendingOptions.Effects[0];

                if ((colorStroke.BlendMode != BlendMode.Normal) ||
                    (colorStroke.Opacity != 255) ||
                    (colorStroke.IsVisible != true))
                {
                    throw new Exception("Color stroke effect was read wrong");
                }

                var fillSettings = (ColorFillSettings)colorStroke.FillSettings;
                if ((fillSettings.Color != Color.Black) || (fillSettings.FillType != FillType.Color))
                {
                    throw new Exception("Color stroke effect settings were read wrong");
                }

                fillSettings.Color = Color.Yellow;

                colorStroke.Opacity = 127;
                colorStroke.BlendMode = BlendMode.Color;
                im.Save(exportPath);
            }

            // Test file after edit
            using (var im = (PsdImage)Image.Load(exportPath, loadOptions))
            {
                var colorStroke = (StrokeEffect)im.Layers[1].BlendingOptions.Effects[0];

                if ((colorStroke.BlendMode != BlendMode.Color) ||
                    (colorStroke.Opacity != 127) ||
                    (colorStroke.IsVisible != true))
                {
                    throw new Exception("Color stroke effect was read wrong");
                }

                var fillSettings = (ColorFillSettings)colorStroke.FillSettings;
                if ((fillSettings.Color != Color.Yellow) || (fillSettings.FillType != FillType.Color))
                {
                    throw new Exception("Color stroke effect settings were read wrong");
                }
            }
            //ExEnd:AddStrokeLayer_Color
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddStrokeLayer_Color.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddStrokeLayer_Gradient.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddStrokeLayer_Gradient
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddStrokeLayer_Gradient

            // Stroke effect. FillType - Gradient. Example
            void AssertIsTrue(bool condition, string message = "Assertion fails")
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            string sourceFileName = dataDir + "Stroke.psd";
            string exportPath = dataDir + "StrokeGradientChanged.psd";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var gradientStroke = (StrokeEffect)im.Layers[2].BlendingOptions.Effects[0];

                AssertIsTrue(gradientStroke.BlendMode == BlendMode.Normal);
                AssertIsTrue(gradientStroke.Opacity == 255);
                AssertIsTrue(gradientStroke.IsVisible);

                var fillSettings = (GradientFillSettings)gradientStroke.FillSettings;
                AssertIsTrue(fillSettings.FillType == FillType.Gradient);
                AssertIsTrue(fillSettings.AlignWithLayer);
                AssertIsTrue(fillSettings.GradientType == GradientType.Linear);
                AssertIsTrue(Math.Abs(90 - fillSettings.Angle) < 0.001, "Angle is incorrect");
                AssertIsTrue(fillSettings.Dither == false);
                AssertIsTrue(Math.Abs(0 - fillSettings.HorizontalOffset) < 0.001, "Horizontal offset is incorrect");
                AssertIsTrue(Math.Abs(0 - fillSettings.VerticalOffset) < 0.001, "Vertical offset is incorrect");
                AssertIsTrue(fillSettings.Reverse == false);

                // Color Points
                var solidGradient = (SolidGradient)fillSettings.Gradient;
                var colorPoints = solidGradient.ColorPoints;
                
                AssertIsTrue(colorPoints.Length == 2);

                AssertIsTrue(colorPoints[0].Color == Color.Black);
                AssertIsTrue(colorPoints[0].Location == 0);
                AssertIsTrue(colorPoints[0].MedianPointLocation == 50);

                AssertIsTrue(colorPoints[1].Color == Color.White);
                AssertIsTrue(colorPoints[1].Location == 4096);
                AssertIsTrue(colorPoints[1].MedianPointLocation == 50);

                // Transparency points
                var transparencyPoints = solidGradient.TransparencyPoints;
                AssertIsTrue(transparencyPoints.Length == 2);

                AssertIsTrue(transparencyPoints[0].Location == 0);
                AssertIsTrue(transparencyPoints[0].MedianPointLocation == 50);
                AssertIsTrue(transparencyPoints[0].Opacity == 100);

                AssertIsTrue(transparencyPoints[1].Location == 4096);
                AssertIsTrue(transparencyPoints[1].MedianPointLocation == 50);
                AssertIsTrue(transparencyPoints[1].Opacity == 100);

                // Test editing
                gradientStroke.Opacity = 127;
                gradientStroke.BlendMode = BlendMode.Color;

                fillSettings.AlignWithLayer = false;
                fillSettings.GradientType = GradientType.Radial;
                fillSettings.Angle = 45;
                fillSettings.Dither = true;
                fillSettings.HorizontalOffset = 15;
                fillSettings.VerticalOffset = 11;
                fillSettings.Reverse = true;

                // Add new color point
                var colorPoint = solidGradient.AddColorPoint();
                colorPoint.Color = Color.Green;
                colorPoint.Location = 4096;
                colorPoint.MedianPointLocation = 75;

                // Change location of previous point
                solidGradient.ColorPoints[1].Location = 1899;

                // Add new transparency point
                var transparencyPoint = solidGradient.AddTransparencyPoint();
                transparencyPoint.Opacity = 25;
                transparencyPoint.MedianPointLocation = 25;
                transparencyPoint.Location = 4096;

                // Change location of previous transparency point
                solidGradient.TransparencyPoints[1].Location = 2411;

                im.Save(exportPath);
            }

            // Test file after edit
            using (var im = (PsdImage)Image.Load(exportPath, loadOptions))
            {
                var gradientStroke = (StrokeEffect)im.Layers[2].BlendingOptions.Effects[0];

                if ((gradientStroke.BlendMode != BlendMode.Color) ||
                    (gradientStroke.Opacity != 127) ||
                    (gradientStroke.IsVisible != true))
                {
                    throw new Exception("Assertion of Gradient Stroke fails");
                }

                var fillSettings = (GradientFillSettings)gradientStroke.FillSettings;
                var solidGradient = (SolidGradient)fillSettings.Gradient;

                if (fillSettings.FillType != FillType.Gradient || solidGradient.ColorPoints.Length != 3)
                {
                    throw new Exception("Assertion fails");
                }

                // Check color points
                var point = solidGradient.ColorPoints[0];

                AssertIsTrue(point.MedianPointLocation == 50);
                AssertIsTrue(point.Color == Color.Black);
                AssertIsTrue(point.Location == 0);

                point = solidGradient.ColorPoints[1];
                AssertIsTrue(point.MedianPointLocation == 50);
                AssertIsTrue(point.Color == Color.White);
                AssertIsTrue(point.Location == 1899);

                point = solidGradient.ColorPoints[2];
                AssertIsTrue(point.MedianPointLocation == 75);
                AssertIsTrue(point.Color == Color.Green);
                AssertIsTrue(point.Location == 4096);

                // Check transparent points
                AssertIsTrue(solidGradient.TransparencyPoints.Length == 3);

                var transparencyPoint = solidGradient.TransparencyPoints[0];
                AssertIsTrue(transparencyPoint.MedianPointLocation == 50);
                AssertIsTrue(transparencyPoint.Opacity == 100);
                AssertIsTrue(transparencyPoint.Location == 0);

                transparencyPoint = solidGradient.TransparencyPoints[1];
                AssertIsTrue(transparencyPoint.MedianPointLocation == 50);
                AssertIsTrue(transparencyPoint.Opacity == 100);
                AssertIsTrue(transparencyPoint.Location == 2411);

                transparencyPoint = solidGradient.TransparencyPoints[2];
                AssertIsTrue(transparencyPoint.MedianPointLocation == 25);
                AssertIsTrue(transparencyPoint.Opacity == 25);
                AssertIsTrue(transparencyPoint.Location == 4096);
            }
            //ExEnd:AddStrokeLayer_Gradient
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddStrokeLayer_Gradient.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/AddStrokeLayer_Pattern.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageLoadOptions;
using System;
using Aspose.PSD.FileFormats.Core.Blending;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class AddStrokeLayer_Pattern
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddStrokeLayer_Pattern

            // Stroke effect. FillType - Pattern. Example
            string sourceFileName = Path.Combine(SourceDir, "Stroke.psd");
            string exportPath = Path.Combine(OutputDir, "StrokePatternChanged.psd");

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            // Preparing new data
            var newPattern = new int[]
            {
              Color.Aqua.ToArgb(), Color.Red.ToArgb(), Color.Red.ToArgb(), Color.Aqua.ToArgb(),
              Color.Aqua.ToArgb(), Color.White.ToArgb(), Color.White.ToArgb(), Color.Aqua.ToArgb(),
              Color.Aqua.ToArgb(), Color.White.ToArgb(), Color.White.ToArgb(), Color.Aqua.ToArgb(),
              Color.Aqua.ToArgb(), Color.Red.ToArgb(), Color.Red.ToArgb(), Color.Aqua.ToArgb(),
            };

            var newPatternBounds = new Rectangle(0, 0, 4, 4);
            var guid = Guid.NewGuid();

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                var patternStroke = (StrokeEffect)im.Layers[3].BlendingOptions.Effects[0];
                var fillSettings = (PatternFillSettings)patternStroke.FillSettings;

                if ((patternStroke.BlendMode != BlendMode.Normal) ||
                    (patternStroke.Opacity != 255) ||
                    (patternStroke.IsVisible != true) ||
                    (fillSettings.FillType != FillType.Pattern))
                {
                    throw new Exception("Pattern effect properties were read wrong");
                }

                patternStroke.Opacity = 127;
                patternStroke.BlendMode = BlendMode.Color;

                PattResource resource;
                foreach (var globalLayerResource in im.GlobalLayerResources)
                {
                    if (globalLayerResource is PattResource)
                    {
                        resource = (PattResource)globalLayerResource;
                        var patternData = resource.Patterns[0];
                        patternData.PatternId = guid.ToString();
                        patternData.Name = "$$$/Presets/Patterns/HorizontalLine1=Horizontal Line 9";

                        patternData.SetPattern(newPattern, newPatternBounds);
                    }
                }

                var settings = (PatternFillSettings) patternStroke.FillSettings;
                settings.PatternName = "$$$/Presets/Patterns/HorizontalLine1=Horizontal Line 9";
                settings.PatternId = guid.ToString();

                settings.PatternData = newPattern;
                settings.PatternWidth = newPatternBounds.Width;
                settings.PatternHeight = newPatternBounds.Height;
                
                im.Save(exportPath);
            }

            // Test file after edit
            using (var im = (PsdImage)Image.Load(exportPath, loadOptions))
            {
                var patternStroke = (StrokeEffect)im.Layers[3].BlendingOptions.Effects[0];

                PattResource resource = null;
                foreach (var globalLayerResource in im.GlobalLayerResources)
                {
                    if (globalLayerResource is PattResource)
                    {
                        resource = (PattResource)globalLayerResource;
                    }
                }

                if (resource == null)
                {
                    throw new Exception("PattResource not found");
                }

                try
                {
                    // Check the pattern data
                    var fillSettings = (PatternFillSettings)patternStroke.FillSettings;
                    var patternData = resource.Patterns[0];

                    if ((newPatternBounds != new Rectangle(0, 0, patternData.Width, patternData.Height)) ||
                        (patternData.PatternId != guid.ToString().ToUpperInvariant()) ||
                        (patternStroke.BlendMode != BlendMode.Color) ||
                        (patternStroke.Opacity != 127) ||
                        (patternStroke.IsVisible != true) ||
                        (fillSettings.FillType != FillType.Pattern))
                    {
                        throw new Exception("Pattern stroke effect properties were read wrong");
                    }
                }
                catch (Exception e)
                {
                    string ex = e.StackTrace;
                }
            }

            //ExEnd:AddStrokeLayer_Pattern

            File.Delete(exportPath);
        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/AddStrokeLayer_Pattern.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/CoreDrawingFeatures.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class CoreDrawingFeatures
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CoreDrawingFeatures
            // Create an instance of BmpOptions and set its various properties
            string loadpath = dataDir + "sample.psd";
            string outpath = dataDir + "CoreDrawingFeatures.bmp";
            // Create an instance of Image
            using (PsdImage image = new PsdImage(loadpath))
            {
                // load pixels
                var pixels = image.LoadArgb32Pixels(new Rectangle(0, 0, 100, 10));

                for (int i = 0; i < pixels.Length; i++)
                {
                    // specify pixel color value (gradient in this case).
                    pixels[i] = i;
                }

                // save modified pixels.
                image.SaveArgb32Pixels(new Rectangle(0, 0, 100, 10), pixels);

                // export image to bmp file format.
                image.Save(outpath, new BmpOptions());
            }

            //ExEnd:CoreDrawingFeatures

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/CoreDrawingFeatures.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingArc.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingArc
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingArc
            // Create an instance of BmpOptions and set its various properties
            string outpath = dataDir + "Arc.bmp";
            // Create an instance of BmpOptions and set its various properties
            BmpOptions saveOptions = new BmpOptions();
            saveOptions.BitsPerPixel = 32;

            // Create an instance of Image
            using (Image image = new PsdImage(100, 100))
            {
                // Create and initialize an instance of Graphics class and clear Graphics surface
                Graphics graphic = new Graphics(image);
                graphic.Clear(Color.Yellow);

                // Draw an arc shape by specifying the Pen object having red black color and coordinates, height, width, start & end angles                 
                int width = 100;
                int height = 200;
                int startAngle = 45;
                int sweepAngle = 270;

                // Draw arc to screen and save all changes.
                graphic.DrawArc(new Pen(Color.Black), 0, 0, width, height, startAngle, sweepAngle);

                // export image to bmp file format.
                image.Save(outpath, saveOptions);
            }

            //ExEnd:DrawingArc

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingArc.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingBezier.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingBezier
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingBezier
            // Create an instance of BmpOptions and set its various properties
            string outpath = dataDir + "Bezier.bmp";
            // Create an instance of BmpOptions and set its various properties
            BmpOptions saveOptions = new BmpOptions();
            saveOptions.BitsPerPixel = 32;

            // Create an instance of Image
            using (Image image = new PsdImage(100, 100))
            {
                // Create and initialize an instance of Graphics class and clear Graphics surface
                Graphics graphic = new Graphics(image);
                graphic.Clear(Color.Yellow);

                // Initializes the instance of PEN class with black color and width
                Pen BlackPen = new Pen(Color.Black, 3);
                float startX = 10;
                float startY = 25;
                float controlX1 = 20;
                float controlY1 = 5;
                float controlX2 = 55;
                float controlY2 = 10;
                float endX = 90;
                float endY = 25;

                // Draw a Bezier shape by specifying the Pen object having black color and co-ordinate Points and save all changes.
                graphic.DrawBezier(BlackPen, startX, startY, controlX1, controlY1, controlX2, controlY2, endX, endY);

                // export image to bmp file format.
                image.Save(outpath, saveOptions);
            }

            //ExEnd:DrawingBezier

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingBezier.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingEllipse.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingEllipse
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingEllipse
            // Create an instance of BmpOptions and set its various properties
            string outpath = dataDir + "Ellipse.bmp";
            // Create an instance of BmpOptions and set its various properties
            BmpOptions saveOptions = new BmpOptions();
            saveOptions.BitsPerPixel = 32;

            // Create an instance of Image
            using (Image image = new PsdImage(100, 100))
            {
                // Create and initialize an instance of Graphics class and Clear Graphics surface                    
                Graphics graphic = new Graphics(image);
                graphic.Clear(Color.Yellow);

                // Draw a dotted ellipse shape by specifying the Pen object having red color and a surrounding Rectangle
                graphic.DrawEllipse(new Pen(Color.Red), new Rectangle(30, 10, 40, 80));

                // Draw a continuous ellipse shape by specifying the Pen object having solid brush with blue color and a surrounding Rectangle
                graphic.DrawEllipse(new Pen(new SolidBrush(Color.Blue)), new Rectangle(10, 30, 80, 40));

                // export image to bmp file format.
                image.Save(outpath, saveOptions);
            }

            //ExEnd:DrawingEllipse

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingEllipse.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingLines.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingLines
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingLines
            // Create an instance of BmpOptions and set its various properties
            string outpath = dataDir + "Lines.bmp";
            BmpOptions saveOptions = new BmpOptions();
            saveOptions.BitsPerPixel = 32;

            // Create an instance of Image
            using (Image image = new PsdImage(100, 100))
            {
                // Create and initialize an instance of Graphics class and Clear Graphics surface
                Graphics graphic = new Graphics(image);
                graphic.Clear(Color.Yellow);

                // Draw two dotted diagonal lines by specifying the Pen object having blue color and co-ordinate Points
                graphic.DrawLine(new Pen(Color.Blue), 9, 9, 90, 90);
                graphic.DrawLine(new Pen(Color.Blue), 9, 90, 90, 9);

                // Draw a four continuous line by specifying the Pen object having Solid Brush with red color and two point structures
                graphic.DrawLine(new Pen(new SolidBrush(Color.Red)), new Point(9, 9), new Point(9, 90));
                graphic.DrawLine(new Pen(new SolidBrush(Color.Aqua)), new Point(9, 90), new Point(90, 90));
                graphic.DrawLine(new Pen(new SolidBrush(Color.Black)), new Point(90, 90), new Point(90, 9));
                graphic.DrawLine(new Pen(new SolidBrush(Color.White)), new Point(90, 9), new Point(9, 9));
                image.Save(outpath, saveOptions);
            }

            //ExEnd:DrawingLines

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingLines.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingRectangle.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingRectangle
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingRectangle
            // Create an instance of BmpOptions and set its various properties
            string outpath = dataDir + "Rectangle.bmp";
            // Create an instance of BmpOptions and set its various properties
            BmpOptions saveOptions = new BmpOptions();
            saveOptions.BitsPerPixel = 32;

            // Create an instance of Image
            using (Image image = new PsdImage(100, 100))
            {
                // Create and initialize an instance of Graphics class,  Clear Graphics surface, Draw a rectangle shapes and  save all changes.
                Graphics graphic = new Graphics(image);
                graphic.Clear(Color.Yellow);
                graphic.DrawRectangle(new Pen(Color.Red), new Rectangle(30, 10, 40, 80));
                graphic.DrawRectangle(new Pen(new SolidBrush(Color.Blue)), new Rectangle(10, 30, 80, 40));

                // export image to bmp file format.
                image.Save(outpath, saveOptions);
            }

            //ExEnd:DrawingRectangle

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingRectangle.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingUsingGraphics.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingUsingGraphics
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingUsingGraphics

            // Create an instance of Image
            using (PsdImage image = new PsdImage(500, 500))
            {
                var graphics = new Graphics(image);

                // Clear the image surface with white color and Create and initialize a Pen object with blue color
                graphics.Clear(Color.White);
                var pen = new Pen(Color.Blue);

                // Draw Ellipse by defining the bounding rectangle of width 150 and height 100 also Draw a polygon using the LinearGradientBrush
                graphics.DrawEllipse(pen, new Rectangle(10, 10, 150, 100));
                using (var linearGradientBrush = new LinearGradientBrush(image.Bounds, Color.Red, Color.White, 45f))
                {
                    graphics.FillPolygon(linearGradientBrush, new[] { new Point(200, 200), new Point(400, 200), new Point(250, 350) });
                }

                // export modified image.
                image.Save(dataDir + "DrawingUsingGraphics_output.bmp", new BmpOptions());
            }


            //ExEnd:DrawingUsingGraphics

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingUsingGraphics.cs ---

--- START OF FILE CSharp/Aspose/DrawingImages/DrawingUsingGraphicsPath.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.Shapes;
using System;

namespace Aspose.PSD.Examples.Aspose.DrawingImages
{
    class DrawingUsingGraphicsPath
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DrawingUsingGraphicsPath

            // Create an instance of Image and initialize an instance of Graphics
            using (PsdImage image = new PsdImage(500, 500))
            {
                // create graphics surface.
                Graphics graphics = new Graphics(image);
                graphics.Clear(Color.White);

                // Create an instance of GraphicsPath and Instance of Figure, add EllipseShape, RectangleShape and TextShape to the figure
                GraphicsPath graphicspath = new GraphicsPath();
                Figure figure = new Figure();
                figure.AddShape(new EllipseShape(new RectangleF(0, 0, 499, 499)));
                figure.AddShape(new RectangleShape(new RectangleF(0, 0, 499, 499)));
                figure.AddShape(new TextShape("Aspose.PSD", new RectangleF(170, 225, 170, 100), new Font("Arial", 20), StringFormat.GenericTypographic));
                graphicspath.AddFigures(new[] { figure });
                graphics.DrawPath(new Pen(Color.Blue), graphicspath);

                // Create an instance of HatchBrush and set its properties also Fill path by supplying the brush and GraphicsPath objects
                HatchBrush hatchbrush = new HatchBrush();
                hatchbrush.BackgroundColor = Color.Brown;
                hatchbrush.ForegroundColor = Color.Blue;
                hatchbrush.HatchStyle = HatchStyle.Vertical;
                graphics.FillPath(hatchbrush, graphicspath);
                image.Save(dataDir + "DrawingUsingGraphicsPath_output.psd");
                Console.WriteLine("Processing completed successfully.");
            }

            //ExEnd:DrawingUsingGraphicsPath

        }
    }
}
--- END OF FILE CSharp/Aspose/DrawingImages/DrawingUsingGraphicsPath.cs ---

--- START OF FILE CSharp/Aspose/FillLayers/AddingFillLayerAtRuntime.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.FillLayers
{
    class AddingFillLayerAtRuntime
    {
        public static void Run()
        {
            // The path to the documents directory.
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddingFillLayerAtRuntime            
            //ExSummary:The following example demonstrates how to add the FillLayer type layer at runtime.
            string outputFilePath = Path.Combine(OutputDir, "output.psd");

            using (var image = new PsdImage(100, 100))
            {
                FillLayer colorFillLayer = FillLayer.CreateInstance(FillType.Color);
                colorFillLayer.DisplayName = "Color Fill Layer";
                image.AddLayer(colorFillLayer);

                FillLayer gradientFillLayer = FillLayer.CreateInstance(FillType.Gradient);
                gradientFillLayer.DisplayName = "Gradient Fill Layer";
                image.AddLayer(gradientFillLayer);

                FillLayer patternFillLayer = FillLayer.CreateInstance(FillType.Pattern);
                patternFillLayer.DisplayName = "Pattern Fill Layer";
                patternFillLayer.Opacity = 50;
                image.AddLayer(patternFillLayer);

                image.Save(outputFilePath);
            }

            //ExEnd:AddingFillLayerAtRuntime
            Console.WriteLine("AddingFillLayerAtRuntime executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/FillLayers/AddingFillLayerAtRuntime.cs ---

--- START OF FILE CSharp/Aspose/FillLayers/RotatePatternSupport.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.FillLayers
{
    public class RotatePatternSupport
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:RotatePatternSupport
            //ExSummary:The following code demonstrates support of Angle property in PtFlResource.
            
            string sourceFile = Path.Combine(baseDir, "PatternFillLayerWide_0.psd");
            string outputFile = Path.Combine(outputDir, "PatternFillLayerWide_0_output.psd");

            using (PsdImage image = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions { LoadEffectsResource = true }))
            {
                FillLayer fillLayer = (FillLayer)image.Layers[1];
                PatternFillSettings fillSettings = (PatternFillSettings)fillLayer.FillSettings;
                fillSettings.Angle = 70;
                fillLayer.Update();
                image.Save(outputFile, new PsdOptions());
            }

            using (PsdImage image = (PsdImage)Image.Load(outputFile, new PsdLoadOptions { LoadEffectsResource = true }))
            {
                FillLayer fillLayer = (FillLayer)image.Layers[1];
                PatternFillSettings fillSettings = (PatternFillSettings)fillLayer.FillSettings;
                AssertAreEqual(70, fillSettings.Angle);
            }
            
            void AssertAreEqual(double expected, double actual)
            {
                if (expected != actual)
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            //ExEnd:RotatePatternSupport
            
            File.Delete(outputFile);

            Console.WriteLine("RotatePatternSupport executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/FillLayers/RotatePatternSupport.cs ---

--- START OF FILE CSharp/Aspose/GlobalResources/SupportOfBackgroundColorResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.GlobalResources
{
    class SupportOfBackgroundColorResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfBackgroundColorResource
            //ExSummary:The following example demonstrates the support of BackgroundColorResource resource.
            string sourceFilePath = Path.Combine(SourceDir, "BackgroundColorResourceInput.psd");
            string outputFilePath = Path.Combine(OutputDir, "BackgroundColorResourceOutput.psd");

            using (var image = (PsdImage)Image.Load(sourceFilePath))
            {
                ResourceBlock[] imageResources = image.ImageResources;
                BackgroundColorResource backgroundColorResource = null;
                foreach (var imageResource in imageResources)
                {
                    if (imageResource is BackgroundColorResource)
                    {
                        backgroundColorResource = (BackgroundColorResource)imageResource;
                        break;
                    }
                }

                // update BackgroundColorResource
                backgroundColorResource.Color = Color.DarkRed;

                image.Save(outputFilePath);
            }

            //ExEnd:SupportOfBackgroundColorResource
            Console.WriteLine("SupportOfBackgroundColorResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/GlobalResources/SupportOfBackgroundColorResource.cs ---

--- START OF FILE CSharp/Aspose/GlobalResources/SupportOfBorderInformationResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using Aspose.PSD.FileFormats.Psd.Resources.ResolutionEnums;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.GlobalResources
{
    class SupportOfBorderInformationResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart
            //ExSummary:The following example demonstrates the support of BorderInformationResource resource.

            string sourceFilePath = Path.Combine(SourceDir, "BorderInformationResourceInput.psd");
            string outputFilePath = Path.Combine(OutputDir, "BorderInformationResourceOutput.psd");

            using (var image = (PsdImage)Image.Load(sourceFilePath))
            {
                ResourceBlock[] imageResources = image.ImageResources;
                BorderInformationResource borderInfoResource = null;
                foreach (var imageResource in imageResources)
                {
                    if (imageResource is BorderInformationResource)
                    {
                        borderInfoResource = (BorderInformationResource)imageResource;
                        break;
                    }
                }

                // update BorderInformationResource
                borderInfoResource.Width = 0.1;
                borderInfoResource.Unit = PhysicalUnit.Inches;

                image.Save(outputFilePath);
            }

            //ExEnd
            Console.WriteLine("SupportOfBackgroundColorResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/GlobalResources/SupportOfBorderInformationResource.cs ---

--- START OF FILE CSharp/Aspose/GlobalResources/SupportOfWorkingPathResource.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;

namespace Aspose.PSD.Examples.Aspose.GlobalResources
{
    class SupportOfWorkingPathResource
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfWorkingPathResource
            //ExSummary:This example demonstrates the support of 'WorkingPathResource' resource in PsdImage.ImageResources fo correct working of Crop operation.

            string sourceFile = Path.Combine(baseFolder, "WorkingPathResourceInput.psd");
            string outputFile = Path.Combine(outputFolder, "WorkingPathResourceOutput.psd");

            // Crop image and save.
            using (var psdImage = (PsdImage)Image.Load(sourceFile))
            {
                // Search WorkingPathResource resource.
                ResourceBlock[] imageResources = psdImage.ImageResources;
                WorkingPathResource workingPathResource = null;
                foreach (var imageResource in imageResources)
                {
                    if (imageResource is WorkingPathResource)
                    {
                        workingPathResource = (WorkingPathResource)imageResource;
                        break;
                    }
                }
                BezierKnotRecord record = workingPathResource.Paths[3] as BezierKnotRecord;

                if (record.Points[0].X != 2572506 || record.Points[0].Y != 8535408)
                {
                    throw new Exception("Values is incorrect.");
                }

                // Crop and save.
                psdImage.Crop(0, 500, 0, 200);
                psdImage.Save(outputFile);
            }

            // Load saved image and check the changes.
            using (var psdImage = (PsdImage)Image.Load(outputFile))
            {
                // Search WorkingPathResource resource.
                ResourceBlock[] imageResources = psdImage.ImageResources;
                WorkingPathResource workingPathResource = null;
                foreach (var imageResource in imageResources)
                {
                    if (imageResource is WorkingPathResource)
                    {
                        workingPathResource = (WorkingPathResource)imageResource;
                        break;
                    }
                }
                BezierKnotRecord record = workingPathResource.Paths[3] as BezierKnotRecord;

                if (record.Points[0].X != 4630510 || record.Points[0].Y != 22761088)
                {
                    throw new Exception("Values is incorrect.");
                }
            }

            //ExEnd:SupportOfWorkingPathResource

            Console.WriteLine("SupportOfWorkingPathResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/GlobalResources/SupportOfWorkingPathResource.cs ---

--- START OF FILE CSharp/Aspose/LayerEffects/AddStrokeEffect.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerEffects
{
    class AddStrokeEffect
    {
        public static void Run()
        {
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddStrokeEffect
            //ExSummary:This example demonstrates the ability to add the stroke effect with different types of fill like Color, Gradient or Pattern.

            string srcFile = Path.Combine(SourceDir, "AddStrokeEffect.psd");
            string outputFilePng = Path.Combine(OutputDir, "AddStrokeEffect.png");

            using (var psdImage = (PsdImage)Image.Load(srcFile, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                StrokeEffect strokeEffect;
                IColorFillSettings colorFillSettings;
                IGradientFillSettings gradientFillSettings;
                IPatternFillSettings patternFillSettings;

                // 1. Adds Color fill, at position Inside
                strokeEffect = psdImage.Layers[1].BlendingOptions.AddStroke(FillType.Color);
                strokeEffect.Size = 7;
                strokeEffect.Position = StrokePosition.Inside;
                colorFillSettings = strokeEffect.FillSettings as IColorFillSettings;
                colorFillSettings.Color = Color.Green;

                // 2. Adds Color fill, at position Outside
                strokeEffect = psdImage.Layers[2].BlendingOptions.AddStroke(FillType.Color);
                strokeEffect.Size = 7;
                strokeEffect.Position = StrokePosition.Outside;
                colorFillSettings = strokeEffect.FillSettings as IColorFillSettings;
                colorFillSettings.Color = Color.Green;

                // 3. Adds Color fill, at position Center
                strokeEffect = psdImage.Layers[3].BlendingOptions.AddStroke(FillType.Color);
                strokeEffect.Size = 7;
                strokeEffect.Position = StrokePosition.Center;
                colorFillSettings = strokeEffect.FillSettings as IColorFillSettings;
                colorFillSettings.Color = Color.Green;

                // 4. Adds Gradient fill, at position Inside
                strokeEffect = psdImage.Layers[4].BlendingOptions.AddStroke(FillType.Gradient);
                strokeEffect.Size = 5;
                strokeEffect.Position = StrokePosition.Inside;
                gradientFillSettings = strokeEffect.FillSettings as IGradientFillSettings;
                gradientFillSettings.AlignWithLayer = false;
                gradientFillSettings.Angle = 90;

                // 5. Adds Gradient fill, at position Outside
                strokeEffect = psdImage.Layers[5].BlendingOptions.AddStroke(FillType.Gradient);
                strokeEffect.Size = 5;
                strokeEffect.Position = StrokePosition.Outside;
                gradientFillSettings = strokeEffect.FillSettings as IGradientFillSettings;
                gradientFillSettings.AlignWithLayer = true;
                gradientFillSettings.Angle = 90;

                // 6. Adds Gradient fill, at position Center
                strokeEffect = psdImage.Layers[6].BlendingOptions.AddStroke(FillType.Gradient);
                strokeEffect.Size = 5;
                strokeEffect.Position = StrokePosition.Center;
                gradientFillSettings = strokeEffect.FillSettings as IGradientFillSettings;
                gradientFillSettings.AlignWithLayer = true;
                gradientFillSettings.Angle = 0;

                // 7. Adds Pattern fill, at position Inside
                strokeEffect = psdImage.Layers[7].BlendingOptions.AddStroke(FillType.Pattern);
                strokeEffect.Size = 5;
                strokeEffect.Position = StrokePosition.Inside;
                patternFillSettings = strokeEffect.FillSettings as IPatternFillSettings;
                patternFillSettings.Scale = 200;

                // 8. Adds Pattern fill, at position Outside
                strokeEffect = psdImage.Layers[8].BlendingOptions.AddStroke(FillType.Pattern);
                strokeEffect.Size = 10;
                strokeEffect.Position = StrokePosition.Outside;
                patternFillSettings = strokeEffect.FillSettings as IPatternFillSettings;
                patternFillSettings.Scale = 100;

                // 9. Adds Pattern fill, at position Center
                strokeEffect = psdImage.Layers[9].BlendingOptions.AddStroke(FillType.Pattern);
                strokeEffect.Size = 10;
                strokeEffect.Position = StrokePosition.Center;
                patternFillSettings = strokeEffect.FillSettings as IPatternFillSettings;
                patternFillSettings.Scale = 75;

                psdImage.Save(outputFilePng, new PngOptions());
            }

            //ExEnd:AddStrokeEffect

            Console.WriteLine("AddStrokeEffect executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerEffects/AddStrokeEffect.cs ---

--- START OF FILE CSharp/Aspose/LayerEffects/RenderingOfGradientOverlayEffect.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.LayerEffects
{
    class RenderingOfGradientOverlayEffect
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:RenderingOfGradientOverlayEffect
            //ExSummary:The following example demonstrates how Aspose.PSD can render the Gradient Overlay Layer Effect 

            string sourceFilePath = Path.Combine(SourceDir, "gradientOverlayEffect.psd");
            string outputFilePath = Path.Combine(OutputDir, "output");
            string outputPng = outputFilePath + ".png";
            string outputPsd = outputFilePath + ".psd";

            using (var psdImage = (PsdImage)Image.Load(sourceFilePath, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                psdImage.Save(outputPng, new PngOptions());
                psdImage.Save(outputPsd);
            }

            //ExEnd:RenderingOfGradientOverlayEffect

            Console.WriteLine("SupportOfGradientOverlayEffect executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerEffects/RenderingOfGradientOverlayEffect.cs ---

--- START OF FILE CSharp/Aspose/LayerEffects/SupportOfGradientOverlayEffect.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;

namespace Aspose.PSD.Examples.Aspose.LayerEffects
{
    class SupportOfGradientOverlayEffect
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart            
            //ExSummary:The following example demonstrates how to create/edit the GradientOverlayEffect effect object in layer.

            string sourceFilePath = Path.Combine(SourceDir, "psdnet256.psd");
            string outputFilePath = Path.Combine(OutputDir, "psdnet256.psd_output.psd");

            // Creates/Gets and edits the gradient overlay effect in a layer.
            using (var psdImage = (PsdImage)Image.Load(sourceFilePath, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                BlendingOptions layerBlendOptions = psdImage.Layers[1].BlendingOptions;
                GradientOverlayEffect gradientOverlayEffect = null;

                // Search GradientOverlayEffect in a layer.
                foreach (ILayerEffect effect in layerBlendOptions.Effects)
                {
                    gradientOverlayEffect = effect as GradientOverlayEffect;
                    if (gradientOverlayEffect != null)
                    {
                        break;
                    }
                }

                if (gradientOverlayEffect == null)
                {
                    // You can create a new GradientOverlayEffect if it not exists.
                    gradientOverlayEffect = layerBlendOptions.AddGradientOverlay();
                }

                // Add a bit of transparency to the effect.
                gradientOverlayEffect.Opacity = 200;

                // Change the blend mode of gradient effect.
                gradientOverlayEffect.BlendMode = BlendMode.Hue;

                // Gets GradientFillSettings object to configure gradient overlay settings.
                GradientFillSettings settings = (GradientFillSettings)gradientOverlayEffect.Settings;
                SolidGradient solidGradient = (SolidGradient)settings.Gradient;

                // Setting a new gradient with two colors.
                solidGradient.ColorPoints = new IGradientColorPoint[]
                {
                    new GradientColorPoint(Color.GreenYellow, 0, 50),
                    new GradientColorPoint(Color.BlueViolet, 4096, 50),
                };

                // Sets an inclination of the gradient at an angle of 80 degrees.
                settings.Angle = 80;

                // Scale gradient effect up to 150%.
                settings.Scale = 150;

                // Sets type of gradient.
                settings.GradientType = GradientType.Linear;

                // Make the gradient opaque by setting the opacity to 100% at each transparency point.
                solidGradient.TransparencyPoints[0].Opacity = 100;
                solidGradient.TransparencyPoints[1].Opacity = 100;

                psdImage.Save(outputFilePath);
            }

            //ExEnd

            Console.WriteLine("SupportOfGradientOverlayEffect executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerEffects/SupportOfGradientOverlayEffect.cs ---

--- START OF FILE CSharp/Aspose/LayerEffects/SupportOfGradientPropery.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.LayerEffects
{
    public class SupportOfGradientPropery
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfGradientPropery
            //ExSummary:Demonstrates reading and modifying noise and solid gradient settings in stroke fill effects.

            string inputFile = Path.Combine(baseDir, "StrokeNoise.psd");
            string outputFile = Path.Combine(outputDir, "output.psd");

            var loadOptions = new PsdLoadOptions() { LoadEffectsResource = true };

            using (PsdImage image = (PsdImage)Image.Load(inputFile, loadOptions))
            {
                var gradientStroke = (StrokeEffect)image.Layers[0].BlendingOptions.Effects[0];
                GradientFillSettings gradientFillSettings = gradientStroke.FillSettings as GradientFillSettings;

                // Check common gradient fill settings properties
                AssertIsNotNull(gradientFillSettings);
                AssertAreEqual(true, gradientFillSettings.AlignWithLayer);
                AssertAreEqual(true, gradientFillSettings.Dither);
                AssertAreEqual(true, gradientFillSettings.Reverse);
                AssertAreEqual(116.0, gradientFillSettings.Angle);
                AssertAreEqual(122, gradientFillSettings.Scale);
                AssertAreEqual(GradientType.Angle, gradientFillSettings.GradientType);

                // Check Noise gradient properties
                NoiseGradient noiseGradient = gradientFillSettings.Gradient as NoiseGradient;
                AssertIsNotNull(noiseGradient);
                AssertAreEqual(GradientKind.Noise, noiseGradient.GradientMode);
                AssertAreEqual(2107422935, noiseGradient.RndNumberSeed);
                AssertAreEqual(false, noiseGradient.ShowTransparency);
                AssertAreEqual(false, noiseGradient.UseVectorColor);
                AssertAreEqual(2048, noiseGradient.Roughness);
                AssertAreEqual(NoiseColorModel.RGB, noiseGradient.ColorModel);
                AssertAreEqual((long)0, noiseGradient.MinimumColor.GetAsLong());
                AssertAreEqual(28147819798528050, noiseGradient.MaximumColor.GetAsLong());

                // Change gradient settings
                gradientFillSettings.AlignWithLayer = false;
                gradientFillSettings.Dither = false;
                gradientFillSettings.Reverse = false;
                gradientFillSettings.Angle = 30;
                gradientFillSettings.Scale = 80;
                gradientFillSettings.GradientType = GradientType.Linear;

                var solidGradient = new SolidGradient();
                solidGradient.Interpolation = 2048;
                solidGradient.ColorPoints[0].RawColor.Components[0].Value = 255; // A
                solidGradient.ColorPoints[0].RawColor.Components[1].Value = 255; // R 
                solidGradient.ColorPoints[0].RawColor.Components[2].Value = 0; // G
                solidGradient.ColorPoints[0].RawColor.Components[3].Value = 0; // B
                solidGradient.TransparencyPoints[1].Opacity = 50;
                gradientFillSettings.Gradient = solidGradient;

                image.Save(outputFile);
            }

            // Check saved changes
            using (PsdImage image = (PsdImage)Image.Load(outputFile))
            {
                var gradientStroke = (StrokeEffect)image.Layers[0].BlendingOptions.Effects[0];
                GradientFillSettings gradientFillSettings = gradientStroke.FillSettings as GradientFillSettings;

                // Check common gradient fill settings properties
                AssertIsNotNull(gradientFillSettings);
                AssertAreEqual(false, gradientFillSettings.AlignWithLayer);
                AssertAreEqual(false, gradientFillSettings.Dither);
                AssertAreEqual(false, gradientFillSettings.Reverse);
                AssertAreEqual(30.0, gradientFillSettings.Angle);
                AssertAreEqual(80, gradientFillSettings.Scale);
                AssertAreEqual(GradientType.Linear, gradientFillSettings.GradientType);

                SolidGradient solidGradient = gradientFillSettings.Gradient as SolidGradient;
                AssertIsNotNull(solidGradient);
                AssertAreEqual((short)2048, solidGradient.Interpolation);
                AssertAreEqual(
                    (ulong)255,
                    solidGradient.ColorPoints[0].RawColor.Components[0].Value);
                AssertAreEqual(
                    (ulong)255,
                    solidGradient.ColorPoints[0].RawColor.Components[1].Value);
                AssertAreEqual(
                    (ulong)0,
                    solidGradient.ColorPoints[0].RawColor.Components[2].Value);
                AssertAreEqual(
                    (ulong)0,
                    solidGradient.ColorPoints[0].RawColor.Components[3].Value);
                AssertAreEqual(50.0, solidGradient.TransparencyPoints[1].Opacity);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            void AssertIsNotNull(object actual)
            {
                if (actual == null)
                {
                    throw new Exception("Object is null.");
                }
            }

            //ExEnd:SupportOfGradientPropery

            File.Delete(outputFile);

            Console.WriteLine("SupportOfGradientPropery executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerEffects/SupportOfGradientPropery.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/Structures/SupportOfNameStructure.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources.Structures
{
    public class SupportOfNameStructure
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfNameStructure

            //ExSummary:The following code demonstrates the support of NameStructure.

            string inputFile = Path.Combine(baseDir, "Mixer_ipad_Hand_W_crash.psd");
            string outputFile = Path.Combine(outputDir, "output.psd");

            using (var psdImage = (PsdImage)Image.Load(inputFile, new PsdLoadOptions { DataRecoveryMode = DataRecoveryMode.MaximalRecover }))
            {
                //// File is loaded successfully

                SmartObjectLayer layer = (SmartObjectLayer)psdImage.Layers[3];
                SoLdResource resource = (SoLdResource)layer.Resources[9];

                DescriptorStructure struct1 = (DescriptorStructure)resource.Items[15];
                ListStructure struct2 = (ListStructure)struct1.Structures[5];
                DescriptorStructure struct3 = (DescriptorStructure)struct2.Types[0];
                DescriptorStructure struct4 = (DescriptorStructure)struct3.Structures[6];
                ReferenceStructure struct5 = (ReferenceStructure)struct4.Structures[8];
                NameStructure nameStructure = (NameStructure)struct5.Items[0];

                AssertIsNotNull(nameStructure);
                AssertAreEqual(37, nameStructure.Length);
                AssertAreEqual("None\0", nameStructure.Value);

                // Save the test file without changes
                psdImage.Save(outputFile);

                //// File should be opened in PS without mistakes
            }

            // Check that the structures of Lighting effects are saved correctly
            using (var psdImage = (PsdImage)Image.Load(
                       outputFile,
                       new PsdLoadOptions { DataRecoveryMode = DataRecoveryMode.MaximalRecover }))
            {
                SmartObjectLayer layer = (SmartObjectLayer)psdImage.Layers[3];
                SoLdResource resource = (SoLdResource)layer.Resources[9];

                DescriptorStructure struct1 = (DescriptorStructure)resource.Items[15];
                ListStructure struct2 = (ListStructure)struct1.Structures[5];
                DescriptorStructure struct3 = (DescriptorStructure)struct2.Types[0];
                DescriptorStructure struct4 = (DescriptorStructure)struct3.Structures[6];
                ReferenceStructure struct5 = (ReferenceStructure)struct4.Structures[8];
                NameStructure nameStructure = (NameStructure)struct5.Items[0];

                AssertIsNotNull(nameStructure);
                AssertAreEqual(37, nameStructure.Length);
                AssertAreEqual("None\0", nameStructure.Value);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            void AssertIsNotNull(object actual)
            {
                if (actual == null)
                {
                    throw new Exception("Object is null.");
                }
            }

            //ExEnd:SupportOfNameStructure

            File.Delete(outputFile);

            Console.WriteLine("SupportOfNameStructure executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/Structures/SupportOfNameStructure.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportForBlwhResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportForBlwhResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportForBlwhResource
            const string ActualPropertyValueIsWrongMessage = "Expected property value is not equal to actual value";
            void AssertIsTrue(bool condition, string message)
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            void ExampleSupportOfBlwhResource(
                string sourceFileName,
                int reds,
                int yellows,
                int greens,
                int cyans,
                int blues,
                int magentas,
                bool useTint,
                int bwPresetKind,
                string bwPresetFileName,
                double tintColorRed,
                double tintColorGreen,
                double tintColorBlue,
                int tintColor,
                int newTintColor)
            {
                string destinationFileName = OutputDir + "Output_" + sourceFileName;
                bool isRequiredResourceFound = false;
                using (PsdImage im = (PsdImage)Image.Load(SourceDir + sourceFileName))
                {
                    foreach (var layer in im.Layers)
                    {
                        foreach (var layerResource in layer.Resources)
                        {
                            if (layerResource is BlwhResource)
                            {
                                var blwhResource = (BlwhResource)layerResource;
                                var blwhLayer = (BlackWhiteAdjustmentLayer)layer;
                                isRequiredResourceFound = true;

                                AssertIsTrue(blwhResource.Reds == reds, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Yellows == yellows, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Greens == greens, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Cyans == cyans, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Blues == blues, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Magentas == magentas, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.UseTint == useTint, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.TintColor == tintColor, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.BwPresetKind == bwPresetKind, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.BlackAndWhitePresetFileName == bwPresetFileName, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(Math.Abs(blwhLayer.TintColorRed - tintColorRed) < 1e-6, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(Math.Abs(blwhLayer.TintColorGreen - tintColorGreen) < 1e-6, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(Math.Abs(blwhLayer.TintColorBlue - tintColorBlue) < 1e-6, ActualPropertyValueIsWrongMessage);

                                // Test editing and saving
                                blwhResource.Reds = reds - 15;
                                blwhResource.Yellows = yellows - 15;
                                blwhResource.Greens = greens + 15;
                                blwhResource.Cyans = cyans + 15;
                                blwhResource.Blues = blues - 15;
                                blwhResource.Magentas = magentas - 15;
                                blwhResource.UseTint = !useTint;
                                blwhResource.BwPresetKind = 4;
                                blwhResource.BlackAndWhitePresetFileName = "bwPresetFileName";
                                blwhLayer.TintColorRed = tintColorRed - 60;
                                blwhLayer.TintColorGreen = tintColorGreen - 60;
                                blwhLayer.TintColorBlue = tintColorBlue - 60;

                                im.Save(destinationFileName);
                                break;
                            }
                        }
                    }
                }

                AssertIsTrue(isRequiredResourceFound, "The specified BlwhResource not found");
                isRequiredResourceFound = false;

                using (PsdImage im = (PsdImage)Image.Load(destinationFileName))
                {
                    foreach (var layer in im.Layers)
                    {
                        foreach (var layerResource in layer.Resources)
                        {
                            if (layerResource is BlwhResource)
                            {
                                var blwhResource = (BlwhResource)layerResource;
                                var blwhLayer = (BlackWhiteAdjustmentLayer)layer;
                                isRequiredResourceFound = true;

                                AssertIsTrue(blwhResource.Reds == reds - 15, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Yellows == yellows - 15, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Greens == greens + 15, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Cyans == cyans + 15, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Blues == blues - 15, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.Magentas == magentas - 15, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.UseTint == !useTint, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.TintColor == newTintColor, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.BwPresetKind == 4, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(blwhResource.BlackAndWhitePresetFileName == "bwPresetFileName", ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(Math.Abs(blwhLayer.TintColorRed - tintColorRed + 60) < 1e-6, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(Math.Abs(blwhLayer.TintColorGreen - tintColorGreen + 60) < 1e-6, ActualPropertyValueIsWrongMessage);
                                AssertIsTrue(Math.Abs(blwhLayer.TintColorBlue - tintColorBlue + 60) < 1e-6, ActualPropertyValueIsWrongMessage);

                                break;
                            }
                        }
                    }
                }

                AssertIsTrue(isRequiredResourceFound, "The specified BlwhResource not found");
            }

            ExampleSupportOfBlwhResource(
                "BlackWhiteAdjustmentLayerStripesMask.psd",
                0x28,
                0x3c,
                0x28,
                0x3c,
                0x14,
                0x50,
                false,
                1,
                "\0",
                225.00045776367188,
                211.00067138671875,
                179.00115966796875,
                -1977421,
                -5925001);

            ExampleSupportOfBlwhResource(
                "BlackWhiteAdjustmentLayerStripesMask2.psd",
                0x80,
                0x40,
                0x20,
                0x10,
                0x08,
                0x04,
                true,
                4,
                "\0",
                239.996337890625,
                127.998046875,
                63.9990234375,
                -1015744,
                -4963324);
            //ExEnd:SupportForBlwhResource

            Console.WriteLine("SupportForBlwhResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportForBlwhResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportForClblResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportForClblResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportForClblResource
            string sourceFileName = SourceDir + "SampleForClblResource.psd";
            string destinationFileName = OutputDir + "SampleForClblResource_out.psd";

            ClblResource GetClblResource(PsdImage psdImage)
            {
                foreach (var layer in psdImage.Layers)
                {
                    foreach (var layerResource in layer.Resources)
                    {
                        if (layerResource is ClblResource)
                        {
                            return (ClblResource)layerResource;
                        }
                    }
                }

                throw new Exception("The specified ClblResource not found");
            }

            using (PsdImage psdImage = (PsdImage)Image.Load(sourceFileName))
            {
                var resource = GetClblResource(psdImage);
                Console.WriteLine("ClblResource.BlendClippedElements [should be true]: " + resource.BlendClippedElements);

                // Test editing and saving
                resource.BlendClippedElements = false;
                psdImage.Save(destinationFileName);
            }

            using (PsdImage psdImage = (PsdImage)Image.Load(destinationFileName))
            {
                var resource = GetClblResource(psdImage);
                Console.WriteLine("ClblResource.BlendClippedElements [should change to false]: " + resource.BlendClippedElements);
            }
            //ExEnd:SupportForClblResource

            Console.WriteLine("SupportForClblResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportForClblResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportForImfxResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportForImfxResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportForImfxResource
            //ExSummary:The following code demonstrates suport of multi-effects resource.

            // PSD image contains 2 Drop Shadow effects 
            string sourceFile = Path.Combine(baseDir, "MultiExample.psd");
            string outputFile1 = Path.Combine(outputDir, "export1.png");
            string outputFile2 = Path.Combine(outputDir, "export2.png");
            string outputFile3 = Path.Combine(outputDir, "export3.png");

            using (PsdImage image = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions() { LoadEffectsResource = true }))
            {
                // It renders PSD image with 2 Drop Shadow effects
                image.Save(outputFile1, new PngOptions { ColorType = PngColorType.TruecolorWithAlpha });

                var blendingOptions = image.Layers[0].BlendingOptions;

                // It adds a third Drop Shadow effect.
                DropShadowEffect dropShadowEffect3 = blendingOptions.AddDropShadow();
                dropShadowEffect3.Color = Color.Red;
                dropShadowEffect3.Distance = 50;
                dropShadowEffect3.Angle = 0;

                // It renders PSD image with 3 Drop Shadow effects
                image.Save(outputFile2, new PngOptions { ColorType = PngColorType.TruecolorWithAlpha });

                // The imfx resource is used if the layer contains multiple effects of the same type.
                var imfx = (ImfxResource)image.Layers[0].Resources[0];

                // It clears all effects
                blendingOptions.Effects = new ILayerEffect[0];

                DropShadowEffect dropShadowEffect1 = blendingOptions.AddDropShadow();
                dropShadowEffect1.Color = Color.Blue;
                dropShadowEffect1.Distance = 10;

                // It renders PSD image with 1 Drop Shadow effects (others was deleted)
                image.Save(outputFile3, new PngOptions { ColorType = PngColorType.TruecolorWithAlpha });

                // The lfx2 resource is used if the layer does not contain multiple effects of the same type.
                var lfx2 = (Lfx2Resource)image.Layers[0].Resources[14];
            }

            //ExEnd:SupportForImfxResource

            File.Delete(outputFile1);
            File.Delete(outputFile2);
            File.Delete(outputFile3);

            Console.WriteLine("SupportForImfxResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportForImfxResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportForInfxResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportForInfxResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportForInfxResource
            void AssertIsTrue(bool condition, string message)
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            string sourceFileName = SourceDir + "SampleForInfxResource.psd";
            string destinationFileName = OutputDir + "SampleForInfxResource_out.psd";
            bool isRequiredResourceFound = false;
            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    foreach (var layerResource in layer.Resources)
                    {
                        if (layerResource is InfxResource)
                        {
                            var resource = (InfxResource)layerResource;
                            isRequiredResourceFound = true;
                            AssertIsTrue(!resource.BlendInteriorElements, "The InfxResource.BlendInteriorElements should be false");

                            // Test editing and saving
                            resource.BlendInteriorElements = true;
                            im.Save(destinationFileName);
                            break;
                        }
                    }
                }
            }

            AssertIsTrue(isRequiredResourceFound, "The specified InfxResource not found");
            isRequiredResourceFound = false;

            using (PsdImage im = (PsdImage)Image.Load(destinationFileName))
            {
                foreach (var layer in im.Layers)
                {
                    foreach (var layerResource in layer.Resources)
                    {
                        if (layerResource is InfxResource)
                        {
                            var resource = (InfxResource)layerResource;
                            isRequiredResourceFound = true;
                            AssertIsTrue(resource.BlendInteriorElements, "The InfxResource.BlendInteriorElements should change to true");

                            break;
                        }
                    }
                }
            }

            AssertIsTrue(isRequiredResourceFound, "The specified InfxResource not found");
            //ExEnd:SupportForInfxResource

            Console.WriteLine("SupportForInfxResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportForInfxResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportForLspfResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportForLspfResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportForLspfResource
            const string ActualPropertyValueIsWrongMessage = "Expected property value is not equal to actual value";
            void AssertIsTrue(bool condition, string message)
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            string sourceFileName = SourceDir + "SampleForLspfResource.psd";
            string destinationFileName = OutputDir + "SampleForLspfResource_out.psd";
            bool isRequiredResourceFound = false;
            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    foreach (var layerResource in layer.Resources)
                    {
                        if (layerResource is LspfResource)
                        {
                            var resource = (LspfResource)layerResource;

                            isRequiredResourceFound = true;

                            AssertIsTrue(false == resource.IsCompositeProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(false == resource.IsPositionProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(false == resource.IsTransparencyProtected, ActualPropertyValueIsWrongMessage);

                            // Test editing and saving
                            resource.IsCompositeProtected = true;
                            AssertIsTrue(true == resource.IsCompositeProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(false == resource.IsPositionProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(false == resource.IsTransparencyProtected, ActualPropertyValueIsWrongMessage);

                            resource.IsCompositeProtected = false;
                            resource.IsPositionProtected = true;
                            AssertIsTrue(false == resource.IsCompositeProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(true == resource.IsPositionProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(false == resource.IsTransparencyProtected, ActualPropertyValueIsWrongMessage);

                            resource.IsPositionProtected = false;
                            resource.IsTransparencyProtected = true;
                            AssertIsTrue(false == resource.IsCompositeProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(false == resource.IsPositionProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(true == resource.IsTransparencyProtected, ActualPropertyValueIsWrongMessage);

                            resource.IsCompositeProtected = true;
                            resource.IsPositionProtected = true;
                            resource.IsTransparencyProtected = true;

                            im.Save(destinationFileName);
                            break;
                        }
                    }
                }
            }

            AssertIsTrue(isRequiredResourceFound, "The specified LspfResource not found");
            isRequiredResourceFound = false;

            using (PsdImage im = (PsdImage)Image.Load(destinationFileName))
            {
                foreach (var layer in im.Layers)
                {
                    foreach (var layerResource in layer.Resources)
                    {
                        if (layerResource is LspfResource)
                        {
                            var resource = (LspfResource)layerResource;

                            isRequiredResourceFound = true;

                            AssertIsTrue(resource.IsCompositeProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(resource.IsPositionProtected, ActualPropertyValueIsWrongMessage);
                            AssertIsTrue(resource.IsTransparencyProtected, ActualPropertyValueIsWrongMessage);

                            break;
                        }
                    }
                }
            }

            AssertIsTrue(isRequiredResourceFound, "The specified LspfResource not found");
            Console.WriteLine("LspfResource updating works as expected. Press any key.");
            //ExEnd:SupportForLspfResource

            Console.WriteLine("SupportForLspfResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportForLspfResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfArtBResourceArtDResourceLyvrResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    public class SupportOfArtBResourceArtDResourceLyvrResource
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfArtBResourceArtDResourceLyvrResource
            //ExSummary:The following code demonstrates the support of Artboard resources.
            
            string srcFile = Path.Combine(baseDir, "artboard1.psd");

            using (PsdImage psdImage = (PsdImage)Image.Load(srcFile))
            {
                ArtDResource artDResource = (ArtDResource)psdImage.GlobalLayerResources[2];

                ArtBResource artBResource1 = (ArtBResource)psdImage.Layers[2].Resources[7];
                ArtBResource artBResource2 = (ArtBResource)psdImage.Layers[5].Resources[7];

                LyvrResource lyvrResource1 = (LyvrResource)psdImage.Layers[2].Resources[9];
                LyvrResource lyvrResource2 = (LyvrResource)psdImage.Layers[5].Resources[9];

                var countStruct = (IntegerStructure)artDResource.Items[0];
                AssertAreEqual(2, countStruct.Value);

                var presetNameStruct1 = (StringStructure)artBResource1.Items[2];
                AssertAreEqual("iPhone X\0", presetNameStruct1.Value);

                var presetNameStruct2 = (StringStructure)artBResource2.Items[2];
                AssertAreEqual("iPhone X\0", presetNameStruct2.Value);

                AssertAreEqual(160, lyvrResource1.Version);
                AssertAreEqual(160, lyvrResource2.Version);
            }

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }
            
            //ExEnd:SupportOfArtBResourceArtDResourceLyvrResource

            Console.WriteLine("SupportOfArtBResourceArtDResourceLyvrResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfArtBResourceArtDResourceLyvrResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfBritResource.cs ---
﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfBritResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseFolder = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfBritResource
            /* This Example demonstrates how you can programmatically change the PSD Image Brightness/Contrast Layer Resource - BritResource
            This is a Low-Level Aspose.PSD API. You can use Brightness/Contrast Layer through its API, which will be much easier, 
            but direct PhotoShop resource editing gives you more control over the PSD file content.  */

            string path = Path.Combine(baseFolder, "BrightnessContrastPS6.psd");
            string outputPath = Path.Combine(outputDir, "BrightnessContrastPS6_output.psd");

            using (PsdImage im = (PsdImage)Image.Load(path))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is BrightnessContrastLayer)
                    {
                        foreach (var layerResource in layer.Resources)
                        {
                            if (layerResource is BritResource)
                            {
                                var resource = (BritResource)layerResource;

                                if (resource.Brightness != -40 ||
                                    resource.Contrast != 10 ||
                                    resource.LabColor != false ||
                                    resource.MeanValueForBrightnessAndContrast != 127)
                                {
                                    throw new Exception("BritResource was read wrong");
                                }

                                // Test editing and saving
                                resource.Brightness = 25;
                                resource.Contrast = -14;
                                resource.LabColor = true;
                                resource.MeanValueForBrightnessAndContrast = 200;
                                im.Save(Path.Combine(outputPath, outputPath), new PsdOptions());
                                break;
                            }
                        }
                    }
                }
            }

            //ExEnd:SupportOfBritResource

            Console.WriteLine("SupportOfBritResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfBritResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfFXidResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    internal class SupportOfFXidResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfFXidResource
            //ExSummary:This example demonstrates how to get and set properties of the FXidResource resource.

            string inputFilePath = Path.Combine(SourceDir, "psdnet414_3.psd");
            string output = Path.Combine(OutputDir, "out_psdnet414_3.psd");

            int resLength = 1144;
            long maskLength = 369;

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new FormatException(message ?? "Objects are not equal.");
                }
            }

            using (var psdImage = (PsdImage)Image.Load(inputFilePath))
            {
                FXidResource fXidResource = (FXidResource)psdImage.GlobalLayerResources[3];

                AssertAreEqual(resLength, fXidResource.Length);
                foreach (var maskData in fXidResource.FilterEffectMasks)
                {
                    AssertAreEqual(maskLength, maskData.Length);
                }

                psdImage.Save(output);
            }

            // check after saving
            using (var psdImage = (PsdImage)Image.Load(output))
            {
                FXidResource fXidResource = (FXidResource)psdImage.GlobalLayerResources[3];

                AssertAreEqual(resLength, fXidResource.Length);
                foreach (var maskData in fXidResource.FilterEffectMasks)
                {
                    AssertAreEqual(maskLength, maskData.Length);
                }
            }

            //ExEnd:SupportOfFXidResource

            Console.WriteLine("SupportOfFXidResource executed successfully");

            File.Delete(output);
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfFXidResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfGrdmResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    public class SupportOfGrdmResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfGrdmResource
            //ExSummary:The following code demonstrates support of GrdmResource resource.

            string sourceFile = Path.Combine(baseDir, "gradient_map_default.psd");
            string outputFile = Path.Combine(outputDir, "gradient_map_res.psd");

            using (var image = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions()))
            {
                Layer layer = image.Layers[1];
                GrdmResource grdmResource = (GrdmResource)layer.Resources[0];
                
                // check current values
                AssertAreEqual(false, grdmResource.Reverse);
                AssertAreEqual((ulong)65535, grdmResource.ColorPoints[1].RawColor.Components[2].Value);
                AssertAreEqual((ulong)65535, grdmResource.ColorPoints[1].RawColor.Components[3].Value);
                
                grdmResource.Reverse = true;
                // Red color for second gradient color point
                grdmResource.ColorPoints[1].RawColor.Components[1].Value = ushort.MaxValue;
                grdmResource.ColorPoints[1].RawColor.Components[2].Value = 0;
                grdmResource.ColorPoints[1].RawColor.Components[3].Value = 0;
                
                image.Save(outputFile, new PsdOptions());
            }

            using (var image = (PsdImage)Image.Load(outputFile))
            {
                Layer layer = image.Layers[1];
                GrdmResource grdmResource = (GrdmResource)layer.Resources[0];
                
                // check changed values
                AssertAreEqual(true, grdmResource.Reverse);
                AssertAreEqual((ulong)0, grdmResource.ColorPoints[1].RawColor.Components[2].Value);
                AssertAreEqual((ulong)0, grdmResource.ColorPoints[1].RawColor.Components[3].Value);
            }
            
            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            //ExEnd:SupportOfGrdmResource

            File.Delete(outputFile);

            Console.WriteLine("SupportOfGrdmResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfGrdmResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfLMskResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Resources.Enums;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    public class SupportOfLMskResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfLMskResource
            //ExSummary:The following code demonstrates how to change Layer Mask Display Options on 16-bit images through changing LmskResource properties.
            
            string sourceFile = Path.Combine(baseDir, "sourceFile.psd");
            string outputPsd = Path.Combine(outputDir, "sourceFile_output.psd");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            // Load 16-bit image.
            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                // Find LmskResource.
                LmskResource lmskResource = new LmskResource();
                foreach (var res in image.GlobalLayerResources)
                {
                    if (res is LmskResource)
                    {
                        lmskResource = (LmskResource)res;
                        break;
                    }
                }

                // Check LmskResource properties.
                AssertAreEqual(lmskResource.ColorSpace, ColorSpace.RGB);
                AssertAreEqual(lmskResource.ColorComponent1, (ushort)65535);
                AssertAreEqual(lmskResource.ColorComponent2, (ushort)0);
                AssertAreEqual(lmskResource.ColorComponent3, (ushort)0);
                AssertAreEqual(lmskResource.ColorComponent4, (ushort)0);
                AssertAreEqual(lmskResource.Opacity, (short)45);
                AssertAreEqual(lmskResource.Flag, (byte)128);

                // Change LmskResource properties.
                lmskResource.ColorSpace = ColorSpace.HSB;
                lmskResource.ColorComponent1 = 7854;
                lmskResource.ColorComponent2 = 10;
                lmskResource.ColorComponent3 = 15484;
                lmskResource.Opacity = 85;

                // Save the image.
                image.Save(outputPsd);
            }

            //ExEnd:SupportOfLMskResource
            
            File.Delete(outputPsd);

            Console.WriteLine("SupportOfLMskResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfLMskResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfLclrResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfLclrResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart
            //ExSummary:The following example demonstrates how you can change Sheet Color Highlight In Aspose.PSD
            string sourceFilePath = Path.Combine(baseDir, "AllLclrResourceColors.psd");
            string outputFilePath = Path.Combine(outputDir, "AllLclrResourceColorsReversed.psd");

            // In the file colors of layers' highlighting are in this order
            SheetColorHighlightEnum[] sheetColorsArr = new SheetColorHighlightEnum[] {
                SheetColorHighlightEnum.Red,
                SheetColorHighlightEnum.Orange,
                SheetColorHighlightEnum.Yellow,
                SheetColorHighlightEnum.Green,
                SheetColorHighlightEnum.Blue,
                SheetColorHighlightEnum.Violet,
                SheetColorHighlightEnum.Gray,
                SheetColorHighlightEnum.NoColor
            };

            // Layer Sheet Color is used to visually highlight layers. 
            // For example you can update some layers in PSD and then highlight by color the layer which you want to attract attention. (Sheet color setting)
            using (PsdImage img = (PsdImage)Image.Load(sourceFilePath))
            {
                CheckSheetColorsAndRerverse(sheetColorsArr, img);
                img.Save(outputFilePath, new PsdOptions());
            }

            using (PsdImage img = (PsdImage)Image.Load(outputFilePath))
            {
                // Colors should be reversed
                Array.Reverse(sheetColorsArr);
                CheckSheetColorsAndRerverse(sheetColorsArr, img);
            }

            void CheckSheetColorsAndRerverse(SheetColorHighlightEnum[] sheetColors, PsdImage img)
            {
                int layersCount = img.Layers.Length;
                for (int layerIndex = 0; layerIndex < layersCount; layerIndex++)
                {
                    Layer layer = img.Layers[layerIndex];
                    LayerResource[] resources = layer.Resources;
                    foreach (LayerResource layerResource in resources)
                    {
                        // The lcrl resource always presents in psd file resource list.
                        LclrResource resource = layerResource as LclrResource;
                        if (resource != null)
                        {
                            if (resource.Color != sheetColors[layerIndex])
                            {
                                throw new Exception("Sheet Color has been read wrong");
                            }

                            // Reverse of style sheet colors. Set up of Layer color highlight.
                            resource.Color = sheetColors[layersCount - layerIndex - 1];
                            break;
                        }
                    }
                }
            }

            //ExEnd

            Console.WriteLine("SupportOfLclrResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfLclrResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfLnk2AndLnk3Resource.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfLnk2AndLnk3Resource
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfLnk2AndLnk3Resource
            //ExSummary:This example demonstrates how to get and set properties of the Lnk2Resource and Lnk3Resource.

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(actual, expected))
                {
                    throw new FormatException(string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            object[] Lnk2ResourceSupportCases = new object[]
            {
            new object[]
            {
                "00af34a0-a90b-674d-a821-73ee508c5479",
                "rgb8_2x2.png",
                "png",
                string.Empty,
                0x53,
                0d,
                string.Empty,
                7,
                true,
                0x124L,
                0x74cL
            }
            };

            object[] LayeredLnk2ResourceSupportCases = new object[]
            {
            new object[]
            {
                "69ac1c0d-1b74-fd49-9c7e-34a7aa6299ef",
                "huset.jpg",
                "JPEG",
                string.Empty,
                0x9d46,
                0d,
                "xmp.did:0F94B342065B11E395B1FD506DED6B07",
                7,
                true,
                0x9E60L,
                0xc60cL
            },
            new object[]
            {
                "5a7d1965-0eae-b24e-a82f-98c7646424c2",
                "panama-papers.jpg",
                "JPEG",
                string.Empty,
                0xF56B,
                0d,
                "xmp.did:BDE940CBF51B11E59D759CDA690663E3",
                7,
                true,
                0xF694L,
                0x10dd4L
            },
            };

            object[] LayeredLnk3ResourceSupportCases = new object[]
            {
            new object[]
            {
                "2fd7ba52-0221-de4c-bdc4-1210580c6caa",
                "panama-papers.jpg",
                "JPEG",
                string.Empty,
                0xF56B,
                0d,
                "xmp.did:BDE940CBF51B11E59D759CDA690663E3",
                7,
                true,
                0xF694L,
                0x10dd4L
            },
            new object[]
            {
                "372d52eb-5825-8743-81a7-b6f32d51323d",
                "huset.jpg",
                "JPEG",
                string.Empty,
                0x9d46,
                0d,
                "xmp.did:0F94B342065B11E395B1FD506DED6B07",
                7,
                true,
                0x9E60L,
                0xc60cL
            },
            };

            var basePath = Path.Combine(baseFolder, "") + Path.DirectorySeparatorChar;

            // Saves the data of a smart object in PSD file to a file.
            void SaveSmartObjectData(string prefix, string fileName, byte[] data)
            {
                var filePath = prefix + "_" + fileName;

                using (var container = FileStreamContainer.CreateFileStream(filePath, false))
                {
                    container.Write(data);
                }
            }

            // Loads the new data for a smart object in PSD file.
            byte[] LoadNewData(string fileName)
            {
                using (var container = FileStreamContainer.OpenFileStream(basePath + fileName))
                {
                    return container.ToBytes();
                }
            }

            // Gets and sets properties of the PSD Lnk2 / Lnk3 Resource and its liFD data sources in PSD image
            void ExampleOfLnk2ResourceSupport(
                string fileName,
                int dataSourceCount,
                int length,
                int newLength,
                object[] dataSourceExpectedValues)
            {
                using (PsdImage image = (PsdImage)Image.Load(basePath + fileName))
                {
                    Lnk2Resource lnk2Resource = null;
                    foreach (var resource in image.GlobalLayerResources)
                    {
                        lnk2Resource = resource as Lnk2Resource;
                        if (lnk2Resource != null)
                        {
                            AssertAreEqual(lnk2Resource.DataSourceCount, dataSourceCount);
                            AssertAreEqual(lnk2Resource.Length, length);
                            AssertAreEqual(lnk2Resource.IsEmpty, false);

                            for (int i = 0; i < lnk2Resource.DataSourceCount; i++)
                            {
                                LiFdDataSource lifdSource = lnk2Resource[i];
                                object[] expected = (object[])dataSourceExpectedValues[i];
                                AssertAreEqual(LinkDataSourceType.liFD, lifdSource.Type);
                                AssertAreEqual(new Guid((string)expected[0]), lifdSource.UniqueId);
                                AssertAreEqual(expected[1], lifdSource.OriginalFileName);
                                AssertAreEqual(expected[2], lifdSource.FileType.TrimEnd(' '));
                                AssertAreEqual(expected[3], lifdSource.FileCreator.TrimEnd(' '));
                                AssertAreEqual(expected[4], lifdSource.Data.Length);
                                AssertAreEqual(expected[5], lifdSource.AssetModTime);
                                AssertAreEqual(expected[6], lifdSource.ChildDocId);
                                AssertAreEqual(expected[7], lifdSource.Version);
                                AssertAreEqual((bool)expected[8], lifdSource.HasFileOpenDescriptor);
                                AssertAreEqual(expected[9], lifdSource.Length);

                                if (lifdSource.HasFileOpenDescriptor)
                                {
                                    AssertAreEqual(-1, lifdSource.CompId);
                                    AssertAreEqual(-1, lifdSource.OriginalCompId);
                                    lifdSource.CompId = int.MaxValue;
                                }

                                SaveSmartObjectData(
                                    output + fileName,
                                    lifdSource.OriginalFileName,
                                    lifdSource.Data);
                                lifdSource.Data = LoadNewData("new_" + lifdSource.OriginalFileName);
                                AssertAreEqual(expected[10], lifdSource.Length);

                                lifdSource.ChildDocId = Guid.NewGuid().ToString();
                                lifdSource.AssetModTime = double.MaxValue;
                                lifdSource.FileType = "test";
                                lifdSource.FileCreator = "me";
                            }

                            AssertAreEqual(newLength, lnk2Resource.Length);
                            break;
                        }
                    }

                    AssertAreEqual(true, lnk2Resource != null);
                    if (image.BitsPerChannel < 32) // 32 bit per channel saving is not supported yet
                    {
                        image.Save(output + fileName, new PsdOptions(image));
                    }
                }
            }

            // This example demonstrates how to get and set properties of the PSD Lnk2 Resource and its liFD data sources for 8 bit per channel.
            ExampleOfLnk2ResourceSupport("rgb8_2x2_embedded_png.psd", 1, 0x12C, 0x0000079c, Lnk2ResourceSupportCases);

            // This example demonstrates how to get and set properties of the PSD Lnk3 Resource and its liFD data sources for 32 bit per channel.
            ExampleOfLnk2ResourceSupport("Layered PSD file smart objects.psd", 2, 0x19504, 0x0001d3e0, LayeredLnk3ResourceSupportCases);

            // This example demonstrates how to get and set properties of the PSD Lnk2 Resource and its liFD data sources for 16 bit per channel.
            ExampleOfLnk2ResourceSupport("LayeredSmartObjects16bit.psd", 2, 0x19504, 0x0001d3e0, LayeredLnk2ResourceSupportCases);

            //ExEnd:SupportOfLnk2AndLnk3Resource

            Console.WriteLine("SupportOfLnk2AndLnk3Resource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfLnk2AndLnk3Resource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfLnkEResource.cs ---
﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfLnkEResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseFolder = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfLnkEResource

            string message = "The example works incorrectly.";
            void AssertAreEqual(object actual, object expected)
            {
                if (!object.Equals(actual, expected))
                {
                    throw new FormatException(message);
                }
            }

            // This example demonstrates how to get and set properties of the Psd LnkE Resource that contains information about an external linked file.
            void ExampleOfLnkEResourceSupport(
                string fileName,
                int length,
                int length2,
                int length3,
                int length4,
                string fullPath,
                string date,
                double assetModTime,
                string childDocId,
                bool locked,
                string uid,
                string name,
                string originalFileName,
                string fileType,
                long size,
                int version)
            {
                string outputPath = Path.Combine(outputDir, fileName);
                using (PsdImage image = (PsdImage) Image.Load(Path.Combine(baseFolder, fileName)))
                {
                    LnkeResource lnkeResource = null;
                    foreach (var resource in image.GlobalLayerResources)
                    {
                        lnkeResource = resource as LnkeResource;
                        if (lnkeResource != null)
                        {
                            LiFeDataSource lifeSource = lnkeResource[0];
                            AssertAreEqual(lnkeResource.Length, length);
                            AssertAreEqual(lifeSource.UniqueId, new Guid(uid));
                            AssertAreEqual(lifeSource.FullPath, fullPath);
                            AssertAreEqual(lifeSource.Date.ToString(CultureInfo.InvariantCulture), date);
                            AssertAreEqual(lifeSource.AssetModTime, assetModTime);
                            AssertAreEqual(lifeSource.FileName, name);
                            AssertAreEqual(lifeSource.FileSize, size);
                            AssertAreEqual(lifeSource.ChildDocId, childDocId);
                            AssertAreEqual(lifeSource.Version, version);
                            AssertAreEqual(lifeSource.FileType.TrimEnd(' '), fileType);
                            AssertAreEqual(lifeSource.FileCreator.TrimEnd(' '), string.Empty);
                            AssertAreEqual(lifeSource.OriginalFileName, originalFileName);
                            AssertAreEqual(false, lnkeResource.IsEmpty);
                            AssertAreEqual(true, lifeSource.Type == LinkDataSourceType.liFE);
                            if (version == 7)
                            {
                                AssertAreEqual(lifeSource.AssetLockedState, locked);
                            }

                            if (lifeSource.HasFileOpenDescriptor)
                            {
                                AssertAreEqual(lifeSource.CompId, -1);
                                AssertAreEqual(lifeSource.OriginalCompId, -1);
                            }

                            lifeSource.FullPath =
                                @"file:///C:/Aspose/net/Aspose.Psd/test/testdata/Images/Psd/SmartObjects/rgb8_2x2.png";
                            AssertAreEqual(lnkeResource.Length, length2);
                            lifeSource.FileName = "rgb8_2x23.png";
                            AssertAreEqual(lnkeResource.Length, length3);
                            lifeSource.ChildDocId = Guid.NewGuid().ToString();
                            AssertAreEqual(lnkeResource.Length, length4);
                            lifeSource.Date = DateTime.Now;
                            lifeSource.AssetModTime = double.MaxValue;
                            lifeSource.FileSize = long.MaxValue;
                            lifeSource.FileType = "test";
                            lifeSource.FileCreator = "file";
                            lifeSource.CompId = int.MaxValue;
                            break;
                        }
                    }

                    AssertAreEqual(true, lnkeResource != null);

                    image.Save(outputPath, new PsdOptions(image));
                }
            }

            // This example demonstrates how to get and set properties of the Psd LnkeResource that contains information about external linked JPEG file.
            ExampleOfLnkEResourceSupport(
                @"photooverlay_5_new.psd",
                0x21c,
                0x26c,
                0x274,
                0x27c,
                @"file:///C:/Users/cvallejo/Desktop/photo.jpg",
                "05/09/2017 22:24:51",
                0,
                "F062B9DB73E8D124167A4186E54664B0",
                false,
                "02df245c-36a2-11e7-a9d8-fdb2b61f07a7",
                "photo.jpg",
                "photo.jpg",
                "JPEG",
                0x1520d,
                7);

            // This example demonstrates how to get and set properties of the PSD LnkeResource that contains information about an external linked PNG file.
            ExampleOfLnkEResourceSupport(
                "rgb8_2x2_linked.psd",
                0x284,
                0x290,
                0x294,
                0x2dc,
                @"file:///C:/Aspose/net/Aspose.Psd/test/testdata/Issues/PSDNET-491/rgb8_2x2.png",
                "04/14/2020 14:23:44",
                0,
                string.Empty,
                false,
                "5867318f-3174-9f41-abca-22f56a75247e",
                "rgb8_2x2.png",
                "rgb8_2x2.png",
                "png",
                0x53,
                7);

            // This example demonstrates how to get and set properties of the PSD LnkeResource that contains information about two external linked PNG and PSD files.
            ExampleOfLnkEResourceSupport(
                "rgb8_2x2_linked2.psd",
                0x590,
                0x580,
                0x554,
                0x528,
                @"file:///C:/Aspose/net/Aspose.Psd/test/testdata/Images/Psd/AddColorBalanceAdjustmentLayer.psd",
                "01/15/2020 13:02:00",
                0,
                "adobe:docid:photoshop:9312f484-3403-a644-8973-e725abc95fb7",
                false,
                "78a5b588-364f-0940-a2e5-a450a031aa48",
                "AddColorBalanceAdjustmentLayer.psd",
                "AddColorBalanceAdjustmentLayer.psd",
                "8BPS",
                0x4aea,
                7);

            // This example demonstrates how to get and set properties of the Photoshop Psd LnkeResource that contains information about an external linked CC Libraries Asset.
            ExampleOfLnkEResourceSupport(
                "rgb8_2x2_asset_linked.psd",
                0x398,
                0x38c,
                0x388,
                0x3d0,
                @"CC Libraries Asset “rgb8_2x2_linked/rgb8_2x2” (Feature is available in Photoshop CC 2015)",
                "01/01/0001 00:00:00",
                1588890915488.0d,
                string.Empty,
                false,
                "ec15f0a8-7f13-a640-b928-7d29c6e9859c",
                "rgb8_2x2_linked",
                "rgb8_2x2.png",
                "png",
                0,
                7);

            //ExEnd:SupportOfLnkEResource

            Console.WriteLine("SupportOfLnkEResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfLnkEResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfNvrtResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfNvrtResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string sourceDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfNvrtResource
            //The following example demonstrates how to get NvrtResource.
            string sourceFilePath = Path.Combine(sourceDir, "InvertAdjustmentLayer.psd");
            NvrtResource resource = null;
            using (PsdImage psdImage = (PsdImage)Image.Load(sourceFilePath))
            {
                foreach (Layer layer in psdImage.Layers)
                {
                    if (layer is InvertAdjustmentLayer)
                    {
                        foreach (LayerResource layerResource in layer.Resources)
                        {
                            if (layerResource is NvrtResource)
                            {
                                // The NvrtResource is supported.
                                resource = (NvrtResource)layerResource;
                                break;
                            }
                        }
                    }
                }
            }

            if (resource is null)
            {
                throw new Exception("NvrtResource Not Found");
            }
            //ExEnd:SupportOfNvrtResource

            Console.WriteLine("SupportOfNvrtResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfNvrtResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfPlLdResource.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfPlLdResource
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPlLdResource
            //ExSummary:The following code demonstrates the support of the PlLdResource resource.

            void AssertAreEqual(object actual, object expected)
            {
                var areEqual = object.Equals(actual, expected);
                if (!areEqual && actual is Array && expected is Array)
                {
                    var actualArray = (Array)actual;
                    var expectedArray = (Array)actual;
                    if (actualArray.Length == expectedArray.Length)
                    {
                        for (int i = 0; i < actualArray.Length; i++)
                        {
                            if (!object.Equals(actualArray.GetValue(i), expectedArray.GetValue(i)))
                            {
                                break;
                            }
                        }

                        areEqual = true;
                    }
                }

                if (!areEqual)
                {
                    throw new FormatException(
                        string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            var sourceFilePath = baseFolder + "LayeredSmartObjects8bit2.psd";
            var outputFilePath = output + "LayeredSmartObjects8bit2_output.psd";
            var expectedValues = new object[]
            {
                new object[]
                {
                    true,
                    "76f05a3b-7523-5e42-a1bb-27f4735bffa0",
                    1,
                    1,
                    0x10,
                    PlacedLayerType.Raster,
                    new double[8]
                    {
                        29.937922786050663,
                        95.419959734187131,
                        126.85445817782261,
                        1.0540625423957124,
                        172.20861031651307,
                        47.634102808208553,
                        75.292074924741144,
                        142
                    },
                    0d,
                    0d,
                    0d,
                    0d,
                    0d,
                    149d,
                    310d,
                    4,
                    4,
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d,
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d,
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d,
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d
                    },
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0d, 0.0d, 0.0d, 0.0d,
                        49.666666666666664d, 49.666666666666664d, 49.666666666666664d, 49.666666666666664d,
                        99.333333333333329d, 99.333333333333329d, 99.333333333333329d, 99.333333333333329d,
                        149, 149, 149, 149,
                    },
                },
                new object[]
                {
                    true,
                    "cf0477a8-8f92-ac4f-9462-f78e26234851",
                    1,
                    1,
                    0x10,
                    PlacedLayerType.Raster,
                    new double[8]
                    {
                        37.900314592235681,
                        -0.32118219433001371,
                        185.94210608826535,
                        57.7076819802063,
                        153.32047433609358,
                        140.9311755779743,
                        5.2786828400639294,
                        82.902311403437977,
                    },
                    0d,
                    0d,
                    0d,
                    0d,
                    0d,
                    721d,
                    1280d,
                    4,
                    4,
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                    },
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0, 0.0, 0.0, 0.0,
                        240.33333333333331, 240.33333333333331, 240.33333333333331, 240.33333333333331,
                        480.66666666666663, 480.66666666666663, 480.66666666666663, 480.66666666666663,
                        721, 721, 721, 721,
                    },
                    0,
                    0
                }
            };

            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
            {
                PlLdResource resource = null;
                int index = 0;
                foreach (Layer imageLayer in image.Layers)
                {
                    foreach (var imageResource in imageLayer.Resources)
                    {
                        resource = imageResource as PlLdResource;
                        if (resource != null)
                        {
                            var expectedValue = (object[])expectedValues[index++];
                            AssertAreEqual(expectedValue[0], resource.IsCustom);
                            AssertAreEqual(expectedValue[1], resource.UniqueId.ToString());
                            AssertAreEqual(expectedValue[2], resource.PageNumber);
                            AssertAreEqual(expectedValue[3], resource.TotalPages);
                            AssertAreEqual(expectedValue[4], resource.AntiAliasPolicy);
                            AssertAreEqual(expectedValue[5], resource.PlacedLayerType);
                            AssertAreEqual(8, resource.TransformMatrix.Length);
                            AssertAreEqual((double[])expectedValue[6], resource.TransformMatrix);
                            AssertAreEqual(expectedValue[7], resource.Value);
                            AssertAreEqual(expectedValue[8], resource.Perspective);
                            AssertAreEqual(expectedValue[9], resource.PerspectiveOther);
                            AssertAreEqual(expectedValue[10], resource.Top);
                            AssertAreEqual(expectedValue[11], resource.Left);
                            AssertAreEqual(expectedValue[12], resource.Bottom);
                            AssertAreEqual(expectedValue[13], resource.Right);
                            AssertAreEqual(expectedValue[14], resource.UOrder);
                            AssertAreEqual(expectedValue[15], resource.VOrder);
                            if (resource.IsCustom)
                            {
                                AssertAreEqual(expectedValue[16], resource.HorizontalMeshPointUnit);
                                AssertAreEqual((double[])expectedValue[17], resource.HorizontalMeshPoints);
                                AssertAreEqual(expectedValue[18], resource.VerticalMeshPointUnit);
                                AssertAreEqual((double[])expectedValue[19], resource.VerticalMeshPoints);
                                var temp = resource.VerticalMeshPoints;
                                resource.VerticalMeshPoints = resource.HorizontalMeshPoints;
                                resource.HorizontalMeshPoints = temp;
                            }
                            
                            resource.PageNumber = 2;
                            resource.TotalPages = 3;
                            resource.AntiAliasPolicy = 30;
                            resource.Value = 1.23456789;
                            resource.Perspective = 0.123456789;
                            resource.PerspectiveOther = 0.987654321;
                            resource.Top = -126;
                            resource.Left = -215;
                            resource.Bottom = 248;
                            resource.Right = 145;

                            // Be careful with some parameters: image may became unreadable by Adobe® Photoshop®
                            ////resource.UOrder = 6;
                            ////resource.VOrder = 9;

                            // Do no change this otherwise you won't be able to use free transform
                            // or change the underlining smart object to the vector type
                            ////resource.PlacedLayerType = PlacedLayerType.Vector;

                            // There should be valid PlLdResource with this unique Id
                            ////resource.UniqueId = new Guid("98765432-10fe-cba0-1234-56789abcdef0");

                            break;
                        }
                    }
                }

                AssertAreEqual(true, resource != null);
                image.Save(outputFilePath, new PsdOptions(image));
            }

            //ExEnd:SupportOfPlLdResource

            Console.WriteLine("SupportOfPlLdResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfPlLdResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfPlacedResource.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfPlacedResource
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPlacedResource
            //ExSummary:The following code demonstrates the support of the SoLEResource, SmartObjectResource and PlacedResource resources.

            void AssertIsTrue(bool condition)
            {
                if (!condition)
                {
                    throw new FormatException(string.Format("Expected true"));
                }
            }

            void AssertAreEqual(object actual, object expected)
            {
                var areEqual = object.Equals(actual, expected);
                if (!areEqual && actual is Array && expected is Array)
                {
                    var actualArray = (Array)actual;
                    var expectedArray = (Array)actual;
                    if (actualArray.Length == expectedArray.Length)
                    {
                        for (int i = 0; i < actualArray.Length; i++)
                        {
                            if (!object.Equals(actualArray.GetValue(i), expectedArray.GetValue(i)))
                            {
                                break;
                            }
                        }

                        areEqual = true;
                    }
                }

                if (!areEqual)
                {
                    throw new FormatException(
                        string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            void CheckSmartObjectResourceValues(object[] expectedValue, SmartObjectResource resource)
            {
                AssertAreEqual(expectedValue[0], resource.IsCustom);
                AssertAreEqual(expectedValue[2], resource.PageNumber);
                AssertAreEqual(expectedValue[3], resource.TotalPages);
                AssertAreEqual(expectedValue[4], resource.AntiAliasPolicy);
                AssertAreEqual(expectedValue[5], resource.PlacedLayerType);
                AssertAreEqual(8, resource.TransformMatrix.Length);
                AssertAreEqual((double[])expectedValue[6], resource.TransformMatrix);
                AssertAreEqual(expectedValue[7], resource.Value);
                AssertAreEqual(expectedValue[8], resource.Perspective);
                AssertAreEqual(expectedValue[9], resource.PerspectiveOther);
                AssertAreEqual(expectedValue[10], resource.Top);
                AssertAreEqual(expectedValue[11], resource.Left);
                AssertAreEqual(expectedValue[12], resource.Bottom);
                AssertAreEqual(expectedValue[13], resource.Right);
                AssertAreEqual(expectedValue[14], resource.UOrder);
                AssertAreEqual(expectedValue[15], resource.VOrder);

                AssertAreEqual(expectedValue[16], resource.Crop);
                AssertAreEqual(expectedValue[17], resource.FrameStepNumerator);
                AssertAreEqual(expectedValue[18], resource.FrameStepDenominator);
                AssertAreEqual(expectedValue[19], resource.DurationNumerator);
                AssertAreEqual(expectedValue[20], resource.DurationDenominator);
                AssertAreEqual(expectedValue[21], resource.FrameCount);
                AssertAreEqual(expectedValue[22], resource.Width);
                AssertAreEqual(expectedValue[23], resource.Height);
                AssertAreEqual(expectedValue[24], resource.Resolution);
                AssertAreEqual(expectedValue[25], resource.ResolutionUnit);
                AssertAreEqual(expectedValue[26], resource.Comp);
                AssertAreEqual(expectedValue[27], resource.CompId);
                AssertAreEqual(expectedValue[28], resource.OriginalCompId);
                AssertAreEqual(expectedValue[29], resource.PlacedId.ToString());
                AssertAreEqual(expectedValue[30], resource.NonAffineTransformMatrix);
                if (resource.IsCustom)
                {
                    AssertAreEqual(expectedValue[31], resource.HorizontalMeshPointUnit);
                    AssertAreEqual((double[])expectedValue[32], resource.HorizontalMeshPoints);
                    AssertAreEqual(expectedValue[33], resource.VerticalMeshPointUnit);
                    AssertAreEqual((double[])expectedValue[34], resource.VerticalMeshPoints);
                }
            }

            void SetNewSmartValues(SmartObjectResource resource, object[] newValues)
            {
                // This values we do not change in resource
                newValues[0] = resource.IsCustom;
                newValues[1] = resource.UniqueId.ToString();
                newValues[5] = resource.PlacedLayerType;
                newValues[14] = resource.UOrder;
                newValues[15] = resource.VOrder;
                newValues[28] = resource.OriginalCompId;

                // This values should be changed in the PlLdResource (with the specified UniqueId) as well
                // and some of them must be in accord with the underlining smart object in the LinkDataSource
                resource.PageNumber = (int)newValues[2]; // 2;
                resource.TotalPages = (int)newValues[3]; // 3;
                resource.AntiAliasPolicy = (int)newValues[4]; // 0;
                resource.TransformMatrix = (double[])newValues[6];
                resource.Value = (double)newValues[7]; // 1.23456789;
                resource.Perspective = (double)newValues[8]; // 0.123456789;
                resource.PerspectiveOther = (double)newValues[9]; // 0.987654321;
                resource.Top = (double)newValues[10]; // -126;
                resource.Left = (double)newValues[11]; // -215;
                resource.Bottom = (double)newValues[12]; // 248;
                resource.Right = (double)newValues[13]; // 145;
                resource.Crop = (int)newValues[16]; // 5;
                resource.FrameStepNumerator = (int)newValues[17]; // 1;
                resource.FrameStepDenominator = (int)newValues[18]; // 601;
                resource.DurationNumerator = (int)newValues[19]; // 2;
                resource.DurationDenominator = (int)newValues[20]; // 602;
                resource.FrameCount = (int)newValues[21]; // 11;
                resource.Width = (double)newValues[22]; // 541;
                resource.Height = (double)newValues[23]; // 249;
                resource.Resolution = (double)newValues[24]; // 144;
                resource.ResolutionUnit = (UnitTypes)newValues[25];
                resource.Comp = (int)newValues[26]; // 21;
                resource.CompId = (int)newValues[27]; // 22;
                resource.NonAffineTransformMatrix = (double[])newValues[30];

                // This unique Id should be changed in references if any
                resource.PlacedId = new Guid((string)newValues[29]);  // "12345678-9abc-def0-9876-54321fecba98");
                if (resource.IsCustom)
                {
                    resource.HorizontalMeshPointUnit = (UnitTypes)newValues[31];
                    resource.HorizontalMeshPoints = (double[])newValues[32];
                    resource.VerticalMeshPointUnit = (UnitTypes)newValues[33];
                    resource.VerticalMeshPoints = (double[])newValues[34];
                }

                // Be careful with some parameters: the saved image may become unreadable by Adobe® Photoshop®
                ////resource.UOrder = 6;
                ////resource.VOrder = 9;

                // Do no change this otherwise you won't be able to use free transform
                // or change the underlining smart object to the vector type
                ////resource.PlacedLayerType = PlacedLayerType.Vector;

                // There should be valid PlLdResource with this unique Id
                ////resource.UniqueId = new Guid("98765432-10fe-cba0-1234-56789abcdef0");
            }

            object[] newSmartValues = new object[]
            {
                true,
                null,
                2,
                3,
                0,
                PlacedLayerType.ImageStack,
                new double[8]
                {
                    12.937922786050663,
                    19.419959734187131,
                    2.85445817782261,
                    1.0540625423957124,
                    7.20861031651307,
                    14.634102808208553,
                    17.292074924741144,
                    4
                },
                1.23456789,
                0.123456789,
                0.987654321,
                -126d,
                -215d,
                248d,
                145d,
                4,
                4,
                5,
                1,
                601,
                2,
                602,
                11,
                541d,
                249d,
                144d,
                UnitTypes.Percent,
                21,
                22,
                23,
                "12345678-9abc-def0-9876-54321fecba98",
                new double[8]
                {
                    129.937922786050663,
                    195.419959734187131,
                    26.85445817782261,
                    12.0540625423957124,
                    72.20861031651307,
                    147.634102808208553,
                    175.292074924741144,
                    42
                },
                UnitTypes.Points,
                new double[16]
                {
                    0.01d, 103.33333333333433d, 206.66686666666666d, 310.02d,
                    0.20d, 103.33333333333533d, 206.69666666666666d, 310.03d,
                    30.06d, 103.33333333336333d, 206.66660666666666d, 310.04d,
                    04.05d, 103.33333333373333d, 206.66666166666666d, 310.05d
                },
                UnitTypes.Distance,
                new double[16]
                {
                    0.06d, 0.07d, 0.08d, 0.09d,
                    49.066666666666664d, 49.266666666666664d, 49.566666666666664d, 49.766666666666664d,
                    99.133333333333329d, 99.433333333333329d, 99.633333333333329d, 99.833333333333329d,
                    140, 141, 142, 143,
                },
            };

            object[] expectedValues = new object[]
            {
                new object[]
                {
                    false,
                    "5867318f-3174-9f41-abca-22f56a75247e",
                    1,
                    1,
                    0x10,
                    PlacedLayerType.Raster,
                    new double[8]
                    {
                        0, 0, 2, 0, 2, 2, 0, 2
                    },
                    0d,
                    0d,
                    0d,
                    0d,
                    0d,
                    2d,
                    2d,
                    4,
                    4,
                    1,
                    0,
                    600,
                    0,
                    600,
                    1,
                    2d,
                    2d,
                    72d,
                    UnitTypes.Density,
                    -1,
                    -1,
                    -1,
                    "64b3997c-06e0-be40-a349-41acf397c897",
                    new double[8]
                    {
                        0, 0, 2, 0, 2, 2, 0, 2
                    },
                }
            };

            var sourceFilePath = baseFolder + "rgb8_2x2_linked.psd";
            var outputPath = output + "rgb8_2x2_linked_output.psd";
            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
            {
                SoLeResource soleResource = null;
                int index = 0;
                foreach (Layer imageLayer in image.Layers)
                {
                    foreach (var imageResource in imageLayer.Resources)
                    {
                        var resource = imageResource as SoLeResource;
                        if (resource != null)
                        {
                            soleResource = resource;
                            var expectedValue = (object[])expectedValues[index++];
                            AssertAreEqual(expectedValue[1], resource.UniqueId.ToString());
                            CheckSmartObjectResourceValues(expectedValue, resource);
                            SetNewSmartValues(resource, newSmartValues);

                            break;
                        }
                    }
                }

                AssertIsTrue(soleResource != null);
                image.Save(outputPath, new PsdOptions(image));
                using (PsdImage savedImage = (PsdImage)Image.Load(outputPath))
                {
                    foreach (Layer imageLayer in savedImage.Layers)
                    {
                        foreach (var imageResource in imageLayer.Resources)
                        {
                            var resource = imageResource as SoLeResource;
                            if (resource != null)
                            {
                                CheckSmartObjectResourceValues(newSmartValues, resource);

                                break;
                            }
                        }
                    }
                }
            }

            //ExEnd:SupportOfPlacedResource

            Console.WriteLine("SupportOfPlacedResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfPlacedResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfSoLdResource.cs ---
﻿using System;
using System.Collections;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfSoLdResource
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfSoLdResource
            //ExSummary:The following code demonstrates the support of the SoLdResource resource.

            // This example shows how to get or set the smart object layer data properties of the PSD file.

            void AssertAreEqual(object actual, object expected)
            {
                var areEqual = object.Equals(actual, expected);
                if (!areEqual && actual is Array && expected is Array)
                {
                    var actualArray = (Array)actual;
                    var expectedArray = (Array)actual;
                    if (actualArray.Length == expectedArray.Length)
                    {
                        for (int i = 0; i < actualArray.Length; i++)
                        {
                            if (!object.Equals(actualArray.GetValue(i), expectedArray.GetValue(i)))
                            {
                                break;
                            }
                        }

                        areEqual = true;
                    }
                }

                if (!areEqual)
                {
                    throw new FormatException(
                        string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            var sourceFilePath = baseFolder + "LayeredSmartObjects8bit2.psd";
            var outputFilePath = output + "LayeredSmartObjects8bit2_output.psd";
            var expectedValues = new object[]
            {
                new object[]
                {
                    true,
                    "76f05a3b-7523-5e42-a1bb-27f4735bffa0",
                    1,
                    1,
                    0x10,
                    PlacedLayerType.Raster,
                    new double[8]
                    {
                        29.937922786050663,
                        95.419959734187131,
                        126.85445817782261,
                        1.0540625423957124,
                        172.20861031651307,
                        47.634102808208553,
                        75.292074924741144,
                        142
                    },
                    0.0,
                    0.0,
                    0.0,
                    0d,
                    0d,
                    149d,
                    310d,
                    4,
                    4,
                    1,
                    0,
                    600,
                    0,
                    600,
                    1,
                    310d,
                    149d,
                    72d,
                    UnitTypes.Density,
                    -1,
                    -1,
                    -1,
                    "d3388655-19e4-9742-82f2-f553bb01046a",
                    new double[8]
                    {
                        29.937922786050663,
                        95.419959734187131,
                        126.85445817782261,
                        1.0540625423957124,
                        172.20861031651307,
                        47.634102808208553,
                        75.292074924741144,
                        142
                    },
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d,
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d,
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d,
                        0.0d, 103.33333333333333d, 206.66666666666666d, 310.0d
                    },
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0d, 0.0d, 0.0d, 0.0d,
                        49.666666666666664d, 49.666666666666664d, 49.666666666666664d, 49.666666666666664d,
                        99.333333333333329d, 99.333333333333329d, 99.333333333333329d, 99.333333333333329d,
                        149, 149, 149, 149,
                    },
                },
                new object[]
                {
                    true,
                    "cf0477a8-8f92-ac4f-9462-f78e26234851",
                    1,
                    1,
                    0x10,
                    PlacedLayerType.Raster,
                    new double[8]
                    {
                        37.900314592235681,
                        -0.32118219433001371,
                        185.94210608826535,
                        57.7076819802063,
                        153.32047433609358,
                        140.9311755779743,
                        5.2786828400639294,
                        82.902311403437977,
                    },
                    0.0,
                    0.0,
                    0.0,
                    0d,
                    0d,
                    721d,
                    1280d,
                    4,
                    4,
                    1,
                    0,
                    600,
                    0,
                    600,
                    1,
                    1280d,
                    721d,
                    72d,
                    UnitTypes.Density,
                    -1,
                    -1,
                    -1,
                    "625cc4b9-2c5f-344f-8636-03caf2bd3489",
                    new double[8]
                    {
                        37.900314592235681,
                        -0.32118219433001371,
                        185.94210608826535,
                        57.7076819802063,
                        153.32047433609358,
                        140.9311755779743,
                        5.2786828400639294,
                        82.902311403437977,
                    },
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                        0.0, 426.66666666666663, 853.33333333333326, 1280,
                    },
                    UnitTypes.Pixels,
                    new double[16]
                    {
                        0.0, 0.0, 0.0, 0.0,
                        240.33333333333331, 240.33333333333331, 240.33333333333331, 240.33333333333331,
                        480.66666666666663, 480.66666666666663, 480.66666666666663, 480.66666666666663,
                        721, 721, 721, 721,
                    },
                    0,
                    0
                }
            };

            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
            {
                SoLdResource resource = null;
                int index = 0;
                foreach (Layer imageLayer in image.Layers)
                {
                    foreach (var imageResource in imageLayer.Resources)
                    {
                        resource = imageResource as SoLdResource;
                        if (resource != null)
                        {
                            var expectedValue = (object[])expectedValues[index++];
                            AssertAreEqual(expectedValue[0], resource.IsCustom);
                            AssertAreEqual(expectedValue[1], resource.UniqueId.ToString());
                            AssertAreEqual(expectedValue[2], resource.PageNumber);
                            AssertAreEqual(expectedValue[3], resource.TotalPages);
                            AssertAreEqual(expectedValue[4], resource.AntiAliasPolicy);
                            AssertAreEqual(expectedValue[5], resource.PlacedLayerType);
                            AssertAreEqual(8, resource.TransformMatrix.Length);
                            AssertAreEqual((double[])expectedValue[6], resource.TransformMatrix);
                            AssertAreEqual(expectedValue[7], resource.Value);
                            AssertAreEqual(expectedValue[8], resource.Perspective);
                            AssertAreEqual(expectedValue[9], resource.PerspectiveOther);
                            AssertAreEqual(expectedValue[10], resource.Top);
                            AssertAreEqual(expectedValue[11], resource.Left);
                            AssertAreEqual(expectedValue[12], resource.Bottom);
                            AssertAreEqual(expectedValue[13], resource.Right);
                            AssertAreEqual(expectedValue[14], resource.UOrder);
                            AssertAreEqual(expectedValue[15], resource.VOrder);

                            AssertAreEqual(expectedValue[16], resource.Crop);
                            AssertAreEqual(expectedValue[17], resource.FrameStepNumerator);
                            AssertAreEqual(expectedValue[18], resource.FrameStepDenominator);
                            AssertAreEqual(expectedValue[19], resource.DurationNumerator);
                            AssertAreEqual(expectedValue[20], resource.DurationDenominator);
                            AssertAreEqual(expectedValue[21], resource.FrameCount);
                            AssertAreEqual(expectedValue[22], resource.Width);
                            AssertAreEqual(expectedValue[23], resource.Height);
                            AssertAreEqual(expectedValue[24], resource.Resolution);
                            AssertAreEqual(expectedValue[25], resource.ResolutionUnit);
                            AssertAreEqual(expectedValue[26], resource.Comp);
                            AssertAreEqual(expectedValue[27], resource.CompId);
                            AssertAreEqual(expectedValue[28], resource.OriginalCompId);
                            AssertAreEqual(expectedValue[29], resource.PlacedId.ToString());
                            AssertAreEqual((IEnumerable)expectedValue[30], resource.NonAffineTransformMatrix);
                            if (resource.IsCustom)
                            {
                                AssertAreEqual(expectedValue[31], resource.HorizontalMeshPointUnit);
                                AssertAreEqual((double[])expectedValue[32], resource.HorizontalMeshPoints);
                                AssertAreEqual(expectedValue[33], resource.VerticalMeshPointUnit);
                                AssertAreEqual((double[])expectedValue[34], resource.VerticalMeshPoints);
                                var temp = resource.VerticalMeshPoints;
                                resource.VerticalMeshPoints = resource.HorizontalMeshPoints;
                                resource.HorizontalMeshPoints = temp;
                            }

                            // This values should be changed in the PlLdResource (with the specified UniqueId) as well
                            // and some of them must be in accord with the underlining smart object in the LinkDataSource
                            resource.PageNumber = 2;
                            resource.TotalPages = 3;
                            resource.AntiAliasPolicy = 0;
                            resource.Value = 1.23456789;
                            resource.Perspective = 0.123456789;
                            resource.PerspectiveOther = 0.987654321;
                            resource.Top = -126;
                            resource.Left = -215;
                            resource.Bottom = 248;
                            resource.Right = 145;
                            resource.Crop = 4;
                            resource.FrameStepNumerator = 1;
                            resource.FrameStepDenominator = 601;
                            resource.DurationNumerator = 2;
                            resource.DurationDenominator = 602;
                            resource.FrameCount = 11;
                            resource.Width = 541;
                            resource.Height = 249;
                            resource.Resolution = 144;
                            resource.Comp = 21;
                            resource.CompId = 22;
                            resource.TransformMatrix = new double[8]
                            {
                                12.937922786050663,
                                19.419959734187131,
                                2.85445817782261,
                                1.0540625423957124,
                                7.20861031651307,
                                14.634102808208553,
                                17.292074924741144,
                                4
                            };
                            resource.NonAffineTransformMatrix = new double[8]
                            {
                                129.937922786050663,
                                195.419959734187131,
                                26.85445817782261,
                                12.0540625423957124,
                                72.20861031651307,
                                147.634102808208553,
                                175.292074924741144,
                                42
                            };

                            // This unique Id should be changed in references if any
                            resource.PlacedId = new Guid("12345678-9abc-def0-9876-54321fecba98");

                            // Be careful with some parameters: image may became unreadable by Adobe® Photoshop®
                            ////resource.UOrder = 6;
                            ////resource.VOrder = 9;

                            // Do no change this otherwise you won't be able to use free transform
                            // or change the underlining smart object to the vector type
                            ////resource.PlacedLayerType = PlacedLayerType.Vector;

                            // There should be valid PlLdResource with this unique Id
                            ////resource.UniqueId = new Guid("98765432-10fe-cba0-1234-56789abcdef0");

                            break;
                        }
                    }
                }

                AssertAreEqual(true, resource != null);
                image.Save(outputFilePath, new PsdOptions(image));
            }

            //ExEnd:SupportOfSoLdResource

            Console.WriteLine("SupportOfSoLdResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfSoLdResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfVectorShapeTransformOfVogkResource.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.CoreExceptions.ImageFormats;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfVectorShapeTransformOfVogkResource
    {
        public static void Run()
        {
            //ExStart:SupportOfVectorShapeTransformOfVogkResource

            // The path to the document's directory.
            string sourceDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            // This example shows how to get and set new Transform and OriginBoxCorners properties
            // of ShapeOriginSettings in the Vogk resource of FillLayer in the PSD file

            string sourceFileName = Path.Combine(sourceDir, "vectorShape_25_50.psd");
            string outputPath = Path.Combine(outputDir, "result.psd");

            VectorShapeOriginSettings originalSetting;
            const int layerIndex = 0;

            // Load the original image
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                AssertIsTrue(layerIndex < image.Layers.Length);
                var layer = image.Layers[layerIndex];
                AssertIsTrue(layer is ShapeLayer);
                var resource = GetVogkResource(layer);
                AssertAreEqual(1, resource.ShapeOriginSettings.Length);

                // Assert after reading
                var setting = resource.ShapeOriginSettings[0];
                AssertAreEqual(false, setting.IsShapeInvalidatedPresent);
                AssertAreEqual(false, setting.IsOriginRadiiRectanglePresent);
                AssertAreEqual(true, setting.IsOriginIndexPresent);
                AssertAreEqual(0, setting.OriginIndex);
                AssertAreEqual(true, setting.IsOriginTypePresent);
                AssertAreEqual(5, setting.OriginType);
                AssertAreEqual(true, setting.IsOriginShapeBBoxPresent);
                AssertAreEqual(Rectangle.FromLeftTopRightBottom(3, 7, 10, 22), setting.OriginShapeBox.Bounds);
                AssertAreEqual(true, setting.IsOriginResolutionPresent);
                AssertAreEqual(300d, setting.OriginResolution);

                // Assert new properties
                AssertAreEqual(true, setting.IsTransformPresent);
                AssertAreEqual(0d, setting.Transform.Tx);
                AssertAreEqual(0d, setting.Transform.Ty);
                AssertAreEqual(0.050000000000000003d, setting.Transform.Xx);
                AssertAreEqual(0d, setting.Transform.Yx);
                AssertAreEqual(0d, setting.Transform.Xy);
                AssertAreEqual(0.1d, setting.Transform.Yy);
                AssertAreEqual(true, setting.IsOriginBoxCornersPresent);
                AssertAreEqual(2.9000000000000004d, setting.OriginBoxCorners[0]);
                AssertAreEqual(7.3000000000000007d, setting.OriginBoxCorners[1]);
                AssertAreEqual(10.450000000000001d, setting.OriginBoxCorners[2]);
                AssertAreEqual(7.3000000000000007d, setting.OriginBoxCorners[3]);
                AssertAreEqual(10.450000000000001d, setting.OriginBoxCorners[4]);
                AssertAreEqual(22.400000000000002d, setting.OriginBoxCorners[5]);
                AssertAreEqual(2.9000000000000004d, setting.OriginBoxCorners[6]);
                AssertAreEqual(22.400000000000002d, setting.OriginBoxCorners[7]);

                // Set new properties
                originalSetting = resource.ShapeOriginSettings[0];
                originalSetting.Transform.Tx = 0.2d;
                originalSetting.Transform.Ty = 0.3d;
                originalSetting.Transform.Xx = 0.4d;
                originalSetting.Transform.Xy = 0.5d;
                originalSetting.Transform.Yx = 0.6d;
                originalSetting.Transform.Yy = 0.7d;
                originalSetting.OriginBoxCorners = new double[8] { 9, 8, 7, 6, 5, 4, 3, 2 };

                // Save this PSD image with changed propeties.
                image.Save(outputPath, new PsdOptions(image));
            }

            // Load the saved PSD image with changed propeties.
            using (PsdImage image = (PsdImage)Image.Load(outputPath))
            {
                var layer = image.Layers[layerIndex];
                AssertIsTrue(layer is ShapeLayer);
                var resource = GetVogkResource(layer);
                AssertAreEqual(1, resource.ShapeOriginSettings.Length);

                // Assert that properties are saved and loaded correctly 
                var setting = resource.ShapeOriginSettings[0];
                AssertAreEqual(true, setting.IsOriginIndexPresent);
                AssertAreEqual(false, setting.IsShapeInvalidatedPresent);
                AssertAreEqual(true, setting.IsOriginResolutionPresent);
                AssertAreEqual(true, setting.IsOriginTypePresent);
                AssertAreEqual(true, setting.IsOriginShapeBBoxPresent);
                AssertAreEqual(false, setting.IsOriginRadiiRectanglePresent);
                AssertAreEqual(0, setting.OriginIndex);
                AssertAreEqual(true, setting.IsTransformPresent);
                AssertAreEqual(0.2d, setting.Transform.Tx);
                AssertAreEqual(0.3d, setting.Transform.Ty);
                AssertAreEqual(0.4d, setting.Transform.Xx);
                AssertAreEqual(0.5d, setting.Transform.Xy);
                AssertAreEqual(0.6d, setting.Transform.Yx);
                AssertAreEqual(0.7d, setting.Transform.Yy);
                AssertAreEqual(true, setting.IsOriginBoxCornersPresent);
                AssertAreEqual(originalSetting.OriginBoxCorners[0], setting.OriginBoxCorners[0]);
                AssertAreEqual(originalSetting.OriginBoxCorners[1], setting.OriginBoxCorners[1]);
                AssertAreEqual(originalSetting.OriginBoxCorners[2], setting.OriginBoxCorners[2]);
                AssertAreEqual(originalSetting.OriginBoxCorners[3], setting.OriginBoxCorners[3]);
                AssertAreEqual(originalSetting.OriginBoxCorners[4], setting.OriginBoxCorners[4]);
                AssertAreEqual(originalSetting.OriginBoxCorners[5], setting.OriginBoxCorners[5]);
                AssertAreEqual(originalSetting.OriginBoxCorners[6], setting.OriginBoxCorners[6]);
                AssertAreEqual(originalSetting.OriginBoxCorners[7], setting.OriginBoxCorners[7]);
            }

            VogkResource GetVogkResource(Layer layer)
            {
                if (layer == null)
                {
                    throw new PsdImageArgumentException("The parameter layer should not be null.");
                }

                VogkResource resource = null;
                var resources = layer.Resources;
                for (int i = 0; i < resources.Length; i++)
                {
                    if (resources[i] is VogkResource)
                    {
                        resource = (VogkResource)resources[i];
                        break;
                    }
                }

                if (resource == null)
                {
                    throw new PsdImageException("VogkResource not found.");
                }

                return resource;
            }

            void AssertIsTrue(bool condition)
            {
                if (!condition)
                {
                    throw new FormatException(string.Format("Expected true"));
                }
            }

            void AssertAreEqual(object actual, object expected)
            {
                if (!object.Equals(actual, expected))
                {
                    throw new FormatException(string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            //ExEnd:SupportOfVectorShapeTransformOfVogkResource

            File.Delete(outputPath);
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfVectorShapeTransformOfVogkResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfVibAResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    internal class SupportOfVibAResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfVibAResource
            //ExSummary:The following code example demonstrates the support of the VibAResource resource.

            // Example of the support of read and write Vibration Resource at runtime.
            string sourceFileName = Path.Combine(SourceDir, "VibranceResource.psd");
            string outputFileName = Path.Combine(OutputDir, "out_VibranceResource.psd");

            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in image.Layers)
                {
                    foreach (var resource in layer.Resources)
                    {
                        if (resource is VibAResource)
                        {
                            var vibranceResource = (VibAResource)resource;

                            int vibranceValue =  vibranceResource.Vibrance;
                            int saturationValue = vibranceResource.Saturation;

                            vibranceResource.Vibrance = vibranceValue * 2;
                            vibranceResource.Saturation = saturationValue * 2;

                            break;
                        }
                    }
                }

                image.Save(outputFileName);
            }

            //ExEnd:SupportOfVibAResource

            Console.WriteLine("SupportOfVibAResource executed successfully");

            File.Delete(outputFileName);
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfVibAResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfVogkResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfVogkResource
    {
        public static void Run()
        {
            //ExStart:SupportOfVogkResource
            // VogkResource Support
            void ExampleOfVogkResourceSupport()
            {
                // The path to the documents directory.
                string SourceDir = RunExamples.GetDataDir_PSD();
                string OutputDir = RunExamples.GetDataDir_Output();

                string fileName = Path.Combine(SourceDir, "VectorOriginationDataResource.psd");
                string outFileName = Path.Combine(OutputDir, "out_VectorOriginationDataResource_.psd");

                using (var psdImage = (PsdImage)Image.Load(fileName))
                {
                    var resource = GetVogkResource(psdImage);

                    // Reading
                    if (resource.ShapeOriginSettings.Length != 1 ||
                        !resource.ShapeOriginSettings[0].IsShapeInvalidated ||
                        resource.ShapeOriginSettings[0].OriginIndex != 0)
                    {
                        throw new Exception("VogkResource were read wrong.");
                    }

                    // Editing
                    resource.ShapeOriginSettings = new[]
                    {
                    resource.ShapeOriginSettings[0],
                    new VectorShapeOriginSettings(true, 1)
                };

                    psdImage.Save(outFileName);
                }
            }

            VogkResource GetVogkResource(PsdImage image)
            {
                var layer = image.Layers[1];

                VogkResource resource = null;
                var resources = layer.Resources;
                for (int i = 0; i < resources.Length; i++)
                {
                    if (resources[i] is VogkResource)
                    {
                        resource = (VogkResource)resources[i];
                        break;
                    }
                }

                if (resource == null)
                {
                    throw new Exception("VogkResourcenot found.");
                }

                return resource;
            }


            ExampleOfVogkResourceSupport();

            //ExEnd:SupportOfVogkResource

            Console.WriteLine("SupportOfVogkResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfVogkResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfVogkResourceProperties.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class SupportOfVogkResourceProperties
    {
        public static void Run()
        {
            //ExStart:SupportOfVogkResourceProperties

            // This example demonstrates that loading and saving the PSD image with shape layers and vector paths works correctly.

            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            string sourcePath = Path.Combine(SourceDir, "vectorShapes.psd");
            string outputFilePath = Path.Combine(OutputDir, "output_vectorShapes.psd");
            using (PsdImage image = (PsdImage)Image.Load(sourcePath))
            {
                var resource = GetVogkResource(image);
                AssertAreEqual(1, resource.ShapeOriginSettings.Length);
                var setting = resource.ShapeOriginSettings[0];
                AssertAreEqual(true, setting.IsOriginIndexPresent);
                AssertAreEqual(false, setting.IsShapeInvalidatedPresent);
                AssertAreEqual(true, setting.IsOriginResolutionPresent);
                AssertAreEqual(true, setting.IsOriginTypePresent);
                AssertAreEqual(true, setting.IsOriginShapeBBoxPresent);
                AssertAreEqual(false, setting.IsOriginRadiiRectanglePresent);
                AssertAreEqual(0, setting.OriginIndex);
                var originalSetting = resource.ShapeOriginSettings[0];
                originalSetting.IsShapeInvalidated = true;
                resource.ShapeOriginSettings = new[]
                {
                    originalSetting,
                    new VectorShapeOriginSettings()
                    {
                        OriginIndex = 1,
                        OriginResolution = 144,
                        OriginType = 4,
                        OriginShapeBox = new VectorShapeBoundingBox()
                        {
                            Bounds = Rectangle.FromLeftTopRightBottom(10, 15, 40, 70)
                        }
                    },
                    new VectorShapeOriginSettings()
                    {
                        OriginIndex = 2,
                        OriginResolution = 301,
                        OriginType = 5,
                        OriginRadiiRectangle = new VectorShapeRadiiRectangle()
                        {
                            TopLeft = 2,
                            TopRight = 6,
                            BottomLeft = 23,
                            BottomRight = 42,
                            QuadVersion = 1
                        }
                    }
                };

                image.Save(outputFilePath, new PsdOptions());
            }

            using (PsdImage image = (PsdImage)Image.Load(outputFilePath))
            {
                var resource = GetVogkResource(image);
                AssertAreEqual(3, resource.ShapeOriginSettings.Length);

                var setting = resource.ShapeOriginSettings[0];
                AssertAreEqual(true, setting.IsOriginIndexPresent);
                AssertAreEqual(true, setting.IsShapeInvalidatedPresent);
                AssertAreEqual(true, setting.IsOriginResolutionPresent);
                AssertAreEqual(true, setting.IsOriginTypePresent);
                AssertAreEqual(true, setting.IsOriginShapeBBoxPresent);
                AssertAreEqual(false, setting.IsOriginRadiiRectanglePresent);
                AssertAreEqual(0, setting.OriginIndex);
                AssertAreEqual(true, setting.IsShapeInvalidated);

                setting = resource.ShapeOriginSettings[1];
                AssertAreEqual(true, setting.IsOriginIndexPresent);
                AssertAreEqual(false, setting.IsShapeInvalidatedPresent);
                AssertAreEqual(true, setting.IsOriginResolutionPresent);
                AssertAreEqual(true, setting.IsOriginTypePresent);
                AssertAreEqual(true, setting.IsOriginShapeBBoxPresent);
                AssertAreEqual(false, setting.IsOriginRadiiRectanglePresent);
                AssertAreEqual(1, setting.OriginIndex);
                AssertAreEqual(144.0, setting.OriginResolution);
                AssertAreEqual(4, setting.OriginType);
                AssertAreEqual(Rectangle.FromLeftTopRightBottom(10, 15, 40, 70), setting.OriginShapeBox.Bounds);

                setting = resource.ShapeOriginSettings[2];
                AssertAreEqual(true, setting.IsOriginIndexPresent);
                AssertAreEqual(false, setting.IsShapeInvalidatedPresent);
                AssertAreEqual(true, setting.IsOriginResolutionPresent);
                AssertAreEqual(true, setting.IsOriginTypePresent);
                AssertAreEqual(false, setting.IsOriginShapeBBoxPresent);
                AssertAreEqual(true, setting.IsOriginRadiiRectanglePresent);
                AssertAreEqual(2, setting.OriginIndex);
                AssertAreEqual(301.0, setting.OriginResolution);
                AssertAreEqual(5, setting.OriginType);
                AssertAreEqual(2.0, setting.OriginRadiiRectangle.TopLeft);
                AssertAreEqual(6.0, setting.OriginRadiiRectangle.TopRight);
                AssertAreEqual(23.0, setting.OriginRadiiRectangle.BottomLeft);
                AssertAreEqual(42.0, setting.OriginRadiiRectangle.BottomRight);
                AssertAreEqual(1, setting.OriginRadiiRectangle.QuadVersion);
            }

            VogkResource GetVogkResource(PsdImage image)
            {
                var layer = image.Layers[1];

                VogkResource resource = null;
                var resources = layer.Resources;
                for (int i = 0; i < resources.Length; i++)
                {
                    if (resources[i] is VogkResource)
                    {
                        resource = (VogkResource)resources[i];
                        break;
                    }
                }

                if (resource == null)
                {
                    throw new Exception("VogkResource not found.");
                }

                return resource;
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new FormatException(message ?? "Objects are not equal.");
                }
            }

            //ExEnd:SupportOfVogkResourceProperties

            File.Delete(outputFilePath);

            Console.WriteLine("SupportOfVogkResourceProperties executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfVogkResourceProperties.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/SupportOfVstkResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.StrokeResources;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    public class SupportOfVstkResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfVstkResource
            //ExSummary:The following code demonstrates the support of VstkResource resource.

            string srcFile = Path.Combine(baseDir, "StrokeShapeTest1.psd");
            string dstFile = Path.Combine(outputDir, "StrokeShapeTest2.psd");

            using (PsdImage image = (PsdImage)Image.Load(srcFile))
            {
                Layer layer = image.Layers[1];
                foreach (LayerResource resource in layer.Resources)
                {
                    if (resource is VstkResource)
                    {
                        VstkResource vstkResource = (VstkResource)resource;
                        vstkResource.StrokeStyleLineAlignment = StrokePosition.Outside;
                        vstkResource.StrokeStyleLineWidth = 20;
                    }
                }
            
                image.Save(dstFile);
            }

            //ExEnd:SupportOfVstkResource

            File.Delete(dstFile);

            Console.WriteLine("SupportOfVstkResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/SupportOfVstkResource.cs ---

--- START OF FILE CSharp/Aspose/LayerResources/VsmsResourceLengthRecordSupport.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using Aspose.PSD.FileFormats.Core.VectorPaths;

namespace Aspose.PSD.Examples.Aspose.LayerResources
{
    class VsmsResourceLengthRecordSupport
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:VsmsResourceLengthRecordSupport
            //ExSummary:The following code example demonstrates the support of new LengthRecord properties, PathOperations (boolean operations), ShapeIndex and BezierKnotRecordsCount.
            string fileName = SourceDir + "PathOperationsShape.psd";
            string outFileName = OutputDir + "out_PathOperationsShape.psd";
            using (var im = (PsdImage)Image.Load(fileName))
            {
                VsmsResource resource = null;
                foreach (var layerResource in im.Layers[1].Resources)
                {
                    if (layerResource is VsmsResource)
                    {
                        resource = (VsmsResource)layerResource;
                        break;
                    }
                }

                LengthRecord lengthRecord0 = (LengthRecord)resource.Paths[2];
                LengthRecord lengthRecord1 = (LengthRecord)resource.Paths[7];
                LengthRecord lengthRecord2 = (LengthRecord)resource.Paths[11];

                // Here we changin the way to combining betwen shapes.
                lengthRecord0.PathOperations = PathOperations.ExcludeOverlappingShapes;
                lengthRecord1.PathOperations = PathOperations.IntersectShapeAreas;
                lengthRecord2.PathOperations = PathOperations.SubtractFrontShape;

                im.Save(outFileName);
            }
            //ExEnd:SupportForClblResource

            Console.WriteLine("VsmsResourceLengthRecordSupport executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/LayerResources/VsmsResourceLengthRecordSupport.cs ---

--- START OF FILE CSharp/Aspose/Licensing/MeteredLicensing.cs ---
﻿using System;

namespace Aspose.PSD.Examples.Licensing
{
    class MeteredLicensing
    {
        public static void Run()
        {
            //ExStart:MeteredLicensing

            // Create an instance of CAD Metered class
            Metered metered = new Metered();

            // Access the setMeteredKey property and pass public and private keys as parameters
            metered.SetMeteredKey("*****", "*****");

            // Get metered data amount before calling API
            decimal amountbefore = Metered.GetConsumptionQuantity();

            // Display information
            Console.WriteLine("Amount Consumed Before: " + amountbefore.ToString());
            // Get metered data amount After calling API
            decimal amountafter = Metered.GetConsumptionQuantity();

            // Display information
            Console.WriteLine("Amount Consumed After: " + amountafter.ToString());

            //ExEnd:MeteredLicensing
        }
    }
}
--- END OF FILE CSharp/Aspose/Licensing/MeteredLicensing.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToGIF.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class AIToGIF
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_AI();

            //ExStart:AIToGIF

            string[] sourcesFiles = new string[]
            {
                @"34992OStroke",
                @"rect2_color",
            };

            for (int i = 0; i < sourcesFiles.Length; i++)
            {
                string name = sourcesFiles[i];
                string sourceFileName = dataDir + name + ".ai";
                string outFileName = dataDir + name + ".gif";


                using (AiImage image = (AiImage)Image.Load(sourceFileName))
                {

                    ImageOptionsBase options = new GifOptions() { DoPaletteCorrection = false };
                    image.Save(outFileName, options);

                }
            }

            //ExEnd:AIToGIF
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToGIF.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToJPG.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class AIToJPG
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_AI();

            //ExStart:AIToJPG
            string[] sourcesFiles = new string[]
            {
                @"34992OStroke",
                @"rect2_color",
            };

            for (int i = 0; i < sourcesFiles.Length; i++)
            {
                string name = sourcesFiles[i];
                string sourceFileName = dataDir + name + ".ai";
                string outFileName = dataDir + name + ".jpg";


                using (AiImage image = (AiImage)Image.Load(sourceFileName))
                {

                    ImageOptionsBase options = new JpegOptions() { Quality = 85 };
                    image.Save(outFileName, options);

                }
            }

            //ExEnd:AIToJPG
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToJPG.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPDF.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class AIToPDF
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:AIToPDF
            string sourceFileName = Path.Combine(baseDir, "ai_one.ai");
            string outFileName = Path.Combine(outputDir, "rect2_color.pdf");

            ImageOptionsBase pdfOptions = new PdfOptions();
            
            using (AiImage image = (AiImage)Image.Load(sourceFileName))
            {
                image.Save(outFileName, pdfOptions);
            }
            //ExEnd:AIToPDF

            File.Delete(outFileName);

            Console.WriteLine("AIToPDF executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPDF.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPDFA1a.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.FileFormats.Pdf;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    public class AIToPDFA1a
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:AIToPDFA1a
            string sourceFileName = Path.Combine(baseDir, "ai_one.ai");
            string outFileNamePdfA1a = Path.Combine(outputDir, "rect2_color.pdf");

            var pdfOptionsPdfA1a = new PdfOptions();
            pdfOptionsPdfA1a.PdfCoreOptions = new PdfCoreOptions();
            pdfOptionsPdfA1a.PdfCoreOptions.PdfCompliance = PdfComplianceVersion.PdfA1a;
            
            using (AiImage image = (AiImage)Image.Load(sourceFileName))
            {
                image.Save(outFileNamePdfA1a, pdfOptionsPdfA1a);
            }
            //ExEnd:AIToPDFA1a

            File.Delete(outFileNamePdfA1a);

            Console.WriteLine("AIToPDFA1a executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPDFA1a.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPNG.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class AIToPNG
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_AI();

            //ExStart:AIToPNG

            string[] sourcesFiles = new string[]
            {
                @"34992OStroke",
                @"rect2_color",
            };

            for (int i = 0; i < sourcesFiles.Length; i++)
            {
                string name = sourcesFiles[i];
                string sourceFileName = dataDir + name + ".ai";
                string outFileName = dataDir + name + ".png";


                using (AiImage image = (AiImage)Image.Load(sourceFileName))
                {

                    ImageOptionsBase options = new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha };
                    image.Save(outFileName, options);

                }
            }

            //ExEnd:AIToPNG
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPNG.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPSD.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class AIToPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_AI();

            //ExStart:AIToPSD
            string[] sourcesFiles = new string[]
            {
                @"34992OStroke",
                @"rect2_color",
            };

            for (int i = 0; i < sourcesFiles.Length; i++)
            {
                string name = sourcesFiles[i];
                string sourceFileName = dataDir + name + ".ai";
                string outFileName = dataDir + name + ".psd";


                using (AiImage image = (AiImage)Image.Load(sourceFileName))
                {

                    ImageOptionsBase options = new PsdOptions();
                    image.Save(outFileName, options);

                }
            }

            //ExEnd:AIToPSD
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToTIFF.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class AIToTIFF
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_AI();

            //ExStart:AIToTIFF

            string[] sourcesFiles = new string[]
            {
                @"34992OStroke",
                @"rect2_color",
            };

            for (int i = 0; i < sourcesFiles.Length; i++)
            {
                string name = sourcesFiles[i];
                string sourceFileName = dataDir + name + ".ai";
                string outFileName = dataDir + name + ".tif";


                using (AiImage image = (AiImage)Image.Load(sourceFileName))
                {

                    ImageOptionsBase options = new TiffOptions(TiffExpectedFormat.TiffDeflateRgba);
                    image.Save(outFileName, options);

                }
            }

            //ExEnd:AIToTIFF
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/AIToTIFF.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfAiFormatVersion8.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.ImageOptions;
namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class SupportOfAiFormatVersion8
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfAiFormatVersion8
            //ExSummary:The following example demonstrates how you can export AI file of 8 version to PSD and PNG format in Aspose.PSD
            string sourceFileName = dataDir + "form_8.ai";
            string outputFileName = dataDir + "form_8_export";
            using (AiImage image = (AiImage)Image.Load(sourceFileName))
            {
                image.Save(outputFileName + ".psd", new PsdOptions());
                image.Save(outputFileName + ".png", new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd:SupportOfAiFormatVersion8
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfAiFormatVersion8.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfAiImageXmpDataProperty.cs ---
using System;
using System.Globalization;
using System.IO;
using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.Xmp;
using Aspose.PSD.Xmp.Schemas.XmpBaseSchema;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    public class SupportOfAiImageXmpDataProperty
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfAiImageXmpDataProperty
            //ExSummary:The following code demonstrates the support of AiImage.XmpData property.
            
            string sourceFile = Path.Combine(baseDir, "ai_one.ai");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            void AssertIsNotNull(object testObject)
            {
                if (testObject == null)
                {
                    throw new Exception("Test object are null.");
                }
            }

            string creatorToolKey = ":CreatorTool";
            string nPagesKey = "xmpTPg:NPages";
            string unitKey = "stDim:unit";
            string heightKey = "stDim:h";
            string widthKey = "stDim:w";

            string expectedCreatorTool = "Adobe Illustrator CC 22.1 (Windows)";
            string expectedNPages = "1";
            string expectedUnit = "Pixels";
            double expectedHeight = 768;
            double expectedWidth = 1366;

            using (AiImage image = (AiImage)Image.Load(sourceFile))
            {
                // Xmp Metadata was added.
                var xmpMetaData = image.XmpData;

                AssertIsNotNull(xmpMetaData);

                // No we can get access to Xmp Packages of AI files.
                var basicPackage = xmpMetaData.GetPackage(Namespaces.XmpBasic) as XmpBasicPackage;
                var package = xmpMetaData.Packages[4];

                // And we have access to the content of these packages.
                var creatorTool = basicPackage[creatorToolKey].ToString();
                var nPages = package[nPagesKey];
                var unit = package[unitKey];
                var height = double.Parse(package[heightKey].ToString(), CultureInfo.InvariantCulture);
                var width = double.Parse(package[widthKey].ToString(), CultureInfo.InvariantCulture);

                AssertAreEqual(creatorTool, expectedCreatorTool);
                AssertAreEqual(nPages, expectedNPages);
                AssertAreEqual(unit, expectedUnit);
                AssertAreEqual(height, expectedHeight);
                AssertAreEqual(width, expectedWidth);
            }
            
            //ExEnd:SupportOfAiImageXmpDataProperty

            Console.WriteLine("SupportOfAiImageXmpDataProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfAiImageXmpDataProperty.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfHasMultiLayerMasksAndColorIndexProperties.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Ai;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    public class SupportOfHasMultiLayerMasksAndColorIndexProperties
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfHasMultiLayerMasksAndColorIndexProperties
            //ExSummary:The following code demonstrates support of HasMultiLayerMasks and ColorIndex properties in AiLayerSection.
            
            string sourceFile = Path.Combine(baseDir, "example.ai");
            string outputFilePath = Path.Combine(outputDir, "example.png");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            using (AiImage image = (AiImage)Image.Load(sourceFile))
            {
                AssertAreEqual(image.Layers.Length, 2);
                AssertAreEqual(image.Layers[0].HasMultiLayerMasks, false);
                AssertAreEqual(image.Layers[0].ColorIndex, -1);
                AssertAreEqual(image.Layers[1].HasMultiLayerMasks, false);
                AssertAreEqual(image.Layers[1].ColorIndex, -1);

                image.Save(outputFilePath, new PngOptions());
            }
            
            //ExEnd:SupportOfHasMultiLayerMasksAndColorIndexProperties

            File.Delete(outputFilePath);

            Console.WriteLine("SupportOfHasMultiLayerMasksAndColorIndexProperties executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfHasMultiLayerMasksAndColorIndexProperties.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfRasterImagesInAI.cs ---
﻿using Aspose.PSD.FileFormats.Ai;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI
{
    class SupportOfRasterImagesInAI
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_AI();

            //ExStart:SupportOfRasterImagesInAI
            const double DefaultTolerance = 1e-6;

            void AssertIsTrue(bool condition, string message)
            {
                if (!condition)
                {
                    throw new FormatException(message);
                }
            }

            string sourceFile = dataDir + "sample.ai";
            using (AiImage image = (AiImage)Image.Load(sourceFile))
            {
                AiLayerSection layer = image.Layers[0];

                AssertIsTrue(layer.RasterImages != null, "RasterImages property should be not null");
                AssertIsTrue(layer.RasterImages.Length == 1, "RasterImages property should contain exactly one item");

                AiRasterImageSection rasterImage = layer.RasterImages[0];
                AssertIsTrue(rasterImage.Pixels != null, "rasterImage.Pixels property should be not null");
                AssertIsTrue(rasterImage.Pixels.Length == 100, "rasterImage.Pixels property should contain exactly 100 items");
                AssertIsTrue((uint)rasterImage.Pixels[99] == 0xFFB21616, "rasterImage.Pixels[99] should be 0xFFB21616");
                AssertIsTrue((uint)rasterImage.Pixels[19] == 0xFF00FF00, "rasterImage.Pixels[19] should be 0xFF00FF00");
                AssertIsTrue((uint)rasterImage.Pixels[10] == 0xFF01FD00, "rasterImage.Pixels[10] should be 0xFF01FD00");
                AssertIsTrue((uint)rasterImage.Pixels[0] == 0xFF0000FF, "rasterImage.Pixels[0] should be 0xFF0000FF");
                AssertIsTrue(Math.Abs(0.999875 - rasterImage.Width) < DefaultTolerance, "rasterImage.Width should be 0.99987");
                AssertIsTrue(Math.Abs(0.999875 - rasterImage.Height) < DefaultTolerance, "rasterImage.Height should be 0.99987");
                AssertIsTrue(Math.Abs(387 - rasterImage.OffsetX) < DefaultTolerance, "rasterImage.OffsetX should be 387");
                AssertIsTrue(Math.Abs(379 - rasterImage.OffsetY) < DefaultTolerance, "rasterImage.OffsetY should be 379");
                AssertIsTrue(Math.Abs(0 - rasterImage.Angle) < DefaultTolerance, "rasterImage.Angle should be 0");
                AssertIsTrue(Math.Abs(0 - rasterImage.LeftBottomShift) < DefaultTolerance, "rasterImage.LeftBottomShift should be 0");
                AssertIsTrue(Math.Abs(0 - rasterImage.ImageRectangle.X) < DefaultTolerance, "rasterImage.ImageRectangle.X should be 0");
                AssertIsTrue(Math.Abs(0 - rasterImage.ImageRectangle.Y) < DefaultTolerance, "rasterImage.ImageRectangle.Y should be 0");
                AssertIsTrue(Math.Abs(10 - rasterImage.ImageRectangle.Width) < DefaultTolerance, "rasterImage.ImageRectangle.Width should be 10");
                AssertIsTrue(Math.Abs(10 - rasterImage.ImageRectangle.Height) < DefaultTolerance, "rasterImage.ImageRectangle.Height should be 10");
            }

            //ExEnd:SupportOfRasterImagesInAI
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/AI/SupportOfRasterImagesInAI.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/AddThumbnailToEXIFSegment.cs ---
﻿using Aspose.PSD.Exif;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class AddThumbnailToEXIFSegment
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddThumbnailToEXIFSegment

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "aspose_out.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Adjust thumbnail data.
                        var thumbnail = (ThumbnailResource)resource;
                        var exifData = new JpegExifData();
                        var thumbnailImage = new PsdImage(100, 100);
                        try
                        {
                            // Fill thumbnail data.
                            int[] pixels = new int[thumbnailImage.Width * thumbnailImage.Height];
                            for (int i = 0; i < pixels.Length; i++)
                            {
                                pixels[i] = i;
                            }

                            // Assign thumbnail data.
                            thumbnailImage.SaveArgb32Pixels(thumbnailImage.Bounds, pixels);
                            exifData.Thumbnail = thumbnailImage;
                            thumbnail.JpegOptions.ExifData = exifData;
                        }
                        catch
                        {
                            thumbnailImage.Dispose();
                            throw;
                        }
                    }
                }

                image.Save();

            }

            //ExEnd:AddThumbnailToEXIFSegment

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/AddThumbnailToEXIFSegment.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/AddThumbnailToJFIFSegment.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class AddThumbnailToJFIFSegment
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddThumbnailToJFIFSegment

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "aspose_out.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Adjust thumbnail data.
                        var thumbnail = (ThumbnailResource)resource;
                        var jfifData = new FileFormats.Jpeg.JFIFData();
                        var thumbnailImage = new PsdImage(100, 100);
                        try
                        {
                            // Fill thumbnail data.
                            int[] pixels = new int[thumbnailImage.Width * thumbnailImage.Height];
                            for (int i = 0; i < pixels.Length; i++)
                            {
                                pixels[i] = i;
                            }

                            // Assign thumbnail data.
                            thumbnailImage.SaveArgb32Pixels(thumbnailImage.Bounds, pixels);
                            jfifData.Thumbnail = thumbnailImage;
                            jfifData.XDensity = 1;
                            jfifData.YDensity = 1;
                            thumbnail.JpegOptions.Jfif = jfifData;
                        }
                        catch
                        {
                            thumbnailImage.Dispose();
                            throw;
                        }
                    }
                }

                image.Save();

            }
            //ExEnd:AddThumbnailToJFIFSegment

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/AddThumbnailToJFIFSegment.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ColorTypeAndCompressionType.cs ---
﻿using Aspose.PSD.FileFormats.Jpeg;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ColorTypeAndCompressionType
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ColorTypeAndCompressionType

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "PsdImage.psd"))
            {
                JpegOptions options = new JpegOptions();
                options.ColorType = JpegCompressionColorMode.Grayscale;
                options.CompressionType = JpegCompressionMode.Progressive;

                image.Save(dataDir + "ColorTypeAndCompressionType_output.jpg", options);
            }

            //ExEnd:ColorTypeAndCompressionType

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ColorTypeAndCompressionType.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ExtractThumbnailFromJFIF.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ExtractThumbnailFromJFIF
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ExtractThumbnailFromJFIF

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "1280px-Zebras_Serengeti.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract thumbnail data and store it as a separate image file.
                        var thumbnail = (ThumbnailResource)resource;
                        var jfif = thumbnail.JpegOptions.Jfif;
                        if (jfif != null)
                        {
                            // extract JFIF data and process.
                        }

                        var exif = thumbnail.JpegOptions.ExifData;
                        if (exif != null)
                        {
                            // extract Exif data and process.
                        }
                    }
                }
            }
            //ExEnd:ExtractThumbnailFromJFIF

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ExtractThumbnailFromJFIF.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ExtractThumbnailFromPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ExtractThumbnailFromPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ExtractThumbnailFromPSD

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "1280px-Zebras_Serengeti.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract thumbnail data and store it as a separate image file.
                        var thumbnail = (ThumbnailResource)resource;
                        var data = ((ThumbnailResource)resource).ThumbnailArgb32Data;
                        using (PsdImage extractedThumnailImage = new PsdImage(thumbnail.Width, thumbnail.Height))
                        {
                            extractedThumnailImage.SaveArgb32Pixels(extractedThumnailImage.Bounds, data);
                            extractedThumnailImage.Save(dataDir + "extracted_thumbnail.jpg", new JpegOptions());
                        }
                    }
                }
            }
            //ExEnd:ExtractThumbnailFromPSD

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ExtractThumbnailFromPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadAllEXIFTagList.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using System;
using System.Reflection;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ReadAllEXIFTagList
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ReadAllEXIFTagList
            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "1280px-Zebras_Serengeti.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract thumbnail data and store it as a separate image file.
                        var thumbnail = (ThumbnailResource)resource;
                        var exifData = thumbnail.JpegOptions.ExifData;
                        if (exifData != null)
                        {
                            Type type = exifData.GetType();
                            PropertyInfo[] properties = type.GetProperties();
                            foreach (PropertyInfo property in properties)
                            {
                                Console.WriteLine(property.Name + ":" + property.GetValue(exifData, null));
                            }
                        }
                    }
                }
            }

            //ExEnd:ReadAllEXIFTagList
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadAllEXIFTagList.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadAllEXIFTags.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using System;
using System.Reflection;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ReadAllEXIFTags
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ReadAllEXIFTags

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "1280px-Zebras_Serengeti.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract exif data and print to the console.
                        var exif = ((ThumbnailResource)resource).JpegOptions.ExifData;
                        if (exif != null)
                        {
                            Type type = exif.GetType();
                            PropertyInfo[] properties = type.GetProperties();
                            foreach (PropertyInfo property in properties)
                            {
                                Console.WriteLine(property.Name + ":" + property.GetValue(exif, null));
                            }
                        }
                    }
                }
            }
            //ExEnd:ReadAllEXIFTags
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadAllEXIFTags.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadSpecificEXIFTagsInformation.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ReadSpecificEXIFTagsInformation
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ReadSpecificEXIFTagsInformation

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "1280px-Zebras_Serengeti.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract exif data and print to the console.
                        var exif = ((ThumbnailResource)resource).JpegOptions.ExifData;
                        if (exif != null)
                        {
                            Console.WriteLine("Exif WhiteBalance: " + exif.WhiteBalance);
                            Console.WriteLine("Exif PixelXDimension: " + exif.PixelXDimension);
                            Console.WriteLine("Exif PixelYDimension: " + exif.PixelYDimension);
                            Console.WriteLine("Exif ISOSpeed: " + exif.ISOSpeed);
                            Console.WriteLine("Exif FocalLength: " + exif.FocalLength);
                        }
                    }
                }
            }
            //ExEnd:ReadSpecificEXIFTagsInformation
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadSpecificEXIFTagsInformation.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadandModifyJpegEXIFTags.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class ReadandModifyJpegEXIFTags
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ReadandModifyJpegEXIFTags

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "1280px-Zebras_Serengeti.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract thumbnail data and store it as a separate image file.
                        var thumbnail = (ThumbnailResource)resource;
                        var exifData = thumbnail.JpegOptions.ExifData;
                        if (exifData != null)
                        {
                            // extract Exif data and process.
                            Console.WriteLine("Camera Owner Name: " + exifData.CameraOwnerName);
                            Console.WriteLine("Aperture Value: " + exifData.ApertureValue);
                            Console.WriteLine("Orientation: " + exifData.Orientation);
                            Console.WriteLine("Focal Length: " + exifData.FocalLength);
                            Console.WriteLine("Compression: " + exifData.Compression);
                        }
                    }
                }
            }
            //ExEnd:ReadandModifyJpegEXIFTags

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/ReadandModifyJpegEXIFTags.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/SupportFor2-7BitsJPEG.cs ---
﻿using Aspose.PSD.FileFormats.Jpeg;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class SupportFor2_7BitsJPEG
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportFor2_7BitsJPEG

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "PsdImage.psd"))
            {
                JpegOptions options = new JpegOptions();

                // Set 2 bits per sample to see the difference in size and quality
                byte bpp = 2;

                //Just replace one line given below in examples to use YCCK instead of CMYK
                //options.ColorType = JpegCompressionColorMode.Cmyk;
                options.ColorType = JpegCompressionColorMode.Cmyk;
                options.CompressionType = JpegCompressionMode.JpegLs;
                options.BitsPerChannel = bpp;

                // The default profiles will be used.
                options.RgbColorProfile = null;
                options.CmykColorProfile = null;

                image.Save(dataDir + "2_7BitsJPEG_output.jpg", options);
            }


            //ExEnd:SupportFor2_7BitsJPEG

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/SupportFor2-7BitsJPEG.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/SupportForJPEG_LSWithCMYK.cs ---
﻿using Aspose.PSD.FileFormats.Jpeg;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class SupportForJPEG_LSWithCMYK
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportForJPEG_LSWithCMYK

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "PsdImage.psd"))
            {
                JpegOptions options = new JpegOptions();
                //Just replace one line given below in examples to use YCCK instead of CMYK
                //options.ColorType = JpegCompressionColorMode.Cmyk;
                options.ColorType = JpegCompressionColorMode.Cmyk;
                options.CompressionType = JpegCompressionMode.JpegLs;

                // The default profiles will be used.
                options.RgbColorProfile = null;
                options.CmykColorProfile = null;

                image.Save(dataDir + "output.jpg", options);
            }

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "PsdImage.psd"))
            {
                JpegOptions options = new JpegOptions();
                //Just replace one line given below in examples to use YCCK instead of CMYK
                //options.ColorType = JpegCompressionColorMode.Cmyk;
                options.ColorType = JpegCompressionColorMode.Cmyk;
                options.CompressionType = JpegCompressionMode.Lossless;

                // The default profiles will be used.
                options.RgbColorProfile = null;
                options.CmykColorProfile = null;

                image.Save(dataDir + "output2.jpg", options);
            }


            //ExEnd:SupportForJPEG_LSWithCMYK

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/SupportForJPEG_LSWithCMYK.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/WritingAndModifyingEXIFData.cs ---
﻿using Aspose.PSD.Exif.Enums;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG
{
    class WritingAndModifyingEXIFData
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:WritingAndModifyingEXIFData

            // Load PSD image.
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                // Iterate over resources.
                foreach (var resource in image.ImageResources)
                {
                    // Find thumbnail resource. Typically they are in the Jpeg file format.
                    if (resource is ThumbnailResource || resource is Thumbnail4Resource)
                    {
                        // Extract exif data and print to the console.
                        var exif = ((ThumbnailResource)resource).JpegOptions.ExifData;
                        if (exif != null)
                        {
                            // Set LensMake, WhiteBalance, Flash information Save the image
                            exif.LensMake = "Sony";
                            exif.WhiteBalance = ExifWhiteBalance.Auto;
                            exif.Flash = ExifFlash.Fired;
                        }
                    }
                }

                image.Save(dataDir + "aspose_out.psd");
            }
            //ExEnd:WritingAndModifyingEXIFData
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/JPEG/WritingAndModifyingEXIFData.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/ApplyFilterMethod.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG
{
    class ApplyFilterMethodOnPng
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ApplyFilterMethod

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                // Create an instance of PngOptions, Set the PNG filter method and Save changes to the disc
                PngOptions options = new PngOptions();
                options.FilterType = PngFilterType.Paeth;
                psdImage.Save(dataDir + "ApplyFilterMethod_out.png", options);
            }

            //ExEnd:ApplyFilterMethod
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/ApplyFilterMethod.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/ChangeBackgroundColor.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG
{
    class ChangeBackgroundColorOfPng
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ChangeBackgroundColor

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {

                int[] pixels = psdImage.LoadArgb32Pixels(psdImage.Bounds);
                // Iterate through the pixel array and Check the pixel information 
                //that if it is a transparent color pixel and Change the pixel color to white
                int transparent = psdImage.TransparentColor.ToArgb();
                int replacementColor = Color.Yellow.ToArgb();
                for (int i = 0; i < pixels.Length; i++)
                {
                    if (pixels[i] == transparent)
                    {
                        pixels[i] = replacementColor;
                    }
                }
                // Replace the pixel array into the image.
                psdImage.SaveArgb32Pixels(psdImage.Bounds, pixels);
                psdImage.Save(dataDir + "ChangeBackground_out.png", new PngOptions());

            }

            //ExEnd:ChangeBackgroundColor
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/ChangeBackgroundColor.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/CompressingFiles.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG
{
    class SetPngCompressingOnExport
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CompressingFiles

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                // Loop over possible CompressionLevel range
                for (int i = 0; i <= 9; i++)
                {
                    // Create an instance of PngOptions for each resultant PNG, Set CompressionLevel and  Save result on disk
                    PngOptions options = new PngOptions();
                    options.CompressionLevel = i;
                    psdImage.Save(dataDir + i + "_out.png", options);
                }
            }

            //ExEnd:CompressingFiles
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/CompressingFiles.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/SettingResolution.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG
{
    class SettingResolutionOfPngOnExport
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SettingResolution

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                // Create an instance of PngOptions, Set the horizontal & vertical resolutions and Save the result on disc
                PngOptions options = new PngOptions();
                options.ResolutionSettings = new ResolutionSetting(72, 96);
                psdImage.Save(dataDir + "SettingResolution_output.png", options);
            }
            //ExEnd:SettingResolution
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/SettingResolution.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/SpecifyBitDepth.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG
{
    class SpecifyBitDepthOnPng
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SpecifyBitDepth

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                // Create an instance of PngOptions, Set the desired ColorType, BitDepth according to the specified ColorType and save image
                PngOptions options = new PngOptions();
                options.ColorType = PngColorType.Grayscale;
                options.BitDepth = 1;
                psdImage.Save(dataDir + "SpecifyBitDepth_out.png", options);
            }


            //ExEnd:SpecifyBitDepth
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/SpecifyBitDepth.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/SpecifyTransparency.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG
{
    class SpecifyTransparencyOfPngOnExport
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SpecifyTransparency

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {

                // specify the PNG image transparency options and save to file.
                psdImage.TransparentColor = Color.White;
                psdImage.HasTransparentColor = true;
                PngOptions opt = new PngOptions();
                psdImage.Save(dataDir + "Specify_Transparency_result.png", new PngOptions());

            }

            //ExEnd:SpecifyTransparency
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PNG/SpecifyTransparency.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSB/PSBToJPG.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSB
{
    class PSBToJPG
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSB();

            //ExStart:PSBToJPG

            string[] sourceFileNames = new string[] { 
               //Test files with layers
               "Little",
               "Simple",
               //Test files without layers
               "psb",
               "psb3"
           };
            var options = new PsdLoadOptions();
            foreach (var fileName in sourceFileNames)
            {
                var sourceFileName = dataDir + fileName + ".psb";
                using (PsdImage image = (PsdImage)Image.Load(sourceFileName, options))
                {
                    // All jpeg and psd files must be readable
                    image.Save(dataDir + fileName + "_output.jpg", new JpegOptions() { Quality = 95 });
                    image.Save(dataDir + fileName + "_output.psb");
                }
            }
            //ExEnd:PSBToJPG
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSB/PSBToJPG.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSB/PSBToPDF.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSB
{
    class PSBToPDF
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSB();

            //ExStart:PSBToPDF

            string sourceFileName = dataDir + "Simple.psb";
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                string outFileName = dataDir + "Simple.pdf";
                image.Save(outFileName, new PdfOptions());
            }
            //ExEnd:PSBToPDF

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSB/PSBToPDF.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSB/PSBToPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSB
{
    class PSBToPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSB();
            //ExStart:PSBToPSD

            string sourceFilePathPsb = dataDir + "2layers.psb";
            string outputFilePathPsd = dataDir + "ConvertFromPsb.psd";
            using (Image img = Image.Load(sourceFilePathPsb))
            {
                var options = new PsdOptions((PsdImage)img) { PsdVersion = PsdVersion.Psd };
                img.Save(outputFilePathPsd, options);
            }
            //ExEnd:PSBToPSD
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSB/PSBToPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddBlackAndWhiteAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddBlackAndWhiteAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddBlackAndWhiteAdjustmentLayer
            //ExSummary:The following example demonstrates how you can add the black white adjustment layer at runtime in Aspose.PSD
            string sourceFileName = dataDir + "Stripes.psd";
            string outputFileName = dataDir + "OutputStripes.psd";
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                BlackWhiteAdjustmentLayer newLayer = image.AddBlackWhiteAdjustmentLayer();
                newLayer.Name = "BlackWhiteAdjustmentLayer";
                newLayer.Reds = 22;
                newLayer.Yellows = 92;
                newLayer.Greens = 70;
                newLayer.Cyans = 79;
                newLayer.Blues = 7;
                newLayer.Magentas = 28;

                image.Save(outputFileName, new PsdOptions());
            }

            //ExEnd:AddBlackAndWhiteAdjustmentLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddBlackAndWhiteAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddChannelMixerAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddChannelMixerAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddChannelMixerAdjustmentLayer

            string sourceFileName = dataDir + "ChannelMixerAdjustmentLayerRgb.psd";
            string psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerRgbChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is RgbChannelMixerLayer)
                    {
                        var rgbLayer = (RgbChannelMixerLayer)layer;
                        rgbLayer.RedChannel.Blue = 100;
                        rgbLayer.BlueChannel.Green = -100;
                        rgbLayer.GreenChannel.Constant = 50;
                    }
                }

                im.Save(psdPathAfterChange);
            }

            // Cmyk Channel Mixer
            sourceFileName = dataDir + "ChannelMixerAdjustmentLayerCmyk.psd";
            psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerCmykChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is CmykChannelMixerLayer)
                    {
                        var cmykLayer = (CmykChannelMixerLayer)layer;
                        cmykLayer.CyanChannel.Black = 20;
                        cmykLayer.MagentaChannel.Yellow = 50;
                        cmykLayer.YellowChannel.Cyan = -25;
                        cmykLayer.BlackChannel.Yellow = 25;
                    }
                }

                im.Save(psdPathAfterChange);
            }


            // Adding the new layer(Cmyk for this example)
            sourceFileName = dataDir + "CmykWithAlpha.psd";
            psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerCmykChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                var newlayer = im.AddChannelMixerAdjustmentLayer();
                newlayer.GetChannelByIndex(2).Constant = 50;
                newlayer.GetChannelByIndex(0).Constant = 50;

                im.Save(psdPathAfterChange);
            }
            //ExEnd:AddChannelMixerAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddChannelMixerAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddCurvesAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddCurvesAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddCurvesAdjustmentLayer

            // Curves layer editing
            string sourceFileName = dataDir + "CurvesAdjustmentLayer";
            string psdPathAfterChange = dataDir + "CurvesAdjustmentLayerChanged";

            for (int j = 1; j < 2; j++)
            {
                using (var im = (PsdImage)Image.Load(sourceFileName + j.ToString() + ".psd"))
                {
                    foreach (var layer in im.Layers)
                    {
                        if (layer is CurvesLayer)
                        {
                            var curvesLayer = (CurvesLayer)layer;
                            if (curvesLayer.IsDiscreteManagerUsed)
                            {
                                var manager = (CurvesDiscreteManager)curvesLayer.GetCurvesManager();

                                for (int i = 10; i < 50; i++)
                                {
                                    manager.SetValueInPosition(0, (byte)i, (byte)(15 + (i * 2)));
                                }
                            }
                            else
                            {
                                var manager = (CurvesContinuousManager)curvesLayer.GetCurvesManager();
                                manager.AddCurvePoint(0, 50, 100);
                                manager.AddCurvePoint(0, 150, 130);
                            }
                        }
                    }
                    // Save PSD
                    im.Save(psdPathAfterChange + j.ToString() + ".psd");
                }

            }
            //ExEnd:AddCurvesAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddCurvesAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddDiagnolWatermark.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddDiagnolWatermark
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddDiagnolWatermark

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Create graphics object to perform draw operations.
                Graphics graphics = new Graphics(psdImage);

                // Create font to draw watermark with.
                Font font = new Font("Arial", 20.0f);

                // Create a solid brush with color alpha set near to 0 to use watermarking effect.
                using (SolidBrush brush = new SolidBrush(Color.FromArgb(50, 128, 128, 128)))
                {
                    // specify transform matrix to rotate watermark.
                    graphics.Transform = new Matrix();
                    graphics.Transform.RotateAt(45, new PointF(psdImage.Width / 2, psdImage.Height / 2));

                    // Specify string alignment to put watermark at the image center.
                    StringFormat sf = new StringFormat();
                    sf.Alignment = StringAlignment.Center;

                    // Draw watermark using font, partly-transparent brush at the image center.
                    graphics.DrawString("Some watermark text", font, brush, new RectangleF(0, psdImage.Height / 2, psdImage.Width, psdImage.Height / 2), sf);
                }

                // Export the image into PNG file format.
                psdImage.Save(dataDir + "AddDiagnolWatermark_output.png", new PngOptions());
            }


            //ExEnd:AddDiagnolWatermark
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddDiagnolWatermark.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddGradientMapAdjustmentLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class AddGradientMapAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddGradientMapAdjustmentLayer
            //ExSummary:The following code demonstrates the support of Gradient map layer.
            
            string sourceFile = Path.Combine(baseDir, "gradient_map_src.psd");
            string outputFile = Path.Combine(outputDir, "gradient_map_src_output.psd");

            using (PsdImage im = (PsdImage)Image.Load(sourceFile))
            {
                // Add Gradient map adjustment layer.
                GradientMapLayer layer = im.AddGradientMapAdjustmentLayer();
                layer.GradientSettings.Reverse = true;
                layer.Update();

                im.Save(outputFile);
            }

            // Check saved changes
            using (PsdImage im = (PsdImage)Image.Load(outputFile))
            {
                GradientMapLayer gradientMapLayer = im.Layers[1] as GradientMapLayer;
                var gradientSettings = gradientMapLayer.GradientSettings;
                SolidGradient solidGradient = (SolidGradient)gradientSettings.Gradient;

                AssertAreEqual((short)4096, solidGradient.Interpolation);
                AssertAreEqual(true, gradientSettings.Reverse);
                AssertAreEqual(false, gradientSettings.Dither);
                AssertAreEqual("Custom", solidGradient.GradientName);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }
            
            //ExEnd:AddGradientMapAdjustmentLayer

            File.Delete(outputFile);

            Console.WriteLine("AddGradientMapAdjustmentLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddGradientMapAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddHueSaturationAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddHueSaturationAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddHueSaturationAdjustmentLayer

            // Hue/Saturation layer editing
            string sourceFileName = dataDir + "HueSaturationAdjustmentLayer.psd";
            string psdPathAfterChange = dataDir + "HueSaturationAdjustmentLayerChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is HueSaturationLayer)
                    {
                        var hueLayer = (HueSaturationLayer)layer;
                        hueLayer.Hue = -25;
                        hueLayer.Saturation = -12;
                        hueLayer.Lightness = 67;

                        var colorRange = hueLayer.GetRange(2);
                        colorRange.Hue = -40;
                        colorRange.Saturation = 50;
                        colorRange.Lightness = -20;
                        colorRange.MostLeftBorder = 300;
                    }
                }

                im.Save(psdPathAfterChange);
            }

            // Hue/Saturation layer adding
            sourceFileName = dataDir + "PhotoExample.psd";
            psdPathAfterChange = dataDir + "PhotoExampleAddedHueSaturation.psd";

            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                //this.SaveForVisualTest(im, this.OutputPath, prefix + file, "before");
                var hueLayer = im.AddHueSaturationAdjustmentLayer();
                hueLayer.Hue = -25;
                hueLayer.Saturation = -12;
                hueLayer.Lightness = 67;

                var colorRange = hueLayer.GetRange(2);
                colorRange.Hue = -160;
                colorRange.Saturation = 100;
                colorRange.Lightness = 20;
                colorRange.MostLeftBorder = 300;

                im.Save(psdPathAfterChange);
            }
            //ExEnd:AddHueSaturationAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddHueSaturationAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddIopaResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddIopaResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddIopaResource

            string sourceFileName = dataDir + "FillOpacitySample.psd";
            string exportPath = dataDir + "FillOpacitySampleChanged.psd";

            using (var im = (PsdImage)(Image.Load(sourceFileName)))
            {
                var layer = im.Layers[2];

                var resources = layer.Resources;
                foreach (var resource in resources)
                {
                    if (resource is FileFormats.Psd.Layers.LayerResources.IopaResource)
                    {
                        var iopaResource = (IopaResource)resource;
                        iopaResource.FillOpacity = 200;
                    }
                }

                im.Save(exportPath);
            }

            //ExEnd:AddIopaResource

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddIopaResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddLevelAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddLevelAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddLevelAdjustmentLayer

            string sourceFileName = dataDir + "LevelsAdjustmentLayer.psd";
            string psdPathAfterChange = dataDir + "LevelsAdjustmentLayerChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is LevelsLayer)
                    {
                        var levelsLayer = (LevelsLayer)layer;
                        var channel = levelsLayer.GetChannel(0);
                        channel.InputMidtoneLevel = 2.0f;
                        channel.InputShadowLevel = 10;
                        channel.InputHighlightLevel = 230;
                        channel.OutputShadowLevel = 20;
                        channel.OutputHighlightLevel = 200;
                    }
                }

                // Save PSD
                im.Save(psdPathAfterChange);
            }
            //ExEnd:AddLevelAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddLevelAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddTextLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddTextLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddTextLayer
            string sourceFileName = dataDir + "OneLayer.psd";
            string outFileName = dataDir + "OneLayerWithAddedText.psd";

            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                image.AddTextLayer("Some text", new Rectangle(50, 50, 100, 100));
                PsdOptions options = new PsdOptions(image);
                image.Save(outFileName, options);
            }

            //ExEnd:AddTextLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddTextLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddTextLayerOnRuntime.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddTextLayerOnRuntime
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddTextLayerOnRuntime

            string sourceFileName = dataDir + "OneLayer.psd";
            string psdPath = dataDir + "ImageWithTextLayer.psd";

            using (var img = Image.Load(sourceFileName))
            {
                PsdImage im = (PsdImage)img;
                var rect = new Rectangle(
                    (int)(im.Width * 0.25),
                    (int)(im.Height * 0.25),
                    (int)(im.Width * 0.5),
                    (int)(im.Height * 0.5));

                var layer = im.AddTextLayer("Added text", rect);

                im.Save(psdPath);
            }
            //ExEnd:AddTextLayerOnRuntime

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddTextLayerOnRuntime.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddVibranceAdjustmentLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    internal class AddVibranceAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:AddVibranceAdjustmentLayer
            //ExSummary:The following code example demonstrates support of the VibranceLayer layer and the ability to edit this adjustment.
            
            string sourceFileName = Path.Combine(SourceDir, "WithoutVibrance.psd");
            string outputFileNamePsd = Path.Combine(OutputDir, "out_VibranceLayer.psd");
            string outputFileNamePng = Path.Combine(OutputDir, "out_VibranceLayer.png");

            using (PsdImage image = (PsdImage) Image.Load(sourceFileName))
            {
                // Creating a new VibranceLayer
                VibranceLayer vibranceLayer = image.AddVibranceAdjustmentLayer();
                vibranceLayer.Vibrance = 50;
                vibranceLayer.Saturation = 100;

                image.Save(outputFileNamePsd);
                image.Save(outputFileNamePng, new PngOptions());
            }
            
            //ExEnd:AddVibranceAdjustmentLayer
            
            Console.WriteLine("AddVibranceAdjustmentLayer executed successfully");

            File.Delete(outputFileNamePsd);
            File.Delete(outputFileNamePng);
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddVibranceAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddWatermark.cs ---
﻿using Aspose.PSD.Brushes;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class AddWatermark
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:AddWatermark

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Create graphics object to perform draw operations.
                Graphics graphics = new Graphics(psdImage);

                // Create font to draw watermark with.
                Font font = new Font("Arial", 20.0f);

                // Create a solid brush with color alpha set near to 0 to use watermarking effect.
                using (SolidBrush brush = new SolidBrush(Color.FromArgb(50, 128, 128, 128)))
                {
                    // Specify string alignment to put watermark at the image center.
                    StringFormat sf = new StringFormat();
                    sf.Alignment = StringAlignment.Center;
                    sf.LineAlignment = StringAlignment.Center;

                    // Draw watermark using font, partly-transparent brush and rotation matrix at the image center.
                    graphics.DrawString("Some watermark text", font, brush, new RectangleF(0, 0, psdImage.Width, psdImage.Height), sf);
                }

                // Export the image into PNG file format.
                psdImage.Save(dataDir + "AddWatermark_output.png", new PngOptions());
            }

            //ExEnd:AddWatermark
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/AddWatermark.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ColorFillLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ColorFillLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ColorFillLayer

            string sourceFileName = dataDir + "ColorFillLayer.psd";
            string exportPath = dataDir + "ColorFillLayer_output.psd";

            var im = (PsdImage)Image.Load(sourceFileName);

            using (im)
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is FillLayer)
                    {
                        var fillLayer = (FillLayer)layer;

                        if (fillLayer.FillSettings.FillType != FillType.Color)
                        {
                            throw new Exception("Wrong Fill Layer");
                        }

                        var settings = (IColorFillSettings)fillLayer.FillSettings;

                        settings.Color = Color.Red;
                        fillLayer.Update();
                        im.Save(exportPath);
                        break;
                    }
                }
            }

            //ExEnd:ColorFillLayer

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ColorFillLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ColorReplacementInPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ColorReplacementInPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ColorReplacementInPSD

            // Load a PSD file as an image and caste it into PsdImage
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                foreach (var layer in image.Layers)
                {
                    if (layer.Name == "Rectangle 1")
                    {
                        layer.HasBackgroundColor = true;
                        layer.BackgroundColor = Color.Orange;
                    }

                }

                image.Save(dataDir + "asposeImage02.psd");
            }

            //ExEnd:ColorReplacementInPSD

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ColorReplacementInPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ControllCacheReallocation.cs ---
﻿using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ControllCacheReallocation
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ControllCacheReallocation

            // By default the cache folder is set to the local temp directory.  You can specify a different cache folder from the default this way:
            Cache.CacheFolder = dataDir;

            // Set cache on disk.
            Cache.CacheType = CacheType.CacheOnDiskOnly;

            // The default cache max value is 0, which means that there is no upper limit
            Cache.MaxDiskSpaceForCache = 1073741824; // 1 gigabyte
            Cache.MaxMemoryForCache = 1073741824; // 1 gigabyte

            // We do not recommend that you change the following property because it may greatly affect performance
            Cache.ExactReallocateOnly = false;

            // At any time you can check how many bytes are currently allocated for the cache in memory or on disk By examining the following properties
            long l1 = Cache.AllocatedDiskBytesCount;
            long l2 = Cache.AllocatedMemoryBytesCount;

            PsdOptions options = new PsdOptions();

            //GifOptions options = new GifOptions();
            options.Palette = new ColorPalette(new[] { Color.Red, Color.Blue, Color.Black, Color.White });
            options.Source = new StreamSource(new MemoryStream(), true);

            using (RasterImage image = (RasterImage)Image.Create(options, 100, 100))
            {
                Color[] pixels = new Color[10000];
                for (int i = 0; i < pixels.Length; i++)
                {
                    pixels[i] = Color.White;
                }

                image.SavePixels(image.Bounds, pixels);

                // After executing the code above 40000 bytes are allocated to disk.
                long diskBytes = Cache.AllocatedDiskBytesCount;
                long memoryBytes = Cache.AllocatedMemoryBytesCount;
            }

            // The allocation properties may be used to check whether all Aspose.Imaging objects were properly disposed. If you've forgotten to call dispose on an object the cache values will not be 0.
            l1 = Cache.AllocatedDiskBytesCount;
            l2 = Cache.AllocatedMemoryBytesCount;

            //ExEnd:ControllCacheReallocation
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ControllCacheReallocation.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ConvertPsdToJpg.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ConvertPsdToJpg
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ConvertPsdToJpg

            string inputFile = dataDir + "PsdConvertToExample.psd";

            using (var psdImage = (PsdImage)Image.Load(inputFile))
            {
                psdImage.Save(dataDir + "PsdConvertedToJpg.jpg", new JpegOptions() {Quality = 80, JpegLsAllowedLossyError = 10 });
            }

            //ExEnd:ConvertPsdToJpg
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ConvertPsdToJpg.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ConvertPsdToPdf.cs ---
﻿using Aspose.PSD.FileFormats.Pdf;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ConvertPsdToPdf
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ConvertPsdToPdf

            string inputFile = dataDir + "PsdConvertToPdfExample.psd";

            using (var psdImage = (PsdImage)Image.Load(inputFile, new PsdLoadOptions()))
            {
                psdImage.Save(dataDir + "PsdConvertedToPdf.pdf",
                    new PdfOptions() { 
                        PdfDocumentInfo = new PdfDocumentInfo()
                    {
                        Author = "Aspose.PSD", 
                        Keywords = "Convert,Psd,Pdf,Online,HowTo", 
                        Subject = "PSD Conversion to PDF",
                        Title = "Pdf From Psd",
                    },
                        ResolutionSettings = new ResolutionSetting(5, 6)
                    });
            }

            //ExEnd:ConvertPsdToPdf
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ConvertPsdToPdf.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ConvertPsdToPng.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ConvertPsdToPng
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ConvertPsdToPng

            string inputFile = dataDir + "PsdConvertToPngExample.psd";

            using (var psdImage = (PsdImage)Image.Load(inputFile, new PsdLoadOptions() { ReadOnlyMode = true }))
            {
                psdImage.Save(dataDir + "PsdConvertedToPng.png",
                    new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha, Progressive = true, CompressionLevel = 9 });
            }

            //ExEnd:ConvertPsdToPng
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ConvertPsdToPng.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/CreateIndexedPSDFiles.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class CreateIndexedPSDFiles
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CreateIndexedPSDFiles

            // Create an instance of PsdOptions and set it's properties
            var createOptions = new PsdOptions();
            createOptions.Source = new FileCreateSource(dataDir + "Newsample_out.psd", false);
            createOptions.ColorMode = ColorModes.Indexed;
            createOptions.Version = 5;

            // Create a new color palette having RGB colors, Set Palette property & compression method
            Color[] palette = { Color.Red, Color.Green, Color.Blue, Color.Yellow };
            createOptions.Palette = new PsdColorPalette(palette);
            createOptions.CompressionMethod = CompressionMethod.RLE;

            // Create a new PSD with PsdOptions created previously
            using (var psd = Image.Create(createOptions, 500, 500))
            {
                // Draw some graphics over the newly created PSD
                var graphics = new Graphics(psd);
                graphics.Clear(Color.White);
                graphics.DrawEllipse(new Pen(Color.Red, 6), new Rectangle(0, 0, 400, 400));
                psd.Save();
            }

            //ExEnd:CreateIndexedPSDFiles

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/CreateIndexedPSDFiles.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/CreateLayerGroups.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class CreateLayerGroups
    {
        public static void Run()
        {
            // The path to the document's directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CreateLayerGroups

            string inputFile = dataDir + "ButtonTemp.psd";

            var createOptions = new PsdOptions();
            createOptions.Source = new FileCreateSource(inputFile, false);
            createOptions.Palette = new PsdColorPalette(new Color[] { Color.Green });

            using (var psdImage = (PsdImage)Image.Create(createOptions, 500, 500))
            {
                LayerGroup group1 = psdImage.AddLayerGroup("Group 1", 0, true);

                Layer layer1 = new Layer(psdImage);
                layer1.Name = "Layer 1";
                group1.AddLayer(layer1);

                LayerGroup group2 = group1.AddLayerGroup("Group 2", 1);

                Layer layer2 = new Layer(psdImage);
                layer2.Name = "Layer 2";
                group2.AddLayer(layer2);

                Layer layer3 = new Layer(psdImage);
                layer3.Name = "Layer 3";
                group2.AddLayer(layer3);

                Layer layer4 = new Layer(psdImage);
                layer4.Name = "Layer 4";
                group1.AddLayer(layer4);

                psdImage.Save(dataDir + "LayerGroups_out.psd");
            }
            //ExEnd:CreateLayerGroups

            Console.WriteLine("CreateLayerGroups executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/CreateLayerGroups.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/CreateThumbnailsFromPSDFiles.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Resources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class CreateThumbnailsFromPSDFiles
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CreateThumbnailsFromPSDFiles

            // Load a PSD file as an image and caste it into PsdImage
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                int index = 0;
                // Iterate over the PSD resources
                foreach (var resource in image.ImageResources)
                {
                    index++;
                    // Check if the resource is of thumbnail type
                    if (resource is ThumbnailResource)
                    {
                        // Retrieve the ThumbnailResource and Check the format of the ThumbnailResource
                        var thumbnail = (ThumbnailResource)resource;
                        if (thumbnail.Format == ThumbnailFormat.KJpegRgb)
                        {
                            // Create a new image by specifying the width and height,  Store the pixels of thumbnail on to the newly created image and save image
                            PsdImage thumnailImage = new PsdImage(thumbnail.Width, thumbnail.Height);

                            thumnailImage.SavePixels(thumnailImage.Bounds, thumbnail.ThumbnailData);
                            thumnailImage.Save(dataDir + "CreateThumbnailsFromPSDFiles_out_" + index.ToString() + ".bmp", new BmpOptions());
                        }
                    }
                }
            }

            //ExEnd:CreateThumbnailsFromPSDFiles

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/CreateThumbnailsFromPSDFiles.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/DetectFlattenedPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class DetectFlattenedPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:DetectFlattenedPSD

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Do processing, Get the true value if PSD is flatten and false in case the PSD is not flatten.
                Console.WriteLine(psdImage.IsFlatten);
            }

            //ExEnd:DetectFlattenedPSD
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/DetectFlattenedPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ExportImageToPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ExportImageToPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ExportImageToPSD

            // Create a new image from scratch.
            using (PsdImage image = new PsdImage(300, 300))
            {
                // Fill image data.
                Graphics graphics = new Graphics(image);
                graphics.Clear(Color.White);
                var pen = new Pen(Color.Brown);
                graphics.DrawRectangle(pen, image.Bounds);

                // Create an instance of PsdOptions, Set it's various properties Save image to disk in PSD format
                PsdOptions psdOptions = new PsdOptions();
                psdOptions.ColorMode = ColorModes.Rgb;
                psdOptions.CompressionMethod = CompressionMethod.Raw;
                psdOptions.Version = 4;
                image.Save(dataDir + "ExportImageToPSD_output.psd", psdOptions);
            }

            //ExEnd:ExportImageToPSD

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ExportImageToPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ExportPSDLayerToRasterImage.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ExportPSDLayerToRasterImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ExportPSDLayerToRasterImage

            // Load a PSD file as an image and caste it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                // Create an instance of PngOptions class
                var pngOptions = new PngOptions();
                pngOptions.ColorType = PngColorType.TruecolorWithAlpha;

                // Loop through the list of layers
                for (int i = 0; i < psdImage.Layers.Length; i++)
                {
                    // Convert and save the layer to PNG file format.
                    psdImage.Layers[i].Save(string.Format("layer_out{0}.png", i + 1), pngOptions);
                }
            }


            //ExEnd:ExportPSDLayerToRasterImage

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ExportPSDLayerToRasterImage.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ExtractLayerName.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ExtractLayerName
    {

        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ExtractLayerName

            // make changes in layer names and save it
            using (var image = (PsdImage)Image.Load(dataDir + "Korean_layers.psd"))
            {
                for (int i = 0; i < image.Layers.Length; i++)
                {
                    var layer = image.Layers[i];
                    // set new value into DisplayName property
                    layer.DisplayName += "_changed";
                }

                image.Save(dataDir + "Korean_layers_output.psd");
            }

            //ExEnd:ExtractLayerName
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ExtractLayerName.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/FillOpacityOfLayers.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class FillOpacityOfLayers
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:FillOpacityOfLayers

            // Change the Fill Opacity property
            string sourceFileName = dataDir + "FillOpacitySample.psd";
            string exportPath = dataDir + "FillOpacitySampleChanged.psd";

            using (var im = (PsdImage)(Image.Load(sourceFileName)))
            {
                var layer = im.Layers[2];
                layer.FillOpacity = 5;
                im.Save(exportPath);
            }

            //ExEnd:FillOpacityOfLayers

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/FillOpacityOfLayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GetPropertiesOfInlineFormattingOfTextLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.Text;
using System;
using System.Collections.Generic;

namespace Aspose.PSD.Examples
{
    class GetPropertiesOfInlineFormattingOfTextLayer
    {

        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:GetPropertiesOfInlineFormattingOfTextLayer
            using (var psdImage = (PsdImage)Image.Load(dataDir + "inline_formatting.psd"))
            {
                List<ITextPortion> regularText = new List<ITextPortion>();
                List<ITextPortion> boldText = new List<ITextPortion>();
                List<ITextPortion> italicText = new List<ITextPortion>();
                var layers = psdImage.Layers;
                for (int index = 0; index < layers.Length; index++)
                {
                    var layer = layers[index];
                    if (!(layer is TextLayer))
                    {
                        continue;
                    }

                    var textLayer = (TextLayer)layer;
                    // gets fonts that contains in text layer
                    var fonts = textLayer.GetFonts();
                    var textPortions = textLayer.TextData.Items;

                    foreach (var textPortion in textPortions)
                    {
                        TextFontInfo font = fonts[textPortion.Style.FontIndex];
                        if (font != null)
                        {
                            switch (font.Style)
                            {
                                case FontStyle.Regular:
                                    regularText.Add(textPortion);
                                    break;
                                case FontStyle.Bold:
                                    boldText.Add(textPortion);
                                    break;
                                case FontStyle.Italic:
                                    italicText.Add(textPortion);
                                    break;
                                default:
                                    throw new ArgumentOutOfRangeException();
                            }
                        }
                    }
                }
            }

            //ExEnd:GetPropertiesOfInlineFormattingOfTextLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GetPropertiesOfInlineFormattingOfTextLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GetTextPropertiesFromTextLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageOptions;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class GetTextPropertiesFromTextLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:GetTextPropertiesFromTextLayer

            const double Tolerance = 0.0001;
            var filePath = Path.Combine(SourceDir, "ThreeColorsParagraphs.psd");
            var outputPath = Path.Combine(OutputDir, "ThreeColorsParagraph_out.psd");
            using (var im = (PsdImage)Image.Load(filePath))
            {
                for (int i = 0; i < im.Layers.Length; i++)
                {
                    var layer = im.Layers[i] as TextLayer;

                    if (layer != null)
                    {
                        var portions = layer.TextData.Items;

                        if (portions.Length != 4)
                        {
                            throw new Exception();
                        }

                        // Checking text of every portion
                        if (portions[0].Text != "Old " ||
                            portions[1].Text != "color" ||
                            portions[2].Text != " text\r" ||
                            portions[3].Text != "Second paragraph\r")
                        {
                            throw new Exception();
                        }

                        // Checking paragraphs data
                        // Paragraphs have different justification
                        if (
                            portions[0].Paragraph.Justification != JustificationMode.Left ||
                            portions[1].Paragraph.Justification != JustificationMode.Left ||
                            portions[2].Paragraph.Justification != JustificationMode.Left ||
                            portions[3].Paragraph.Justification != JustificationMode.Center)
                        {
                            throw new Exception();
                        }

                        // All other properties of first and second paragraph are equal
                        for (int j = 0; j < portions.Length; j++)
                        {
                            var paragraph = portions[j].Paragraph;

                            if (Math.Abs(paragraph.AutoLeading - 1.2) > Tolerance ||
                                paragraph.AutoHyphenate != false ||
                                paragraph.Burasagari != false ||
                                paragraph.ConsecutiveHyphens != 8 ||
                                Math.Abs(paragraph.StartIndent) > Tolerance ||
                                Math.Abs(paragraph.EndIndent) > Tolerance ||
                                paragraph.EveryLineComposer != false ||
                                Math.Abs(paragraph.FirstLineIndent) > Tolerance ||
                                paragraph.GlyphSpacing.Length != 3 ||
                                Math.Abs(paragraph.GlyphSpacing[0] - 1) > Tolerance ||
                                Math.Abs(paragraph.GlyphSpacing[1] - 1) > Tolerance ||
                                Math.Abs(paragraph.GlyphSpacing[2] - 1) > Tolerance ||
                                paragraph.Hanging != false ||
                                paragraph.HyphenatedWordSize != 6 ||
                                paragraph.KinsokuOrder != 0 ||
                                paragraph.LetterSpacing.Length != 3 ||
                                Math.Abs(paragraph.LetterSpacing[0]) > Tolerance ||
                                Math.Abs(paragraph.LetterSpacing[1]) > Tolerance ||
                                Math.Abs(paragraph.LetterSpacing[2]) > Tolerance ||
                                paragraph.LeadingType != LeadingType.BottomToBottom ||
                                paragraph.PreHyphen != 2 ||
                                paragraph.PostHyphen != 2 ||
                                Math.Abs(paragraph.SpaceBefore) > Tolerance ||
                                Math.Abs(paragraph.SpaceAfter) > Tolerance ||
                                paragraph.WordSpacing.Length != 3 ||
                                Math.Abs(paragraph.WordSpacing[0] - 0.8) > Tolerance ||
                                Math.Abs(paragraph.WordSpacing[1] - 1.0) > Tolerance ||
                                Math.Abs(paragraph.WordSpacing[2] - 1.33) > Tolerance ||
                                Math.Abs(paragraph.Zone - 36.0) > Tolerance)
                            {
                                throw new Exception();
                            }
                        }

                        // Checking style data
                        // Styles have different colors and font size
                        if (Math.Abs(portions[0].Style.FontSize - 12) > Tolerance ||
                            Math.Abs(portions[1].Style.FontSize - 12) > Tolerance ||
                            Math.Abs(portions[2].Style.FontSize - 12) > Tolerance ||
                            Math.Abs(portions[3].Style.FontSize - 10) > Tolerance)
                        {
                            throw new Exception();
                        }

                        if (portions[0].Style.FillColor != Color.FromArgb(255, 145, 0, 0) ||
                            portions[1].Style.FillColor != Color.FromArgb(255, 201, 128, 2) ||
                            portions[2].Style.FillColor != Color.FromArgb(255, 18, 143, 4) ||
                            portions[3].Style.FillColor != Color.FromArgb(255, 145, 42, 100))
                        {
                            throw new Exception();
                        }

                        for (int j = 0; j < portions.Length; j++)
                        {
                            var style = portions[j].Style;

                            if (style.AutoLeading != true ||
                                style.HindiNumbers != false ||
                                style.Kerning != 0 ||
                                style.Leading != 0 ||
                                style.StrokeColor != Color.FromArgb(255, 175, 90, 163) ||
                                style.Tracking != 50)
                            {
                                throw new Exception();
                            }
                        }

                        // Example of text editing
                        portions[0].Text = "Hello ";
                        portions[1].Text = "World";

                        // Example of text portions removing
                        layer.TextData.RemovePortion(3);
                        layer.TextData.RemovePortion(2);

                        // Example of adding new text portion
                        var createdPortion = layer.TextData.ProducePortion();
                        createdPortion.Text = "!!!\r";
                        layer.TextData.AddPortion(createdPortion);

                        portions = layer.TextData.Items;

                        // Example of paragraph and style editing for portions
                        // Set right justification
                        portions[0].Paragraph.Justification = JustificationMode.Right;
                        portions[1].Paragraph.Justification = JustificationMode.Right;
                        portions[2].Paragraph.Justification = JustificationMode.Right;

                        // Different colors for each style. The will be changed, but rendering is not fully supported
                        portions[0].Style.FillColor = Color.Aquamarine;
                        portions[1].Style.FillColor = Color.Violet;
                        portions[2].Style.FillColor = Color.LightBlue;

                        // Different font. The will be changed, but rendering is not fully supported
                        portions[0].Style.FontSize = 6;
                        portions[1].Style.FontSize = 8;
                        portions[2].Style.FontSize = 10;

                        layer.TextData.UpdateLayerData();

                        im.Save(outputPath, new PsdOptions(im));

                        break;
                    }
                }
            }

            //ExEnd:GetTextPropertiesFromTextLayer

            File.Delete(outputPath);
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GetTextPropertiesFromTextLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GradientFillLayer.cs ---
﻿using System;
using System.Collections.Generic;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class GradientFillLayer
    {
        public static void Run()
        {
            //ExStart:GradientFillLayer

            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            string sourceFileName = dataDir + "ComplexGradientFillLayer.psd";
            string outputFile = dataDir + "ComplexGradientFillLayer_output.psd";
            var image = (PsdImage)Image.Load(sourceFileName);
            using (image)
            {
                foreach (var layer in image.Layers)
                {
                    if (layer is FillLayer)
                    {
                        var fillLayer = (FillLayer)layer;
                        if (fillLayer.FillSettings.FillType != FillType.Gradient)
                        {
                            throw new Exception("Wrong Fill Layer");
                        }
                        var settings = (GradientFillSettings)fillLayer.FillSettings;
                        var solidGradient = (SolidGradient)settings.Gradient;

                        if (
                         Math.Abs(settings.Angle - 45) > 0.25 ||
                         settings.Dither != true ||
                         settings.AlignWithLayer != false ||
                         settings.Reverse != false ||
                         Math.Abs(settings.HorizontalOffset - (-39)) > 0.25 ||
                         Math.Abs(settings.VerticalOffset - (-5)) > 0.25 ||
                         solidGradient.TransparencyPoints.Length != 3 ||
                         solidGradient.ColorPoints.Length != 2 ||
                         Math.Abs(100.0 - solidGradient.TransparencyPoints[0].Opacity) > 0.25 ||
                         solidGradient.TransparencyPoints[0].Location != 0 ||
                         solidGradient.TransparencyPoints[0].MedianPointLocation != 50 ||
                         solidGradient.ColorPoints[0].Color != Color.FromArgb(203, 64, 140) ||
                         solidGradient.ColorPoints[0].Location != 0 ||
                         solidGradient.ColorPoints[0].MedianPointLocation != 50)
                        {
                            throw new Exception("Gradient Fill was not read correctly");
                        }

                        settings.Angle = 0.0;
                        settings.Dither = false;
                        settings.AlignWithLayer = true;
                        settings.Reverse = true;
                        settings.HorizontalOffset = 25;
                        settings.VerticalOffset = -15;

                        var colorPoints = new List<IGradientColorPoint>(solidGradient.ColorPoints);
                        var transparencyPoints = new List<IGradientTransparencyPoint>(solidGradient.TransparencyPoints);

                        colorPoints.Add(new GradientColorPoint()
                        {
                            Color = Color.Violet,
                            Location = 4096,
                            MedianPointLocation = 75
                        });

                        colorPoints[1].Location = 3000;

                        transparencyPoints.Add(new GradientTransparencyPoint()
                        {
                            Opacity = 80.0,
                            Location = 4096,
                            MedianPointLocation = 25
                        });

                        transparencyPoints[2].Location = 3000;
                        solidGradient.ColorPoints = colorPoints.ToArray();
                        solidGradient.TransparencyPoints = transparencyPoints.ToArray();
                        fillLayer.Update();
                        image.Save(outputFile, new PsdOptions(image));
                        break;
                    }
                }
            }

            //ExEnd:GradientFillLayer

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GradientFillLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GradientFillLayers.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class GradientFillLayers
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:GradientFillLayers

            string fileName = dataDir + "FillLayerGradient.psd";
            GradientType[] gradientTypes = new[]
            {
                GradientType.Linear, GradientType.Radial, GradientType.Angle, GradientType.Reflected, GradientType.Diamond
            };
            using (var image = Image.Load(fileName))
            {
                PsdImage psdImage = (PsdImage)image;
                FillLayer fillLayer = (FillLayer)psdImage.Layers[0];
                GradientFillSettings fillSettings = (GradientFillSettings)fillLayer.FillSettings;
                foreach (var gradientType in gradientTypes)
                {
                    fillSettings.GradientType = gradientType;
                    fillLayer.Update();
                    psdImage.Save(fileName + "_" + gradientType.ToString() + ".png", new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            //ExEnd:GradientFillLayers

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/GradientFillLayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ImportImageToPSDLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ImportImageToPSDLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ImportImageToPSDLayer

            // Load a PSD file as an image and caste it into PsdImage
            using (PsdImage image = (PsdImage)Image.Load(dataDir + "sample.psd"))
            {
                //Extract a layer from PSDImage
                Layer layer = image.Layers[1];

                // Create an image that is needed to be imported into the PSD file.
                using (PsdImage drawImage = new PsdImage(200, 200))
                {
                    // Fill image surface as needed.
                    Graphics g = new Graphics(drawImage);
                    g.Clear(Color.Yellow);

                    // Call DrawImage method of the Layer class and pass the image instance.
                    layer.DrawImage(new Point(10, 10), drawImage);
                }

                // Save the results to output path.
                image.Save(dataDir + "ImportImageToPSDLayer_out.psd");
            }

            //ExEnd:ImportImageToPSDLayer

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ImportImageToPSDLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/InterruptMonitorTest.cs ---
﻿using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    //ExStart:InterruptMonitorTest

    class InterruptMonitorTest
    {
        public static void Run()
        {

            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSB();
            InterruptMonitor(dataDir, dataDir);
        }

        public static void InterruptMonitor(string dir, string ouputDir)
        {
            ImageOptionsBase saveOptions = new ImageOptions.PngOptions();
            Multithreading.InterruptMonitor monitor = new Multithreading.InterruptMonitor();
            SaveImageWorker worker = new SaveImageWorker(dir + "big.psb", dir + "big_out.png", saveOptions, monitor);
            System.Threading.Thread thread = new System.Threading.Thread(new System.Threading.ThreadStart(worker.ThreadProc));

            try
            {
                thread.Start();

                // The timeout should be less than the time required for full image conversion (without interruption).
                System.Threading.Thread.Sleep(3000);

                // Interrupt the process
                monitor.Interrupt();
                System.Console.WriteLine("Interrupting the save thread #{0} at {1}", thread.ManagedThreadId, System.DateTime.Now);

                // Wait for interruption...
                thread.Join();
            }
            finally
            {
                // If the file to be deleted does not exist, no exception is thrown.
                System.IO.File.Delete(dir + "big_out.png");
            }
        }
    }
    /// <summary>
    /// Initiates image conversion and waits for its interruption.
    /// </summary>
    public class SaveImageWorker
    {
        /// <summary>
        /// The path to the input image.
        /// </summary>
        private readonly string inputPath;

        /// <summary>
        /// The path to the output image.
        /// </summary>
        private readonly string outputPath;

        /// <summary>
        /// The interrupt monitor.
        /// </summary>
        private readonly Multithreading.InterruptMonitor monitor;

        /// <summary>
        /// The save options.
        /// </summary>
        private readonly ImageOptionsBase saveOptions;

        /// <summary>
        /// Initializes a new instance of the <see cref="SaveImageWorker" /> class.
        /// </summary>
        /// <param name="inputPath">The path to the input image.</param>
        /// <param name="outputPath">The path to the output image.</param>
        /// <param name="saveOptions">The save options.</param>
        /// <param name="monitor">The interrupt monitor.</param>
        public SaveImageWorker(string inputPath, string outputPath, ImageOptionsBase saveOptions, Multithreading.InterruptMonitor monitor)
        {
            this.inputPath = inputPath;
            this.outputPath = outputPath;
            this.saveOptions = saveOptions;
            this.monitor = monitor;
        }

        /// <summary>
        /// Tries to convert image from one format to another. Handles interruption. 
        /// </summary>
        public void ThreadProc()
        {
            using (Image image = Image.Load(this.inputPath))
            {
                Multithreading.InterruptMonitor.ThreadLocalInstance = this.monitor;

                try
                {
                    image.Save(this.outputPath, this.saveOptions);
                    throw new Exception("Expected interruption.");
                }
                catch (CoreExceptions.OperationInterruptedException e)
                {
                    System.Console.WriteLine("The save thread #{0} finishes at {1}", System.Threading.Thread.CurrentThread.ManagedThreadId, System.DateTime.Now);
                    System.Console.WriteLine(e);
                }
                catch (System.Exception e)
                {
                    System.Console.WriteLine(e);
                }
                finally
                {
                    Multithreading.InterruptMonitor.ThreadLocalInstance = null;
                }
            }
        }
    }



    //ExEnd:InterruptMonitorTest
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/InterruptMonitorTest.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LayerCreationDateTime.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class LayerCreationDateTime
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:LayerCreationDateTime

            string SourceName = dataDir + "OneLayer.psd";

            // Load a PSD file as an image and cast it into PsdImage
            using (var im = (PsdImage)(Image.Load(SourceName)))
            {
                var layer = im.Layers[0];
                var creationDateTime = layer.LayerCreationDateTime;
                var expectedDateTime = new DateTime(2018, 7, 17, 8, 57, 24, 769);

                if (expectedDateTime != creationDateTime)
                {
                    throw new Exception("Assertion fails");
                }

                var now = DateTime.Now;
                var createdLayer = im.AddLevelsAdjustmentLayer();

                // Check if Creation Date Time Updated on newly created layers
                if (!(now <= createdLayer.LayerCreationDateTime))
                {
                    throw new Exception("Assertion fails");
                }
            }

            //ExEnd:LayerCreationDateTime
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LayerCreationDateTime.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LayerEffectsForPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class LayerEffectsForPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:LayerEffectsForPSD

            string sourceFileName = dataDir + "LayerWithText.psd";
            string exportPath = dataDir + "LayerEffectsForPSD.png";

            using (PsdImage image = (PsdImage)Image.Load(sourceFileName, new ImageLoadOptions.PsdLoadOptions()
            {
                LoadEffectsResource = true,
                UseDiskForLoadEffectsResource = true
            }))
            {
                image.Save(exportPath,
                    new ImageOptions.PngOptions()
                    {
                        ColorType =
                            FileFormats.Png
                                .PngColorType
                                .TruecolorWithAlpha
                    });
            }

            //ExEnd:LayerEffectsForPSD

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LayerEffectsForPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LoadImageToPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class LoadImageToPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:LoadImageToPSD

            string filePath = dataDir + "PsdExample.psd";
            string outputFilePath = dataDir + "PsdResult.psd";
            using (var image = new PsdImage(200, 200))
            {
                using (var im = Image.Load(filePath))
                {
                    Layer layer = null;
                    try
                    {
                        layer = new Layer((RasterImage)im);
                        image.AddLayer(layer);
                    }
                    catch (Exception e)
                    {
                        if (layer != null)
                        {
                            layer.Dispose();
                        }
                        throw;
                    }
                }
                image.Save(outputFilePath);
            }

            //ExEnd:LoadImageToPSD
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LoadImageToPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LoadPSDWithReadOnlyMode.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class LoadPSDWithReadOnlyMode
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:LoadPSDWithReadOnlyMode

            string sourceFileName = dataDir + "White 3D Text Effect.psd";
            string outFileName = dataDir + "Exported.png";

            LoadOptions loadOptions = new PsdLoadOptions() { ReadOnlyMode = true };
            ImageOptionsBase saveOptions = new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha };
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                image.Save(outFileName, saveOptions);
            }
            double memoryUsed = (GC.GetTotalMemory(false) / 1024.0) / 1024.0;

            // Memory usage must be less then 100 MB for this examples
            if (memoryUsed > 100)
            {
                throw new Exception("Usage of memory is too big");
            }
            //ExEnd:LoadPSDWithReadOnlyMode
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/LoadPSDWithReadOnlyMode.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManageBrightnessContrastAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ManageBrightnessContrastAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ManageBrightnessContrastAdjustmentLayer

            // Brightness/Contrast layer editing
            string sourceFileName = dataDir + "BrightnessContrastModern.psd";
            string psdPathAfterChange = dataDir + "BrightnessContrastModernChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is BrightnessContrastLayer)
                    {
                        var brightnessContrastLayer = (BrightnessContrastLayer)layer;
                        brightnessContrastLayer.Brightness = 50;
                        brightnessContrastLayer.Contrast = 50;
                    }
                }

                // Save PSD
                im.Save(psdPathAfterChange);
            }

            //ExEnd:ManageBrightnessContrastAdjustmentLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManageBrightnessContrastAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManageChannelMixerAdjusmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ManageChannelMixerAdjusmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ManageChannelMixerAdjusmentLayer

            // Rgb Channel Mixer
            string sourceFileName = dataDir + "ChannelMixerAdjustmentLayerRgb.psd";
            string psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerRgbChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is RgbChannelMixerLayer)
                    {
                        var rgbLayer = (RgbChannelMixerLayer)layer;
                        rgbLayer.RedChannel.Blue = 100;
                        rgbLayer.BlueChannel.Green = -100;
                        rgbLayer.GreenChannel.Constant = 50;
                    }
                }

                im.Save(psdPathAfterChange);
            }

            // Adding the new layer(Cmyk for this example)
            sourceFileName = dataDir + "CmykWithAlpha.psd";
            psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerCmykChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                var newlayer = im.AddChannelMixerAdjustmentLayer();
                newlayer.GetChannelByIndex(2).Constant = 50;
                newlayer.GetChannelByIndex(0).Constant = 50;

                im.Save(psdPathAfterChange);
            }

            //ExEnd:ManageChannelMixerAdjusmentLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManageChannelMixerAdjusmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManageExposureAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ManageExposureAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ManageExposureAdjustmentLayer

            // Exposure layer editing
            string sourceFileName = dataDir + "ExposureAdjustmentLayer.psd";
            string psdPathAfterChange = dataDir + "ExposureAdjustmentLayerChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is ExposureLayer)
                    {
                        var expLayer = (ExposureLayer)layer;
                        expLayer.Exposure = 2;
                        expLayer.Offset = -0.25f;
                        expLayer.GammaCorrection = 0.5f;
                    }
                }
                im.Save(psdPathAfterChange);
            }

            // Exposure layer adding
            sourceFileName = dataDir + "PhotoExample.psd";
            psdPathAfterChange = dataDir + "PhotoExampleAddedExposure.psd";

            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                var newlayer = im.AddExposureAdjustmentLayer();
                newlayer.Exposure = 10;
                newlayer.Offset = -0.25f;
                newlayer.GammaCorrection = 2f;

                im.Save(psdPathAfterChange);
            }
            //ExEnd:ManageExposureAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManageExposureAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManagePhotoFilterAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ManagePhotoFilterAdjustmentLayer
    {
        public static void Run()
        {
            //ExStart:ManagePhotoFilterAdjustmentLayer
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            // Photo Filter layer editing
            string sourceFileName = dataDir + "PhotoFilterAdjustmentLayer.psd";
            string psdPathAfterChange = dataDir + "PhotoFilterAdjustmentLayerChanged.psd";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is PhotoFilterLayer)
                    {
                        var photoLayer = (PhotoFilterLayer)layer;
                        photoLayer.Color = Color.FromArgb(255, 60, 60);
                        photoLayer.Density = 78;
                        photoLayer.PreserveLuminosity = false;
                    }
                }
                im.Save(psdPathAfterChange);
            }

            // Photo Filter layer adding
            sourceFileName = dataDir + "PhotoExample.psd";
            psdPathAfterChange = dataDir + "PhotoExampleAddedPhotoFilter.psd";

            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                var layer = im.AddPhotoFilterLayer(Color.FromArgb(25, 255, 35));

                im.Save(psdPathAfterChange);
            }
            //ExEnd:ManagePhotoFilterAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ManagePhotoFilterAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/MergeOnePSDlayerToOther.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class MergeOnePSDlayerToOther
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:MergeOnePSDlayerToOther

            var sourceFile1 = dataDir + "FillOpacitySample.psd";
            var sourceFile2 = dataDir + "ThreeRegularLayersSemiTransparent.psd";
            var exportPath = dataDir + "MergedLayersFromTwoDifferentPsd.psd";

            using (var im1 = (PsdImage)(Image.Load(sourceFile1)))
            {
                var layer1 = im1.Layers[1];

                using (var im2 = (PsdImage)(Image.Load(sourceFile2)))
                {
                    var layer2 = im2.Layers[0];

                    layer1.MergeLayerTo(layer2);
                    im2.Save(exportPath);
                }
            }

            //ExEnd:MergeOnePSDlayerToOther
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/MergeOnePSDlayerToOther.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/MergePSDlayers.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class MergePSDlayers
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:MergePSDlayers

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Create JPEG option class object, Set its properties and save image
                var jpgOptions = new JpegOptions();
                psdImage.Save(dataDir + "MergePSDlayers_output.jpg", jpgOptions);
            }

            //ExEnd:MergePSDlayers

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/MergePSDlayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDF.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PSDToPDF
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PSDToPDF

            // Add support of PSD export to PDF
            string[] sourcesFiles = new string[]
            {
              @"1.psd",
              @"little.psb",
              @"psb3.psb",
              @"inRgb16.psd",
              @"ALotOfElementTypes.psd",
              @"ColorOverlayAndShadowAndMask.psd",
              @"ThreeRegularLayersSemiTransparent.psd"
            };
            for (int i = 0; i < sourcesFiles.Length; i++)
            {
                string sourceFileName = sourcesFiles[i];
                using (PsdImage image = (PsdImage)Image.Load(dataDir + sourceFileName))
                {
                    string outFileName = "PsdToPdf" + i + ".pdf";
                    image.Save(dataDir + outFileName, new PdfOptions());
                }
            }

            //ExEnd:PSDToPDF
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDF.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDFWithAdjustmentLayers.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PSDToPDFWithAdjustmentLayers
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PSDToPDFWithAdjustmentLayers

            using (PsdImage image = (PsdImage)Image.Load(dataDir + "example.psd"))
            {
                image.Save(dataDir + "document.pdf", new PdfOptions());
            }

            //ExEnd:PSDToPDFWithAdjustmentLayers
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDFWithAdjustmentLayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDFWithClippingMask.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PSDToPDFWithClippingMask
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PSDToPDFWithClippingMask

            using (PsdImage image = (PsdImage)Image.Load(dataDir + "clip.psd"))
            {
                image.Save(dataDir + "output.pdf", new PdfOptions());
            }

            //ExEnd:PSDToPDFWithClippingMask
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDFWithClippingMask.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDFWithSelectableText.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PSDToPDFWithSelectableText
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PSDToPDFWithSelectableText

            string sourceFileName = dataDir + "text.psd";
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                string outFileName = dataDir + "text.pdf";
                image.Save(outFileName, new PdfOptions());
            }

            //ExEnd:PSDToPDFWithSelectableText

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPDFWithSelectableText.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPSB.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PSDToPSB
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PSDToPSB

            string sourceFilePathPsd = dataDir + "2layers.psd";
            string outputFilePathPsb = dataDir + "ConvertFromPsd.psb";
            using (Image img = Image.Load(sourceFilePathPsd))
            {
                var options = new PsdOptions((PsdImage)img) { PsdVersion = PsdVersion.Psb };
                img.Save(outputFilePathPsb, options);
            }
            //ExEnd:PSDToPSB
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PSDToPSB.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PatternFillLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PatternFillLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PatternFillLayer

            // Add support of Fill layers: Pattern
            string sourceFileName = dataDir + "PatternFillLayer.psd";
            string exportPath = dataDir + "PatternFillLayer_Edited.psd";
            double tolerance = 0.0001;
            var im = (PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is FillLayer)
                    {
                        FillLayer fillLayer = (FillLayer)layer;
                        PatternFillSettings fillSettings = (PatternFillSettings)fillLayer.FillSettings;
                        if (fillSettings.HorizontalOffset != -46 ||
                            fillSettings.VerticalOffset != -45 ||
                            fillSettings.PatternId != "a6818df2-7532-494e-9615-8fdd6b7f38e5" ||
                            fillSettings.PatternName != "$$$/Presets/Patterns/OpticalSquares=Optical Squares" ||
                            fillSettings.AlignWithLayer != true ||
                            fillSettings.Linked != true ||
                            fillSettings.PatternHeight != 64 ||
                            fillSettings.PatternWidth != 64 ||
                            fillSettings.PatternData.Length != 4096 ||
                            Math.Abs(fillSettings.Scale - 50) > tolerance)
                        {
                            throw new Exception("PSD Image was read wrong");
                        }
                        // Editing 
                        fillSettings.Scale = 300;
                        fillSettings.HorizontalOffset = 2;
                        fillSettings.VerticalOffset = -20;
                        fillSettings.PatternData = new int[]
                        {
                       Color.Red.ToArgb(), Color.Blue.ToArgb(),  Color.Blue.ToArgb(),
                       Color.Blue.ToArgb(), Color.Red.ToArgb(),  Color.Blue.ToArgb(),
                       Color.Blue.ToArgb(), Color.Blue.ToArgb(),  Color.Red.ToArgb()
                        };
                        fillSettings.PatternHeight = 3;
                        fillSettings.PatternWidth = 3;
                        fillSettings.AlignWithLayer = false;
                        fillSettings.Linked = false;
                        fillSettings.PatternId = Guid.NewGuid().ToString();
                        fillLayer.Update();
                        break;
                    }
                }
                im.Save(exportPath);
            }

            //ExEnd:PatternFillLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PatternFillLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PossibilityToFlattenLayers.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class PossibilityToFlattenLayers
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:PossibilityToFlattenLayers

            // Flatten whole PSD
            string sourceFileName = dataDir + "ThreeRegularLayersSemiTransparent.psd";
            string exportPath = dataDir + "ThreeRegularLayersSemiTransparentFlattened.psd";

            using (var im = (PsdImage)(Image.Load(sourceFileName)))
            {
                im.FlattenImage();
                im.Save(exportPath);
            }

            // Merge one layer in another
            exportPath = dataDir + "ThreeRegularLayersSemiTransparentFlattenedLayerByLayer.psd";

            using (var im = (PsdImage)(Image.Load(sourceFileName)))
            {
                var bottomLayer = im.Layers[0];
                var middleLayer = im.Layers[1];
                var topLayer = im.Layers[2];

                var layer1 = im.MergeLayers(bottomLayer, middleLayer);
                var layer2 = im.MergeLayers(layer1, topLayer);

                // Set up merged layers
                im.Layers = new Layer[] { layer2 };

                im.Save(exportPath);
            }
            //ExEnd:PossibilityToFlattenLayers
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/PossibilityToFlattenLayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingExportOfChannelMixerAdjusmentLyer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class RenderingExportOfChannelMixerAdjusmentLyer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingExportOfChannelMixerAdjusmentLyer

            // Rgb Channel Mixer
            string sourceFileName = dataDir + "ChannelMixerAdjustmentLayerRgb.psd";
            string psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerRgbChanged.psd";
            string pngExportPath = dataDir + "ChannelMixerAdjustmentLayerRgbChanged.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is RgbChannelMixerLayer)
                    {
                        var rgbLayer = (RgbChannelMixerLayer)layer;
                        rgbLayer.RedChannel.Blue = 100;
                        rgbLayer.BlueChannel.Green = -100;
                        rgbLayer.GreenChannel.Constant = 50;
                    }
                }

                // Save PSD
                im.Save(psdPathAfterChange);

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }

            // Cmyk Channel Mixer
            sourceFileName = dataDir + "ChannelMixerAdjustmentLayerCmyk.psd";
            psdPathAfterChange = dataDir + "ChannelMixerAdjustmentLayerCmykChanged.psd";
            pngExportPath = dataDir + "ChannelMixerAdjustmentLayerCmykChanged.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is CmykChannelMixerLayer)
                    {
                        var cmykLayer = (CmykChannelMixerLayer)layer;
                        cmykLayer.CyanChannel.Black = 20;
                        cmykLayer.MagentaChannel.Yellow = 50;
                        cmykLayer.YellowChannel.Cyan = -25;
                        cmykLayer.BlackChannel.Yellow = 25;
                    }
                }

                // Save PSD
                im.Save(psdPathAfterChange);

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }
            //ExEnd:RenderingExportOfChannelMixerAdjusmentLyer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingExportOfChannelMixerAdjusmentLyer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingExposureAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class RenderingExposureAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingExposureAdjustmentLayer

            // Exposure layer editing
            string sourceFileName = dataDir + "ExposureAdjustmentLayer.psd";
            string psdPathAfterChange = dataDir + "ExposureAdjustmentLayerChanged.psd";
            string pngExportPath = dataDir + "ExposureAdjustmentLayerChanged.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is ExposureLayer)
                    {
                        var expLayer = (ExposureLayer)layer;
                        expLayer.Exposure = 2;
                        expLayer.Offset = -0.25f;
                        expLayer.GammaCorrection = 0.5f;
                    }
                }

                // Save PSD
                im.Save(psdPathAfterChange);

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }

            // Exposure layer adding
            sourceFileName = dataDir + "PhotoExample.psd";
            psdPathAfterChange = dataDir + "PhotoExampleAddedExposure.psd";
            pngExportPath = dataDir + "PhotoExampleAddedExposure.png";

            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                var newlayer = im.AddExposureAdjustmentLayer();
                newlayer.Exposure = 2;
                newlayer.Offset = -0.25f;
                newlayer.GammaCorrection = 2f;

                // Save PSD
                im.Save(psdPathAfterChange);

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }
            //ExEnd:RenderingExposureAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingExposureAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfCurvesAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class RenderingOfCurvesAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingOfCurvesAdjustmentLayer

            // Curves layer editing
            string sourceFileName = dataDir + "CurvesAdjustmentLayer";
            string psdPathAfterChange = "CurvesAdjustmentLayerChanged";
            string pngExportPath = "CurvesAdjustmentLayerChanged";

            for (int j = 1; j < 2; j++)
            {
                using (var im = (PsdImage)Image.Load(sourceFileName + j.ToString() + ".psd"))
                {
                    foreach (var layer in im.Layers)
                    {
                        if (layer is CurvesLayer)
                        {
                            var curvesLayer = (CurvesLayer)layer;
                            if (curvesLayer.IsDiscreteManagerUsed)
                            {
                                var manager = (CurvesDiscreteManager)curvesLayer.GetCurvesManager();

                                for (int i = 10; i < 50; i++)
                                {
                                    manager.SetValueInPosition(0, (byte)i, (byte)(15 + (i * 2)));
                                }
                            }
                            else
                            {
                                var manager = (CurvesContinuousManager)curvesLayer.GetCurvesManager();
                                manager.AddCurvePoint(0, 50, 100);
                                manager.AddCurvePoint(0, 150, 130);
                            }
                        }
                    }

                    // Save PSD
                    im.Save(psdPathAfterChange + j.ToString() + ".psd");

                    // Save PNG
                    var saveOptions = new PngOptions();
                    saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                    im.Save(pngExportPath + j.ToString() + ".png", saveOptions);
                }
            }
            //ExEnd:RenderingOfCurvesAdjustmentLayer

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfCurvesAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfDifferentStylesInOneTextLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.Text;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class RenderingOfDifferentStylesInOneTextLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingOfDifferentStylesInOneTextLayer
            //ExSummary:The following example demonstrates how you can render different styles in one text layer in Aspose.PSD
            string sourceFile = dataDir + "text212.psd";
            string outputFile = dataDir + "Output_text212.psd";

            using (var img = (PsdImage)Image.Load(sourceFile))
            {
                TextLayer textLayer = (TextLayer)img.Layers[1];
                IText textData = textLayer.TextData;
                ITextStyle defaultStyle = textData.ProducePortion().Style;
                ITextParagraph defaultParagraph = textData.ProducePortion().Paragraph;
                defaultStyle.FillColor = Color.DimGray;
                defaultStyle.FontSize = 51;

                textData.Items[1].Style.Strikethrough = true;

                ITextPortion[] newPortions = textData.ProducePortions(
                    new string[]
                    {
                      "E=mc", "2\r", "Bold", "Italic\r",
                      "Lowercasetext"
                    },
                    defaultStyle,
                    defaultParagraph);

                newPortions[0].Style.Underline = true; // edit text style "E=mc"
                newPortions[1].Style.FontBaseline = FontBaseline.Superscript; // edit text style "2\r"
                newPortions[2].Style.FauxBold = true; // edit text style "Bold"
                newPortions[3].Style.FauxItalic = true; // edit text style "Italic\r"
                newPortions[3].Style.BaselineShift = -25; // edit text style "Italic\r"
                newPortions[4].Style.FontCaps = FontCaps.SmallCaps; // edit text style "Lowercasetext"

                foreach (var newPortion in newPortions)
                {
                    textData.AddPortion(newPortion);
                }

                textData.UpdateLayerData();
                img.Save(outputFile);
            }

            //ExEnd:RenderingOfDifferentStylesInOneTextLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfDifferentStylesInOneTextLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfLevelAdjustmentLayer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class RenderingOfLevelAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingOfLevelAdjustmentLayer

            string sourceFileName = dataDir + "LevelsAdjustmentLayer.psd";
            string psdPathAfterChange = dataDir + "LevelsAdjustmentLayerChanged.psd";
            string pngExportPath = dataDir + "LevelsAdjustmentLayerChanged.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is LevelsLayer)
                    {
                        var levelsLayer = (LevelsLayer)layer;
                        var channel = levelsLayer.GetChannel(0);
                        channel.InputMidtoneLevel = 2.0f;
                        channel.InputShadowLevel = 10;
                        channel.InputHighlightLevel = 230;
                        channel.OutputShadowLevel = 20;
                        channel.OutputHighlightLevel = 200;
                    }
                }

                // Save PSD
                im.Save(psdPathAfterChange);

                // Save PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(pngExportPath, saveOptions);
            }
            //ExEnd:RenderingOfLevelAdjustmentLayer

        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfLevelAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfPosterizeAdjustmentLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class RenderingOfPosterizeAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:RenderingOfPosterizeAdjustmentLayer
            //ExSummary:The following code demonstrates the support of PosterizeLayer.

            string sourceFile = Path.Combine(baseDir, "zendeya_posterize.psd");
            string outputFile = Path.Combine(outputDir, "zendeya_posterize_10.psd");

            using (var image = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions()))
            {
                foreach (Layer layer in image.Layers)
                {
                    if (layer is PosterizeLayer)
                    {
                        ((PosterizeLayer)layer).Levels = 10;
                        image.Save(outputFile);

                        break;
                    }
                }
            }

            //ExEnd:RenderingOfPosterizeAdjustmentLayer

            File.Delete(outputFile);

            Console.WriteLine("RenderingOfPosterizeAdjustmentLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfPosterizeAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfRotatedTextLayer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class RenderingOfRotatedTextLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:RenderingOfRotatedTextLayer
            string sourceFileName = dataDir + "TransformedText.psd";
            string exportPath = dataDir + "TransformedTextExport.psd";
            string exportPathPng = dataDir + "TransformedTextExport.png";
            var im = (PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                im.Save(exportPath);
                im.Save(exportPathPng, new PngOptions()
                {
                    ColorType = PngColorType.Grayscale
                });
            }

            //ExEnd:RenderingOfRotatedTextLayer

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/RenderingOfRotatedTextLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ResizePSDFile.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class ResizePSDFile
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ResizePSDFile

            // Implement correct Resize method for PSD files.
            string sourceFileName = dataDir + "1.psd";
            string exportPathPsd = dataDir + "ResizeTest.psd";
            string exportPathPng = dataDir + "ResizeTest.png";
            using (RasterImage image = Image.Load(sourceFileName) as RasterImage)
            {
                image.Resize(160, 120);
                image.Save(exportPathPsd, new PsdOptions());
                image.Save(exportPathPng, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd:ResizePSDFile
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/ResizePSDFile.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/Saving16BitGrayscalePsdImage.cs ---
﻿using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class Saving16BitGrayscalePsdImage
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output();

            //ExStart:Saving16BitGrayscalePsdImage
            
            Stack<string> outputFilePathStack = new Stack<string>();

            //The following example demonstrates that reading and saving the Grayscale 16 bit PSD files works correctly and without an exception.
            void SaveToPsdThenLoadAndSaveToPng(
                string file,
                ColorModes colorMode,
                short channelBitsCount,
                short channelsCount,
                CompressionMethod compression,
                int layerNumber)
            {
                string filePath = Path.Combine(dataDir, file + ".psd");
                string postfix = colorMode.ToString() + channelBitsCount + "_" + channelsCount + "_" + compression;
                string exportPath = Path.Combine(outputFolder, file + postfix + ".psd");
                PsdOptions psdOptions = new PsdOptions()
                {
                    ColorMode = colorMode,
                    ChannelBitsCount = channelBitsCount,
                    ChannelsCount = channelsCount,
                    CompressionMethod = compression
                };

                using (PsdImage image = (PsdImage)Image.Load(filePath))
                {
                    RasterCachedImage raster = layerNumber >= 0 ? (RasterCachedImage)image.Layers[layerNumber] : image;

                    Graphics graphics = new Graphics(raster);
                    int width = raster.Width;
                    int height = raster.Height;
                    Rectangle rect = new Rectangle(
                        width / 3,
                        height / 3,
                        width - (2 * (width / 3)) - 1,
                        height - (2 * (height / 3)) - 1);
                    graphics.DrawRectangle(new Pen(Color.DarkGray, 1), rect);

                    image.Save(exportPath, psdOptions);
                }

                string pngExportPath = Path.ChangeExtension(exportPath, "png");
                using (PsdImage image = (PsdImage)Image.Load(exportPath))
                {
                    // Here should be no exception.
                    image.Save(pngExportPath, new PngOptions() { ColorType = PngColorType.GrayscaleWithAlpha });
                }

                outputFilePathStack.Push(exportPath);
            }

            SaveToPsdThenLoadAndSaveToPng("grayscale5x5", ColorModes.Cmyk, 16, 5, CompressionMethod.RLE, 0);
            SaveToPsdThenLoadAndSaveToPng("argb16bit_5x5", ColorModes.Grayscale, 16, 2, CompressionMethod.RLE, 0);
            SaveToPsdThenLoadAndSaveToPng("argb16bit_5x5_no_layers", ColorModes.Grayscale, 16, 2, CompressionMethod.RLE, -1);
            SaveToPsdThenLoadAndSaveToPng("argb8bit_5x5", ColorModes.Grayscale, 16, 2, CompressionMethod.RLE, 0);
            SaveToPsdThenLoadAndSaveToPng("argb8bit_5x5_no_layers", ColorModes.Grayscale, 16, 2, CompressionMethod.RLE, -1);
            SaveToPsdThenLoadAndSaveToPng("cmyk16bit_5x5_no_layers", ColorModes.Grayscale, 16, 2, CompressionMethod.RLE, -1);
            SaveToPsdThenLoadAndSaveToPng("index8bit_5x5", ColorModes.Grayscale, 16, 2, CompressionMethod.RLE, -1);

            //ExEnd:Saving16BitGrayscalePsdImage

            Console.WriteLine("Saving16BitGrayscalePsdImage executed successfully");
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/Saving16BitGrayscalePsdImage.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/Saving16BitGrayscalePsdTo8BitGrayscale.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class Saving16BitGrayscalePsdTo8BitGrayscale
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output();

            //ExStart:Saving16BitGrayscalePsdTo8BitGrayscale

            //The following example demonstrates that reading and saving the Grayscale 16 bit PSD files to 8 bit per channel Grayscale works correctly and without an exception.
            string sourceFilePath = Path.Combine(dataDir, "grayscale16bit.psd");
            string exportFilePath = Path.Combine(outputFolder, "grayscale16bit_Grayscale8_2_RLE.psd");
            PsdOptions psdOptions = new PsdOptions()
            {
                ColorMode = ColorModes.Grayscale,
                ChannelBitsCount = 8,
                ChannelsCount = 2
            };

            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
            {
                RasterCachedImage raster = image.Layers[0];
                Graphics graphics = new Graphics(raster);
                int width = raster.Width;
                int height = raster.Height;
                Rectangle rect = new Rectangle(width / 3, height / 3, width - (2 * (width / 3)) - 1, height - (2 * (height / 3)) - 1);
                graphics.DrawRectangle(new Pen(Color.DarkGray, 1), rect);
                image.Save(exportFilePath, psdOptions);
            }

            string pngExportPath = Path.ChangeExtension(exportFilePath, "png");
            using (PsdImage image = (PsdImage)Image.Load(exportFilePath))
            {
                // Here should be no exception.
                image.Save(pngExportPath, new PngOptions() { ColorType = PngColorType.GrayscaleWithAlpha });
            }
            //ExEnd:Saving16BitGrayscalePsdTo8BitGrayscale

            Console.WriteLine("Saving16BitGrayscalePsdTo8BitGrayscale executed successfully");
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/Saving16BitGrayscalePsdTo8BitGrayscale.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/Saving16BitGrayscalePsdTo8BitRgb.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class Saving16BitGrayscalePsdTo8BitRgb
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();
            string outputFolder = RunExamples.GetDataDir_Output();

            //ExStart:Saving16BitGrayscalePsdTo8BitRgb

            //The following example demonstrates that reading and saving the Grayscale 16 bit PSD files to 16bit per channel RGB works correctly and without an exception.

            string sourceFilePath = Path.Combine(dataDir, "grayscale5x5.psd");
            string exportFilePath = Path.Combine(outputFolder, "rgb16bit5x5.psd");
            PsdOptions psdOptions = new PsdOptions()
            {
                ColorMode = ColorModes.Rgb,
                ChannelBitsCount = 16,
                ChannelsCount = 4
            };

            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
            {
                RasterCachedImage raster = image.Layers[0];
                Graphics graphics = new Graphics(raster);
                int width = raster.Width;
                int height = raster.Height;
                Rectangle rect = new Rectangle(width / 3, height / 3, width - (2 * (width / 3)) - 1, height - (2 * (height / 3)) - 1);
                graphics.DrawRectangle(new Pen(Color.DarkGray, 1), rect);
                image.Save(exportFilePath, psdOptions);
            }

            string pngExportPath = Path.ChangeExtension(exportFilePath, "png");
            using (PsdImage image = (PsdImage)Image.Load(exportFilePath))
            {
                // Here should be no exception.
                image.Save(pngExportPath, new PngOptions() { ColorType = PngColorType.GrayscaleWithAlpha });
            }

            //ExEnd:Saving16BitGrayscalePsdTo8BitRgb

            Console.WriteLine("Saving16BitGrayscalePsdTo8BitRgb executed successfully");
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/Saving16BitGrayscalePsdTo8BitRgb.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SetTextLayerPosition.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SetTextLayerPosition
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SetTextLayerPosition
            string sourceFileName = dataDir + "OneLayer.psd";
            string exportPath = dataDir + "OneLayer_Edited.psd";
            int leftPos = 99;
            int topPos = 47;
            var im = (PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                im.AddTextLayer("Some text", new Rectangle(leftPos, topPos, 99, 47));
                TextLayer textLayer = (TextLayer)im.Layers[1];
                if (textLayer.Left != leftPos || textLayer.Top != topPos)
                {
                    throw new Exception("Was created incorrect Text Layer");
                }

                im.Save(exportPath);
            }

            //ExEnd:SetTextLayerPosition
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SetTextLayerPosition.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SheetColorHighlighting.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SheetColorHighlighting
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SheetColorHighlighting
            string sourceFileName = dataDir + "SheetColorHighlightExample.psd";
            string exportPath = dataDir + "SheetColorHighlightExampleChanged.psd";


            // Load a PSD file as an image and cast it into PsdImage
            using (var im = (PsdImage)(Image.Load(sourceFileName)))
            {
                var layer1 = im.Layers[0];
                var layer2 = im.Layers[1];

                if (layer1.SheetColorHighlight != SheetColorHighlightEnum.Violet ||
                    layer2.SheetColorHighlight != SheetColorHighlightEnum.Orange)
                {
                    throw new Exception("Assertion failed");
                }

                layer1.SheetColorHighlight = SheetColorHighlightEnum.Yellow;

                im.Save(exportPath);
            }

            //ExEnd:SheetColorHighlighting
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SheetColorHighlighting.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/StrokeEffectWithColorFill.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class StrokeEffectWithColorFill
    {
        public static void Run()
        {
            //ExStart:StrokeEffectWithColorFill

            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            // Implement rendering of Stroke effect with Color Fill for export
            string sourceFileName = dataDir + "StrokeComplex.psd";
            string exportPath = dataDir + "StrokeComplexRendering.psd";
            string exportPathPng = dataDir + "StrokeComplexRendering.png";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            using (var im = (PsdImage)Image.Load(sourceFileName, loadOptions))
            {
                for (int i = 0; i < im.Layers.Length; i++)
                {
                    var effect = (StrokeEffect)im.Layers[i].BlendingOptions.Effects[0];
                    var settings = (ColorFillSettings)effect.FillSettings;
                    settings.Color = Color.DeepPink;
                }

                // Save psd
                im.Save(exportPath, new PsdOptions());

                // Save png
                im.Save(exportPathPng, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd:StrokeEffectWithColorFill
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/StrokeEffectWithColorFill.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit
    {
        
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit
            //ExSummary:The following code demonstrates the support of the new IsStandardVerticalRomanAlignmentEnabled property.

            // The following code demonstrates the ability to edit the new IsStandardVerticalRomanAlignmentEnabled property.
            // This does not affect rendering at the moment, but only allows you to edit the property value.

            string src = Path.Combine(baseDir, "1346test.psd");
            string output = Path.Combine(outputDir, "out_1346test.psd");

            using (var image = (PsdImage)Image.Load(src))
            {
                var textLayer = image.Layers[1] as TextLayer;
                var textPortion = textLayer.TextData.Items[0];
                if (textPortion.Style.IsStandardVerticalRomanAlignmentEnabled)
                {
                    // Correct reading
                }
                else
                {
                    throw new Exception("Incorrect reading of IsStandardVerticalRomanAlignmentEnabled property value");
                }

                textPortion.Style.IsStandardVerticalRomanAlignmentEnabled = false;
                textLayer.TextData.UpdateLayerData();

                image.Save(output);
            }

            using (var image = (PsdImage)Image.Load(output))
            {
                var textLayer = image.Layers[1] as TextLayer;
                var textPortion = textLayer.TextData.Items[0];
                if (!textPortion.Style.IsStandardVerticalRomanAlignmentEnabled)
                {
                    // Correct reading
                }
                else
                {
                    throw new Exception("Incorrect reading of IsStandardVerticalRomanAlignmentEnabled property value");
                }
            }

            //ExEnd:SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit

            File.Delete(output);

            Console.WriteLine("SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportLayerForPSD.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using System.Diagnostics;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportLayerForPSD
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportLayerForPSD

            string sourceFileName = dataDir + "layers.psd";
            string output = dataDir + "layers.png";

            using (PsdImage image = (PsdImage)Image.Load(sourceFileName,
                new ImageLoadOptions.PsdLoadOptions()
                {
                    LoadEffectsResource = true,
                    UseDiskForLoadEffectsResource = true
                }))
            {
                Debug.Assert(image.Layers[2] != null, "Layer with effects resource was not recognized");

                image.Save(output, new ImageOptions.PngOptions()
                {
                    ColorType =
                        FileFormats.Png
                            .PngColorType
                            .TruecolorWithAlpha
                });
            }

            //ExEnd:SupportLayerForPSD
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportLayerForPSD.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfAdjusmentLayers.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfAdjusmentLayers
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfAdjusmentLayers

            // Channel Mixer Adjustment Layer
            string sourceFileName1 = dataDir + "ChannelMixerAdjustmentLayer.psd";
            string exportPath1 = dataDir + "ChannelMixerAdjustmentLayerChanged.psd";

            using (var im = (PsdImage)(Image.Load(sourceFileName1)))
            {
                for (int i = 0; i < im.Layers.Length; i++)
                {
                    var adjustmentLayer = im.Layers[i] as AdjustmentLayer;

                    if (adjustmentLayer != null)
                    {
                        adjustmentLayer.MergeLayerTo(im.Layers[0]);
                    }
                }

                // Save PSD
                im.Save(exportPath1);
            }

            // Levels adjustment layer
            var sourceFileName2 = dataDir + "LevelsAdjustmentLayerRgb.psd";
            var exportPath2 = dataDir + "LevelsAdjustmentLayerRgbChanged.psd";

            using (var im = (PsdImage)(Image.Load(sourceFileName2)))
            {
                for (int i = 0; i < im.Layers.Length; i++)
                {
                    var adjustmentLayer = im.Layers[i] as AdjustmentLayer;

                    if (adjustmentLayer != null)
                    {
                        adjustmentLayer.MergeLayerTo(im.Layers[0]);
                    }
                }

                // Save PSD
                im.Save(exportPath2);
            }
            //ExEnd:SupportOfAdjusmentLayers

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfAdjusmentLayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfBlendClippedElementsProperty.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfBlendClippedElementsProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfBlendClippedElementsProperty
            //ExSummary:The following code demonstrates support of BlendClippedElements property.
            
            string sourceFile = Path.Combine(baseDir, "example_source.psd");
            string outputPsd = Path.Combine(outputDir, "example_output.psd");
            string outputPng = Path.Combine(outputDir, "example_output.png");

            using (var image = (PsdImage)Image.Load(sourceFile))
            {
                image.Layers[1].BlendClippedElements = false;
                image.Save(outputPsd);
                image.Save(outputPng, new PngOptions());
            }

            //ExEnd:SupportOfBlendClippedElementsProperty

            File.Delete(outputPsd);
            File.Delete(outputPng);

            Console.WriteLine("SupportOfBlendClippedElementsProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfBlendClippedElementsProperty.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfCMYKColorMode16bit.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfCMYKColorMode16bit
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfCMYKColorMode16bit
            //ExSummary:The following code demonstrates the support of the CMYK ColorMode 16 bit and the ability to drawing by using Aspose.PSD.Graphics class.

            string srcFile = Path.Combine(baseFolder, "cub16bit_cmyk.psd");
            string outputPsd = Path.Combine(output, "output.psd");
            string outputPng = Path.Combine(output, "output.png");

            using (PsdImage image = (PsdImage)Image.Load(srcFile))
            {
                RasterCachedImage raster = image.Layers[0];
                Graphics graphics = new Graphics(raster);
                int width = raster.Width;
                int height = raster.Height;
                Rectangle rect = new Rectangle(width / 3, height / 3, width - (2 * (width / 3)) - 1, height - (2 * (height / 3)) - 1);
                graphics.DrawRectangle(new Pen(Color.DarkGray, 1), rect);
                image.Save(outputPsd);
                image.Save(outputPng, new PngOptions());
            }

            //ExEnd:SupportOfCMYKColorMode16bit
            
            File.Delete(outputPsd);
            File.Delete(outputPng);

            Console.WriteLine("SupportOfCMYKColorMode16bit executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfCMYKColorMode16bit.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfClippingMask.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfClippingMask
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfClippingMask

            // Exposure layer editing
            // Export of the psd with complex clipping mask
            string sourceFileName = dataDir + "ClippingMaskComplex.psd";
            string exportPath = dataDir + "ClippingMaskComplex.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                // Export to PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(exportPath, saveOptions);
            }
            //ExEnd:SupportOfClippingMask
        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfClippingMask.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfEditFontNameInTextPortionStyle.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.Text;
using Aspose.PSD.ImageOptions;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfEditFontNameInTextPortionStyle
    {
        public static void Run()
        {
            // The path to the documents directory.
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfEditFontNameInTextPortionStyle
            //ExSummary:The following code demonstrate the ability to change font name at portion style.

            string outputFilePng = outputDir + "result_fontEditTest.png";
            string outputFilePsd = outputDir + "fontEditTest.psd";

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            using (var image = new PsdImage(500, 500))
            {
                FillLayer backgroundFillLayer = FillLayer.CreateInstance(FillType.Color);
                ((IColorFillSettings)backgroundFillLayer.FillSettings).Color = Color.White;
                image.AddLayer(backgroundFillLayer);

                TextLayer textLayer = image.AddTextLayer("Text 1", new Rectangle(10, 35, image.Width, 60));

                ITextPortion firstPortion = textLayer.TextData.Items[0];
                firstPortion.Style.FontSize = 24;
                firstPortion.Style.FontName = FontSettings.GetAdobeFontName("Comic Sans MS");

                var secondPortion = textLayer.TextData.ProducePortion();
                secondPortion.Text = "Text 2";
                secondPortion.Paragraph.Apply(firstPortion.Paragraph);
                secondPortion.Style.Apply(firstPortion.Style);
                secondPortion.Style.FontName = FontSettings.GetAdobeFontName("Arial");

                textLayer.TextData.AddPortion(secondPortion);
                textLayer.TextData.UpdateLayerData();

                image.Save(outputFilePng, new PngOptions());
                image.Save(outputFilePsd);
            }

            using (var image = (PsdImage)Image.Load(outputFilePsd))
            {
                TextLayer textLayer = (TextLayer)image.Layers[2];

                string adobeFontName1 = FontSettings.GetAdobeFontName("Comic Sans MS");
                string adobeFontName2 = FontSettings.GetAdobeFontName("Arial");

                AssertAreEqual(adobeFontName1, textLayer.TextData.Items[0].Style.FontName);
                AssertAreEqual(adobeFontName2, textLayer.TextData.Items[1].Style.FontName);
            }

            //ExEnd:SupportOfEditFontNameInTextPortionStyle

            File.Delete(outputFilePng);
            File.Delete(outputFilePsd);
            
            Console.WriteLine("SupportOfEditFontNameInTextPortionStyle executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfEditFontNameInTextPortionStyle.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfEffectTypeProperty.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfEffectTypeProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportOfEffectTypeProperty
            //ExSummary:The following code demonstrates support of ILayerEffect.EffectType property.
            
            string inputFile = Path.Combine(baseDir, "input.psd");
            string outputWithout = Path.Combine(outputDir, "outputWithout.png");
            string outputWith = Path.Combine(outputDir, "outputWith.png");

            using (PsdImage psdImage = (PsdImage)Image.Load(inputFile, new LoadOptions()))
            {
                psdImage.Save(outputWithout, new PngOptions());

                Layer workLayer = psdImage.Layers[1];

                DropShadowEffect dropShadowEffect = workLayer.BlendingOptions.AddDropShadow();
                dropShadowEffect.Distance = 0;
                dropShadowEffect.Size = 8;
                dropShadowEffect.Opacity = 20;

                foreach (ILayerEffect iEffect in workLayer.BlendingOptions.Effects)
                {
                    if (iEffect.EffectType == LayerEffectsTypes.DropShadow)
                    {
                        // it caught
                        psdImage.Save(outputWith, new PngOptions());
                    }
                }
            }

            //ExEnd:SupportOfEffectTypeProperty
            
            File.Delete(outputWithout);
            File.Delete(outputWith);
            
            Console.WriteLine("SupportOfEffectTypeProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfEffectTypeProperty.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfGdFlResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using System.Collections.Generic;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfGdFlResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfGdFlResource

            // Support of GdFlResource
            string sourceFileName = dataDir + "ComplexGradientFillLayer.psd";
            string exportPath = dataDir + "ComplexGradientFillLayer_after.psd";
            var im = (FileFormats.Psd.PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is FillLayer)
                    {
                        var fillLayer = (FillLayer)layer;
                        var resources = fillLayer.Resources;
                        foreach (var res in resources)
                        {
                            if (res is GdFlResource)
                            {
                                // Reading
                                var resource = (GdFlResource)res;
                                if (resource.AlignWithLayer != false ||
                                 (Math.Abs(resource.Angle - 45.0) > 0.001) ||
                                 resource.Dither != true ||
                                 resource.Reverse != false ||
                                 resource.Color != Color.Empty ||
                                 Math.Abs(resource.HorizontalOffset - (-39)) > 0.001 ||
                                 Math.Abs(resource.VerticalOffset - (-5)) > 0.001 ||
                                 resource.TransparencyPoints.Length != 3 ||
                                 resource.ColorPoints.Length != 2)
                                {
                                    throw new Exception("Resource Parameters were read wrong");
                                }
                                var transparencyPoints = resource.TransparencyPoints;
                                if (Math.Abs(100.0 - transparencyPoints[0].Opacity) > 0.25 ||
                                 transparencyPoints[0].Location != 0 ||
                                 transparencyPoints[0].MedianPointLocation != 50 ||
                                 Math.Abs(50.0 - transparencyPoints[1].Opacity) > 0.25 ||
                                 transparencyPoints[1].Location != 2048 ||
                                 transparencyPoints[1].MedianPointLocation != 50 ||
                                 Math.Abs(100.0 - transparencyPoints[2].Opacity) > 0.25 ||
                                 transparencyPoints[2].Location != 4096 ||
                                 transparencyPoints[2].MedianPointLocation != 50)
                                {
                                    throw new Exception("Gradient Transparency Points were read Wrong");
                                }
                                var colorPoints = resource.ColorPoints;
                                if (colorPoints[0].Color != Color.FromArgb(203, 64, 140) ||
                                 colorPoints[0].Location != 0 ||
                                 colorPoints[0].MedianPointLocation != 50 ||
                                 colorPoints[1].Color != Color.FromArgb(203, 0, 0) ||
                                 colorPoints[1].Location != 4096 ||
                                 colorPoints[1].MedianPointLocation != 50)
                                {
                                    throw new Exception("Gradient Color Points were read Wrong");
                                }
                                // Editing
                                resource.Angle = 30.0;
                                resource.Dither = false;
                                resource.AlignWithLayer = true;
                                resource.Reverse = true;
                                resource.HorizontalOffset = 25;
                                resource.VerticalOffset = -15;
                                var newColorPoints = new List<IGradientColorPoint>(resource.ColorPoints);
                                var
                                 newTransparencyPoints = new
                                List<IGradientTransparencyPoint>(resource.TransparencyPoints);
                                newColorPoints.Add(new GradientColorPoint()
                                {
                                    Color = Color.Violet,
                                    Location = 4096,
                                    MedianPointLocation = 75
                                });
                                colorPoints[1].Location = 3000;
                                newTransparencyPoints.Add(new GradientTransparencyPoint()
                                {
                                    Opacity = 80.0,
                                    Location = 4096,
                                    MedianPointLocation = 25
                                });
                                transparencyPoints[2].Location = 3000;
                                resource.ColorPoints = newColorPoints.ToArray();
                                resource.TransparencyPoints = newTransparencyPoints.ToArray();
                                im.Save(exportPath);
                            }
                            break;
                        }
                        break;
                    }
                }
            }

            //ExEnd:SupportOfGdFlResource

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfGdFlResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfITextStyleProperties.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfITextStyleProperties
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfITextStyleProperties
            //ExSummary:The following code demonstrates the support of the support of new ITextStyle properties.

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new FormatException(
                        string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            string srcFile = baseFolder + "A.psd";
            string outputFile = output + "output.psd";

            using (var psdImage = (PsdImage)Image.Load(srcFile))
            {
                var textLayer = (TextLayer)psdImage.Layers[1];
                textLayer.UpdateText("abc");

                psdImage.Save(outputFile);
            }

            // Check values
            using (var srcImage = (PsdImage)Image.Load(srcFile))
            {
                var srcTextLayer = (TextLayer)srcImage.Layers[1];
                var etalonStyle = srcTextLayer.TextData.Items[0].Style;

                using (var outImage = (PsdImage)Image.Load(outputFile))
                {
                    var outTextLayer = (TextLayer)outImage.Layers[1];
                    var resultStyle = outTextLayer.TextData.Items[0].Style;

                    AssertAreEqual(etalonStyle.AutoLeading, resultStyle.AutoLeading);
                    AssertAreEqual(etalonStyle.FontIndex, resultStyle.FontIndex);
                    AssertAreEqual(etalonStyle.Underline, resultStyle.Underline);
                    AssertAreEqual(etalonStyle.Strikethrough, resultStyle.Strikethrough);
                    AssertAreEqual(etalonStyle.AutoKerning, resultStyle.AutoKerning);
                    AssertAreEqual(etalonStyle.StandardLigatures, resultStyle.StandardLigatures);
                    AssertAreEqual(etalonStyle.DiscretionaryLigatures, resultStyle.DiscretionaryLigatures);
                    AssertAreEqual(etalonStyle.ContextualAlternates, resultStyle.ContextualAlternates);
                    AssertAreEqual(etalonStyle.LanguageIndex, resultStyle.LanguageIndex);
                    AssertAreEqual(etalonStyle.VerticalScale, resultStyle.VerticalScale);
                    AssertAreEqual(etalonStyle.HorizontalScale, resultStyle.HorizontalScale);
                    AssertAreEqual(etalonStyle.Fractions, resultStyle.Fractions);
                }
            }

            //ExEnd:SupportOfITextStyleProperties

            Console.WriteLine("SupportOfITextStyleProperties executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfITextStyleProperties.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfInnerShadowLayerEffect.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfInnerShadowLayerEffect
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfInnerShadowLayerEffect
            string sourceFile = dataDir + "innershadow.psd";
            string destName = dataDir + "innershadow_out.psd";

            var loadOptions = new PsdLoadOptions()
            {
                LoadEffectsResource = true
            };

            // Load an existing image into an instance of PsdImage class
            using (var image = (PsdImage)Image.Load(sourceFile, loadOptions))
            {
                var layer = image.Layers[image.Layers.Length - 1];
                var shadowEffect = (IShadowEffect)layer.BlendingOptions.Effects[0];

                shadowEffect.Color = Color.Green;
                shadowEffect.Opacity = 128;
                shadowEffect.Distance = 1;
                shadowEffect.UseGlobalLight = false;
                shadowEffect.Size = 2;
                shadowEffect.Angle = 45;
                shadowEffect.Spread = 50;
                shadowEffect.Noise = 5;

                image.Save(destName, new PsdOptions(image));
            }

            //ExEnd:SupportOfInnerShadowLayerEffect

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfInnerShadowLayerEffect.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLayerMask.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfLayerMask
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfLayerMask

            // Export of the psd with complex mask
            string sourceFileName = dataDir + "MaskComplex.psd";
            string exportPath = dataDir + "MaskComplex.png";

            using (var im = (PsdImage)Image.Load(sourceFileName))
            {
                // Export to PNG
                var saveOptions = new PngOptions();
                saveOptions.ColorType = PngColorType.TruecolorWithAlpha;
                im.Save(exportPath, saveOptions);
            }

            //ExEnd:SupportOfLayerMask
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLayerMask.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLayerVectorMask.cs ---
﻿using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfLayerVectorMask
    {
        public static void Run()
        {
            // The path to the document's directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfLayerVectorMask
            string sourceFileName = dataDir + "DifferentLayerMasks_Source.psd";
            string exportPath = dataDir + "DifferentLayerMasks_Export.psd";
            string exportPathPng = dataDir + "DifferentLayerMasks_Export.png";
            // reading
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                // make changes to the vector path points
                foreach (var layer in image.Layers)
                {
                    foreach (var layerResource in layer.Resources)
                    {
                        var resource = layerResource as VectorPathDataResource;
                        if (resource != null)
                        {
                            foreach (var pathRecord in resource.Paths)
                            {
                                var bezierKnotRecord = pathRecord as BezierKnotRecord;
                                if (bezierKnotRecord != null)
                                {
                                    Point p0 = bezierKnotRecord.Points[0];
                                    bezierKnotRecord.Points[0] = bezierKnotRecord.Points[2];
                                    bezierKnotRecord.Points[2] = p0;
                                    break;
                                }
                            }
                        }
                    }
                }
                // exporting
                image.Save(exportPath);
                image.Save(exportPathPng, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd:SupportOfLayerVectorMask
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLayerVectorMask.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLeadingTypeInTextPortion.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.Text;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfLeadingTypeInTextPortion
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfLeadingTypeInTextPortion
            //ExSummary:The following code demonstrates the support of Bottom-to-bottom and Top-to-Top leading modes from Paragraph settings.

            string input = Path.Combine(baseDir, "leadingMode.psd");
            string output = Path.Combine(outputDir, "output_leadingMode.png");
            
            using (var psdImage = (PsdImage)Image.Load(input, new PsdLoadOptions()))
            {
                IText text1 = ((TextLayer)psdImage.Layers[1]).TextData;
                foreach (var textPortion in text1.Items)
                {
                    textPortion.Paragraph.LeadingType = LeadingType.TopToTop; // Change LeadingType value   
                }
                text1.Items[8].Text = "TopToTop";
                text1.Items[8].Style.FillColor = Color.ForestGreen;
                text1.UpdateLayerData();

                IText text2 = ((TextLayer)psdImage.Layers[2]).TextData;
                foreach (var textPortion in text2.Items)
                {
                    textPortion.Paragraph.LeadingType = LeadingType.BottomToBottom; // Change LeadingType value   
                }
                text2.Items[8].Text = "BottomToBottom";
                text2.Items[8].Style.FillColor = Color.ForestGreen;
                text2.UpdateLayerData();

                psdImage.Save(output, new PngOptions());
            }

            //ExEnd:SupportOfLeadingTypeInTextPortion

            File.Delete(output);

            Console.WriteLine("SupportOfLeadingTypeInTextPortion executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLeadingTypeInTextPortion.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLinkedLayer.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfLinkedLayer
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfLinkedLayer
            using (var psd = (PsdImage)Image.Load(dataDir + "LinkedLayerexample.psd"))
            {
                Layer[] layers = psd.Layers;

                // link all layers in one linked group
                short layersLinkGroupId = psd.LinkedLayersManager.LinkLayers(layers);

                // gets id for one layer
                short linkGroupId = psd.LinkedLayersManager.GetLinkGroupId(layers[0]);
                if (layersLinkGroupId != linkGroupId)
                {
                    throw new Exception("layersLinkGroupId and linkGroupId are not equal.");
                }

                // gets all linked layers by link group id.
                Layer[] linkedLayers = psd.LinkedLayersManager.GetLayersByLinkGroupId(linkGroupId);

                // unlink each layer from group
                foreach (var linkedLayer in linkedLayers)
                {
                    psd.LinkedLayersManager.UnlinkLayer(linkedLayer);
                }

                // retrieves NULL for a link group ID that has no layers in the group.
                linkedLayers = psd.LinkedLayersManager.GetLayersByLinkGroupId(linkGroupId);
                if (linkedLayers != null)
                {
                    throw new Exception("The linkedLayers field is not NULL.");
                }
                psd.Save(dataDir + "LinkedLayerexample_output.psd");
            }

            //ExEnd:SupportOfLinkedLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfLinkedLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPostResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.StrokeResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfPostResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPostResource
            //ExSummary:The following code demonstrates the ability to manipulation of PostResource.

            string sourceFile = Path.Combine(baseDir, "zendeya_posterize.psd");
            string outputFile = Path.Combine(outputDir, "zendeya_posterize_10.psd");

            using (var image = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions()))
            {
                Layer layer = image.Layers[1];

                foreach (LayerResource resource in layer.Resources)
                {
                    if (resource is PostResource)
                    {
                        ((PostResource)resource).Levels = 10;
                        image.Save(outputFile);

                        break;
                    }
                }
            }

            //ExEnd:SupportOfPostResource

            File.Delete(outputFile);

            Console.WriteLine("SupportOfPostResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPostResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPosterizeAdjustmentLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfPosterizeAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPosterizeAdjustmentLayer
            //ExSummary:The following code demonstrates the ability to add PosterizeAdjustmentLayer through PsdImage.
            
            string srcFile = Path.Combine(baseDir, "zendeya.psd");
            string outFile = Path.Combine(outputDir, "zendeya.psd.out.psd");

            using (PsdImage psdImage = (PsdImage)Image.Load(srcFile))
            {
                psdImage.AddPosterizeAdjustmentLayer();
                psdImage.Save(outFile);
            }

            // Check saved changes
            using (PsdImage image = (PsdImage)Image.Load(
                       outFile,
                       new PsdLoadOptions { LoadEffectsResource = true }))
            {
                AssertAreEqual(2, image.Layers.Length);

                PosterizeLayer posterizeLayer = (PosterizeLayer)image.Layers[1];

                AssertAreEqual(true, posterizeLayer is PosterizeLayer);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            //ExEnd:SupportOfPosterizeAdjustmentLayer

            File.Delete(outFile);

            Console.WriteLine("SupportOfPosterizeAdjustmentLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPosterizeAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPsdOptionsBackgroundContentsProperty.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Core.RawColor;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfPsdOptionsBackgroundContentsProperty
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPsdOptionsBackgroundContentsProperty
            //ExSummary:The following code demonstrates support of BackgroundContents property in PsdOptions.
            
            // Semi transparency is processed wrong on the psd file preview.
            // BackgroundContents assigned to White. Transparent areas should have white color.

            string sourceFile = Path.Combine(baseDir, "frog_nosymb.psd");
            string outputFile = Path.Combine(outputDir, "frog_nosymb_backgroundcontents_output.psd");

            using (PsdImage psdImage = (PsdImage)Image.Load(sourceFile))
            {
                RawColor backgroundColor = new RawColor(PixelDataFormat.Rgb32Bpp);
                int argbValue = 255 << 24 | 255 << 16 | 255 << 8 | 255;
                backgroundColor.SetAsInt(argbValue); // White

                PsdOptions psdOptions = new PsdOptions(psdImage)
                {
                    ColorMode = ColorModes.Rgb,
                    CompressionMethod = CompressionMethod.RLE,
                    ChannelsCount = 4,
                    BackgroundContents = backgroundColor,
                };

                psdImage.Save(outputFile, psdOptions);
            }
            //ExEnd:SupportOfPsdOptionsBackgroundContentsProperty

            File.Delete(outputFile);

            Console.WriteLine("SupportOfPsdOptionsBackgroundContentsProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPsdOptionsBackgroundContentsProperty.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPtFlResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfPtFlResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfPtFlResource

            // Support of PtFlResource
            string sourceFileName = dataDir + "PatternFillLayer.psd";
            string exportPath = dataDir + "PtFlResource_Edited.psd";
            double tolerance = 0.0001;
            var im = (PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is FillLayer)
                    {
                        var fillLayer = (FillLayer)layer;
                        var resources = fillLayer.Resources;
                        foreach (var res in resources)
                        {
                            if (res is PtFlResource)
                            {
                                // Reading
                                PtFlResource resource = (PtFlResource)res;
                                if (
                                    resource.Offset.X != -46 ||
                                    resource.Offset.Y != -45 ||
                                    resource.PatternId != "a6818df2-7532-494e-9615-8fdd6b7f38e5\0" ||
                                    resource.PatternName != "$$$/Presets/Patterns/OpticalSquares=Optical Squares\0" ||
                                    resource.AlignWithLayer != true ||
                                    resource.IsLinkedWithLayer != true ||
                                    !(Math.Abs(resource.Scale - 50) < tolerance))
                                {
                                    throw new Exception("PtFl Resource was read incorrect");
                                }
                                // Editing
                                resource.Offset = new Point(-11, 13);
                                resource.Scale = 200;
                                resource.AlignWithLayer = false;
                                resource.IsLinkedWithLayer = false;
                                fillLayer.Resources = fillLayer.Resources;
                                // We haven't pattern data in PattResource, so we can add it.
                                var fillSettings = (PatternFillSettings)fillLayer.FillSettings;
                                fillSettings.PatternData = new int[]
                                {
                           Color.Black.ToArgb(),
                           Color.White.ToArgb(),
                           Color.White.ToArgb(),
                           Color.White.ToArgb(),
                                };
                                fillSettings.PatternHeight = 1;
                                fillSettings.PatternWidth = 4;
                                fillSettings.PatternName = "$$$/Presets/Patterns/VerticalLine=Vertical Line New\0";
                                fillSettings.PatternId = Guid.NewGuid().ToString() + "\0";
                                fillLayer.Update();
                            }
                            break;
                        }
                        break;
                    }
                }
                im.Save(exportPath);
            }

            //ExEnd:SupportOfPtFlResource


        }

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfPtFlResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfRGBColorModeWith16BitPerChannel.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfRGBColorModeWith16BitPerChannel
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfRGBColor

            // Support of RGB Color mode with 16bits/channel (64 bits per color)
            string sourceFileName = dataDir + "inRgb16.psd";
            string outputFilePathJpg = dataDir + "outRgb16.jpg";
            string outputFilePathPsd = dataDir + "outRgb16.psd";

            PsdLoadOptions options = new PsdLoadOptions();
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName, options))
            {
                image.Save(outputFilePathPsd, new PsdOptions(image));
                image.Save(outputFilePathJpg, new JpegOptions()
                {
                    Quality = 100
                });
            }
            // Files must be opened without exception and must be readable for Photoshop    
            using (Image image = Image.Load(outputFilePathPsd))
            {
            }
            //ExEnd:SupportOfRGBColor
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfRGBColorModeWith16BitPerChannel.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfRotateLayer.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfRotateLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfRotateLayer
            var sourceFile = dataDir + "1.psd";
            var pngPath = dataDir + "RotateFlipTest2617.png";
            var psdPath = dataDir + "RotateFlipTest2617.psd";
            var flipType = RotateFlipType.Rotate270FlipXY;
            using (var im = (PsdImage)(Image.Load(sourceFile)))
            {
                im.RotateFlip(flipType);
                im.Save(pngPath, new PngOptions()
                {
                    ColorType = PngColorType.TruecolorWithAlpha
                });
                im.Save(psdPath);
            }

            //ExEnd:SupportOfRotateLayer
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfRotateLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfScaleProperty.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfScaleProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfScaleProperty

            using (var image = (PsdImage)Image.Load(dataDir + "FillLayerGradient.psd"))
            {
                // getting a fill layer
                FillLayer fillLayer = null;
                foreach (var layer in image.Layers)
                {
                    fillLayer = layer as FillLayer;
                    if (fillLayer != null)
                    {
                        break;
                    }
                }

                var settings = fillLayer.FillSettings as IGradientFillSettings;

                // update scale value
                settings.Scale = 200;
                fillLayer.Update(); // Updates pixels data

                image.Save(dataDir + "scaledImage.png", new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }


            //ExEnd:SupportOfScaleProperty

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfScaleProperty.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfSelectiveColorAdjustmentLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfSelectiveColorAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfSelectiveColorAdjustmentLayer
            //ExSummary:The following code demonstrates the support of SelectiveColorLayer adjustment layer.

            string sourceFileWithSelectiveColorLayer = Path.Combine(baseDir, "houses_selectiveColor_source.psd");
            string outputPsdWithSelectiveColorLayer = Path.Combine(outputDir, "houses_selectiveColor_output.psd");
            string outputPngWithSelectiveColorLayer = Path.Combine(outputDir, "houses_selectiveColor_output.png");

            string sourceFileWithoutSelectiveColorLayer = Path.Combine(baseDir, "houses_source.psd");
            string outputPsdWithoutSelectiveColorLayer = Path.Combine(outputDir, "houses_output.psd");
            string outputPngWithoutSelectiveColorLayer = Path.Combine(outputDir, "houses_output.png");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            // Get, check, and change the Selective Color adjustment layer from the image.
            using (var image = (PsdImage)Image.Load(sourceFileWithSelectiveColorLayer))
            {
                foreach (var layer in image.Layers)
                {
                    if (layer is SelectiveColorLayer)
                    {
                        // Get Selective Color adjustment layer.
                        SelectiveColorLayer selcLayer = (SelectiveColorLayer)layer;
                        var redCorrection = selcLayer.GetCmykCorrection(SelectiveColorsTypes.Reds);
                        var yellowCorrection = selcLayer.GetCmykCorrection(SelectiveColorsTypes.Yellows);
                        var greenCorrection = selcLayer.GetCmykCorrection(SelectiveColorsTypes.Greens);
                        var blueCorrection = selcLayer.GetCmykCorrection(SelectiveColorsTypes.Blues);

                        // Check layers parameters.
                        AssertAreEqual(CorrectionMethodTypes.Absolute, selcLayer.CorrectionMethod);

                        AssertAreEqual(redCorrection.Cyan, (short)-31);
                        AssertAreEqual(redCorrection.Magenta, (short)-12);
                        AssertAreEqual(redCorrection.Yellow, (short)27);
                        AssertAreEqual(redCorrection.Black, (short)33);

                        AssertAreEqual(yellowCorrection.Cyan, (short)-22);
                        AssertAreEqual(yellowCorrection.Magenta, (short)-19);
                        AssertAreEqual(yellowCorrection.Yellow, (short)8);
                        AssertAreEqual(yellowCorrection.Black, (short)0);

                        AssertAreEqual(greenCorrection.Cyan, (short)0);
                        AssertAreEqual(greenCorrection.Magenta, (short)0);
                        AssertAreEqual(greenCorrection.Yellow, (short)0);
                        AssertAreEqual(greenCorrection.Black, (short)0);

                        AssertAreEqual(blueCorrection.Cyan, (short)58);
                        AssertAreEqual(blueCorrection.Magenta, (short)18);
                        AssertAreEqual(blueCorrection.Yellow, (short)1);
                        AssertAreEqual(blueCorrection.Black, (short)7);

                        // Change layers parameters.
                        selcLayer.CorrectionMethod = CorrectionMethodTypes.Relative;
                        selcLayer.SetCmykCorrection(SelectiveColorsTypes.Reds,
                            new CmykCorrection { Cyan = 12, Magenta = -20, Yellow = 10, Black = -15 });
                        selcLayer.SetCmykCorrection(SelectiveColorsTypes.Whites,
                            new CmykCorrection { Cyan = 15, Magenta = 20, Yellow = -75, Black = 42 });

                        image.Save(outputPsdWithSelectiveColorLayer);
                        image.Save(outputPngWithSelectiveColorLayer, new PngOptions());
                    }
                }
            }

            // Add and set the Selective color adjustment layer to the image.
            using (var image = (PsdImage)Image.Load(sourceFileWithoutSelectiveColorLayer))
            {
                // Add Selective Color Adjustment layer.
                SelectiveColorLayer selectiveColorLayer = image.AddSelectiveColorAdjustmentLayer();

                // Set layers parameters.
                selectiveColorLayer.CorrectionMethod = CorrectionMethodTypes.Absolute;
                selectiveColorLayer.SetCmykCorrection(SelectiveColorsTypes.Whites,
                    new CmykCorrection { Cyan = 100, Magenta = -100, Yellow = 100, Black = 0 });
                selectiveColorLayer.SetCmykCorrection(SelectiveColorsTypes.Blacks,
                    new CmykCorrection { Cyan = 10, Magenta = 15, Yellow = 17, Black = -3 });
                selectiveColorLayer.SetCmykCorrection(SelectiveColorsTypes.Neutrals,
                    new CmykCorrection { Cyan = 45, Magenta = 21, Yellow = -14, Black = 0 });
                selectiveColorLayer.SetCmykCorrection(SelectiveColorsTypes.Magentas,
                    new CmykCorrection { Cyan = 8, Magenta = -10, Yellow = -14, Black = 25 });

                image.Save(outputPsdWithoutSelectiveColorLayer);
                image.Save(outputPngWithoutSelectiveColorLayer, new PngOptions());
            }
            
            //ExEnd:SupportOfSelectiveColorAdjustmentLayer

            File.Delete(outputPsdWithSelectiveColorLayer);
            File.Delete(outputPngWithSelectiveColorLayer);
            File.Delete(outputPsdWithoutSelectiveColorLayer);
            File.Delete(outputPngWithoutSelectiveColorLayer);

            Console.WriteLine("SupportOfSelectiveColorAdjustmentLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfSelectiveColorAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfSoCoResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfSoCoResource
    {
        public static void Run()
        {
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:SupportOfSoCoResource

            string sourceFileName = dataDir + "ColorFillLayer.psd";
            string exportPath = dataDir + "SoCoResource_Edited.psd";

            var im = (PsdImage)Image.Load(sourceFileName);

            using (im)
            {
                foreach (var layer in im.Layers)
                {
                    if (layer is FillLayer)
                    {
                        var fillLayer = (FillLayer)layer;
                        foreach (var resource in fillLayer.Resources)
                        {
                            if (resource is SoCoResource)
                            {
                                var socoResource = (SoCoResource)resource;

                                if (socoResource.Color != Color.FromArgb(63, 83, 141))
                                {
                                    throw new Exception("Color from SoCoResource was read wrong");
                                }

                                socoResource.Color = Color.Red;
                                break;
                            }
                        }
                        break;
                    }
                    im.Save(exportPath);
                }
            }

            //ExEnd:SupportOfSoCoResource
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfSoCoResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfThresholdAdjustmentLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfThresholdAdjustmentLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfThresholdAdjustmentLayer
            //ExSummary:The following code demonstrates the support of ThresholdLayer adjustment layer.

            string sourceFileWithThresholdLayer = Path.Combine(baseDir, "flowers_threshold_source.psd");
            string outputPsdWithThresholdLayer = Path.Combine(outputDir, "flowers_threshold_output.psd");
            string outputPngWithThresholdLayer = Path.Combine(outputDir, "flowers_threshold_output.png");

            string sourceFileWithoutThresholdLayer = Path.Combine(baseDir, "flowers_source.psd");
            string outputPsdWithoutThresholdLayer = Path.Combine(outputDir, "flowers_output.psd");
            string outputPngWithoutThresholdLayer = Path.Combine(outputDir, "flowers_output.png");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            // Get, check, and change the Threshold adjustment layer from the image.
            using (var image = (PsdImage)Image.Load(sourceFileWithThresholdLayer))
            {
                foreach (var layer in image.Layers)
                {
                    if (layer is ThresholdLayer)
                    {
                        // Get Threshold adjustment layer.
                        ThresholdLayer thrsLayer = (ThresholdLayer)layer;
                        var level = thrsLayer.Level;

                        // Check layers parameters.
                        AssertAreEqual(level, (short)115);

                        // Set layers parameters.
                        thrsLayer.Level = 50;

                        image.Save(outputPsdWithThresholdLayer);
                        image.Save(outputPngWithThresholdLayer, new PngOptions());
                    }
                }
            }

            // Add and set the Threshold adjustment layer to the image.
            using (var image = (PsdImage)Image.Load(sourceFileWithoutThresholdLayer))
            {
                // Add Threshold Adjustment layer.
                ThresholdLayer thresholdLayer = image.AddThresholdAdjustmentLayer();

                // Set layers parameters.
                thresholdLayer.Level = 115;

                image.Save(outputPsdWithoutThresholdLayer);
                image.Save(outputPngWithoutThresholdLayer, new PngOptions());
            }
            
            //ExEnd:SupportOfThresholdAdjustmentLayer

            File.Delete(outputPsdWithThresholdLayer);
            File.Delete(outputPngWithThresholdLayer);
            File.Delete(outputPsdWithoutThresholdLayer);
            File.Delete(outputPngWithoutThresholdLayer);

            Console.WriteLine("SupportOfThresholdAdjustmentLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfThresholdAdjustmentLayer.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfUpdatingLinkedSmartObjects.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfUpdatingLinkedSmartObjects
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfUpdatingLinkedSmartObjects
            //ExSummary:The following code demonstrates the support of updating Linked Smart objects.

            void AssertAreEqual(object actual, object expected)
            {
                var areEqual = object.Equals(actual, expected);
                if (!areEqual && actual is Array && expected is Array)
                {
                    var actualArray = (Array)actual;
                    var expectedArray = (Array)actual;
                    if (actualArray.Length == expectedArray.Length)
                    {
                        for (int i = 0; i < actualArray.Length; i++)
                        {
                            if (!object.Equals(actualArray.GetValue(i), expectedArray.GetValue(i)))
                            {
                                break;
                            }
                        }

                        areEqual = true;
                    }
                }

                if (!areEqual)
                {
                    throw new FormatException(
                        string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            // This example demonstrates how to update the external or embedded smart object layer using these methods:
            // RelinkToFile, UpdateModifiedContent, ExportContents
            ExampleOfUpdatingSmartObjectLayer("rgb8_2x2_linked2.psd", 0x53, 0, 0, 2, 2, FileFormat.Png);
            ExampleOfUpdatingSmartObjectLayer("r-embedded-png.psd", 0x207, 0, 0, 0xb, 0x10, FileFormat.Png);

            void ExampleOfUpdatingSmartObjectLayer(
                string filePath,
                int contentsLength,
                int left,
                int top,
                int right,
                int bottom,
                FileFormat format)
            {
                // This example demonstrates how to change the smart object layer in the PSD file and export / update its contents.
                string fileName = Path.GetFileNameWithoutExtension(filePath);
                string dataDir = output + "updating_output" + Path.DirectorySeparatorChar;
                filePath = baseFolder + filePath;
                string pngOutputPath = dataDir + fileName + "_modified.png";
                string png2OutputPath = dataDir + fileName + "_updated_modified.png";
                string psd2OutputPath = dataDir + fileName + "_updated_modified.psd";
                string exportPath = dataDir + fileName + "_exported." + GetFormatExt(format);
                using (PsdImage image = (PsdImage)Image.Load(filePath))
                {
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[0];
                    var contentType = smartObjectLayer.ContentType;
                    AssertAreEqual(contentsLength, smartObjectLayer.Contents.Length);
                    AssertAreEqual(left, smartObjectLayer.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer.ContentsBounds.Bottom);

                    if (contentType == SmartObjectType.AvailableLinked)
                    {
                        Directory.CreateDirectory(Path.GetDirectoryName(exportPath));
                        // Let's export the external smart object image from the PSD smart object layer to a new location
                        // because we are going to modify it.
                        smartObjectLayer.ExportContents(exportPath);
                        smartObjectLayer.RelinkToFile(exportPath);
                    }

                    // Let's invert the content of the smart object: inner (not cached) image
                    using (var innerImage = (RasterImage)smartObjectLayer.LoadContents(new LoadOptions()))
                    {
                        InvertImage(innerImage);
                        using (var stream = new MemoryStream())
                        {
                            innerImage.Save(stream);
                            smartObjectLayer.Contents = stream.ToArray();
                        }
                    }

                    // Let's check whether the modified content does not affect rendering yet.
                    image.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });

                    smartObjectLayer.UpdateModifiedContent();

                    // Let's check whether the updated content affects rendering and the psd image is saved correctly
                    image.Save(psd2OutputPath, new PsdOptions(image));
                    image.Save(png2OutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            // This example demonstrates how to convert the embedded smart object to external linked contents using the ConvertToLinked method.
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("new_panama-papers-4.psd", 0x10caa, 0, 0, 0x280, 0x169, FileFormat.Jpeg);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r3-embedded.psd", 0x207, 0, 0, 0xb, 0x10, FileFormat.Png);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-tiff.psd", 0xca94, 0, 0, 0xb, 0x10, FileFormat.Tiff);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-bmp.psd", 0x278, 0, 0, 0xb, 0x10, FileFormat.Bmp);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-gif.psd", 0x3ec, 0, 0, 0xb, 0x10, FileFormat.Gif);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-jpeg.psd", 0x327, 0, 0, 0xb, 0x10, FileFormat.Jpeg);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-jpeg2000.psd", 0x519f, 0, 0, 0xb, 0x10, FileFormat.Jpeg2000);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-psd.psd", 0xc074, 0, 0, 0xb, 0x10, FileFormat.Psd);
            ExampleOfEmbeddedSmartObjectLayerToLinkedConversion("r-embedded-png.psd", 0x207, 0, 0, 0xb, 0x10, FileFormat.Png);

            void ExampleOfEmbeddedSmartObjectLayerToLinkedConversion(
                string filePath,
                int contentsLength,
                int left,
                int top,
                int right,
                int bottom,
                FileFormat format)
            {
                // This demonstrates how to convert an embedded smart object layer in the PSD file to external one.
                var formatExt = GetFormatExt(format);
                string fileName = Path.GetFileNameWithoutExtension(filePath);
                string dataDir = output + "to_linked_output" + Path.DirectorySeparatorChar;
                filePath = baseFolder + filePath;
                string pngOutputPath = dataDir + fileName + "_to_external.png";
                string psdOutputPath = dataDir + fileName + "_to_external.psd";
                string externalPath = dataDir + fileName + "_external." + formatExt;
                using (PsdImage image = (PsdImage)Image.Load(filePath))
                {
                    Directory.CreateDirectory(Path.GetDirectoryName(externalPath));
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[0];
                    smartObjectLayer.ConvertToLinked(externalPath);

                    AssertAreEqual(contentsLength, smartObjectLayer.Contents.Length);
                    AssertAreEqual(left, smartObjectLayer.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer.ContentsBounds.Bottom);
                    AssertAreEqual(SmartObjectType.AvailableLinked, smartObjectLayer.ContentType);

                    // Let's check if the converted image is saved correctly
                    image.Save(psdOutputPath, new PsdOptions(image));
                    image.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }

                using (PsdImage image = (PsdImage)Image.Load(psdOutputPath))
                {
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[0];
                    AssertAreEqual(contentsLength, smartObjectLayer.Contents.Length);
                    AssertAreEqual(left, smartObjectLayer.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer.ContentsBounds.Bottom);
                    AssertAreEqual(SmartObjectType.AvailableLinked, smartObjectLayer.ContentType);
                }
            }

            // This example demonstrates how to embed one external smart object layer or all linked layers in the PSD file using the EmbedLinked method.
            ExampleOfLinkedSmartObjectLayerToEmbeddedConversion("rgb8_2x2_linked.psd", 0x53, 0, 0, 2, 2, FileFormat.Png);
            ExampleOfLinkedSmartObjectLayerToEmbeddedConversion("rgb8_2x2_linked2.psd", 0x53, 0, 0, 2, 2, FileFormat.Png);
            void ExampleOfLinkedSmartObjectLayerToEmbeddedConversion(
                string filePath,
                int contentsLength,
                int left,
                int top,
                int right,
                int bottom,
                FileFormat format)
            {
                string fileName = Path.GetFileNameWithoutExtension(filePath);
                string dataDir = output + "to_embedded_output" + Path.DirectorySeparatorChar;
                filePath = baseFolder + filePath;
                string pngOutputPath = dataDir + fileName + "_to_embedded.png";
                string psdOutputPath = dataDir + fileName + "_to_embedded.psd";
                using (PsdImage image = (PsdImage)Image.Load(filePath))
                {
                    var smartObjectLayer0 = (SmartObjectLayer)image.Layers[0];
                    smartObjectLayer0.EmbedLinked();
                    AssertAreEqual(contentsLength, smartObjectLayer0.Contents.Length);
                    AssertAreEqual(left, smartObjectLayer0.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer0.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer0.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer0.ContentsBounds.Bottom);
                    if (image.Layers.Length >= 2)
                    {
                        var smartObjectLayer1 = (SmartObjectLayer)image.Layers[1];
                        AssertAreEqual(SmartObjectType.Embedded, smartObjectLayer0.ContentType);
                        AssertAreEqual(SmartObjectType.AvailableLinked, smartObjectLayer1.ContentType);

                        image.SmartObjectProvider.EmbedAllLinked();
                        foreach (Layer layer in image.Layers)
                        {
                            var smartLayer = layer as SmartObjectLayer;
                            if (smartLayer != null)
                            {
                                AssertAreEqual(SmartObjectType.Embedded, smartLayer.ContentType);
                            }
                        }
                    }

                    Directory.CreateDirectory(Path.GetDirectoryName(psdOutputPath));
                    // Let's check if the converted image is saved correctly
                    image.Save(psdOutputPath, new PsdOptions(image));
                    image.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }

                using (PsdImage image = (PsdImage)Image.Load(psdOutputPath))
                {
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[0];
                    AssertAreEqual(contentsLength, smartObjectLayer.Contents.Length);
                    AssertAreEqual(left, smartObjectLayer.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer.ContentsBounds.Bottom);
                    AssertAreEqual(SmartObjectType.Embedded, smartObjectLayer.ContentType);
                }
            }

            // This example demonstrates how to change the Adobe® Photoshop® external smart object layer and export / update its contents
            // using the ExportContents and ReplaceContents methods.
            ExampleOfExternalSmartObjectLayerSupport("rgb8_2x2_linked.psd", 0x53, 0, 0, 2, 2, FileFormat.Png);
            ExampleOfExternalSmartObjectLayerSupport("rgb8_2x2_linked2.psd", 0x4aea, 0, 0, 10, 10, FileFormat.Psd);
            void ExampleOfExternalSmartObjectLayerSupport(string filePath, int contentsLength, int left, int top, int right, int bottom, FileFormat format)
            {
                string formatExt = GetFormatExt(format);
                string fileName = Path.GetFileNameWithoutExtension(filePath);
                string dataDir = output + "external_support_output" + Path.DirectorySeparatorChar;
                filePath = baseFolder + filePath;
                string pngOutputPath = dataDir + fileName + ".png";
                string psdOutputPath = dataDir + fileName + ".psd";
                string linkOutputPath = dataDir + fileName + "_inverted." + formatExt;
                string png2OutputPath = dataDir + fileName + "_updated.png";
                string psd2OutputPath = dataDir + fileName + "_updated.psd";
                string exportPath = dataDir + fileName + "_export." + formatExt;
                using (PsdImage image = (PsdImage)Image.Load(filePath))
                {
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[image.Layers.Length - 1];
                    AssertAreEqual(left, smartObjectLayer.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer.ContentsBounds.Bottom);
                    AssertAreEqual(contentsLength, smartObjectLayer.Contents.Length);
                    AssertAreEqual(SmartObjectType.AvailableLinked, smartObjectLayer.ContentType);

                    Directory.CreateDirectory(Path.GetDirectoryName(exportPath));
                    // Let's export the linked smart object image from the PSD smart object layer
                    smartObjectLayer.ExportContents(exportPath);

                    // Let's check if the original image isz saved correctly
                    image.Save(psdOutputPath, new PsdOptions(image));
                    image.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });

                    using (var innerImage = (RasterImage)smartObjectLayer.LoadContents(null))
                    {
                        AssertAreEqual(format, innerImage.FileFormat);

                        // Let's invert the linked smart object image
                        InvertImage(innerImage);
                        innerImage.Save(linkOutputPath);

                        // Let's replace the linked smart object image in the PSD layer
                        smartObjectLayer.ReplaceContents(linkOutputPath);
                    }

                    // Let's check if the updated image is saved correctly
                    image.Save(psd2OutputPath, new PsdOptions(image));
                    image.Save(png2OutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            // Inverts the image.
            void InvertImage(RasterImage innerImage)
            {
                var innerPsdImage = innerImage as PsdImage;
                if (innerPsdImage != null)
                {
                    InvertRasterImage(innerPsdImage.Layers[0]);
                }
                else
                {
                    InvertRasterImage(innerImage);
                }
            }

            // Inverts the raster image.
            void InvertRasterImage(RasterImage innerImage)
            {
                var pixels = innerImage.LoadArgb32Pixels(innerImage.Bounds);
                for (int i = 0; i < pixels.Length; i++)
                {
                    var pixel = pixels[i];
                    var alpha = (int)(pixel & 0xff000000);
                    pixels[i] = (~(pixel & 0x00ffffff)) | alpha;
                }

                innerImage.SaveArgb32Pixels(innerImage.Bounds, pixels);
            }

            // Gets the format extension.
            string GetFormatExt(FileFormat format)
            {
                string formatExt = format == FileFormat.Jpeg2000 ? "jpf" : format.ToString().ToLowerInvariant();
                return formatExt;
            }

            //ExEnd:SupportOfUpdatingLinkedSmartObjects

            Console.WriteLine("SupportOfUpdatingLinkedSmartObjects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfUpdatingLinkedSmartObjects.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfVmskResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using Aspose.PSD.FileFormats.Core.VectorPaths;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfVmskResource
    {
        // VmskResource Support
        //ExStart:SupportOfVmskResource
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            string sourceFileName = dataDir + "Rectangle.psd";
            string exportPath = dataDir + "Rectangle_changed.psd";
            var im = (PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                var resource = GetVmskResource(im);
                // Reading
                if (resource.IsDisabled != false ||
                 resource.IsInverted != false ||
                 resource.IsNotLinked != false ||
                 resource.Paths.Length != 7 ||
                 resource.Paths[0].Type != VectorPathType.PathFillRuleRecord ||
                 resource.Paths[1].Type != VectorPathType.InitialFillRuleRecord ||
                 resource.Paths[2].Type != VectorPathType.ClosedSubpathLengthRecord ||
                 resource.Paths[3].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked ||
                 resource.Paths[4].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked ||
                 resource.Paths[5].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked ||
                 resource.Paths[6].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked)
                {
                    throw new Exception("VmskResource was read wrong");
                }
                var pathFillRule = (PathFillRuleRecord)resource.Paths[0];
                var initialFillRule = (InitialFillRuleRecord)resource.Paths[1];
                var subpathLength = (LengthRecord)resource.Paths[2];
                // Path fill rule doesn't contain any additional information
                if (pathFillRule.Type != VectorPathType.PathFillRuleRecord ||
                 initialFillRule.Type != VectorPathType.InitialFillRuleRecord ||
                 initialFillRule.IsFillStartsWithAllPixels != false ||
                 subpathLength.Type != VectorPathType.ClosedSubpathLengthRecord ||
                 subpathLength.IsClosed != true ||
                 subpathLength.IsOpen != false)
                {
                    throw new Exception("VmskResource paths were read wrong");
                }
                // Editing
                resource.IsDisabled = true;
                resource.IsInverted = true;
                resource.IsNotLinked = true;
                var bezierKnot = (BezierKnotRecord)resource.Paths[3];
                bezierKnot.Points[0] = new Point(0, 0);
                bezierKnot = (BezierKnotRecord)resource.Paths[4];
                bezierKnot.Points[0] = new Point(8039797, 10905190);
                initialFillRule.IsFillStartsWithAllPixels = true;
                subpathLength.IsClosed = false;
                im.Save(exportPath);
            }

            //ExEnd:SupportOfVmskResource
        }
        static VmskResource GetVmskResource(PsdImage image)
        {
            var layer = image.Layers[1];
            VmskResource resource = null;
            var resources = layer.Resources;
            for (int i = 0; i < resources.Length; i++)
            {
                if (resources[i] is VmskResource)
                {
                    resource = (VmskResource)resources[i];
                    break;
                }
            }
            if (resource == null)
            {
                throw new Exception("VmskResource not found");
            }
            return resource;
        }
        //ExEnd:SupportOfVmskResource

    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfVmskResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfVscgResource.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.StrokeResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportOfVscgResource
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfVscgResource
            //ExSummary:The following code demonstrates the support of VscgResource.

            string sourceFile = Path.Combine(baseDir, "StrokeInternalFill_src.psd");
            string outputFile = Path.Combine(outputDir, "StrokeInternalFill_res.psd");

            void AreEqual(double expected, double current, double tolerance = 0.1)
            {
                if (Math.Abs(expected - current) > tolerance)
                {
                    throw new Exception(
                        $"Values is not equal.\nExpected:{expected}\nResult:{current}\nDifference:{expected - current}");
                }
            }

            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                VscgResource vscgResource = (VscgResource)image.Layers[1].Resources[0];
                DescriptorStructure rgbColorStructure = (DescriptorStructure)vscgResource.Items[0];

                AreEqual(89.8, ((DoubleStructure)rgbColorStructure.Structures[0]).Value);
                AreEqual(219.6, ((DoubleStructure)rgbColorStructure.Structures[1]).Value);
                AreEqual(34.2, ((DoubleStructure)rgbColorStructure.Structures[2]).Value);

                ((DoubleStructure)rgbColorStructure.Structures[0]).Value = 255d; // Red
                ((DoubleStructure)rgbColorStructure.Structures[1]).Value = 0d; // Green
                ((DoubleStructure)rgbColorStructure.Structures[2]).Value = 0d; // Blue

                image.Save(outputFile);
            }

            // checking changes
            using (PsdImage image = (PsdImage)Image.Load(outputFile))
            {
                VscgResource vscgResource = (VscgResource)image.Layers[1].Resources[0];
                DescriptorStructure rgbColorStructure = (DescriptorStructure)vscgResource.Items[0];

                AreEqual(255, ((DoubleStructure)rgbColorStructure.Structures[0]).Value);
                AreEqual(0, ((DoubleStructure)rgbColorStructure.Structures[1]).Value);
                AreEqual(0, ((DoubleStructure)rgbColorStructure.Structures[2]).Value);
            }

            //ExEnd:SupportOfVscgResource

            File.Delete(outputFile);

            Console.WriteLine("SupportOfVscgResource executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfVscgResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfVsmsResource.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using System;
using Aspose.PSD.FileFormats.Core.VectorPaths;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class SupportOfVsmsResource
    {
        //ExStart:SupportOfVsmsResource
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            string sourceFileName = dataDir + "EmptyRectangle.psd";
            string exportPath = dataDir + "EmptyRectangle_changed.psd";
            var im = (PsdImage)Image.Load(sourceFileName);
            using (im)
            {
                var resource = GetVsmsResource(im);
                // Reading
                if (resource.IsDisabled != false ||
                    resource.IsInverted != false ||
                    resource.IsNotLinked != false ||
                    resource.Paths.Length != 7 ||
                    resource.Paths[0].Type != VectorPathType.PathFillRuleRecord ||
                    resource.Paths[1].Type != VectorPathType.InitialFillRuleRecord ||
                    resource.Paths[2].Type != VectorPathType.ClosedSubpathLengthRecord ||
                    resource.Paths[3].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked ||
                    resource.Paths[4].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked ||
                    resource.Paths[5].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked ||
                    resource.Paths[6].Type != VectorPathType.ClosedSubpathBezierKnotUnlinked)
                {
                    throw new Exception("VsmsResource was read wrong");
                }
                var pathFillRule = (PathFillRuleRecord)resource.Paths[0];
                var initialFillRule = (InitialFillRuleRecord)resource.Paths[1];
                var subpathLength = (LengthRecord)resource.Paths[2];

                // Path fill rule doesn't contain any additional information
                if (pathFillRule.Type != VectorPathType.PathFillRuleRecord ||
                initialFillRule.Type != VectorPathType.InitialFillRuleRecord ||
                initialFillRule.IsFillStartsWithAllPixels != false ||
                subpathLength.Type != VectorPathType.ClosedSubpathLengthRecord ||
                subpathLength.IsClosed != true ||
                subpathLength.IsOpen != false)
                {
                    throw new Exception("VsmsResource paths were read wrong");
                }

                // Editing
                resource.IsDisabled = true;
                resource.IsInverted = true;
                resource.IsNotLinked = true;
                var bezierKnot = (BezierKnotRecord)resource.Paths[3];
                bezierKnot.Points[0] = new Point(0, 0);
                bezierKnot = (BezierKnotRecord)resource.Paths[4];
                bezierKnot.Points[0] = new Point(8039798, 10905191);
                initialFillRule.IsFillStartsWithAllPixels = true;
                subpathLength.IsClosed = false;
                im.Save(exportPath);
            }
        }

        static VsmsResource GetVsmsResource(PsdImage image)
        {
            var layer = image.Layers[1];
            VsmsResource resource = null;
            var resources = layer.Resources;
            for (int i = 0; i < resources.Length; i++)
            {
                if (resources[i] is VsmsResource)
                {
                    resource = (VsmsResource)resources[i];
                    break;
                }
            }
            if (resource == null)
            {
                throw new Exception("VsmsResource not found");
            }
            return resource;
        }

        //ExEnd:GetVsmsResource
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportOfVsmsResource.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportTextOrientationPropertyEdit.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportTextOrientationPropertyEdit
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportTextOrientationPropertyEdit
            //ExSummary:The following code demonstrates the ability to edit the new TextOrientation property. This does not affect rendering at the moment, but only allows you to edit the property value.

            string src = Path.Combine(baseDir, "1336test.psd");
            string output = Path.Combine(outputDir, "out_1336test.psd");

            using (var image = (PsdImage)Image.Load(src))
            {
                var textLayer = image.Layers[1] as TextLayer;
                if (textLayer.TextData.TextOrientation == TextOrientation.Vertical)
                {
                    // Correct reading
                }
                else
                {
                    throw new Exception("Incorrect reading of TextOrientation property value");
                }
            
                textLayer.TextData.TextOrientation = TextOrientation.Horizontal;
                textLayer.TextData.UpdateLayerData();
            
                image.Save(output);
            }
            
            using (var image = (PsdImage)Image.Load(output))
            {
                var textLayer = image.Layers[1] as TextLayer;
                if (textLayer.TextData.TextOrientation == TextOrientation.Horizontal)
                {
                    // Correct reading
                }
                else
                {
                    throw new Exception("Incorrect reading of TextOrientation property value");
                }
            }

            //ExEnd:SupportTextOrientationPropertyEdit

            File.Delete(output);

            Console.WriteLine("SupportTextOrientationPropertyEdit executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportTextOrientationPropertyEdit.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportTextStyleJustificationMode.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class SupportTextStyleJustificationMode
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();
            
            //ExStart:SupportTextStyleJustificationMode
            //ExSummary:The following code demonstrates support of JustificationMode enum to set the text alignment for text portions.

            string src = Path.Combine(baseDir, "source1107.psd");
            string outputPsd = Path.Combine(outputDir, "output.psd");
            string outputPng = Path.Combine(outputDir, "output.png");

            using (var image = (PsdImage) Image.Load(src))
            {
                var txtLayer = image.AddTextLayer("Text line1\rText line2\rText line3",
                    new Rectangle(200, 200, 500, 500));
                var portions = txtLayer.TextData.Items;

                portions[0].Paragraph.Justification = JustificationMode.Left;
                portions[1].Paragraph.Justification = JustificationMode.Right;
                portions[2].Paragraph.Justification = JustificationMode.Center;

                foreach (var portion in portions)
                {
                    portion.Style.FontSize = 24;
                }

                txtLayer.TextData.UpdateLayerData();

                image.Save(outputPsd);
                image.Save(outputPng, new PngOptions());
            }

            //ExEnd:SupportTextStyleJustificationMode

            File.Delete(outputPsd);
            File.Delete(outputPng);
            
            Console.WriteLine("SupportTextStyleJustificationMode executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/SupportTextStyleJustificationMode.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/TextLayerBoundBox.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class TextLayerBoundBox
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:TextLayerBoundBox

            string sourceFileName = dataDir + "LayerWithText.psd";

            var correctOpticalSize = new Size(127, 45);
            var correctBoundBox = new Size(172, 62);

            using (var im = (PsdImage)(Image.Load(sourceFileName)))
            {
                var textLayer = (TextLayer)im.Layers[1];

                // Size of the layer is the size of the rendered area
                var opticalSize = textLayer.Size;

                // TextBoundBox is the maximum layer size for Text Layer. 
                // In this area PS will try to fit your text
                var boundBox = textLayer.TextBoundBox;

                if (opticalSize != correctOpticalSize ||
                    boundBox.Size != correctBoundBox)
                {
                    throw new Exception("Assertion failed");
                }
            }

            //ExEnd:TextLayerBoundBox
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/TextLayerBoundBox.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UncompressedImageStreamObject.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class UncompressedImageStreamObject
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:UncompressedImageStreamObject
            using (MemoryStream stream = new MemoryStream())
            {
                // Load a PSD file as an image and cast it into PsdImage
                using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
                {
                    PsdOptions saveOptions = new PsdOptions();
                    saveOptions.CompressionMethod = CompressionMethod.Raw;
                    psdImage.Save(stream, saveOptions);

                }

                // Now reopen the newly created image. But first seek to the beginning of stream since after saving seek is at the end now.
                stream.Seek(0, System.IO.SeekOrigin.Begin);
                using (PsdImage psdImage = (PsdImage)Image.Load(stream))
                {
                    Graphics graphics = new Graphics(psdImage);
                    // Perform graphics operations.
                }
            }
            //ExEnd:UncompressedImageStreamObject
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UncompressedImageStreamObject.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UncompressedImageUsingFile.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class UncompressedImageUsingFile
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:UncompressedImageUsingFile

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                PsdOptions saveOptions = new PsdOptions();
                saveOptions.CompressionMethod = CompressionMethod.Raw;
                psdImage.Save(dataDir + "uncompressed_out.psd", saveOptions);
            }

            // Now reopen the newly created image.
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "uncompressed_out.psd"))
            {
                Graphics graphics = new Graphics(psdImage);
                // Perform graphics operations.
            }

            //ExEnd:UncompressedImageUsingFile
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UncompressedImageUsingFile.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UpdateTextLayerInPSDFile.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class UpdateTextLayerInPSDFile
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:UpdateTextLayerInPSDFile

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                foreach (var layer in psdImage.Layers)
                {
                    if (layer is TextLayer)
                    {
                        TextLayer textLayer = layer as TextLayer;
                        textLayer.UpdateText("test update", new Point(0, 0), 15.0f, Color.Purple);
                    }
                }

                psdImage.Save(dataDir + "UpdateTextLayerInPSDFile_out.psd");
            }

            //ExEnd:UpdateTextLayerInPSDFile

        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UpdateTextLayerInPSDFile.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UsingAdjustmentLayers.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.AdjustmentLayers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class UsingAdjustmentLayers
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:UsingAdjustmentLayers

            string sourcePsd = Path.Combine(baseDir, "AllAdjustments.psd");
            string outputOrigPng = Path.Combine(outputDir, "AllAdjustments_orig.png");
            string outputModPng = Path.Combine(outputDir, "AllAdjustments_mod.png");
            PngOptions pngOpt = new PngOptions();
            pngOpt.ColorType = PngColorType.TruecolorWithAlpha;

            using (PsdImage psdImage = (PsdImage)Image.Load(sourcePsd))
            {
                psdImage.Save(outputOrigPng, pngOpt);
                var layers = psdImage.Layers;

                foreach (var layer in layers)
                {
                    if (layer is BrightnessContrastLayer br)
                    {
                        br.Brightness = -br.Brightness;
                        br.Contrast = -br.Contrast;
                    }

                    if (layer is LevelsLayer levels)
                    {
                        levels.MasterChannel.OutputShadowLevel = 30;
                        levels.MasterChannel.InputShadowLevel = 5;
                        levels.MasterChannel.InputMidtoneLevel = 2;
                        levels.MasterChannel.OutputHighlightLevel = 213;
                        levels.MasterChannel.InputHighlightLevel = 120;
                    }

                    if (layer is CurvesLayer curves)
                    {
                        var manager = curves.GetCurvesManager();
                        var curveManager = (CurvesContinuousManager)manager;
                        curveManager.AddCurvePoint(2, 150, 180);
                    }

                    if (layer is ExposureLayer exp)
                    {
                        exp.Exposure += 0.1f;
                    }

                    if (layer is HueSaturationLayer hue)
                    {
                        hue.Hue = -15;
                        hue.Saturation = 30;
                    }

                    if (layer is ColorBalanceAdjustmentLayer colorBal)
                    {
                        colorBal.MidtonesCyanRedBalance = 30;
                    }

                    if (layer is BlackWhiteAdjustmentLayer bw)
                    {
                        bw.Reds = 30;
                        bw.Greens = 25;
                        bw.Blues = 40;
                    }

                    if (layer is PhotoFilterLayer photoFilter)
                    {
                        photoFilter.Color = Color.Azure;
                    }

                    if (layer is ChannelMixerLayer channelMixer)
                    {
                        var channel = channelMixer.GetChannelByIndex(0);
                        if (channel is RgbMixerChannel rgbChannel)
                        {
                            rgbChannel.Green = 120;
                            rgbChannel.Red = 50;
                            rgbChannel.Blue = 70;
                            rgbChannel.Constant += 10;
                        }
                    }

                    if (layer is InvertAdjustmentLayer)
                    {
                        // No actions needed for InvertAdjustmentLayer
                    }

                    if (layer is PosterizeLayer post)
                    {
                        post.Levels = 3;
                    }

                    if (layer is ThresholdLayer threshold)
                    {
                        threshold.Level = 15;
                    }

                    if (layer is SelectiveColorLayer selectiveColor)
                    {
                        var correction = new CmykCorrection
                        {
                            Cyan = 25,
                            Magenta = 10,
                            Yellow = -15,
                            Black = 5
                        };
                        selectiveColor.SetCmykCorrection(SelectiveColorsTypes.Cyans, correction);
                    }
                }

                psdImage.Save(outputModPng, pngOpt);
            }

            //ExEnd:UsingAdjustmentLayers

            File.Delete(outputOrigPng);
            File.Delete(outputModPng);

            Console.WriteLine("UsingAdjustmentLayers executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UsingAdjustmentLayers.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UsingDocumentConversionProgressHandler.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.ProgressManagement;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    class UsingDocumentConversionProgressHandler
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:UpdateTextLayerInPSDFile

            //The following example demonstrates how you can obtain the document conversion progress 
            string sourceFilePath = Path.Combine(dataDir, "Apple.psd");
            Stream outputStream = new MemoryStream();

            ProgressEventHandler localProgressEventHandler = delegate (ProgressEventHandlerInfo progressInfo)
            {
                string message = string.Format(
                    "{0} {1}: {2} out of {3}",
                    progressInfo.Description,
                    progressInfo.EventType,
                    progressInfo.Value,
                    progressInfo.MaxValue);
                Console.WriteLine(message);
            };

            Console.WriteLine("---------- Loading Apple.psd ----------");
            var loadOptions = new PsdLoadOptions() { ProgressEventHandler = localProgressEventHandler };
            using (PsdImage image = (PsdImage)Image.Load(sourceFilePath, loadOptions))
            {
                Console.WriteLine("---------- Saving Apple.psd to PNG format ----------");
                image.Save(
                    outputStream,
                    new PngOptions()
                    {
                        ColorType = PngColorType.Truecolor,
                        ProgressEventHandler = localProgressEventHandler
                    });

                Console.WriteLine("---------- Saving Apple.psd to PSD format ----------");
                image.Save(
                    outputStream,
                    new PsdOptions()
                    {
                        ColorMode = ColorModes.Rgb,
                        ChannelsCount = 4,
                        ProgressEventHandler = localProgressEventHandler
                    });
            }

            //ExEnd:UpdateTextLayerInPSDFile

            Console.WriteLine("UsingDocumentConversionProgressHandler example executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/UsingDocumentConversionProgressHandler.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/WorkingWithMasks.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD
{
    public class WorkingWithMasks
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:WorkingWithMasks
            string source = Path.Combine(baseDir, "example.psd");
            string outputUpdated = Path.Combine(outputDir, "updated_mask_features.psd");

            using (PsdImage image = (PsdImage)Image.Load(source))
            {
                // The most simple is the using of Clipping masks
                // Some Layer and Adjustment Layer Become Clipping Masks
                image.Layers[2].Clipping = 1;
                image.Layers[3].Clipping = 1;

                // Example how to add Mask to Layer
                LayerMaskDataShort mask = new LayerMaskDataShort
                {
                    Left = 50,
                    Top = 213,
                    Right = 50 + 150,
                    Bottom = 213 + 150
                };
                byte[] maskData = new byte[(mask.Right - mask.Left) * (mask.Bottom - mask.Top)];
                for (int index = 0; index < maskData.Length; index++)
                {
                    maskData[index] = (byte)(100 + index % 100);
                }

                mask.ImageData = maskData;
                image.Layers[1].AddLayerMask(mask);

                image.Save(outputUpdated);
            }
            //ExEnd:WorkingWithMasks
            
            File.Delete(outputUpdated);

            Console.WriteLine("WorkingWithMasks executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/PSD/WorkingWithMasks.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/CompressingTiff.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.TIFF
{
    class CompressingTiff
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:CompressingTiff

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Create an instance of TiffOptions for the resultant image
                TiffOptions outputSettings = new TiffOptions(TiffExpectedFormat.Default);

                // Set BitsPerSample, Compression, Photometric mode and graycale palette
                outputSettings.BitsPerSample = new ushort[] { 4 };
                outputSettings.Compression = TiffCompressions.Lzw;
                outputSettings.Photometric = TiffPhotometrics.Palette;
                outputSettings.Palette = ColorPaletteHelper.Create4BitGrayscale(true);

                psdImage.Save(dataDir + "SampleTiff_out.tiff", outputSettings);
            }


            //ExEnd:CompressingTiff
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/CompressingTiff.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/ExportToMultiPageTiff.cs ---
﻿using Aspose.PSD.FileFormats.Psd;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.TIFF
{
    class ExportToMultiPageTiff
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:ExportToMultiPageTiff

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {

                // Initialize tiff frame list.
                //List<TiffFrame> frames = new List<TiffFrame>();

                // Iterate over each layer of PsdImage and convert it to Tiff frame.
                //foreach (var layer in psdImage.Layers)
                //{
                //    TiffFrame frame = new TiffFrame(layer, new TiffOptions(FileFormats.Tiff.Enums.TiffExpectedFormat.TiffLzwCmyk));
                //    frames.Add(frame);
                //}

                // Create a new TiffImage with frames created earlier and save to disk.
                //TiffImage tiffImage = new TiffImage(frames.ToArray());
                //tiffImage.Save(dataDir + "ExportToMultiPageTiff_output.tif");
            }
            //ExEnd:ExportToMultiPageTiff
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/ExportToMultiPageTiff.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/TIFFwithAdobeDeflateCompression.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.TIFF
{
    class TIFFwithAdobeDeflateCompression
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:TIFFwithAdobeDeflateCompression

            // Create an instance of TiffOptions and set its various properties
            TiffOptions options = new TiffOptions(TiffExpectedFormat.Default);
            options.BitsPerSample = new ushort[] { 8, 8, 8 };
            options.Photometric = TiffPhotometrics.Rgb;
            options.Xresolution = new TiffRational(72);
            options.Yresolution = new TiffRational(72);
            options.ResolutionUnit = TiffResolutionUnits.Inch;
            options.PlanarConfiguration = TiffPlanarConfigs.Contiguous;

            // Set the Compression to AdobeDeflate
            options.Compression = TiffCompressions.AdobeDeflate;

            //Create a new image with specific size and TiffOptions settings
            using (PsdImage image = new PsdImage(100, 100))
            {

                // Fill image data.
                int count = image.Width * image.Height;
                int[] pixels = new int[count];

                for (int i = 0; i < count; i++)
                {

                    pixels[i] = Color.Red.ToArgb();
                }

                // Save the newly created pixels.
                image.SaveArgb32Pixels(image.Bounds, pixels);

                // Save resultant image
                image.Save(dataDir + "TIFFwithAdobeDeflateCompression_output.tif", options);
            }


            //ExEnd:TIFFwithAdobeDeflateCompression
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/TIFFwithAdobeDeflateCompression.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/TIFFwithDeflateCompression.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.TIFF
{
    class TIFFwithDeflateCompression
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:TIFFwithDeflateCompression

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Create an instance of TiffOptions while specifying desired format and compression
                TiffOptions options = new TiffOptions(TiffExpectedFormat.TiffDeflateRgb);
                options.Compression = TiffCompressions.AdobeDeflate;
                psdImage.Save(dataDir + "TIFFwithDeflateCompression_out.tiff", options);
            }

            //ExEnd:TIFFwithDeflateCompression
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/TIFFwithDeflateCompression.cs ---

--- START OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/TiffOptionsConfiguration.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Tiff.Enums;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.TIFF
{
    class TiffOptionsConfiguration
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_PSD();

            //ExStart:TiffOptionsConfiguration

            // Load a PSD file as an image and cast it into PsdImage
            using (PsdImage psdImage = (PsdImage)Image.Load(dataDir + "layers.psd"))
            {
                // Create an instance of TiffOptions while specifying desired format Passsing TiffExpectedFormat.TiffJpegRGB will set the compression to Jpeg and BitsPerPixel according to the RGB color space.
                TiffOptions options = new TiffOptions(TiffExpectedFormat.TiffJpegRgb);
                psdImage.Save(dataDir + "SampleTiff_out.tiff", options);
            }

            //ExEnd:TiffOptionsConfiguration
        }
    }
}
--- END OF FILE CSharp/Aspose/ModifyingAndConvertingImages/TIFF/TiffOptionsConfiguration.cs ---

--- START OF FILE CSharp/Aspose/Opening/LoadingImageFromStream.cs ---
﻿using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using System;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.Opening
{
    class LoadingImageFromStreamAsALayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string dataDir = RunExamples.GetDataDir_Opening();

            //ExStart:LoadingImageFromStream

            string outputFilePath = dataDir + "PsdResult.psd";

            var filesList = new string[]
            {
                "PsdExample.psd",
                "BmpExample.bmp",
                "GifExample.gif",
                "Jpeg2000Example.jpf",
                "JpegExample.jpg",
                "PngExample.png",
                "TiffExample.tif",
            };
            using (var image = new PsdImage(200, 200))
            {
                foreach (var fileName in filesList)
                {
                    string filePath = dataDir + fileName;
                    using (var stream = new FileStream(filePath, FileMode.Open))
                    {
                        Layer layer = null;
                        try
                        {
                            layer = new Layer(stream);
                            image.AddLayer(layer);
                        }
                        catch (Exception e)
                        {
                            if (layer != null)
                            {
                                layer.Dispose();
                            }
                            throw e;
                        }
                    }
                }
                image.Save(outputFilePath);
            }
            //ExEnd:LoadingImageFromStream

        }
    }
}
--- END OF FILE CSharp/Aspose/Opening/LoadingImageFromStream.cs ---

--- START OF FILE CSharp/Aspose/Opening/SupportOfAllowNonChangedLayerRepaint.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.Opening
{
    public class SupportOfAllowNonChangedLayerRepaint
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfAllowNonChangedLayerRepaint
            //ExSummary:The following code demonstrates the new behaviour that prevent auto repaint of layers before changes.

            string srcFile = Path.Combine(baseDir, "psdnet2400.psd");
            string output1 = Path.Combine(outputDir, "unchanged-2400.png");
            string output2 = Path.Combine(outputDir, "updated-2400.png");

            using (var psdImage = (PsdImage)Image.Load(srcFile,
                       new PsdLoadOptions() { AllowNonChangedLayerRepaint = false /* The new default behaviour */ }))
            {
                psdImage.Save(output1, new PngOptions());

                ((TextLayer)psdImage.Layers[1]).TextData.UpdateLayerData();

                psdImage.Save(output2, new PngOptions());
            }

            //ExEnd:SupportOfAllowNonChangedLayerRepaint

            File.Delete(output1);
            File.Delete(output2);

            Console.WriteLine("SupportOfAllowNonChangedLayerRepaint executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/Opening/SupportOfAllowNonChangedLayerRepaint.cs ---

--- START OF FILE CSharp/Aspose/SmartFilters/DirectlyApplySmartFilter.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.SmartFilters;

namespace Aspose.PSD.Examples.Aspose.SmartFilters
{
    public class DirectlyApplySmartFilter
    {
        public static void Run()
        {
            // The path to the document's directory.
            string sourceDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:DirectlyApplySmartFilter
            string source = Path.Combine(sourceDir, "sharpen_source.psd");
            string outputUpdated = Path.Combine(outputDir, "output_updated.psd");

            using (PsdImage im = (PsdImage)Image.Load(source))
            {
                SharpenSmartFilter sharpenFilter = new SharpenSmartFilter();
                Layer regularLayer = im.Layers[1];
                for (int i = 0; i < 3; i++)
                {
                    sharpenFilter.Apply(regularLayer);
                }

                im.Save(outputUpdated);
            }

            //ExEnd:DirectlyApplySmartFilter

            File.Delete(outputUpdated);
            
            Console.WriteLine("DirectlyApplySmartFilter executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartFilters/DirectlyApplySmartFilter.cs ---

--- START OF FILE CSharp/Aspose/SmartFilters/ManipulatingSmartFiltersInSmartObjects.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartFilters;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;

namespace Aspose.PSD.Examples.Aspose.SmartFilters
{
    public class ManipulatingSmartFiltersInSmartObjects
    {
        public static void Run()
        {
            // The path to the document's directory.
            string sourceDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:ManipulatingSmartFiltersInSmartObjects
            string source = Path.Combine(sourceDir, "r2_SmartFilters.psd");
            string outputOriginal = Path.Combine(outputDir, "original_smart_features.psd");
            string outputUpdated = Path.Combine(outputDir, "output_updated_features.psd");

            using (PsdImage im = (PsdImage)Image.Load(source))
            {
                im.Save(outputOriginal);
                SmartObjectLayer smartObj = (SmartObjectLayer)im.Layers[1];

                // Edit smart filters
                GaussianBlurSmartFilter gaussianBlur = (GaussianBlurSmartFilter)smartObj.SmartFilters.Filters[0];

                // Update filter values including blend mode
                gaussianBlur.Radius = 1;
                gaussianBlur.BlendMode = BlendMode.Divide;
                gaussianBlur.Opacity = 75;
                gaussianBlur.IsEnabled = false;

                // Working with Add Noise Smart Filter
                AddNoiseSmartFilter addNoise = (AddNoiseSmartFilter)smartObj.SmartFilters.Filters[1];
                addNoise.Distribution = NoiseDistribution.Uniform;

                // Add new filter items
                List<SmartFilter> filters = new List<SmartFilter>(smartObj.SmartFilters.Filters)
                {
                    new GaussianBlurSmartFilter(),
                    new AddNoiseSmartFilter()
                };
                smartObj.SmartFilters.Filters = filters.ToArray();

                // Apply changes
                smartObj.SmartFilters.UpdateResourceValues();

                // Apply filters directly to layer and mask of layer
                smartObj.SmartFilters.Filters[0].Apply(im.Layers[2]);
                smartObj.SmartFilters.Filters[4].ApplyToMask(im.Layers[2]);

                im.Save(outputUpdated);
            }

            //ExEnd:ManipulatingSmartFiltersInSmartObjects

            File.Delete(outputOriginal);
            File.Delete(outputUpdated);
            
            Console.WriteLine("ManipulatingSmartFiltersInSmartObjects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartFilters/ManipulatingSmartFiltersInSmartObjects.cs ---

--- START OF FILE CSharp/Aspose/SmartFilters/SupportAccessToSmartFilters.cs ---
﻿using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartFilters;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using System;
using System.Collections.Generic;
using System.IO;

namespace Aspose.PSD.Examples.Aspose.SmartFilters
{
    internal class SupportAccessToSmartFilters
    {
        public static void Run()
        {
            // The path to the documents directory.
            string sourceDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportAccessToSmartFilters
            //ExSummary:This example demonstrates the support of the smart filters interface.

            string sourceFile = Path.Combine(sourceDir, "r2_SmartFilters.psd");
            string outputPsd = Path.Combine(outputDir, "out_r2_SmartFilters.psd");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }

            using (var image = (PsdImage)Image.Load(sourceFile))
            {
                SmartObjectLayer smartObj = (SmartObjectLayer)image.Layers[1];

                // edit smart filters
                GaussianBlurSmartFilter gaussianBlur = (GaussianBlurSmartFilter)smartObj.SmartFilters.Filters[0];

                // check filter values
                AssertAreEqual(3.1, gaussianBlur.Radius);
                AssertAreEqual(BlendMode.Dissolve, gaussianBlur.BlendMode);
                AssertAreEqual(90d, gaussianBlur.Opacity);
                AssertAreEqual(true, gaussianBlur.IsEnabled);

                // update filter values
                gaussianBlur.Radius = 1;
                gaussianBlur.BlendMode = BlendMode.Divide;
                gaussianBlur.Opacity = 75;
                gaussianBlur.IsEnabled = false;
                AddNoiseSmartFilter addNoise = (AddNoiseSmartFilter)smartObj.SmartFilters.Filters[1];
                addNoise.Distribution = NoiseDistribution.Uniform;

                // add new filter items
                var filters = new List<SmartFilter>(smartObj.SmartFilters.Filters);
                filters.Add(new GaussianBlurSmartFilter());
                filters.Add(new AddNoiseSmartFilter());
                smartObj.SmartFilters.Filters = filters.ToArray();

                // apply changes
                smartObj.SmartFilters.UpdateResourceValues();

                // Apply filters
                smartObj.SmartFilters.Filters[0].Apply(image.Layers[2]);
                smartObj.SmartFilters.Filters[4].ApplyToMask(image.Layers[2]);

                image.Save(outputPsd);
            }

            using (var image = (PsdImage)Image.Load(outputPsd))
            {
                SmartObjectLayer smartObj = (SmartObjectLayer)image.Layers[1];

                GaussianBlurSmartFilter gaussianBlur = (GaussianBlurSmartFilter)smartObj.SmartFilters.Filters[0];

                // check filter values
                AssertAreEqual(1d, gaussianBlur.Radius);
                AssertAreEqual(BlendMode.Divide, gaussianBlur.BlendMode);
                AssertAreEqual(75d, gaussianBlur.Opacity);
                AssertAreEqual(false, gaussianBlur.IsEnabled);

                AssertAreEqual(true, smartObj.SmartFilters.Filters[5] is GaussianBlurSmartFilter);
                AssertAreEqual(true, smartObj.SmartFilters.Filters[6] is AddNoiseSmartFilter);
            }

            //ExEnd:SupportAccessToSmartFilters

            Console.WriteLine("SupportAccessToSmartFilters executed successfully");

            File.Delete(outputPsd);
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartFilters/SupportAccessToSmartFilters.cs ---

--- START OF FILE CSharp/Aspose/SmartFilters/SupportCustomSmartFilterRenderer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.TypeToolInfoStructures;
using Aspose.PSD.FileFormats.Psd.Layers.SmartFilters;
using Aspose.PSD.FileFormats.Psd.Layers.SmartFilters.Rendering;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartFilters
{
    internal class SupportCustomSmartFilterRenderer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            string sourceFile = Path.Combine(SourceDir, "psdnet1057.psd");
            string outputPsd = Path.Combine(OutputDir, "out_psdnet1057.psd");
            string outputPng = Path.Combine(OutputDir, "out_psdnet1057.png");

            CustomSmartFilterExample(sourceFile, outputPsd, outputPng);
            
            Console.WriteLine("SupportCustomSmartFilterRenderer executed successfully");

            File.Delete(outputPsd);
            File.Delete(outputPng);
        }
        
        //ExStart:SupportCustomSmartFilterRenderer
        //ExSummary:The following code shows you how to create a custom smart filter that has a custom renderer.
        
        public static void CustomSmartFilterExample(string sourceFile = "psdnet1057.psd", string outputPsd = "out_psdnet1057.psd", string outputPng = "out_psdnet1057.png")
        {
            // Inits the unsupported 'Crystallize' smart filter at input array
            SmartFilter[] InitUnknownSmartFilters(SmartFilter[] smartFilters)
            {
                // the 'Crystallize' smart filter ID.
                int id = 1131574132;

                for (int i = 0; i < smartFilters.Length; i++)
                {
                    var smartFilter = smartFilters[i];
                    if (smartFilter is UnknownSmartFilter && smartFilter.FilterId == id)
                    {
                        var customSmartFilterInstance = new CustomSmartFilterWithRenderer();
                        customSmartFilterInstance.SourceDescriptor.Structures = smartFilter.SourceDescriptor.Structures;
                        smartFilters[i] = customSmartFilterInstance;
                    }
                }

                return smartFilters;
            }

            using (var image = (PsdImage) Image.Load(sourceFile))
            {
                SmartObjectLayer smartLayer = (SmartObjectLayer) image.Layers[1];
                Layer maskLayer = image.Layers[2];
                Layer regularLayer = image.Layers[3];

                smartLayer.SmartFilters.Filters = InitUnknownSmartFilters(smartLayer.SmartFilters.Filters);
                var smartFilter = smartLayer.SmartFilters.Filters[0];

                // Apply filter to SmartObject
                smartLayer.UpdateModifiedContent();
                smartLayer.SmartFilters.UpdateResourceValues();

                // Apply filter to layer mask
                smartFilter.ApplyToMask(maskLayer);

                //Apply filter to layer
                smartFilter.Apply(regularLayer);

                image.Save(outputPsd);
                image.Save(outputPng, new PngOptions());
            }
        }

        public sealed class CustomSmartFilterWithRenderer : SmartFilter, ISmartFilterRenderer
        {
            public override string Name
            {
                get { return "Custom 'Crystallize' smart filter\0"; }
            }

            public override int FilterId
            {
                // the 'Crystallize' smart filter ID.
                get { return 1131574132; }
            }

            public PixelsData Render(PixelsData pixelsData)
            {
                // get filter structure
                var filterDescriptor = (DescriptorStructure) this.SourceDescriptor.Structures[6];
                // get value of Crystallize Size
                var valueStructure = (IntegerStructure) filterDescriptor.Structures[0];

                for (int i = 0; i < pixelsData.Pixels.Length; i++)
                {
                    if (i % valueStructure.Value == 0)
                    {
                        pixelsData.Pixels[i] = 0;
                    }
                }

                return pixelsData;
            }
        }
        
        //ExEnd:SupportCustomSmartFilterRenderer
    }
}
--- END OF FILE CSharp/Aspose/SmartFilters/SupportCustomSmartFilterRenderer.cs ---

--- START OF FILE CSharp/Aspose/SmartFilters/SupportSharpenSmartFilter.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.Blending;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartFilters;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartFilters
{
    public class SupportSharpenSmartFilter
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportSharpenSmartFilter
            //ExSummary:The following code demonstrates support of SharpenSmartFilter.

            string sourceFile = Path.Combine(baseDir, "sharpen_source.psd");
            string outputPsd = Path.Combine(outputDir, "sharpen_output.psd");
            string outputPng = Path.Combine(outputDir, "sharpen_output.png");

            void AssertAreEqual(object expected, object actual)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception("Objects are not equal.");
                }
            }
            
            using (var image = (PsdImage)Image.Load(sourceFile))
            {
                SmartObjectLayer smartObj = (SmartObjectLayer)image.Layers[1];

                // edit smart filters
                SharpenSmartFilter sharpen = (SharpenSmartFilter)smartObj.SmartFilters.Filters[0];

                // check filter values
                AssertAreEqual(BlendMode.Normal, sharpen.BlendMode);
                AssertAreEqual(100d, sharpen.Opacity);
                AssertAreEqual(true, sharpen.IsEnabled);

                // update filter values
                sharpen.BlendMode = BlendMode.Divide;
                sharpen.Opacity = 75;
                sharpen.IsEnabled = false;

                // add new filter items
                var filters = new List<SmartFilter>(smartObj.SmartFilters.Filters);
                filters.Add(new SharpenSmartFilter());
                smartObj.SmartFilters.Filters = filters.ToArray();

                // apply changes
                smartObj.SmartFilters.UpdateResourceValues();
                smartObj.UpdateModifiedContent();

                image.Save(outputPsd);
                image.Save(outputPng, new PngOptions());
            }
            
            //ExEnd:SupportSharpenSmartFilter

            File.Delete(outputPsd);
            File.Delete(outputPng);

            Console.WriteLine("SupportSharpenSmartFilter executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartFilters/SupportSharpenSmartFilter.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfConvertingLayerToSmartObject.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    class SupportOfConvertingLayerToSmartObject
    {
        public static void Run()
        {
            //ExStart:SupportOfConvertingLayerToSmartObject

            // Tests that the layer, imported from an image, is converted to smart object layer and the saved PSD file is correct.

            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            string outputFilePath = OutputDir + "layerTest2.psd";
            string outputPngFilePath = Path.ChangeExtension(outputFilePath, ".png");
            using (PsdImage image = (PsdImage)Image.Load(SourceDir + "layerTest1.psd"))
            {
                string layerFilePath = SourceDir + "picture.jpg";
                using (var stream = new FileStream(layerFilePath, FileMode.Open))
                {
                    Layer layer = null;
                    try
                    {
                        layer = new Layer(stream);
                        image.AddLayer(layer);
                    }
                    catch (Exception)
                    {
                        if (layer != null)
                        {
                            layer.Dispose();
                        }

                        throw;
                    }

                    var layer2 = image.Layers[2];
                    var layer3 = image.SmartObjectProvider.ConvertToSmartObject(image.Layers.Length - 1);
                    var bounds = layer3.Bounds;
                    layer3.Left = (image.Width - layer3.Width) / 2;
                    layer3.Top = layer2.Top;
                    layer3.Right = layer3.Left + bounds.Width;
                    layer3.Bottom = layer3.Top + bounds.Height;

                    image.Save(outputFilePath);
                    image.Save(outputPngFilePath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            //ExEnd:SupportOfConvertingLayerToSmartObject

            File.Delete(outputFilePath);
            File.Delete(outputPngFilePath);

            Console.WriteLine("SupportOfConvertingLayerToSmartObject executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfConvertingLayerToSmartObject.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfCopyingOfSmartObjectLayers.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    class SupportOfCopyingOfSmartObjectLayers
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfCopyingOfSmartObjectLayers
            //ExSummary:These examples demonstrate how to copy smart object layers in a PSD image.

            string dataDir = baseFolder;
            string outputDir = output;

            // These examples demonstrate how to copy smart object layers in a PSD image.
            ExampleOfCopingSmartObjectLayer("r-embedded-psd");
            ExampleOfCopingSmartObjectLayer("r-embedded-png");
            ExampleOfCopingSmartObjectLayer("r-embedded-transform");
            ExampleOfCopingSmartObjectLayer("new_panama-papers-8-trans4");

            void ExampleOfCopingSmartObjectLayer(string fileName)
            {
                int layerNumber = 0; // The layer number to copy
                string filePath = dataDir + fileName + ".psd";
                string outputFilePath = outputDir + fileName + "_copy_" + layerNumber;
                string pngOutputPath = outputFilePath + ".png";
                string psdOutputPath = outputFilePath + ".psd";
                using (PsdImage image = (PsdImage)Image.Load(filePath))
                {
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[layerNumber];
                    var newLayer = smartObjectLayer.NewSmartObjectViaCopy();
                    newLayer.IsVisible = false;
                    AssertIsTrue(object.ReferenceEquals(newLayer, image.Layers[layerNumber + 1]));
                    AssertIsTrue(object.ReferenceEquals(smartObjectLayer, image.Layers[layerNumber]));

                    var duplicatedLayer = smartObjectLayer.DuplicateLayer();
                    duplicatedLayer.DisplayName = smartObjectLayer.DisplayName + " shared image";
                    AssertIsTrue(object.ReferenceEquals(newLayer, image.Layers[layerNumber + 2]));
                    AssertIsTrue(object.ReferenceEquals(duplicatedLayer, image.Layers[layerNumber + 1]));
                    AssertIsTrue(object.ReferenceEquals(smartObjectLayer, image.Layers[layerNumber]));

                    using (var innerImage = (RasterImage)smartObjectLayer.LoadContents(null))
                    {
                        // Let's invert the embedded smart object image (for an inner PSD image we invert only its first layer)
                        InvertImage(innerImage);

                        // Let's replace the embedded smart object image in the PSD layer
                        smartObjectLayer.ReplaceContents(innerImage);
                    }

                    // The duplicated layer shares its imbedded image with the original smart object
                    // and it should be updated explicitly otherwise its rendering cache remains unchanged.
                    // We update every smart object to make sure that the new layer created by NewSmartObjectViaCopy
                    // does not share the embedded image with the others.
                    image.SmartObjectProvider.UpdateAllModifiedContent();

                    image.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                    image.Save(psdOutputPath, new PsdOptions(image));
                }
            }

            // Inverts the raster image including the PSD image.
            void InvertImage(RasterImage innerImage)
            {
                var innerPsdImage = innerImage as PsdImage;
                if (innerPsdImage != null)
                {
                    InvertRasterImage(innerPsdImage.Layers[0]);
                }
                else
                {
                    InvertRasterImage(innerImage);
                }
            }

            // Inverts the raster image.
            void InvertRasterImage(RasterImage innerImage)
            {
                var pixels = innerImage.LoadArgb32Pixels(innerImage.Bounds);
                for (int i = 0; i < pixels.Length; i++)
                {
                    var pixel = pixels[i];
                    var alpha = (int)(pixel & 0xff000000);
                    pixels[i] = (~(pixel & 0x00ffffff)) | alpha;
                }

                innerImage.SaveArgb32Pixels(innerImage.Bounds, pixels);
            }

            void AssertIsTrue(bool condition)
            {
                if (!condition)
                {
                    throw new FormatException(string.Format("Expected true"));
                }
            }

            //ExEnd:SupportOfCopyingOfSmartObjectLayers

            Console.WriteLine("SupportOfCopyingOfSmartObjectLayers executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfCopyingOfSmartObjectLayers.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfEmbeddedSmartObjects.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    class SupportOfEmbeddedSmartObjects
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfEmbeddedSmartObjects
            //ExSummary:The following code demonstrates the support of Embedded Smart objects.

            void AssertAreEqual(object actual, object expected)
            {
                if (!object.Equals(actual, expected))
                {
                    throw new FormatException(string.Format("Actual value {0} are not equal to expected {1}.", actual, expected));
                }
            }

            // This example demonstrates how to change the smart object layer in the PSD file and export / update smart object original embedded contents.
            const int left = 0;
            const int top = 0;
            const int right = 0xb;
            const int bottom = 0x10;
            FileFormat[] formats = new[]
            {
                FileFormat.Png, FileFormat.Psd, FileFormat.Bmp, FileFormat.Jpeg, FileFormat.Gif, FileFormat.Tiff, FileFormat.Jpeg2000
            };
            foreach (FileFormat format in formats)
            {
                string formatString = format.ToString().ToLowerInvariant();
                string formatExt = format == FileFormat.Jpeg2000 ? "jpf" : formatString;
                string fileName = "r-embedded-" + formatString;
                string sourceFilePath = baseFolder + fileName + ".psd";
                string pngOutputPath = output + fileName + "_output.png";
                string psdOutputPath = output + fileName + "_output.psd";
                string png2OutputPath = output + fileName + "_updated.png";
                string psd2OutputPath = output + fileName + "_updated.psd";
                string exportPath = output + fileName + "_export." + formatExt;
                using (PsdImage image = (PsdImage)Image.Load(sourceFilePath))
                {
                    var smartObjectLayer = (SmartObjectLayer)image.Layers[0];

                    AssertAreEqual(left, smartObjectLayer.ContentsBounds.Left);
                    AssertAreEqual(top, smartObjectLayer.ContentsBounds.Top);
                    AssertAreEqual(right, smartObjectLayer.ContentsBounds.Right);
                    AssertAreEqual(bottom, smartObjectLayer.ContentsBounds.Bottom);

                    // Let's export the embedded smart object image from the PSD smart object layer
                    smartObjectLayer.ExportContents(exportPath);

                    // Let's check if the original image is saved correctly
                    image.Save(psdOutputPath, new PsdOptions(image));
                    image.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });

                    using (var innerImage = (RasterImage)smartObjectLayer.LoadContents(null))
                    {
                        AssertAreEqual(format, innerImage.FileFormat);

                        // Let's invert original smart object image
                        var pixels = innerImage.LoadArgb32Pixels(innerImage.Bounds);
                        for (int i = 0; i < pixels.Length; i++)
                        {
                            var pixel = pixels[i];
                            var alpha = (int)(pixel & 0xff000000);
                            pixels[i] = (~(pixel & 0x00ffffff)) | alpha;
                        }

                        innerImage.SaveArgb32Pixels(innerImage.Bounds, pixels);

                        // Let's replace the embedded smart object image in the PSD layer
                        smartObjectLayer.ReplaceContents(innerImage);
                    }

                    // Let's check if the updated image is saved correctly
                    image.Save(psd2OutputPath, new PsdOptions(image));
                    image.Save(png2OutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            //ExEnd:SupportOfEmbeddedSmartObjects

            Console.WriteLine("SupportOfEmbeddedSmartObjects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfEmbeddedSmartObjects.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfExportContentsFromSmartObject.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    public class SupportOfExportContentsFromSmartObject
    {
        public static void Run()
        {
            string baseFolder = RunExamples.GetDataDir_PSD();
            string output = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfExportContentsFromSmartObject
            string source = Path.Combine(baseFolder, "new_panama-papers-8-trans4.psd");
            string exportContentPath = Path.Combine(output, "export_content.jpg");
            string outputUpdated = Path.Combine(output, "smart_object.psd");

            using (PsdImage im = (PsdImage)Image.Load(source))
            {
                SmartObjectLayer smartLayer = (SmartObjectLayer)im.Layers[0];

                // How to export content of Smart Object
                smartLayer.ExportContents(exportContentPath);

                // Creating Smart Object as a Copy
                SmartObjectLayer newLayer = smartLayer.NewSmartObjectViaCopy();
                newLayer.IsVisible = false;
                newLayer.DisplayName = "Duplicate";

                // Get the content of Smart Object for manipulation
                using (RasterImage innerImage = (RasterImage)smartLayer.LoadContents(null))
                {
                    InvertImage(innerImage);
                    smartLayer.ReplaceContents(innerImage);
                }

                im.SmartObjectProvider.UpdateAllModifiedContent();

                PsdOptions psdOptions = new PsdOptions(im);
                im.Save(outputUpdated, psdOptions);
            }
         
            void InvertImage(RasterImage image)
            {
                int[] pixels = image.LoadArgb32Pixels(image.Bounds);
                for (int i = 0; i < pixels.Length; i++)
                {
                    int pixel = pixels[i];
                    int alpha = pixel & unchecked((int)0xff000000);
                    pixels[i] = (~(pixel & 0x00ffffff)) | alpha;
                }
                image.SaveArgb32Pixels(image.Bounds, pixels);
            }
            //ExEnd:SupportOfExportContentsFromSmartObject
            
            File.Delete(outputUpdated);
            File.Delete(exportContentPath);

            Console.WriteLine("SupportOfExportContentsFromSmartObject executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfExportContentsFromSmartObject.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfProcessingAreaProperty.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.FileFormats.Psd.Layers.Warp;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    public class SupportOfProcessingAreaProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfProcessingAreaProperty
            //ExSummary:The following code demonstrates WarpSettings.ProcessingArea property to configure warp deformation.

            string sourceFile = Path.Combine(baseDir, "Warping.psd");
            List<string> outputFiles = new List<string>();

            PsdLoadOptions loadOptions = new PsdLoadOptions() { LoadEffectsResource = true, AllowWarpRepaint = true };

            int[] areaValues = { 5, 10, 25, 40 };

            for (int i = 0; i < 4; i++)
            {
                using (var psdImage = (PsdImage)Image.Load(sourceFile, loadOptions))
                {
                    // It gets WarpSettings from Smart Layer
                    WarpSettings warpSettings = ((SmartObjectLayer)psdImage.Layers[1]).WarpSettings;

                    // It sets size of warp processing area
                    warpSettings.ProcessingArea = areaValues[i];
                    ((SmartObjectLayer)psdImage.Layers[1]).WarpSettings = warpSettings;

                    string outputFile = Path.Combine(outputDir, "export" + areaValues[i] + ".png");
                    outputFiles.Add(outputFile);

                    // There should no error here
                    psdImage.Save(outputFile, new PngOptions { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            //ExEnd:SupportOfProcessingAreaProperty

            foreach (string outputFile in outputFiles)
            {
                File.Delete(outputFile);
            }

            Console.WriteLine("SupportOfProcessingAreaProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfProcessingAreaProperty.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfReplaceContentsByLink.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    public class SupportOfReplaceContentsByLink
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfReplaceContentsByLink

            //ExSummary:The following code demonstrates the support of replacing content in many smart objects that have the same source reference.
            
            string srcFile = Path.Combine(baseDir, "2233_Source.psd");
            string replaceAll = Path.Combine(baseDir, "2233_replaceAll.jpg");
            string replaceOne = Path.Combine(baseDir, "2233_replaceOne.jpg");
            string outFileImgAll = Path.Combine(outputDir, "2233_output_All.png");
            string outFileImgOne = Path.Combine(outputDir, "2233_output_one.png");
            
            // This will replace the same context in all smart layers with the same link.
            using (var image = (PsdImage)Image.Load(srcFile))
            {
                var smartObjectLayer = (SmartObjectLayer)image.Layers[1];

                // This will replace the content in all SmartLayers that use the same content.
                smartObjectLayer.ReplaceContents(replaceAll, false);
                smartObjectLayer.UpdateModifiedContent();

                image.Save(outFileImgAll, new PngOptions());
            }
            
            //This will replace the context of only the selected layer, leaving all others with the same context alone.
            using (var image = (PsdImage)Image.Load(srcFile))
            {
                var smartObjectLayer = (SmartObjectLayer)image.Layers[1];

                // It replaces the content in the selected SmartLayer only. 
                smartObjectLayer.ReplaceContents(replaceOne, true);
                smartObjectLayer.UpdateModifiedContent();

                image.Save(outFileImgOne, new PngOptions());
            }
            
            //ExEnd:SupportOfReplaceContentsByLink

            File.Delete(outFileImgAll);
            File.Delete(outFileImgOne);
            Console.WriteLine("SupportOfReplaceContentsByLink executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfReplaceContentsByLink.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfReplaceContentsInSmartObjects.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    class SupportOfReplaceContentsInSmartObjects
    {
        public static void Run()
        {
            //ExStart:SupportOfReplaceContentsInSmartObjects

            // This example demonstrates that the ReplaceContents method works correctly when the new content file has a different resolution.

            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            string fileName = "CommonPsb.psd";
            string filePath = SourceDir + fileName; // original PSD image
            string newContentPath = SourceDir + "image.jpg"; // the new content file for the smart object
            string outputFilePath = OutputDir + "ChangedPsd";
            string pngOutputPath = outputFilePath + ".png"; // the output PNG file
            string psdOutputPath = outputFilePath + ".psd"; // the output PSD file
            using (PsdImage psd = (PsdImage)Image.Load(filePath))
            {
                for (int i = 0; i < psd.Layers.Length; i++)
                {
                    var layer = psd.Layers[i];
                    SmartObjectLayer smartObjectLayer = layer as SmartObjectLayer;
                    if (smartObjectLayer != null)
                    {
                        smartObjectLayer.ReplaceContents(newContentPath);

                        psd.Save(psdOutputPath);
                        psd.Save(pngOutputPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                    }
                }
            }

            //ExEnd:SupportOfReplaceContentsInSmartObjects

            File.Delete(psdOutputPath);
            File.Delete(pngOutputPath);

            Console.WriteLine("SupportOfReplaceContentsInSmartObjects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfReplaceContentsInSmartObjects.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/SupportOfWarpTransformationToSmartObject.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    public class SupportOfWarpTransformationToSmartObject
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfWarpTransformationToSmartObject
            //ExSummary:The following code demonstrates the Warp effect rendering.

            string sourceFile = Path.Combine(baseDir, "source.psd");
            string pngWarpedExport = Path.Combine(outputDir, "warped.png");
            string psdWarpedExport = Path.Combine(outputDir, "warpFile.psd");

            var warpLoadOptions = new PsdLoadOptions() { AllowWarpRepaint = true };

            using (var image = (PsdImage)Image.Load(sourceFile, warpLoadOptions))
            {
                image.Save(pngWarpedExport, new PngOptions());
                image.Save(psdWarpedExport, new PsdOptions());
            }

            //ExEnd:SupportOfWarpTransformationToSmartObject

            File.Delete(pngWarpedExport);
            File.Delete(psdWarpedExport);

            Console.WriteLine("SupportOfWarpTransformationToSmartObject executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/SupportOfWarpTransformationToSmartObject.cs ---

--- START OF FILE CSharp/Aspose/SmartObjects/WarpSettingsForSmartObjectLayerAndTextLayer.cs ---
using System;
using System.IO;
using System.Linq;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.SmartObjects;
using Aspose.PSD.FileFormats.Psd.Layers.Warp;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.SmartObjects
{
    public class WarpSettingsForSmartObjectLayerAndTextLayer
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:WarpSettingsForSmartObjectLayerAndTextLayer
            //ExSummary:The following code demonstrates how to manipulate WarpSettings to do warp transformation on SmartObjectLayer and TexLayer. 

            string sourceFile = Path.Combine(baseDir, "smart_without_warp.psd");

            var opt = new PsdLoadOptions()
            {
                LoadEffectsResource = true,
                AllowWarpRepaint = true
            };

            string[] outputImageFile = new string[4];
            string[] outputPsdFile = new string[4];

            for (int caseIndex = 0; caseIndex < outputImageFile.Length; caseIndex++)
            {
                outputImageFile[caseIndex] = Path.Combine(outputDir, "export_" + caseIndex + ".png");
                outputPsdFile[caseIndex] = Path.Combine(outputDir, "export_" + caseIndex + ".psd");

                using (PsdImage img = (PsdImage)Image.Load(sourceFile, opt))
                {
                    foreach (Layer layer in img.Layers)
                    {
                        if (layer is SmartObjectLayer)
                        {
                            var smartLayer = (SmartObjectLayer)layer;
                            smartLayer.WarpSettings = GetWarpSettingsByIndex(smartLayer.WarpSettings, caseIndex);
                        }

                        if (layer is TextLayer)
                        {
                            var textLayer = (TextLayer)layer;

                            if (caseIndex != 3)
                            {
                                textLayer.WarpSettings = GetWarpSettingsByIndex(textLayer.WarpSettings, caseIndex);
                            }
                        }
                    }

                    img.Save(outputPsdFile[caseIndex], new PsdOptions());
                }

                using (PsdImage img = (PsdImage)Image.Load(outputPsdFile[caseIndex], opt))
                {
                    img.Save(outputImageFile[caseIndex],
                        new PngOptions() { CompressionLevel = 9, ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            WarpSettings GetWarpSettingsByIndex(WarpSettings warpParams, int caseIndex)
            {
                switch (caseIndex)
                {
                    case 0:
                        warpParams.Style = WarpStyles.Rise;
                        warpParams.Rotate = WarpRotates.Horizontal;
                        warpParams.Value = 20;
                        break;
                    case 1:
                        warpParams.Style = WarpStyles.Rise;
                        warpParams.Rotate = WarpRotates.Vertical;
                        warpParams.Value = 10;
                        break;
                    case 2:
                        warpParams.Style = WarpStyles.Flag;
                        warpParams.Rotate = WarpRotates.Horizontal;
                        warpParams.Value = 30;
                        break;
                    case 3:
                        warpParams.Style = WarpStyles.Custom;
                        warpParams.MeshPoints[2].Y += 70;
                        break;
                }

                return warpParams;
            }

            //ExEnd:WarpSettingsForSmartObjectLayerAndTextLayer

            foreach (var outputFile in outputImageFile.Concat(outputPsdFile))
            {
                File.Delete(outputFile);   
            }

            Console.WriteLine("WarpSettingsForSmartObjectLayerAndTextLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/SmartObjects/WarpSettingsForSmartObjectLayerAndTextLayer.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/ChangingGroupVisibility.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    class ChangingGroupVisibility
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart
            //ExSummary:The following example demonstrates how you can change LayerGroup visibility in Aspose.PSD
            string sourceFilePath = baseDir + "apple.psd";
            string outputFilePath = outputDir + "apple_with_hidden_gorup_output.psd";

            // make changes in layer names and save it
            using (var image = (PsdImage)Image.Load(sourceFilePath))
            {
                for (int i = 0; i < image.Layers.Length; i++)
                {
                    var layer = image.Layers[i];

                    // Turn off everything inside a group
                    if (layer is LayerGroup)
                    {
                        layer.IsVisible = false;
                    }
                }

                image.Save(outputFilePath);
            }

            //ExEnd

            Console.WriteLine("ChangingGroupVisibility executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/ChangingGroupVisibility.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/ExportLayerGroupToImage.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    class ExportLayerGroupToImage
    {
        public static void Run()
        {
            // The path to the document's directory.
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:ExportLayerGroupToImage
            string outputPsd = Path.Combine(outputDir, "LayerGroup.psd");
            string outputPng = Path.Combine(outputDir, "LayerGroup.psd_folder.png");

            using (PsdImage psdImage = new PsdImage(100, 100))
            {
                // Init background layer
                var bgLayer = FillLayer.CreateInstance(FillType.Color);
                ((IColorFillSettings)bgLayer.FillSettings).Color = Color.Blue;

                // Init regular layers
                byte[] tempBytes = new byte[10 * 10];
                Layer layer1 = new Layer(
                    new Rectangle(50, 50, 10, 10), tempBytes, tempBytes, tempBytes, "Layer 1");
                Layer layer2 = new Layer(
                    new Rectangle(50, 50, 10, 10), tempBytes, tempBytes, tempBytes, "Layer 2");
    
                // Init and add folder
                LayerGroup layerGroup = psdImage.AddLayerGroup("Folder", 0, true);
    
                // add background to PsdImage
                psdImage.AddLayer(bgLayer);
    
                // add regular layers to folder
                layerGroup.AddLayer(layer1);
                layerGroup.AddLayer(layer2);
    
                // Validate that the layers were added correctly
                System.Diagnostics.Debug.Assert(layerGroup.Layers[0].DisplayName == "Layer 1");
                System.Diagnostics.Debug.Assert(layerGroup.Layers[1].DisplayName == "Layer 2");

                psdImage.Save(outputPsd);
                layerGroup.Save(outputPng, new PngOptions());
            }
            //ExEnd:ExportLayerGroupToImage
            
            File.Delete(outputPsd);
            File.Delete(outputPng);
            Console.WriteLine("ExportLayerGroupToImage executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/ExportLayerGroupToImage.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/GettingUniqueHashForSimilarLayers.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    class GettingUniqueHashForSimilarLayers
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            RegularLayerContentHashTest(Path.Combine(SourceDir, "OnlyRegular.psd"));
            FillLayerContentHashTest(Path.Combine(SourceDir, "FillSmartGroup.psd"));
            SmartObjectLayerContentHashTest(Path.Combine(SourceDir, "FillSmartGroup.psd"));
            AdjustmentLayersContentHashTest(Path.Combine(SourceDir, "AllAdjustments.psd"));
            TextLayersContentHashTest(Path.Combine(SourceDir, "TextLayers.psd"));
            GroupLayerContentHashTest(Path.Combine(SourceDir, "FillSmartGroup.psd"));

            var contentTestFiles = new string[]
                { "OnlyRegular.psd", "FillSmartGroup.psd", "TextLayers.psd", "AllAdjustments.psd" };

            foreach (var file in contentTestFiles)
            {
                string srcFile = Path.Combine(SourceDir, file);
                string outFile = Path.Combine(OutputDir, "output_" + file);
                
                RegularLayerContentFromDifferentFilesHashTest(srcFile, outFile);
            }

            Console.WriteLine("GettingUniqueHashForSimilarLayers executed successfully");
        }
        
        //ExStart:GettingUniqueHashForSimilarLayers
        //ExSummary:The following code demonstrates the API for getting the unique hash for similar layers in different files.
        
        /// <summary>
        /// Gets the name of the layer by.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="image">The image.</param>
        /// <param name="name">The name.</param>
        /// <returns></returns>
        private static T GetLayerByName<T>(PsdImage image, string name) where T : Layer
        {
            var layers = image.Layers;
            foreach (var layer in layers)
            {
                if (layer.Name == name)
                {
                    return (T) layer;
                }
            }

            return null;
        }

        /// <summary>
        /// Ares the not equal.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="expected">The expected.</param>
        /// <param name="actual">The actual.</param>
        /// <exception cref="System.Exception">Arguments must not be equal</exception>
        public static void AreNotEqual<T>(T expected, T actual)
        {
            if (expected != null && expected.Equals(actual))
            {
                throw new Exception("Arguments must not be equal");
            }
        }

        /// <summary>
        /// Ares the equal.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="expected">The expected.</param>
        /// <param name="actual">The actual.</param>
        /// <exception cref="System.Exception">Arguments must be equal</exception>
        public static void AreEqual<T>(T expected, T actual)
        {
            if (expected != null && !expected.Equals(actual))
            {
                throw new Exception("Arguments must be equal");
            }
        }

        /// <summary>
        /// Regulars the layer content hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void RegularLayerContentHashTest(string fileName)
        {
            using (var im = (PsdImage) Image.Load(fileName))
            {
                var layers = new Layer[9];
                var hashers = new LayerHashCalculator[9];

                for (int i = 0; i < layers.Length; i++)
                {
                    layers[i] = GetLayerByName<Layer>(im, string.Format("Layer {0}", i + 1));
                    hashers[i] = new LayerHashCalculator(layers[i]);
                }

                AreNotEqual(hashers[0].GetChannelsHash(), hashers[1].GetChannelsHash());
                AreNotEqual(hashers[1].GetChannelsHash(), hashers[2].GetChannelsHash());
                AreNotEqual(hashers[0].GetChannelsHash(), hashers[2].GetChannelsHash());
                AreNotEqual(hashers[5].GetChannelsHash(), hashers[7].GetChannelsHash());
                AreNotEqual(hashers[0].GetChannelsHash(), hashers[8].GetChannelsHash());

                // These layers' hashes are equal
                AreEqual(hashers[0].GetChannelsHash(), hashers[3].GetChannelsHash());
                AreEqual(hashers[1].GetChannelsHash(), hashers[4].GetChannelsHash());
                AreEqual(hashers[0].GetChannelsHash(), hashers[6].GetChannelsHash());

                // Check the blending mode hash 
                AreEqual(hashers[0].GetBlendingHash(), hashers[3].GetBlendingHash());
                AreEqual(hashers[1].GetBlendingHash(), hashers[4].GetBlendingHash());
                AreNotEqual(hashers[0].GetBlendingHash(), hashers[6].GetBlendingHash());

                // But pointers are different
                AreNotEqual(layers[0], layers[3]);
                AreNotEqual(layers[1], layers[4]);
                AreNotEqual(layers[0], layers[6]);
            }
        }

        /// <summary>
        /// Fills the layer content hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void FillLayerContentHashTest(string fileName)
        {
            using (var im = (PsdImage) Image.Load(fileName))
            {
                var fillLayersNames = new string[] { "Color Fill", "Gradient Fill", "Pattern Fill" };

                var colorFillLayers = new Layer[4];
                var colorFillHashers = new LayerHashCalculator[4];

                for (int fillLayerIndex = 0; fillLayerIndex < fillLayersNames.Length; fillLayerIndex++)
                {
                    for (int i = 0; i < 2; i++)
                    {
                        var index = 0 + i * 2;
                        colorFillLayers[index] = GetLayerByName<Layer>(im,
                            string.Format("{0} 1_{1}", fillLayersNames[fillLayerIndex], i + 1));
                        colorFillHashers[index] = new LayerHashCalculator(colorFillLayers[index]);
                        index = 1 + i * 2;
                        colorFillLayers[index] = GetLayerByName<Layer>(im,
                            string.Format("{0} 2_{1}", fillLayersNames[fillLayerIndex], i + 1));
                        colorFillHashers[index] = new LayerHashCalculator(colorFillLayers[index]);
                    }

                    // Similar layers are always in the one index
                    AreEqual(colorFillHashers[0].GetContentHash(), colorFillHashers[2].GetContentHash());
                    AreEqual(colorFillHashers[1].GetContentHash(), colorFillHashers[3].GetContentHash());
                    AreNotEqual(colorFillHashers[0].GetContentHash(), colorFillHashers[1].GetContentHash());
                }
            }
        }

        /// <summary>
        /// Smarts the object layer content hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void SmartObjectLayerContentHashTest(string fileName)
        {
            using (var im = (PsdImage) Image.Load(fileName))
            {
                var smartObjects = new Layer[]
                {
                    GetLayerByName<Layer>(im, "Regular1_1"),
                    GetLayerByName<Layer>(im, "Regular1_2"),
                    GetLayerByName<Layer>(im, "Regular2_1"),
                    GetLayerByName<Layer>(im, "Regular2_2"),
                    GetLayerByName<Layer>(im, "Smart1_1"),
                    GetLayerByName<Layer>(im, "Smart1_2"),
                    GetLayerByName<Layer>(im, "Smart2_1"),
                    GetLayerByName<Layer>(im, "Smart2_2"),
                };

                var hashers = new LayerHashCalculator[smartObjects.Length];

                for (int i = 0; i < smartObjects.Length; i++)
                {
                    hashers[i] = new LayerHashCalculator(smartObjects[i]);
                }

                // Channel data is equal for Layer and Createad from them Smart Objects.
                AreEqual(hashers[0].GetChannelsHash(), hashers[2].GetChannelsHash());
                AreEqual(hashers[0].GetChannelsHash(), hashers[4].GetChannelsHash());

                // Content Hash is different, because Smart Object uses other data as content
                AreNotEqual(hashers[0].GetContentHash(), hashers[4].GetContentHash());

                // But blending hash is similar. Both layers - smart and regular have Normal Blend mode and opacity 255
                AreEqual(hashers[0].GetBlendingHash(), hashers[4].GetBlendingHash());

                // Channel data is equal for Layer and Createad from them Smart Objects.
                AreEqual(hashers[1].GetChannelsHash(), hashers[3].GetChannelsHash());
                AreEqual(hashers[1].GetChannelsHash(), hashers[5].GetChannelsHash());

                // Content Hash is different, because Smart Object uses other data as content
                AreNotEqual(hashers[1].GetContentHash(), hashers[5].GetContentHash());
                // But blending hash is similar. Both layers - smart and regular have Normal Blend mode and opacity 255
                AreEqual(hashers[1].GetBlendingHash(), hashers[5].GetBlendingHash());

                AreNotEqual(hashers[0].GetChannelsHash(), hashers[1].GetChannelsHash());
                AreNotEqual(hashers[2].GetChannelsHash(), hashers[3].GetChannelsHash());
                AreNotEqual(hashers[4].GetChannelsHash(), hashers[5].GetChannelsHash());
            }
        }

        /// <summary>
        /// Adjustments the layers content hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void AdjustmentLayersContentHashTest(string fileName)
        {
            using (var im = (PsdImage) Image.Load(fileName))
            {
                var adjustments = new Layer[]
                {
                    GetLayerByName<Layer>(im, "Brightness/Contrast 1"),
                    GetLayerByName<Layer>(im, "Levels 1"),
                    GetLayerByName<Layer>(im, "Curves 1"),
                    GetLayerByName<Layer>(im, "Exposure 1"),
                    GetLayerByName<Layer>(im, "Vibrance 1"),
                    GetLayerByName<Layer>(im, "Hue/Saturation 1"),
                    GetLayerByName<Layer>(im, "Color Balance 1"),
                    GetLayerByName<Layer>(im, "Black & White 1"),
                    GetLayerByName<Layer>(im, "Photo Filter 1"),
                    GetLayerByName<Layer>(im, "Channel Mixer 1"),
                    GetLayerByName<Layer>(im, "Invert 1"),
                    GetLayerByName<Layer>(im, "Posterize 1"),
                };

                var length = adjustments.Length;
                var hashers = new LayerHashCalculator[length];

                for (int i = 0; i < length; i++)
                {
                    hashers[i] = new LayerHashCalculator(adjustments[i]);
                }

                // All hashes must be different
                for (int i = 0; i < length; i++)
                {
                    for (int j = i + 1; j < length; j++)
                    {
                        AreNotEqual(hashers[i].GetContentHash(), hashers[j].GetContentHash());
                        AreEqual(hashers[i].GetBlendingHash(), hashers[j].GetBlendingHash());
                    }
                }
            }
        }

        /// <summary>
        /// Texts the layers content hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void TextLayersContentHashTest(string fileName)
        {
            using (var im = (PsdImage) Image.Load(fileName))
            {
                var textLayers1 = new TextLayer[]
                {
                    GetLayerByName<TextLayer>(im, "Text 1"),
                    GetLayerByName<TextLayer>(im, "Text 1 Similar"),
                    GetLayerByName<TextLayer>(im, "Text 1 Changed"),
                };

                var textLayers2 = new TextLayer[]
                {
                    GetLayerByName<TextLayer>(im, "Text 2"),
                    GetLayerByName<TextLayer>(im, "Text 2 Similar"),
                    GetLayerByName<TextLayer>(im, "Text 2 Changed 1"),
                    GetLayerByName<TextLayer>(im, "Text 2 Changed 2"),
                    GetLayerByName<TextLayer>(im, "Text 2 Rotated"),
                };

                var textHashers1 = new LayerHashCalculator[textLayers1.Length];
                var textHashers2 = new LayerHashCalculator[textLayers2.Length];

                for (int i = 0; i < textLayers1.Length; i++)
                {
                    textHashers1[i] = new LayerHashCalculator(textLayers1[i]);
                }

                for (int i = 0; i < textLayers2.Length; i++)
                {
                    textHashers2[i] = new LayerHashCalculator(textLayers2[i]);
                }

                AreEqual(textHashers1[0].GetContentHash(), textHashers1[1].GetContentHash());
                AreNotEqual(textHashers1[0].GetContentHash(), textHashers1[2].GetContentHash());

                AreEqual(textHashers2[0].GetContentHash(), textHashers2[1].GetContentHash());

                AreNotEqual(textHashers2[0].GetContentHash(), textHashers2[2].GetContentHash());
                AreNotEqual(textHashers2[0].GetContentHash(), textHashers2[3].GetContentHash());

                // Transformation matrix is not used in hash calculation. You should additionaly check it
                AreEqual(textHashers2[0].GetContentHash(), textHashers2[4].GetContentHash());

                // In this case we have a rotation in matrix
                AreNotEqual(textLayers2[0].TransformMatrix, textLayers2[4].TransformMatrix);
                // In this case we have only translation (Text Layer Shifted below)
                AreNotEqual(textLayers2[0].TransformMatrix, textLayers2[1].TransformMatrix);
            }
        }

        /// <summary>
        /// Groups the layer content hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void GroupLayerContentHashTest(string fileName)
        {
            using (var im = (PsdImage) Image.Load(fileName))
            {
                var fillLayersNames = new string[] { "Color Fill", "Gradient Fill", "Pattern Fill" };

                var groupLayers = new Layer[2];
                var groupLayersHashers = new LayerHashCalculator[2];

                groupLayers[0] = GetLayerByName<Layer>(im, "Fill");
                groupLayers[1] = GetLayerByName<Layer>(im, "Fill copy");

                for (int i = 0; i < groupLayers.Length; i++)
                {
                    groupLayersHashers[i] = new LayerHashCalculator(groupLayers[i]);
                }

                // Group Layer Hash is calculated from layerss inside it
                AreEqual(groupLayersHashers[0].GetContentHash(), groupLayersHashers[1].GetContentHash());
                AreNotEqual(groupLayers[0], groupLayers[1]);
            }
        }

        /// <summary>
        /// Regulars the layer content from different files hash test.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        public static void RegularLayerContentFromDifferentFilesHashTest(string fileName, string outputFile)
        {
            using (var im = (PsdImage) Image.Load(fileName, new PsdLoadOptions() { ReadOnlyMode = true }))
            {
                im.Save(outputFile);
            }

            using (var im = (PsdImage) Image.Load(fileName))
            {
                using (var imCopied = (PsdImage) Image.Load(outputFile))
                {
                    for (int i = 0; i < im.Layers.Length; i++)
                    {
                        var layer = im.Layers[i];
                        var layer_copied = imCopied.Layers[i];
                        var hashCalc = new LayerHashCalculator(layer);
                        var hashCalc_copied = new LayerHashCalculator(layer_copied);

                        // Layers have different pointers
                        AreNotEqual(layer, layer_copied);

                        // But hash of layers are equal
                        AreEqual(hashCalc.GetChannelsHash(), hashCalc_copied.GetChannelsHash());
                        AreEqual(hashCalc.GetContentHash(), hashCalc_copied.GetContentHash());
                    }
                }
            }
            
            File.Delete(outputFile);
        }
        
        //ExEnd:GettingUniqueHashForSimilarLayers
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/GettingUniqueHashForSimilarLayers.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/LayerGroupIsOpenSupport.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    class LayerGroupIsOpenSupport
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:LayerGroupIsOpenSupport
            //ExSummary:The following code shows how to open and close LayerGroup (Folder) using the IsOpen property.

            // Example of reading and writing IsOpen property at runtime.
            string sourceFileName = Path.Combine(baseDir, "LayerGroupOpenClose.psd");
            string outputFileName = Path.Combine(outputDir, "OutputLayerGroupOpenClose.psd");

            using (var image = (PsdImage) Image.Load(sourceFileName))
            {
                foreach (var layer in image.Layers)
                {
                    if (layer is LayerGroup && layer.Name == "Group 1")
                    {
                        bool isOpenedGroup1 = ((LayerGroup) layer).IsOpen;
                        ((LayerGroup) layer).IsOpen = !isOpenedGroup1;
                    }

                    if (layer is LayerGroup && layer.Name == "Group 2")
                    {
                        bool isOpenedGroup2 = ((LayerGroup) layer).IsOpen;
                        ((LayerGroup) layer).IsOpen = !isOpenedGroup2;
                    }
                }

                image.Save(outputFileName);
            }
            
            //ExEnd:LayerGroupIsOpenSupport

            File.Delete(outputFileName);
            
            Console.WriteLine("LayerGroupIsOpenSupport executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/LayerGroupIsOpenSupport.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/SupportEditingGlobalFontList.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    internal class SupportEditingGlobalFontList
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportEditingGlobalFontList
            //ExSummary:The following code demonstrates the ability to programmatically limit fonts using.

            string srcFile = Path.Combine(SourceDir, "fonts_com_updated.psd");
            string output = Path.Combine(OutputDir, "etalon_fonts_com_updated.psd.png");

            try
            {
                var fontList = new string[] { "Courier New", "Webdings", "Bookman Old Style" };
                FontSettings.SetAllowedFonts(fontList);

                var myriadReplacement = new string[] { "Courier New", "Webdings", "Bookman Old Style" };
                var calibriReplacement = new string[] { "Webdings", "Courier New", "Bookman Old Style" };
                var arialReplacement = new string[] { "Bookman Old Style", "Courier New", "Webdings" };
                var timesReplacement = new string[] { "Arial", "NotExistedFont", "Courier New" };

                FontSettings.SetFontReplacements("MyriadPro-Regular", myriadReplacement);
                FontSettings.SetFontReplacements("Calibri", calibriReplacement);
                FontSettings.SetFontReplacements("Arial", arialReplacement);
                FontSettings.SetFontReplacements("Times New Roman", timesReplacement);

                using (PsdImage image = (PsdImage)Image.Load(srcFile,
                    new PsdLoadOptions() { AllowNonChangedLayerRepaint = true }))
                {
                    image.Save(output, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }
            finally
            {
                FontSettings.SetAllowedFonts(null);
                FontSettings.ClearFontReplacements();
            }

            //ExEnd:SupportEditingGlobalFontList

            Console.WriteLine("SupportEditingGlobalFontList executed successfully");

            File.Delete(output);
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/SupportEditingGlobalFontList.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfApplyLayerMask.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageLoadOptions;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    public class SupportOfApplyLayerMask
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfApplyLayerMask
            //ExSummary:The following code demonstrates the feature to apply mask to the layer.

            var sourceFile = Path.Combine(baseDir, "1870_example.psd");
            var outFile =  Path.Combine(outputDir, "export.png");

            using (var psdImage = (PsdImage)Image.Load(sourceFile, new PsdLoadOptions()))
            {
                psdImage.Layers[1].ApplyLayerMask();

                psdImage.Save(outFile, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd:SupportOfApplyLayerMask

            File.Delete(outFile);

            Console.WriteLine("SupportOfApplyLayerMask executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfApplyLayerMask.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfArtboardLayer.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    public class SupportOfArtboardLayer
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfArtboardLayer
            //ExSummary:The following code demonstrates the support of export ArtboardLayer as separate images and all in one image.
            
            string srcFile = Path.Combine(baseDir, "artboard2.psd");

            string outFilePng0 = Path.Combine(outputDir, "art0.png");
            string outFilePng1 = Path.Combine(outputDir, "art1.png");
            string outFilePng2 = Path.Combine(outputDir, "art2.png");
            string outFilePng3 = Path.Combine(outputDir, "art3.png");

            using (var psdImage = (PsdImage)Image.Load(srcFile))
            {
                ArtboardLayer art1 = (ArtboardLayer)psdImage.Layers[4];
                ArtboardLayer art2 = (ArtboardLayer)psdImage.Layers[9];
                ArtboardLayer art3 = (ArtboardLayer)psdImage.Layers[14];

                var pngSaveOptions = new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha };
                art1.Save(outFilePng1, pngSaveOptions);
                art2.Save(outFilePng2, pngSaveOptions);
                art3.Save(outFilePng3, pngSaveOptions);

                psdImage.Save(outFilePng0, pngSaveOptions);
            }
            
            //ExEnd:SupportOfArtboardLayer

            Console.WriteLine("SupportOfArtboardLayer executed successfully");
            
            File.Delete(outFilePng0);
            File.Delete(outFilePng1);
            File.Delete(outFilePng2);
            File.Delete(outFilePng3);
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfArtboardLayer.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfPassThroughBlendingMode.cs ---
﻿using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.ImageOptions;
using System;
using Aspose.PSD.FileFormats.Core.Blending;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    class SupportOfPassThroughBlendingMode
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfPassThroughBlendingMode
            //ExSummary:The following example demonstrates how you can use the PassThrough layer blend mode in Aspose.PSD
            string sourceFileName = baseDir + "Apple.psd";
            string outputFileName = outputDir + "OutputApple";
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                if (image.Layers.Length < 23)
                {
                    throw new Exception("There is not 23rd layer.");
                }

                var layer = image.Layers[23] as LayerGroup;

                if (layer == null)
                {
                    throw new Exception("The 23rd layer is not a layer group.");
                }

                if (layer.Name != "AdjustmentGroup")
                {
                    throw new Exception("The 23rd layer name is not 'AdjustmentGroup'.");
                }

                if (layer.BlendModeKey != BlendMode.PassThrough)
                {
                    throw new Exception("AdjustmentGroup layer should have 'pass through' blend mode.");
                }

                image.Save(outputFileName + ".psd", new PsdOptions(image));
                image.Save(outputFileName + ".png", new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });

                layer.BlendModeKey = BlendMode.Normal;

                image.Save(outputFileName + "Normal.psd", new PsdOptions(image));
                image.Save(outputFileName + "Normal.png", new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            //ExEnd:SupportOfPassThroughBlendingMode

            Console.WriteLine("SupportOfPassThroughBlendingMode executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfPassThroughBlendingMode.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfSectionDividerLayer.cs ---
﻿using System;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    class SupportOfSectionDividerLayer
    {
        public static void Run()
        {
            //ExStart:SupportOfSectionDividerLayer

            // The following code demonstrates SectionDividerLayer layers and how to get the related to it LayerGroup.

            // Layers hierarchy
            //    [0]: '</Layer group>' SectionDividerLayer for Group 1
            //    [1]: 'Layer 1' Regular Layer
            //    [2]: '</Layer group>' SectionDividerLayer for Group 2
            //    [3]: '</Layer group>' SectionDividerLayer for Group 3
            //    [4]: 'Group 3' GroupLayer
            //    [5]: 'Group 2' GroupLayer
            //    [6]: 'Group 1' GroupLayer

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            using (var image = new PsdImage(100, 100))
            {
                // Creating layers hierarchy
                // Add the LayerGroup 'Group 1'
                LayerGroup group1 = image.AddLayerGroup("Group 1", 0, true);
                // Add regular layer
                Layer layer1 = new Layer();
                layer1.DisplayName = "Layer 1";
                group1.AddLayer(layer1);
                // Add the LayerGroup 'Group 2'
                LayerGroup group2 = group1.AddLayerGroup("Group 2", 1);
                // Add the LayerGroup 'Group 3'
                LayerGroup group3 = group2.AddLayerGroup("Group 3", 0);

                // Gets the SectionDividerLayer's
                SectionDividerLayer divider1 = (SectionDividerLayer)image.Layers[0];
                SectionDividerLayer divider2 = (SectionDividerLayer)image.Layers[2];
                SectionDividerLayer divider3 = (SectionDividerLayer)image.Layers[3];

                // using the SectionDividerLayer.GetRelatedLayerGroup() method, obtains the related LayerGroup instance.
                AssertAreEqual(group1.DisplayName, divider1.GetRelatedLayerGroup().DisplayName); // the same LayerGroup
                AssertAreEqual(group2.DisplayName, divider2.GetRelatedLayerGroup().DisplayName); // the same LayerGroup
                AssertAreEqual(group3.DisplayName, divider3.GetRelatedLayerGroup().DisplayName); // the same LayerGroup

                LayerGroup folder1 = divider1.GetRelatedLayerGroup();
                AssertAreEqual(5, folder1.Layers.Length); // 'Group 1' contains 5 layers
            }

            //ExEnd:SupportOfSectionDividerLayer

            Console.WriteLine("SupportOfSectionDividerLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/SupportOfSectionDividerLayer.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithPSD/UpdatingCreatorToolInPSDFile.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Xmp;

namespace Aspose.PSD.Examples.Aspose.WorkingWithPSD
{
    public class UpdatingCreatorToolInPSDFile
    {
        public static void Run()
        {
            // The path to the documents directory.
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:UpdatingCreatorToolInPSDFile
            //ExSummary:The following code demonstrates the using UpdateMetadata option to update CreatorTool value in xmp data.
            
            string path = Path.Combine(outputDir, "output.psd");
            
            using (var image = new PsdImage(100, 100))
            {
                // If you want the creator tool to change, make sure that the "UpdateMetadata" property is set to true. It's set to true by default.
                var psdOptions = new PsdOptions();
                psdOptions.UpdateMetadata = true;

                // Saving the image. 
                image.Save(path, psdOptions);

                // Checking creator tool in code.
                var xmpData = image.XmpData;
                var basicPackage = image.XmpData.GetPackage(Namespaces.XmpBasic);

                // Here will be updated creator tool info.
                var currentCreatorTool = (string)basicPackage[":CreatorTool"];
            }
            
            //ExEnd:UpdatingCreatorToolInPSDFile

            File.Delete(path);
            
            Console.WriteLine("UpdatingCreatorToolInPSDFile executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithPSD/UpdatingCreatorToolInPSDFile.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/AddShapeLayer.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerEffects;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.StrokeResources;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    public class AddShapeLayer
    {
        public static void Run()
        {
            // The path to the document's directory.
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:AddShapeLayer
            //ExSummary:The following code demonstrates how to add ShapeLayer.

            string outputFile = Path.Combine(outputDir, "AddShapeLayer_output.psd");

            const int ImgToPsdRatio = 256 * 65535;

            using (PsdImage newPsd = new PsdImage(600, 400))
            {
                ShapeLayer layer = newPsd.AddShapeLayer();

                var newShape = GenerateNewShape(newPsd.Size);
                List<IPathShape> newShapes = new List<IPathShape>();
                newShapes.Add(newShape);
                layer.Path.SetItems(newShapes.ToArray());

                layer.Update();

                newPsd.Save(outputFile);
            }

            using (PsdImage image = (PsdImage)Image.Load(outputFile))
            {
                AssertAreEqual(2, image.Layers.Length);

                ShapeLayer shapeLayer = image.Layers[1] as ShapeLayer;
                ColorFillSettings internalFill = shapeLayer.Fill as ColorFillSettings;
                IStrokeSettings strokeSettings = shapeLayer.Stroke;
                ColorFillSettings strokeFill = shapeLayer.Stroke.Fill as ColorFillSettings;

                AssertAreEqual(1, shapeLayer.Path.GetItems().Length); // 1 Shape
                AssertAreEqual(3, shapeLayer.Path.GetItems()[0].GetItems().Length); // 3 knots in a shape

                AssertAreEqual(-16127182, internalFill.Color.ToArgb()); // ff09eb32

                AssertAreEqual(7.41, strokeSettings.Size);
                AssertAreEqual(false, strokeSettings.Enabled);
                AssertAreEqual(StrokePosition.Center, strokeSettings.LineAlignment);
                AssertAreEqual(LineCapType.ButtCap, strokeSettings.LineCap);
                AssertAreEqual(LineJoinType.MiterJoin, strokeSettings.LineJoin);
                AssertAreEqual(-16777216, strokeFill.Color.ToArgb()); // ff000000
            }

            PathShape GenerateNewShape(Size imageSize)
            {
                var newShape = new PathShape();

                PointF point1 = new PointF(20, 100);
                PointF point2 = new PointF(200, 100);
                PointF point3 = new PointF(300, 10);

                BezierKnotRecord[] bezierKnots = new BezierKnotRecord[]
                {
                     new BezierKnotRecord()
                     {
                         IsLinked = true,
                         Points = new Point[3]
                                  {
                                      PointFToResourcePoint(point1, imageSize),
                                      PointFToResourcePoint(point1, imageSize),
                                      PointFToResourcePoint(point1, imageSize),
                                  }
                     },
                     new BezierKnotRecord()
                     {
                         IsLinked = true,
                         Points = new Point[3]
                                  {
                                      PointFToResourcePoint(point2, imageSize),
                                      PointFToResourcePoint(point2, imageSize),
                                      PointFToResourcePoint(point2, imageSize),
                                  }
                     },
                     new BezierKnotRecord()
                     {
                         IsLinked = true,
                         Points = new Point[3]
                                  {
                                      PointFToResourcePoint(point3, imageSize),
                                      PointFToResourcePoint(point3, imageSize),
                                      PointFToResourcePoint(point3, imageSize),
                                  }
                     },
                };

                newShape.SetItems(bezierKnots);

                return newShape;
            }

            Point PointFToResourcePoint(PointF point, Size imageSize)
            {
                return new Point(
                    (int)Math.Round(point.Y * (ImgToPsdRatio / imageSize.Height)),
                    (int)Math.Round(point.X * (ImgToPsdRatio / imageSize.Width)));
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }
            
            //ExEnd:AddShapeLayer

            File.Delete(outputFile);

            Console.WriteLine("AddShapeLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/AddShapeLayer.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/ClassesToManipulateVectorPathObjects.cs ---
﻿using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillLayers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageOptions;
using Aspose.PSD.Sources;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    class ClassesToManipulateVectorPathObjects
    {
        public static void Run()
        {
            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            string outputPsd = Path.Combine(OutputDir, "out_CreatingVectorPathExampleTest.psd");

            CreatingVectorPathExample(outputPsd);

            Console.WriteLine("ClassesToManipulateVectorPathObjects executed successfully");

            File.Delete(outputPsd);
        }

        //ExStart:ClassesToManipulateVectorPathObjects
        //ExSummary:The following code example provides classes to manipulate the vector path objects and demonstrates how to use those classes.

        private static void CreatingVectorPathExample(string outputPsd = "outputPsd.psd")
        {
            using (var psdImage = (PsdImage)Image.Create(new PsdOptions() { Source = new StreamSource(new MemoryStream()), }, 500, 500))
            {
                FillLayer layer = FillLayer.CreateInstance(FillType.Color);
                psdImage.AddLayer(layer);

                VectorPath vectorPath = VectorDataProvider.CreateVectorPathForLayer(layer);
                vectorPath.FillColor = Color.IndianRed;
                PathShape shape = new PathShape();
                shape.Points.Add(new BezierKnot(new PointF(50, 150), true));
                shape.Points.Add(new BezierKnot(new PointF(100, 200), true));
                shape.Points.Add(new BezierKnot(new PointF(0, 200), true));
                vectorPath.Shapes.Add(shape);
                VectorDataProvider.UpdateLayerFromVectorPath(layer, vectorPath, true);

                psdImage.Save(outputPsd);
            }
        }

        #region Vector path editor (Here placed classes for edit vector paths).

        /// <summary>
        /// The class that provides work between <see cref="Layer"/> and <see cref="VectorPath"/>.
        /// </summary>
        public static class VectorDataProvider
        {
            /// <summary>
            /// Creates the <see cref="VectorPath"/> instance based on resources from input layer.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            /// <returns>the <see cref="VectorPath"/> instance based on resources from input layer.</returns>
            public static VectorPath CreateVectorPathForLayer(Layer psdLayer)
            {
                ValidateLayer(psdLayer);

                Size imageSize = psdLayer.Container.Size;

                VectorPathDataResource pathResource = FindVectorPathDataResource(psdLayer, true);
                SoCoResource socoResource = FindSoCoResource(psdLayer, true);
                VectorPath vectorPath = new VectorPath(pathResource, imageSize);
                if (socoResource != null)
                {
                    vectorPath.FillColor = socoResource.Color;
                }

                return vectorPath;
            }

            /// <summary>
            /// Updates the input layer resources from <see cref="VectorPath"/> instance, or replace by new path resource and updates.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            /// <param name="vectorPath">The vector path.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            public static void UpdateLayerFromVectorPath(Layer psdLayer, VectorPath vectorPath, bool createIfNotExist = false)
            {
                ValidateLayer(psdLayer);

                VectorPathDataResource pathResource = FindVectorPathDataResource(psdLayer, createIfNotExist);
                VogkResource vogkResource = FindVogkResource(psdLayer, createIfNotExist);
                SoCoResource socoResource = FindSoCoResource(psdLayer, createIfNotExist);

                Size imageSize = psdLayer.Container.Size;
                UpdateResources(pathResource, vogkResource, socoResource, vectorPath, imageSize);

                ReplaceVectorPathDataResourceInLayer(psdLayer, pathResource, vogkResource, socoResource);
            }

            /// <summary>
            /// Removes the vector path data from input layer.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            public static void RemoveVectorPathDataFromLayer(Layer psdLayer)
            {
                List<LayerResource> oldResources = new List<LayerResource>(psdLayer.Resources);
                List<LayerResource> newResources = new List<LayerResource>();
                for (int i = 0; i < oldResources.Count; i++)
                {
                    LayerResource resource = oldResources[i];

                    if (resource is VectorPathDataResource || resource is VogkResource || resource is SoCoResource)
                    {
                        continue;
                    }
                    else
                    {
                        newResources.Add(resource);
                    }
                }

                psdLayer.Resources = newResources.ToArray();
            }

            /// <summary>
            /// Updates resources data from <see cref="VectorPath"/> instance.
            /// </summary>
            /// <param name="pathResource">The path resource.</param>
            /// <param name="vogkResource">The vector origination data resource.</param>
            /// <param name="socoResource">The solid color resource.</param>
            /// <param name="vectorPath">The vector path.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            private static void UpdateResources(VectorPathDataResource pathResource, VogkResource vogkResource, SoCoResource socoResource, VectorPath vectorPath, Size imageSize)
            {
                pathResource.Version = vectorPath.Version;
                pathResource.IsNotLinked = vectorPath.IsNotLinked;
                pathResource.IsDisabled = vectorPath.IsDisabled;
                pathResource.IsInverted = vectorPath.IsInverted;

                List<VectorShapeOriginSettings> originSettings = new List<VectorShapeOriginSettings>();
                List<VectorPathRecord> path = new List<VectorPathRecord>();
                path.Add(new PathFillRuleRecord(null));
                path.Add(new InitialFillRuleRecord(vectorPath.IsFillStartsWithAllPixels));
                for (ushort i = 0; i < vectorPath.Shapes.Count; i++)
                {
                    PathShape shape = vectorPath.Shapes[i];
                    shape.ShapeIndex = i;
                    path.AddRange(shape.ToVectorPathRecords(imageSize));
                    originSettings.Add(new VectorShapeOriginSettings() { IsShapeInvalidated = true, OriginIndex = i });
                }

                pathResource.Paths = path.ToArray();
                vogkResource.ShapeOriginSettings = originSettings.ToArray();

                socoResource.Color = vectorPath.FillColor;
            }

            /// <summary>
            /// Replaces resources in layer by updated or new ones.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            /// <param name="pathResource">The path resource.</param>
            /// <param name="vogkResource">The vector origination data resource.</param>
            /// <param name="socoResource">The solid color resource.</param>
            private static void ReplaceVectorPathDataResourceInLayer(Layer psdLayer, VectorPathDataResource pathResource, VogkResource vogkResource, SoCoResource socoResource)
            {
                bool pathResourceExist = false;
                bool vogkResourceExist = false;
                bool socoResourceExist = false;

                List<LayerResource> resources = new List<LayerResource>(psdLayer.Resources);
                for (int i = 0; i < resources.Count; i++)
                {
                    LayerResource resource = resources[i];
                    if (resource is VectorPathDataResource)
                    {
                        resources[i] = pathResource;
                        pathResourceExist = true;
                    }
                    else if (resource is VogkResource)
                    {
                        resources[i] = vogkResource;
                        vogkResourceExist = true;
                    }
                    else if (resource is SoCoResource)
                    {
                        resources[i] = socoResource;
                        socoResourceExist = true;
                    }
                }

                if (!pathResourceExist)
                {
                    resources.Add(pathResource);
                }

                if (!vogkResourceExist)
                {
                    resources.Add(vogkResource);
                }

                if (!socoResourceExist)
                {
                    resources.Add(socoResource);
                }

                psdLayer.Resources = resources.ToArray();
            }

            /// <summary>
            /// Finds the <see cref="VectorPathDataResource"/> resource in input layer resources.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            /// <param name="createIfNotExist">If resource not exists, then for <see cref="true"/> creates a new resource, otherwise return <see cref="null"/>.</param>
            /// <returns>The <see cref="VectorPathDataResource"/> resource.</returns>
            private static VectorPathDataResource FindVectorPathDataResource(Layer psdLayer, bool createIfNotExist = false)
            {
                VectorPathDataResource pathResource = null;
                foreach (var resource in psdLayer.Resources)
                {
                    if (resource is VectorPathDataResource)
                    {
                        pathResource = (VectorPathDataResource)resource;
                        break;
                    }
                }

                if (createIfNotExist && pathResource == null)
                {
                    pathResource = new VmskResource();
                }

                return pathResource;
            }

            /// <summary>
            /// Finds the <see cref="VogkResource"/> resource in input layer resources.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            /// <param name="createIfNotExist">If resource not exists, then for <see cref="true"/> creates a new resource, otherwise return <see cref="null"/>.</param>
            /// <returns>The <see cref="VogkResource"/> resource.</returns>
            private static VogkResource FindVogkResource(Layer psdLayer, bool createIfNotExist = false)
            {
                VogkResource vogkResource = null;
                foreach (var resource in psdLayer.Resources)
                {
                    if (resource is VogkResource)
                    {
                        vogkResource = (VogkResource)resource;
                        break;
                    }
                }

                if (createIfNotExist && vogkResource == null)
                {
                    vogkResource = new VogkResource();
                }

                return vogkResource;
            }

            /// <summary>
            /// Finds the <see cref="SoCoResource"/> resource in input layer resources.
            /// </summary>
            /// <param name="psdLayer">The psd layer.</param>
            /// <param name="createIfNotExist">If resource not exists, then for <see cref="true"/> creates a new resource, otherwise return <see cref="null"/>.</param>
            /// <returns>The <see cref="SoCoResource"/> resource.</returns>
            private static SoCoResource FindSoCoResource(Layer psdLayer, bool createIfNotExist = false)
            {
                SoCoResource socoResource = null;
                foreach (var resource in psdLayer.Resources)
                {
                    if (resource is SoCoResource)
                    {
                        socoResource = (SoCoResource)resource;
                        break;
                    }
                }

                if (createIfNotExist && socoResource == null)
                {
                    socoResource = new SoCoResource();
                }

                return socoResource;
            }

            /// <summary>
            /// Validates the layer to work with <see cref="VectorDataProvider"/> class.
            /// </summary>
            /// <param name="layer"></param>
            /// <exception cref="ArgumentNullException"></exception>
            private static void ValidateLayer(Layer layer)
            {
                if (layer == null)
                {
                    throw new ArgumentNullException("The layer is NULL.");
                }

                if (layer.Container == null || layer.Container.Size.IsEmpty)
                {
                    throw new ArgumentNullException("The layer should have a Container with no empty size.");
                }
            }
        }

        /// <summary>
        /// The Bezier curve knot, it contains one anchor point and two control points.
        /// </summary>
        public class BezierKnot
        {
            /// <summary>
            /// Image to path point ratio.
            /// </summary>
            private const int ImgToPsdRatio = 256 * 65535;

            /// <summary>
            /// Initializes a new instance of the <see cref="BezierKnot" /> class.
            /// </summary>
            /// <param name="anchorPoint">The anchor point.</param>
            /// <param name="controlPoint1">The first control point.</param>
            /// <param name="controlPoint2">THe second control point.</param>
            /// <param name="isLinked">The value indicating whether this knot is linked.</param>
            public BezierKnot(PointF anchorPoint, PointF controlPoint1, PointF controlPoint2, bool isLinked)
            {
                this.AnchorPoint = anchorPoint;
                this.ControlPoint1 = controlPoint1;
                this.ControlPoint2 = controlPoint2;
                this.IsLinked = isLinked;
            }

            /// <summary>
            /// Initializes a new instance of the <see cref="BezierKnot" /> class based on <see cref="BezierKnotRecord"/>.
            /// </summary>
            /// <param name="bezierKnotRecord">The <see cref="BezierKnotRecord"/>.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            public BezierKnot(BezierKnotRecord bezierKnotRecord, Size imageSize)
            {
                this.IsLinked = bezierKnotRecord.IsLinked;
                this.ControlPoint1 = ResourcePointToPointF(bezierKnotRecord.Points[0], imageSize);
                this.AnchorPoint = ResourcePointToPointF(bezierKnotRecord.Points[1], imageSize);
                this.ControlPoint2 = ResourcePointToPointF(bezierKnotRecord.Points[2], imageSize);
            }

            /// <summary>
            /// Initializes a new instance of the <see cref="BezierKnot" /> class.
            /// </summary>
            /// <param name="anchorPoint">The point to be anchor and control points.</param>
            /// <param name="isLinked">The value indicating whether this knot is linked.</param>
            public BezierKnot(PointF anchorPoint, bool isLinked)
            : this(anchorPoint, anchorPoint, anchorPoint, isLinked)
            {
            }

            /// <summary>
            /// Gets or sets a value indicating whether this instance is linked.
            /// </summary>
            public bool IsLinked { get; set; }

            /// <summary>
            /// Gets or sets the first control point.
            /// </summary>
            public PointF ControlPoint1 { get; set; }

            /// <summary>
            /// Gets or sets the anchor point.
            /// </summary>
            public PointF AnchorPoint { get; set; }

            /// <summary>
            /// Gets or sets the second control point.
            /// </summary>
            public PointF ControlPoint2 { get; set; }

            /// <summary>
            /// Creates the instance of <see cref="BezierKnotRecord"/> based on this instance.
            /// </summary>
            /// <param name="isClosed">Indicating whether this knot is in closed shape.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            /// <returns>The instance of <see cref="BezierKnotRecord"/> based on this instance.</returns>
            public BezierKnotRecord ToBezierKnotRecord(bool isClosed, Size imageSize)
            {
                BezierKnotRecord record = new BezierKnotRecord();
                record.Points = new Point[]
                {
                    PointFToResourcePoint(this.ControlPoint1, imageSize),
                    PointFToResourcePoint(this.AnchorPoint, imageSize),
                    PointFToResourcePoint(this.ControlPoint2, imageSize),
                };
                record.IsLinked = this.IsLinked;
                record.IsClosed = isClosed;

                return record;
            }

            /// <summary>
            /// Shifts this knot points by input values.
            /// </summary>
            /// <param name="xOffset">The x offset.</param>
            /// <param name="yOffset">The y offset.</param>
            public void Shift(float xOffset, float yOffset)
            {
                this.ControlPoint1 = new PointF(this.ControlPoint1.X + xOffset, this.ControlPoint1.Y + yOffset);
                this.AnchorPoint = new PointF(this.AnchorPoint.X + xOffset, this.AnchorPoint.Y + yOffset);
                this.ControlPoint2 = new PointF(this.ControlPoint2.X + xOffset, this.ControlPoint2.Y + yOffset);
            }

            /// <summary>
            /// Converts point values from resource to normal.
            /// </summary>
            /// <param name="point">The point with values from resource.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            /// <returns>The converted to normal point.</returns>
            private static PointF ResourcePointToPointF(Point point, Size imageSize)
            {
                return new PointF(point.Y / (ImgToPsdRatio / imageSize.Width), point.X / (ImgToPsdRatio / imageSize.Height));
            }

            /// <summary>
            /// Converts normal point values to resource point.
            /// </summary>
            /// <param name="point">The point.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            /// <returns>The point with values for resource.</returns>
            private static Point PointFToResourcePoint(PointF point, Size imageSize)
            {
                return new Point((int)Math.Round(point.Y * (ImgToPsdRatio / imageSize.Height)), (int)Math.Round(point.X * (ImgToPsdRatio / imageSize.Width)));
            }
        }

        /// <summary>
        /// The figure from the knots of the Bezier curve.
        /// </summary>
        public class PathShape
        {
            /// <summary>
            /// Initializes a new instance of the <see cref="PathShape" /> class.
            /// </summary>
            public PathShape()
            {
                this.Points = new List<BezierKnot>();
                this.PathOperations = PathOperations.CombineShapes;
            }

            /// <summary>
            /// Initializes a new instance of the <see cref="PathShape" /> class based on <see cref="VectorPathRecord"/>'s.
            /// </summary>
            /// <param name="lengthRecord">The length record.</param>
            /// <param name="bezierKnotRecords">The bezier knot records.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            public PathShape(LengthRecord lengthRecord, List<BezierKnotRecord> bezierKnotRecords, Size imageSize)
            : this()
            {
                this.IsClosed = lengthRecord.IsClosed;
                this.PathOperations = lengthRecord.PathOperations;
                this.ShapeIndex = lengthRecord.ShapeIndex;
                this.InitFromResources(bezierKnotRecords, imageSize);
            }

            /// <summary>
            /// Gets or sets a value indicating whether this instance is closed.
            /// </summary>
            /// <value>
            ///   <c>true</c> if this instance is closed; otherwise, <c>false</c>.
            /// </value>
            public bool IsClosed { get; set; }

            /// <summary>
            /// Gets or sets the path operations (Boolean operations).
            /// </summary>
            public PathOperations PathOperations { get; set; }

            /// <summary>
            /// Gets or sets the index of current path shape in layer.
            /// </summary>
            public ushort ShapeIndex { get; set; }

            /// <summary>
            /// Gets the points of the Bezier curve.
            /// </summary>
            public List<BezierKnot> Points { get; private set; }

            /// <summary>
            /// Creates the <see cref="VectorPathRecord"/> records based on this instance.
            /// </summary>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            /// <returns>Returns one <see cref="LengthRecord"/> and <see cref="BezierKnotRecord"/> for each point in this instance.</returns>
            public IEnumerable<VectorPathRecord> ToVectorPathRecords(Size imageSize)
            {
                List<VectorPathRecord> shapeRecords = new List<VectorPathRecord>();

                LengthRecord lengthRecord = new LengthRecord();
                lengthRecord.IsClosed = this.IsClosed;
                lengthRecord.BezierKnotRecordsCount = this.Points.Count;
                lengthRecord.PathOperations = this.PathOperations;
                lengthRecord.ShapeIndex = this.ShapeIndex;
                shapeRecords.Add(lengthRecord);

                foreach (var bezierKnot in this.Points)
                {
                    shapeRecords.Add(bezierKnot.ToBezierKnotRecord(this.IsClosed, imageSize));
                }

                return shapeRecords;
            }

            /// <summary>
            /// Initializes a values based on input records.
            /// </summary>
            /// <param name="bezierKnotRecords">The bezier knot records.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            private void InitFromResources(IEnumerable<BezierKnotRecord> bezierKnotRecords, Size imageSize)
            {
                List<BezierKnot> newPoints = new List<BezierKnot>();

                foreach (var record in bezierKnotRecords)
                {
                    newPoints.Add(new BezierKnot(record, imageSize));
                }

                this.Points = newPoints;
            }
        }

        /// <summary>
        /// The class that contains vector paths.
        /// </summary>
        public class VectorPath
        {
            /// <summary>
            /// Initializes a new instance of the <see cref="VectorPath" /> class based on <see cref="VectorPathDataResource"/>.
            /// </summary>
            /// <param name="vectorPathDataResource">The vector path data resource.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            public VectorPath(VectorPathDataResource vectorPathDataResource, Size imageSize)
            {
                this.InitFromResource(vectorPathDataResource, imageSize);
            }

            /// <summary>
            /// Gets or sets a value indicating whether is fill starts with all pixels.
            /// </summary>
            /// <value>
            /// The is fill starts with all pixels.
            /// </value>
            public bool IsFillStartsWithAllPixels { get; set; }

            /// <summary>
            /// Gets the vector shapes.
            /// </summary>
            public List<PathShape> Shapes { get; private set; }

            /// <summary>
            /// Gets or sets the vector path fill color.
            /// </summary>
            public Color FillColor { get; set; }

            /// <summary>
            /// Gets or sets the version.
            /// </summary>
            /// <value>
            /// The version.
            /// </value>
            public int Version { get; set; }

            /// <summary>
            /// Gets or sets a value indicating whether this instance is disabled.
            /// </summary>
            /// <value>
            ///   <c>true</c> if this instance is disabled; otherwise, <c>false</c>.
            /// </value>
            public bool IsDisabled { get; set; }

            /// <summary>
            /// Gets or sets a value indicating whether this instance is not linked.
            /// </summary>
            /// <value>
            ///   <c>true</c> if this instance is not linked; otherwise, <c>false</c>.
            /// </value>
            public bool IsNotLinked { get; set; }

            /// <summary>
            /// Gets or sets a value indicating whether this instance is inverted.
            /// </summary>
            /// <value>
            ///   <c>true</c> if this instance is inverted; otherwise, <c>false</c>.
            /// </value>
            public bool IsInverted { get; set; }

            /// <summary>
            /// Initializes a values based on input <see cref="VectorPathDataResource"/> resource.
            /// </summary>
            /// <param name="resource">The vector path data resource.</param>
            /// <param name="imageSize">The image size to correct converting point coordinates.</param>
            private void InitFromResource(VectorPathDataResource resource, Size imageSize)
            {
                List<PathShape> newShapes = new List<PathShape>();
                InitialFillRuleRecord initialFillRuleRecord = null;
                LengthRecord lengthRecord = null;
                List<BezierKnotRecord> bezierKnotRecords = new List<BezierKnotRecord>();

                foreach (var pathRecord in resource.Paths)
                {
                    if (pathRecord is LengthRecord)
                    {
                        if (bezierKnotRecords.Count > 0)
                        {
                            newShapes.Add(new PathShape(lengthRecord, bezierKnotRecords, imageSize));
                            lengthRecord = null;
                            bezierKnotRecords.Clear();
                        }

                        lengthRecord = (LengthRecord)pathRecord;
                    }
                    else if (pathRecord is BezierKnotRecord)
                    {
                        bezierKnotRecords.Add((BezierKnotRecord)pathRecord);
                    }
                    else if (pathRecord is InitialFillRuleRecord)
                    {
                        initialFillRuleRecord = (InitialFillRuleRecord)pathRecord;
                    }
                }

                if (bezierKnotRecords.Count > 0)
                {
                    newShapes.Add(new PathShape(lengthRecord, bezierKnotRecords, imageSize));
                    lengthRecord = null;
                    bezierKnotRecords.Clear();
                }

                this.IsFillStartsWithAllPixels = initialFillRuleRecord != null ? initialFillRuleRecord.IsFillStartsWithAllPixels : false;
                this.Shapes = newShapes;

                this.Version = resource.Version;
                this.IsNotLinked = resource.IsNotLinked;
                this.IsDisabled = resource.IsDisabled;
                this.IsInverted = resource.IsInverted;
            }
        }

        #endregion

        //ExEnd:ClassesToManipulateVectorPathObjects
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/ClassesToManipulateVectorPathObjects.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/ResizeLayersWithVectorPaths.cs ---
﻿using System;
using System.IO;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    class ResizeLayersWithVectorPaths
    {
        public static void Run()
        {
            //ExStart:ResizeLayersWithVectorPaths

            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            string sourceFileName = "vectorShapes.psd";
            string outputFileName = "out_vectorShapes.psd";
            string sourcePath = Path.Combine(SourceDir, sourceFileName);
            string outputPath = Path.Combine(OutputDir, outputFileName);
            string outputPathPng = Path.ChangeExtension(outputPath, ".png");
            using (var psdImage = (PsdImage)Image.Load(sourcePath))
            {
                foreach (var layer in psdImage.Layers)
                {
                    layer.Resize(layer.Width * 5 / 4, layer.Height / 2);
                }

                psdImage.Save(outputPath);
                psdImage.Save(outputPathPng, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
            }

            Console.WriteLine("ResizeLayersWithVectorPaths executed successfully");

            //ExEnd:ResizeLayersWithVectorPaths

            File.Delete(outputPath);
            File.Delete(outputPathPng);
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/ResizeLayersWithVectorPaths.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/ResizeLayersWithVogkResourceAndVectorPaths.cs ---
﻿using System;
using System.Globalization;
using System.IO;
using System.Threading;
using Aspose.PSD.FileFormats.Png;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    class ResizeLayersWithVogkResourceAndVectorPaths
    {
        public static void Run()
        {
            //ExStart:ResizeLayersWithVogkResourceAndVectorPaths

            // The path to the documents directory.
            string SourceDir = RunExamples.GetDataDir_PSD();
            string OutputDir = RunExamples.GetDataDir_Output();

            // This example shows how to resize layers with a Vogk and vector path resource in the PSD image
            float scaleX = 0.45f;
            float scaleY = 1.60f;
            string sourceFileName = Path.Combine(SourceDir, "vectorShapes.psd");
            using (PsdImage image = (PsdImage)Image.Load(sourceFileName))
            {
                for (int layerIndex = 1; layerIndex < image.Layers.Length; layerIndex++, scaleX += 0.25f, scaleY -= 0.25f)
                {
                    var layer = image.Layers[layerIndex];
                    var newWidth = (int)Math.Round(layer.Width * scaleX);
                    var newHeight = (int)Math.Round(layer.Height * scaleY);
                    layer.Resize(newWidth, newHeight);

                    Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("en-GB");
                    string outputName = string.Format("resized_{0}_{1}_{2}", layerIndex, scaleX, scaleY);
                    string outputPath = Path.Combine(OutputDir, outputName + ".psd");
                    string outputPngPath = Path.Combine(OutputDir, outputName + ".png");
                    image.Save(outputPath, new PsdOptions(image));
                    image.Save(outputPngPath, new PngOptions() { ColorType = PngColorType.TruecolorWithAlpha });
                }
            }

            Console.WriteLine("ResizeLayersWithVogkResourceAndVectorPaths executed successfully");

            //ExEnd:ResizeLayersWithVogkResourceAndVectorPaths

            string[] outputFiles = Directory.GetFiles(OutputDir, "resized_*", SearchOption.TopDirectoryOnly);
            foreach (var outputFile in outputFiles)
            {
                if (outputFile.EndsWith(".png") || outputFile.EndsWith(".psd"))
                {
                    File.Delete(outputFile);
                }
            }
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/ResizeLayersWithVogkResourceAndVectorPaths.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/ShapeLayerManipulation.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    public class ShapeLayerManipulation
    {
        public static void Run()
        {
            // The path to the document's directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:ShapeLayerManipulation
            //ExSummary:The following code demonstrates how to add ShapeLayer.

            string sourceFileName = Path.Combine(baseDir, "ShapeLayerTest.psd");
            string updatedOutput = Path.Combine(outputDir, "ShapeLayerTest_Res_up.psd");

            using (PsdImage im = (PsdImage)Image.Load(sourceFileName))
            {
                foreach (var layer in im.Layers)
                {
                    // Finding Shape Layer
                    if (layer is ShapeLayer shapeLayer)
                    {
                        var path = shapeLayer.Path;
                        IPathShape[] pathShapes = path.GetItems();
                        List<BezierKnotRecord> knotsList = new List<BezierKnotRecord>();
                        foreach (var pathShape in pathShapes)
                        {
                            var knots = pathShape.GetItems();
                            knotsList.AddRange(knots);
                        }

                        // Change Path Shape properties
                        PathShape newShape = new PathShape();

                        BezierKnotRecord bn1 = new BezierKnotRecord
                        {
                            IsLinked = true,
                            Points = new Point[]
                            {
                                PointFToResourcePoint(new PointF(20, 100), shapeLayer.Container.Size),
                                PointFToResourcePoint(new PointF(20, 100), shapeLayer.Container.Size),
                                PointFToResourcePoint(new PointF(20, 100), shapeLayer.Container.Size)
                            }
                        };

                        BezierKnotRecord bn2 = new BezierKnotRecord
                        {
                            IsLinked = true,
                            Points = new Point[]
                            {
                                PointFToResourcePoint(new PointF(20, 490), shapeLayer.Container.Size),
                                PointFToResourcePoint(new PointF(20, 490), shapeLayer.Container.Size),
                                PointFToResourcePoint(new PointF(20, 490), shapeLayer.Container.Size)
                            }
                        };

                        BezierKnotRecord bn3 = new BezierKnotRecord
                        {
                            IsLinked = true,
                            Points = new Point[]
                            {
                                PointFToResourcePoint(new PointF(490, 20), shapeLayer.Container.Size),
                                PointFToResourcePoint(new PointF(490, 20), shapeLayer.Container.Size),
                                PointFToResourcePoint(new PointF(490, 20), shapeLayer.Container.Size)
                            }
                        };

                        List<BezierKnotRecord> bezierKnots = new List<BezierKnotRecord> { bn1, bn2, bn3 };
                        newShape.SetItems(bezierKnots.ToArray());

                        List<IPathShape> newShapes = new List<IPathShape>(pathShapes)
                        {
                            newShape
                        };

                        path.SetItems(newShapes.ToArray());

                        shapeLayer.Update();

                        im.Save(updatedOutput);

                        break;
                    }
                }
            }

            Point PointFToResourcePoint(PointF point, Size imageSize)
            {
                const int ImgToPsdRatio = 256 * 65535;
                return new Point((int)(point.Y * (ImgToPsdRatio / imageSize.Height)),
                    (int)(point.X * (ImgToPsdRatio / imageSize.Width)));
            }

            //ExEnd:ShapeLayerManipulation

            File.Delete(updatedOutput);

            Console.WriteLine("ShapeLayerManipulation executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/ShapeLayerManipulation.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportIPathToManipulateVectorPathObjects.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Core.VectorPaths;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    public class SupportIPathToManipulateVectorPathObjects
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportIPathToManipulateVectorPathObjects
            //ExSummary:The following code demonstrates path objects from vsms or vmsk resources for ShapeLayer.

            string srcFile = Path.Combine(baseDir, "ShapeLayerTest.psd");
            string outFile = Path.Combine(outputDir, "ShapeLayerTest-out.psd");

            using (PsdImage image = (PsdImage)Image.Load(srcFile, new PsdLoadOptions { LoadEffectsResource = true }))
            {
                Layer shapeLayer = image.Layers[1];
                VectorPathDataResource vectorPathDataResource = (VectorPathDataResource)shapeLayer.Resources[1];

                bool isFillStartsWithAllPixels;
                List<IPathShape> shapes = GetShapesFromResource(vectorPathDataResource, out isFillStartsWithAllPixels);

                // Remove one shape
                shapes.RemoveAt(1);

                // Save changed data to resource
                List<VectorPathRecord> path = new List<VectorPathRecord>();
                path.Add(new PathFillRuleRecord(null));
                path.Add(new InitialFillRuleRecord(isFillStartsWithAllPixels));

                for (ushort i = 0; i < shapes.Count; i++)
                {
                    PathShape shape = (PathShape)shapes[i];
                    shape.ShapeIndex = i;
                    path.AddRange(shape.ToVectorPathRecords());
                }

                vectorPathDataResource.Paths = path.ToArray();

                image.Save(outFile);
            }

            // Check changed values in saved file
            using (PsdImage image = (PsdImage)Image.Load(outFile, new PsdLoadOptions { LoadEffectsResource = true }))
            {
                Layer shapeLayer = image.Layers[1];
                VectorPathDataResource vectorPathDataResource = (VectorPathDataResource)shapeLayer.Resources[1];

                bool isFillStartsWithAllPixels;
                List<IPathShape> shapes = GetShapesFromResource(vectorPathDataResource, out isFillStartsWithAllPixels);

                // Saved file should have 1 shape
                AssertAreEqual(1, shapes.Count);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            List<IPathShape> GetShapesFromResource(
                VectorPathDataResource vectorPathDataResource,
                out bool isFillStartsWithAllPixels)
            {
                List<IPathShape> shapes = new List<IPathShape>();
                LengthRecord lengthRecord = null;
                isFillStartsWithAllPixels = false;
                List<BezierKnotRecord> bezierKnotRecords = new List<BezierKnotRecord>();

                foreach (var pathRecord in vectorPathDataResource.Paths)
                {
                    if (pathRecord is LengthRecord)
                    {
                        if (bezierKnotRecords.Count > 0)
                        {
                            shapes.Add(new PathShape(lengthRecord, bezierKnotRecords.ToArray()));
                            lengthRecord = null;
                            bezierKnotRecords.Clear();
                        }

                        lengthRecord = (LengthRecord)pathRecord;
                    }
                    else if (pathRecord is BezierKnotRecord)
                    {
                        bezierKnotRecords.Add((BezierKnotRecord)pathRecord);
                    }
                    else if (pathRecord is InitialFillRuleRecord)
                    {
                        InitialFillRuleRecord initialFillRuleRecord = (InitialFillRuleRecord)pathRecord;
                        isFillStartsWithAllPixels = initialFillRuleRecord.IsFillStartsWithAllPixels;
                    }
                }

                if (bezierKnotRecords.Count > 0)
                {
                    shapes.Add(new PathShape(lengthRecord, bezierKnotRecords.ToArray()));
                    lengthRecord = null;
                    bezierKnotRecords.Clear();
                }

                return shapes;
            }
            
            //ExEnd:SupportIPathToManipulateVectorPathObjects

            File.Delete(outFile);

            Console.WriteLine("SupportIPathToManipulateVectorPathObjects executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportIPathToManipulateVectorPathObjects.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportOfShapeLayer.cs ---
using System;
using System.Collections.Generic;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    public class SupportOfShapeLayer
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfShapeLayer
            //ExSummary:The following code shows support for the ShapeLayer layer.
            
            string srcFile = Path.Combine(baseDir, "ShapeLayerTest.psd");
            string outFile = Path.Combine(outputDir, "ShapeLayerTest-out.psd");

            using (PsdImage image = (PsdImage)Image.Load(srcFile, new PsdLoadOptions { LoadEffectsResource = true }))
            {
                ShapeLayer shapeLayer = (ShapeLayer)image.Layers[1];
                IPath layerPath = shapeLayer.Path;

                IPathShape[] pathShapeSource = layerPath.GetItems();
                List<IPathShape> pathShapesDest = new List<IPathShape>(pathShapeSource);

                // Source file contains 2 figures. Remove the seconds one.
                pathShapesDest.RemoveAt(1);

                layerPath.SetItems(pathShapesDest.ToArray());

                shapeLayer.Update();

                image.Save(outFile);
            }
            
            //ExEnd:SupportOfShapeLayer

            File.Delete(outFile);

            Console.WriteLine("SupportOfShapeLayer executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportOfShapeLayer.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportOfShapeLayerRendering.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.FileFormats.Psd.Layers.Gradient;
using Aspose.PSD.FileFormats.Psd.Layers.LayerResources.StrokeResources;
using Aspose.PSD.ImageOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    public class SupportOfShapeLayerRendering
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportOfShapeLayerRendering
            //ExSummary:The following code demonstrates support rendering of Shape Stroke.
            
            string sourceFile = Path.Combine(baseDir, "StrokeShapeTest.psd");
            string outputFilePsd = Path.Combine(outputDir, "StrokeShapeTest.out.psd");
            string outputFilePng = Path.Combine(outputDir, "StrokeShapeTest.out.png");

            using (PsdImage image = (PsdImage)Image.Load(sourceFile))
            {
                Layer layer = image.Layers[1];
                ShapeLayer shapeLayer = (ShapeLayer)image.Layers[1];
                ColorFillSettings fillSettings = (ColorFillSettings)shapeLayer.Fill;
                fillSettings.Color = Color.GreenYellow;
                shapeLayer.Update();

                ShapeLayer shapeLayer2 = (ShapeLayer)image.Layers[3];
                GradientFillSettings gradientSettings = (GradientFillSettings)shapeLayer2.Fill;
                SolidGradient solidGradient = (SolidGradient)gradientSettings.Gradient;
                gradientSettings.Dither = true;
                gradientSettings.Reverse = true;
                gradientSettings.AlignWithLayer = false;
                gradientSettings.Angle = 20;
                gradientSettings.Scale = 50;
                solidGradient.ColorPoints[0].Location = 100;
                solidGradient.ColorPoints[1].Location = 4000;
                solidGradient.TransparencyPoints[0].Location = 200;
                solidGradient.TransparencyPoints[1].Location = 3800;
                solidGradient.TransparencyPoints[0].Opacity = 90;
                solidGradient.TransparencyPoints[1].Opacity = 10;
                shapeLayer2.Update();

                ShapeLayer shapeLayer3 = (ShapeLayer)image.Layers[5];
                StrokeSettings strokeSettings = (StrokeSettings)shapeLayer3.Stroke;
                strokeSettings.Size = 15;
                ColorFillSettings strokeFillSettings = (ColorFillSettings)strokeSettings.Fill;
                strokeFillSettings.Color = Color.GreenYellow;
                shapeLayer3.Update();

                image.Save(outputFilePsd);
                image.Save(outputFilePng, new PngOptions());
            }

            // Check changed data.
            using (PsdImage image = (PsdImage)Image.Load(outputFilePsd))
            {
                ShapeLayer shapeLayer = (ShapeLayer)image.Layers[1];
                ColorFillSettings fillSettings = (ColorFillSettings)shapeLayer.Fill;
                AssertAreEqual(Color.GreenYellow, fillSettings.Color);

                ShapeLayer shapeLayer2 = (ShapeLayer)image.Layers[3];
                GradientFillSettings gradientSettings = (GradientFillSettings)shapeLayer2.Fill;
                SolidGradient solidGradient = (SolidGradient)gradientSettings.Gradient;
                AssertAreEqual(true, gradientSettings.Dither);
                AssertAreEqual(true, gradientSettings.Reverse);
                AssertAreEqual(false, gradientSettings.AlignWithLayer);
                AssertAreEqual(20.0, gradientSettings.Angle);
                AssertAreEqual(50, gradientSettings.Scale);
                AssertAreEqual(100, solidGradient.ColorPoints[0].Location);
                AssertAreEqual(4000, solidGradient.ColorPoints[1].Location);
                AssertAreEqual(200, solidGradient.TransparencyPoints[0].Location);
                AssertAreEqual(3800, solidGradient.TransparencyPoints[1].Location);
                AssertAreEqual(90.0, solidGradient.TransparencyPoints[0].Opacity);
                AssertAreEqual(10.0, solidGradient.TransparencyPoints[1].Opacity);

                ShapeLayer shapeLayer3 = (ShapeLayer)image.Layers[5];
                StrokeSettings strokeSettings = (StrokeSettings)shapeLayer3.Stroke;
                ColorFillSettings strokeFillSettings = (ColorFillSettings)strokeSettings.Fill;
                AssertAreEqual(15.0, strokeSettings.Size);
                AssertAreEqual(Color.GreenYellow, strokeFillSettings.Color);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            //ExEnd:SupportOfShapeLayerRendering

            File.Delete(outputFilePsd);
            File.Delete(outputFilePng);

            Console.WriteLine("SupportOfShapeLayerRendering executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportOfShapeLayerRendering.cs ---

--- START OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportShapeLayerFillProperty.cs ---
using System;
using System.IO;
using Aspose.PSD.FileFormats.Psd;
using Aspose.PSD.FileFormats.Psd.Layers;
using Aspose.PSD.FileFormats.Psd.Layers.FillSettings;
using Aspose.PSD.ImageLoadOptions;

namespace Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths
{
    public class SupportShapeLayerFillProperty
    {
        public static void Run()
        {
            // The path to the documents directory.
            string baseDir = RunExamples.GetDataDir_PSD();
            string outputDir = RunExamples.GetDataDir_Output();

            //ExStart:SupportShapeLayerFillProperty
            //ExSummary:The following code demonstrates the Fill property of ShapeLayer.

            string srcFile =  Path.Combine(baseDir, "ShapeInternalSolid.psd");
            string outFile = Path.Combine(outputDir, "ShapeInternalSolid.psd.out.psd");

            using (PsdImage image = (PsdImage)Image.Load(
                       srcFile,
                       new PsdLoadOptions { LoadEffectsResource = true }))
            {
                ShapeLayer shapeLayer = (ShapeLayer)image.Layers[1];
                ColorFillSettings fillSettings = (ColorFillSettings)shapeLayer.Fill;
                fillSettings.Color = Color.Red;

                shapeLayer.Update();

                image.Save(outFile);
            }

            // Check saved changes
            using (PsdImage image = (PsdImage)Image.Load(
                       outFile,
                       new PsdLoadOptions { LoadEffectsResource = true }))
            {
                ShapeLayer shapeLayer = (ShapeLayer)image.Layers[1];
                ColorFillSettings fillSettings = (ColorFillSettings)shapeLayer.Fill;

                AssertAreEqual(Color.Red, fillSettings.Color);
            }

            void AssertAreEqual(object expected, object actual, string message = null)
            {
                if (!object.Equals(expected, actual))
                {
                    throw new Exception(message ?? "Objects are not equal.");
                }
            }

            //ExEnd:SupportShapeLayerFillProperty

            File.Delete(outFile);

            Console.WriteLine("SupportShapeLayerFillProperty executed successfully");
        }
    }
}
--- END OF FILE CSharp/Aspose/WorkingWithVectorPaths/SupportShapeLayerFillProperty.cs ---

--- START OF FILE CSharp/ExamplesPaths.cs ---
﻿using System;
using System.IO;

namespace Aspose.PSD.Examples
{
    partial class RunExamples
    {
        public static String GetDataDir_Export(string path)
        {
            return Path.GetFullPath(GetDataDir_Data() + "Export/" + path + "/");
        }

        public static String GetDataDir_Files()
        {
            return Path.GetFullPath(GetDataDir_Data() + "Files/");
        }

        public static String GetDataDir_Images(string path)
        {
            return Path.GetFullPath(GetDataDir_Data() + "Images/" + path + "/");
        }

        public static String GetDataDir_PNG()
        {
            return Path.GetFullPath(GetDataDir_Data() + "PNG/");
        }

        public static String GetDataDir_DrawingAndFormattingImages()
        {
            return Path.GetFullPath(GetDataDir_Data() + "DrawingAndFormattingImages/");
        }

        public static String GetDataDir_DICOM()
        {
            return Path.GetFullPath(GetDataDir_Data() + "DICOM/");
        }

        public static String GetDataDir_JPEG()
        {
            return Path.GetFullPath(GetDataDir_Data() + "JPEG/");
        }

        public static String GetDataDir_ModifyingAndConvertingImages()
        {
            return Path.GetFullPath(GetDataDir_Data() + "ModifyingAndConvertingImages/");
        }

        public static String GetDataDir_Cache()
        {
            return Path.GetFullPath(GetDataDir_Data() + "Cache/");
        }

        public static String GetDataDir_MetaFiles()
        {
            return Path.GetFullPath(GetDataDir_Data() + "MetaFiles/");
        }

        public static String GetDataDir_PSD()
        {
            return Path.GetFullPath(GetDataDir_Data() + "PSD/");
        }
        public static String GetDataDir_PSB()
        {
            return Path.GetFullPath(GetDataDir_Data() + "PSB/");
        }

        public static String GetDataDir_WebPImages()
        {
            return Path.GetFullPath(GetDataDir_Data() + "WebPImage/");
        }

        public static String GetDataDir_DjVu()
        {
            return Path.GetFullPath(GetDataDir_Data() + "DjVu/");
        }

        public static String GetDataDir_AI()
        {
            return Path.GetFullPath(GetDataDir_Data() + "AI/");
        }
        public static String GetDataDir_Opening()
        {
            return Path.GetFullPath(GetDataDir_Data() + "Opening/");
        }
        public static String GetDataDir_Output()
        {
            return Path.GetFullPath(GetDataDir_Data() + "1_Output/");
        }

        public static string GetDataDir_Data()
        {
            string currDir = Directory.GetCurrentDirectory();
            string parentDir = currDir;

            int binDirIndex = currDir.LastIndexOf(Path.DirectorySeparatorChar + "bin" + Path.DirectorySeparatorChar);
            if (binDirIndex >= 0)
            {
                parentDir = currDir.Substring(0, binDirIndex);
            }

            string startDirectory = Directory.GetParent(parentDir).FullName;

            return System.IO.Path.Combine(startDirectory, "Data" + Path.DirectorySeparatorChar);
        }
    }
}
--- END OF FILE CSharp/ExamplesPaths.cs ---

--- START OF FILE CSharp/Properties/AssemblyInfo.cs ---
﻿using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// General Information about an assembly is controlled through the following 
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
[assembly: AssemblyTitle("Aspose.PSD.Examples")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("Microsoft")]
[assembly: AssemblyProduct("Aspose.PSD.Examples")]
[assembly: AssemblyCopyright("Copyright © Microsoft 2018")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// Setting ComVisible to false makes the types in this assembly not visible 
// to COM components.  If you need to access a type in this assembly from 
// COM, set the ComVisible attribute to true on that type.
[assembly: ComVisible(false)]

// The following GUID is for the ID of the typelib if this project is exposed to COM
[assembly: Guid("7f50d54c-3dc5-46f1-b38e-e74a36d5bb32")]

// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version 
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Build and Revision Numbers 
// by using the '*' as shown below:
// [assembly: AssemblyVersion("1.0.*")]
[assembly: AssemblyVersion("1.0.0.0")]
[assembly: AssemblyFileVersion("1.0.0.0")]
--- END OF FILE CSharp/Properties/AssemblyInfo.cs ---

--- START OF FILE CSharp/RunExamples.cs ---
using System;
using Aspose.PSD.Examples.Runner;

namespace Aspose.PSD.Examples
{
    partial class RunExamples
    {
        static void Main(string[] args)
        {
            // You have to specify License Firstly. Some tests will not work without License
            //String licPath =  @"Aspose.PSD.NET.lic";
            //License lic = new License();
            //lic.SetLicense(licPath);

            // You can use Metered License Also            
            //MeteredLicensing.Run();

            // Running tester of Aspose.PSD features           
            var mainSection = ExamplesRunner.RequestForSections();
            var subSection = ExamplesRunner.RequestForSubSection(mainSection);

            // Selected sections will be run
            ExamplesRunner.RunExamples(mainSection, subSection);

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}
--- END OF FILE CSharp/RunExamples.cs ---

--- START OF FILE CSharp/Runner/ExamplesMainSection.cs ---
﻿using System;

namespace Aspose.PSD.Examples.Runner
{
    [Flags]
    enum ExamplesMainSection
    {
        OpenSaveCreateBasics = 1,

        ConversionAndExportBasics = 2,

        GraphicOperationsBasics = 4,

        Psd = 8,

        Psb = 16,

        Ai = 32,

        CommonAdvancedFeatures = 64,

        All = OpenSaveCreateBasics | ConversionAndExportBasics | GraphicOperationsBasics | Psd | Psb | Ai | CommonAdvancedFeatures
    }
}
--- END OF FILE CSharp/Runner/ExamplesMainSection.cs ---

--- START OF FILE CSharp/Runner/ExamplesRunner.cs ---
﻿
using System;
using Aspose.PSD.Examples.Aspose.Ai;
using Aspose.PSD.Examples.Aspose.Conversion;
using Aspose.PSD.Examples.Aspose.DrawingAndFormattingImages;
using Aspose.PSD.Examples.Aspose.DrawingImages;
using Aspose.PSD.Examples.Aspose.FillLayers;
using Aspose.PSD.Examples.Aspose.GlobalResources;
using Aspose.PSD.Examples.Aspose.LayerEffects;
using Aspose.PSD.Examples.Aspose.LayerResources;
using Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.AI;
using Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.JPEG;
using Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PNG;
using Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSB;
using Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.PSD;
using Aspose.PSD.Examples.Aspose.ModifyingAndConvertingImages.TIFF;
using Aspose.PSD.Examples.Aspose.Opening;
using Aspose.PSD.Examples.Aspose.WorkingWithPSD;
using Aspose.PSD.Examples.Aspose.Animation;
using Aspose.PSD.Examples.Aspose.LayerResources.Structures;
using Aspose.PSD.Examples.Aspose.SmartObjects;
using Aspose.PSD.Examples.Aspose.WorkingWithVectorPaths;
using Aspose.PSD.Examples.Aspose.SmartFilters;

namespace Aspose.PSD.Examples.Runner
{
    class ExamplesRunner
    {
        /// <summary>
        /// Requests for examples sections of Aspose.PSD
        /// </summary>
        /// <returns></returns>
        /// <exception cref="ArgumentException">Please enter your choise as number between [0..13]</exception>
        public static int RequestForSections()
        {
            Console.WriteLine("================================================");
            Console.WriteLine(
                       "Please select the Aspose.PSD features you want to test: \n" +
                       "0 - Test all features of PSD format,  \n" +
                       "1 - Open/Save Basics, \n" +
                       "2 - Conversion and Export Basics, \n" +
                       "3 - Graphic operations basics, \n" +
                       "4 - Psd Format Features\n" +
                       "5 - Psb Format Features, \n" +
                       "6 - AI Format Features, \n" +
                       "7 - AI Common Advanced Features");
            Console.WriteLine("================================================");
            Console.Write("Enter section number: ");
            string key = Console.ReadLine();

            int keyNumber = 0;

            if (keyNumber - 1 >= 0)
            {
                keyNumber = (int)Math.Pow(2, keyNumber);
            }

            if (!int.TryParse(key, out keyNumber)
                || (!typeof(ExamplesMainSection).IsEnumDefined(keyNumber - 1 >= 0 ? keyNumber = (int)Math.Pow(2, keyNumber - 1) : keyNumber = (int)ExamplesMainSection.All)))
            {
                throw new ArgumentException("Please enter your choise as number between [0..7]");
            }

            return keyNumber;
        }

        /// <summary>
        /// Requests for Examples Sub Sections of Aspose.PSD
        /// </summary>
        /// <param name="subSection">The sub section.</param>
        /// <returns>Number of selected Sub Section or 0</returns>
        public static int RequestForSubSection(int subSection)
        {
            switch ((ExamplesMainSection)subSection)
            {
                case ExamplesMainSection.Psd:
                    return RequestForPsdSection();
            }

            return 0;
        }

        /// <summary>
        /// Requests for PSD section of Aspose.PSD
        /// </summary>
        /// <returns></returns>
        /// <exception cref="ArgumentException">Please enter your choise as number between [0..5]</exception>
        private static int RequestForPsdSection()
        {
            Console.WriteLine("================================================");
            Console.WriteLine(
            "Please select the PSD features you want to test: \n" +
            "0 - Test all features of PSD format,  \n" +
            "1 - Psd Format Basics,  \n" +
            "2 - Layer Resources, \n" +
            "3 - Global PSD Image Resources, \n" +
            "4 - Layers Operations, \n" +
            "5 - Text Layers\n" +
            "6 - Adjustment Layers, \n" +
            "7 - Fill Layers, \n" +
            "8 - Group Layers, \n" +
            "9 - Smart Objects, \n" +
            "10 - Smart Filters, \n" +
            "11 - Working with Masks, \n" +
            "12 - Layer Effects, \n" +
            "13 - Specific Cases, \n");
            Console.WriteLine("================================================");
            Console.Write("Enter section number: ");

            string key = Console.ReadLine();

            int keyNumber = 0;

            if (keyNumber - 1 >= 0)
            {
                keyNumber = (int)Math.Pow(2, keyNumber);
            }


            if (!int.TryParse(key, out keyNumber)
                || (!typeof(ExamplesSubSectionPsd).IsEnumDefined(keyNumber - 1 >= 0 ? keyNumber = (int)Math.Pow(2, keyNumber - 1) : keyNumber = (int)ExamplesSubSectionPsd.All)))
            {
                throw new ArgumentException("Please enter your choise as number between [0..13]");
            }

            return keyNumber;
        }

        /// <summary>
        /// Runs the selected examples.
        /// </summary>
        /// <param name="mainSection">The main section.</param>
        /// <param name="subSection">The sub section.</param>
        public static void RunExamples(int mainSection, int subSection)
        {
            var section = (ExamplesMainSection)mainSection;
            switch (section)
            {
                case ExamplesMainSection.OpenSaveCreateBasics:
                    RunOpenSaveCreateBasics();
                    break;
                case ExamplesMainSection.ConversionAndExportBasics:
                    ConversionAndExportBasics();
                    break;
                case ExamplesMainSection.GraphicOperationsBasics:
                    GraphicOperationsBasics();
                    break;
                case ExamplesMainSection.Psd:
                    RunPsdSection(subSection);
                    break;
                case ExamplesMainSection.Psb:
                    RunPsbSection();
                    break;
                case ExamplesMainSection.Ai:
                    RunAiSection();
                    break;
                case ExamplesMainSection.All:
                    foreach (ExamplesMainSection main in Enum.GetValues(typeof(ExamplesMainSection)))
                    {
                        if (main == ExamplesMainSection.All)
                        {
                            continue;
                        }

                        RunExamples((int)main, 0);
                    }
                    break;
                case ExamplesMainSection.CommonAdvancedFeatures:
                    RunAdvancedFeatures();
                    break;
                default:
                    break;
            }
        }

        /// <summary>
        /// Runs the advanced features examples
        /// </summary>
        private static void RunAdvancedFeatures()
        {
            Console.WriteLine("Starting Advanced Features");

            //Technical Articles
            UncompressedImageUsingFile.Run();
            UncompressedImageStreamObject.Run();

            ControllCacheReallocation.Run();
            ColorConversionUsingICCProfiles.Run();
            ColorConversionUsingDefaultProfiles.Run();
            SupportForInterruptMonitor.Run();
            InterruptMonitorTest.Run();
            CreateXMPMetadata.Run();
            UpdatingCreatorToolInPSDFile.Run();
        }

        /// <summary>
        /// Runs the AI section examples
        /// </summary>
        private static void RunAiSection()
        {
            Console.WriteLine("Starting AI (Adobe Illustrator Format) Examples");

            AIToPSD.Run();
            AIToPNG.Run();
            AIToJPG.Run();
            AIToGIF.Run();
            AIToTIFF.Run();
            AIToPDF.Run();
            AIToPDFA1a.Run();
            SupportOfAiFormatVersion8.Run();
            SupportOfRasterImagesInAI.Run();
            SupportOfLayersInAi.Run();
            SupportOfActivePageIndex.Run();
            SupportOfHasMultiLayerMasksAndColorIndexProperties.Run();
            SupportOfAiImageXmpDataProperty.Run();
            SupportAiImagePageCountProperty.Run();
        }

        /// <summary>
        /// Runs the PSB section examples.
        /// </summary>
        private static void RunPsbSection()
        {
            Console.WriteLine("Starting PSB Image Examples");

            //PSB
            PSBToPSD.Run();
            PSBToJPG.Run();
            PSBToPDF.Run();
        }

        /// <summary>
        /// Runs the PSD section examples
        /// </summary>
        /// <param name="subSection">The sub section.</param>
        private static void RunPsdSection(int subSection)
        {
            ExamplesSubSectionPsd section = CorrectAllSectionSelect(subSection);

            switch (section)
            {
                case ExamplesSubSectionPsd.PsdFormatBasics:
                    RunPsdFormatBasicsExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithLayerResources:
                    RunLayerResourcesExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithGlobalResources:
                    RunGlobalResourcesExamples();
                    break;
                case ExamplesSubSectionPsd.BasicLayersOperations:
                    RunBasicLayersOperationsExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithTextLayers:
                    RunTextLayersExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithAdjustmentLayers:
                    RunAdjustmentLayersExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithFillLayers:
                    RunFillLayersExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithGroupLayers:
                    RunGroupLayersExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithSmartObjectLayers:
                    RunSmartObjectsExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithSmartFilters:
                    RunSmartFiltersExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithMasks:
                    RunWorkingWithMasksExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithLayerEffects:
                    RunLayerEffectsExamples();
                    break;
                case ExamplesSubSectionPsd.WorkingWithAnimationAndTimeLine:
                    RunAnimationExamples();
                    break;
                case ExamplesSubSectionPsd.All:
                    foreach (ExamplesSubSectionPsd sub in Enum.GetValues(typeof(ExamplesSubSectionPsd)))
                    {
                        if (sub == ExamplesSubSectionPsd.All)
                        {
                            continue;
                        }

                        RunPsdSection((int)sub);
                    }
                    break;

                case ExamplesSubSectionPsd.SpecificCases:
                    RunPsdSpecificCases();
                    break;
            }
        }

        /// <summary>
        /// Corrects "all" section select.
        /// </summary>
        /// <param name="subSection">The sub section.</param>
        /// <returns></returns>
        private static ExamplesSubSectionPsd CorrectAllSectionSelect(int subSection)
        {
            ExamplesSubSectionPsd section;
            if (subSection == 0)
            {
                section = ExamplesSubSectionPsd.All;
            }
            else
            {
                section = (ExamplesSubSectionPsd)subSection;
            }

            return section;
        }

        /// <summary>
        /// Runs the group layers examples.
        /// </summary>
        private static void RunGroupLayersExamples()
        {
            Console.WriteLine("Starting Group Layers Examples");

            ExportLayerGroupToImage.Run();
            ChangingGroupVisibility.Run();
            CreateLayerGroups.Run();
            SupportOfPassThroughBlendingMode.Run();
            SupportOfSectionDividerLayer.Run();
            LayerGroupIsOpenSupport.Run();
            SupportOfArtboardLayer.Run();
        }

        /// <summary>
        /// Runs the basic layers operations examples.
        /// </summary>
        private static void RunBasicLayersOperationsExamples()
        {
            Console.WriteLine("Starting Basic Layer Operation Examples");

            LayerCreationDateTime.Run();
            SheetColorHighlighting.Run();
            FillOpacityOfLayers.Run();
            MergeOnePSDlayerToOther.Run();
            ExtractLayerName.Run();
            SupportOfScaleProperty.Run();
            SupportOfRotateLayer.Run();
            SupportOfUpdatingLinkedSmartObjects.Run();
            SupportOfApplyLayerMask.Run();
        }

        /// <summary>
        /// Runs the PSD specific cases examples
        /// </summary>
        private static void RunPsdSpecificCases()
        {
            Console.WriteLine("Starting PSD Specific Cases Examples");

            SettingforReplacingMissingFonts.Run();
            SupportEditingGlobalFontList.Run();
            ImplementBicubicResampler.Run();
            DetectFlattenedPSD.Run();
            ColorReplacementInPSD.Run();
            CreateThumbnailsFromPSDFiles.Run();
            CreateIndexedPSDFiles.Run();
            ExtractThumbnailFromJFIF.Run();
            AddThumbnailToJFIFSegment.Run();
            AddThumbnailToEXIFSegment.Run();
            ReadandModifyJpegEXIFTags.Run();
            ReadAllEXIFTagList.Run();
            ImplementLossyGIFCompressor.Run();
            ForceFontCache.Run();
            FontReplacement.Run();
            RemoveFontCacheFile.Run();
            ReadAllEXIFTags.Run();
            ReadSpecificEXIFTagsInformation.Run();
            WritingAndModifyingEXIFData.Run();
            SupportForJPEG_LSWithCMYK.Run();
            SupportFor2_7BitsJPEG.Run();
            ClassesToManipulateVectorPathObjects.Run();
            SupportIPathToManipulateVectorPathObjects.Run();
            ResizeLayersWithVogkResourceAndVectorPaths.Run();
            ResizeLayersWithVectorPaths.Run();
            GettingUniqueHashForSimilarLayers.Run();
            SupportOfShapeLayer.Run();
            AddShapeLayer.Run();
            ShapeLayerManipulation.Run();
            SupportShapeLayerFillProperty.Run();
            SupportOfShapeLayerRendering.Run();
        }

        /// <summary>
        /// Runs the PSD format basics examples.
        /// </summary>
        private static void RunPsdFormatBasicsExamples()
        {
            Console.WriteLine("Starting PSD Format Basics Examples");

            PSDToRasterImageFormats.Run();
            LoadingImageFromStreamAsALayer.Run();
            CroppingPSDWhenConvertingToPNG.Run();
            CropPSDFile.Run();
            ResizePSDFile.Run();
            PossibilityToFlattenLayers.Run();
            AddNewRegularLayerToPSD.Run();
            SupportOfLinkedLayer.Run();
            MergePSDlayers.Run();
            SupportBlendModes.Run();
            SupportLayerForPSD.Run();
            ExtractThumbnailFromPSD.Run();
            SupportOfRGBColorModeWith16BitPerChannel.Run();
            ColorTypeAndCompressionType.Run();
            SupportOfCMYKColorMode16bit.Run();
            SupportOfObArAndUnFlSignatures.Run();
            SupportOfMeSaSignature.Run();
            SupportOfAllowNonChangedLayerRepaint.Run();
        }

        /// <summary>
        /// Runs the examples that demonstrates how you can work with all types of masks
        /// </summary>
        private static void RunWorkingWithMasksExamples()
        {
            Console.WriteLine("Starting Working with masks Examples");

            SupportOfLayerMask.Run();
            SupportOfClippingMask.Run();
            SupportOfLayerVectorMask.Run();
            WorkingWithMasks.Run();
            SupportOfBlendClippedElementsProperty.Run();
        }

        private static void RunAdjustmentLayersExamples()
        {
            Console.WriteLine("Starting Adjustment Layers Examples");

            SupportOfAdjusmentLayers.Run();
            RenderingOfCurvesAdjustmentLayer.Run();
            AddBlackAndWhiteAdjustmentLayer.Run();
            AddCurvesAdjustmentLayer.Run();
            RenderingOfLevelAdjustmentLayer.Run();
            AddLevelAdjustmentLayer.Run();
            AddChannelMixerAdjustmentLayer.Run();
            AddHueSaturationAdjustmentLayer.Run();
            RenderingExposureAdjustmentLayer.Run();
            RenderingOfPosterizeAdjustmentLayer.Run();
            ColorBalanceAdjustment.Run();
            InvertAdjustmentLayer.Run();
            RenderingExportOfChannelMixerAdjusmentLyer.Run();
            AddVibranceAdjustmentLayer.Run();
            SupportOfPosterizeAdjustmentLayer.Run();
            SupportOfThresholdAdjustmentLayer.Run();
            SupportOfSelectiveColorAdjustmentLayer.Run();
            UsingAdjustmentLayers.Run();
            AddGradientMapAdjustmentLayer.Run();
        }

        private static void RunLayerEffectsExamples()
        {
            Console.WriteLine("Starting Layer Effects Examples");

            // Layer Effects
            LayerEffectsForPSD.Run();
            SupportOfEffectTypeProperty.Run();
            AddStrokeLayer_Pattern.Run();
            AddStrokeLayer_Gradient.Run();
            AddStrokeLayer_Color.Run();
            AddStrokeEffect.Run();
            AddGradientEffects.Run();
            AddPatternEffects.Run();
            SupportOfInnerShadowLayerEffect.Run();
            RenderingDropShadow.Run();

            RenderingColorEffect.Run();
            AddEffectAtRunTime.Run();
            ColorOverLayEffect.Run();
            SupportShadowEffect.Run();
            SupportShadowEffectOpacity.Run();

            SupportOfGradientOverlayEffect.Run();
            RenderingOfGradientOverlayEffect.Run();
            SupportOfOuterGlowEffect.Run();
            SupportOfAreEffectsEnabledProperty.Run();
            SupportOfGradientPropery.Run();
        }

        private static void RunFillLayersExamples()
        {
            Console.WriteLine("Starting Fill Layers Examples");

            // Fill Layers
            PatternFillLayer.Run();
            GradientFillLayers.Run();
            PatternFillLayer.Run();
            AddingFillLayerAtRuntime.Run();
        }

        private static void RunSmartObjectsExamples()
        {
            Console.WriteLine("Starting Smart objects Examples");

            // Smart objects
            SupportOfEmbeddedSmartObjects.Run();
            SupportOfCopyingOfSmartObjectLayers.Run();
            SupportOfConvertingLayerToSmartObject.Run();
            SupportOfReplaceContentsInSmartObjects.Run();
            SupportOfReplaceContentsByLink.Run();
            SupportOfWarpTransformationToSmartObject.Run();
            SupportOfExportContentsFromSmartObject.Run();
            WarpSettingsForSmartObjectLayerAndTextLayer.Run();
            SupportOfProcessingAreaProperty.Run();
        }

        private static void RunSmartFiltersExamples()
        {
            Console.WriteLine("Starting Smart filters Examples");

            // Smart filters
            SupportAccessToSmartFilters.Run();
            SupportCustomSmartFilterRenderer.Run();
            SupportSharpenSmartFilter.Run();
            DirectlyApplySmartFilter.Run();
            ManipulatingSmartFiltersInSmartObjects.Run();
        }

        private static void RunTextLayersExamples()
        {
            Console.WriteLine("Starting Text Layer Examples");

            AddTextLayer.Run();
            SetTextLayerPosition.Run();
            GetTextPropertiesFromTextLayer.Run();
            GetPropertiesOfInlineFormattingOfTextLayer.Run();
            RenderingOfDifferentStylesInOneTextLayer.Run();
            UpdateTextLayerInPSDFile.Run();
            TextLayerBoundBox.Run();
            AddTextLayerOnRuntime.Run();
            RenderTextWithDifferentColorsInTextLayer.Run();
            SupportOfITextStyleProperties.Run();
            SupportOfEditFontNameInTextPortionStyle.Run();
            SupportTextStyleJustificationMode.Run();
            SupportTextOrientationPropertyEdit.Run();
            SupportIsStandardVerticalRomanAlignmentEnabledPropertyEdit.Run();
            SupportOfLeadingTypeInTextPortion.Run();
        }

        private static void RunGlobalResourcesExamples()
        {
            Console.WriteLine("Starting Gloabal PSD Resources Examples");

            // Global Resources of Psd Image
            SupportOfBackgroundColorResource.Run();
            SupportOfBorderInformationResource.Run();
            SupportOfWorkingPathResource.Run();
        }

        /// <summary>
        /// Runs the layer resources examples.
        /// </summary>
        private static void RunLayerResourcesExamples()
        {
            Console.WriteLine("Starting Layer Resources Examples");

            // Layer Resources
            AddIopaResource.Run();
            SupportOfVogkResource.Run();
            SupportOfVogkResourceProperties.Run();
            SupportOfVectorShapeTransformOfVogkResource.Run();
            SupportOfLclrResource.Run();
            VsmsResourceLengthRecordSupport.Run();
            SupportForClblResource.Run();
            SupportForBlwhResource.Run();
            SupportForLspfResource.Run();
            SupportForInfxResource.Run();
            SupportOfVsmsResource.Run();
            SupportOfSoCoResource.Run();
            SupportOfPtFlResource.Run();
            SupportOfNvrtResource.Run();
            SupportOfBritResource.Run();
            SupportOfLnkEResource.Run();
            SupportOfLnk2AndLnk3Resource.Run();
            SupportOfPlLdResource.Run();
            SupportOfSoLdResource.Run();
            SupportOfPlacedResource.Run();
            SupportOfFXidResource.Run();
            SupportOfVibAResource.Run();
            SupportOfVstkResource.Run();
            SupportOfVscgResource.Run();
            SupportOfPostResource.Run();
            SupportOfGrdmResource.Run();
            SupportOfLMskResource.Run();
            SupportOfArtBResourceArtDResourceLyvrResource.Run();
            SupportForImfxResource.Run();
            SupportOfNameStructure.Run();
        }

        /// <summary>
        /// Graphics operations basics examples.
        /// </summary>
        private static void GraphicOperationsBasics()
        {
            Console.WriteLine("Starting Graphic Operations Basics Example");

            //Drawing Images
            DrawingLines.Run();
            DrawingEllipse.Run();
            DrawingRectangle.Run();
            DrawingArc.Run();
            DrawingBezier.Run();
            CoreDrawingFeatures.Run();
            DrawingUsingGraphics.Run();
            DrawingUsingGraphicsPath.Run();
            PixelDataManipulation.Run();

            // Filters
            ApplyMedianAndWienerFilters.Run();
            ApplyGausWienerFilters.Run();
            ApplyGausWienerFiltersForColorImage.Run();
            ApplyMotionWienerFilters.Run();
            BinarizationWithFixedThreshold.Run();
            BinarizationWithOtsuThreshold.Run();
            Grayscaling.Run();
            DitheringforRasterImages.Run();
            AdjustingBrightness.Run();
            AdjustingContrast.Run();
            AdjustingGamma.Run();
            BluranImage.Run();

            // Crop, Resize, Rotate
            CroppingbyRectangle.Run();
            RotatinganImage.Run();
            RotatinganImageonaSpecificAngle.Run();
            ResizeImageProportionally.Run();
            RotatePatternSupport.Run();

            // Common operations
            VerifyImageTransparency.Run();
            AddSignatureToImage.Run();
            AddWatermark.Run();
            AddDiagnolWatermark.Run();
            RawColorClass.Run();

            CombiningImages.Run();
            ExpandandCropImages.Run();
        }

        /// <summary>
        /// Conversions and export basics examples
        /// </summary>
        private static void ConversionAndExportBasics()
        {
            Console.WriteLine("Starting Conversion and Export Basics Examples");
            PSDToPDFWithClippingMask.Run();
            PSDToPDFWithAdjustmentLayers.Run();
            ExportImageToPSD.Run();
            ExportPSDLayerToRasterImage.Run();
            ImportImageToPSDLayer.Run();
            LoadImageToPSD.Run();
            PSDToPSB.Run();
            PSDToPDF.Run();
            PSDToPDFWithSelectableText.Run();
            ExportToMultiPageTiff.Run();
            TiffOptionsConfiguration.Run();
            TIFFwithDeflateCompression.Run();
            TIFFwithAdobeDeflateCompression.Run();
            CompressingTiff.Run();
            Saving16BitGrayscalePsdImage.Run();
            Saving16BitGrayscalePsdTo8BitGrayscale.Run();
            Saving16BitGrayscalePsdTo8BitRgb.Run();
            ConvertPsdToJpg.Run();
            ConvertPsdToPng.Run();
            ConvertPsdToPdf.Run();

            GIFImageLayersToTIFF.Run();
            CMYKPSDtoCMYKTiff.Run();
            ConversionPSDToGrayscaleRgbCmyk.Run();

            // Png export abilities
            SpecifyTransparencyOfPngOnExport.Run();
            SettingResolutionOfPngOnExport.Run();
            SetPngCompressingOnExport.Run();
            SpecifyBitDepthOnPng.Run();
            ApplyFilterMethodOnPng.Run();
            ChangeBackgroundColorOfPng.Run();

            SupportOfPsdOptionsBackgroundContentsProperty.Run();
            SupportOfExportLayerWithEffects.Run();
        }

        /// <summary>
        /// Runs the examples that demonstrates open/save basics.
        /// </summary>
        private static void RunOpenSaveCreateBasics()
        {
            Console.WriteLine("Starting Open/Save/Create Basics Examples");
            //Opening and saving
            SavingtoStream.Run();
            LoadingFromStream.Run();
            ExportImagesinMultiThreadEnv.Run();
            LoadPSDWithReadOnlyMode.Run();
            CreatingbySettingPath.Run();
            UsingDocumentConversionProgressHandler.Run();
        }
        
        /// <summary>
        /// Runs the examples that demonstrates work with timeline and other animation data.
        /// </summary>
        private static void RunAnimationExamples()
        {
            Console.WriteLine("Starting Animation Examples");

            SupportOfAnimatedDataSection.Run();
            SupportOfMlstResource.Run();
            SupportOfTimeLine.Run();
            SupportOfLayerStateEffects.Run();
            SupportOfPsdImageTimelineProperty.Run();
            SupportExportToGifImage.Run();
        }
    }
}
--- END OF FILE CSharp/Runner/ExamplesRunner.cs ---

--- START OF FILE CSharp/Runner/ExamplesSubSectionPsd.cs ---
﻿using System;

namespace Aspose.PSD.Examples.Runner
{

    [Flags]
    enum ExamplesSubSectionPsd
    {
        PsdFormatBasics = 1,

        WorkingWithLayerResources = 2,

        WorkingWithGlobalResources = 4,

        BasicLayersOperations = 8,

        WorkingWithTextLayers = 16,

        WorkingWithAdjustmentLayers = 32,

        WorkingWithFillLayers = 64,

        WorkingWithGroupLayers = 128,

        WorkingWithSmartObjectLayers = 256,

        WorkingWithSmartFilters = 512,

        WorkingWithMasks = 1024,

        WorkingWithLayerEffects = 2048,

        WorkingWithAnimationAndTimeLine = 4096,

        SpecificCases = 8192,

        All = WorkingWithLayerResources | WorkingWithGlobalResources
              | BasicLayersOperations | WorkingWithTextLayers | WorkingWithAdjustmentLayers | WorkingWithFillLayers |
            WorkingWithSmartObjectLayers | WorkingWithSmartFilters | WorkingWithMasks | WorkingWithLayerEffects
              | WorkingWithAnimationAndTimeLine
    }
}
--- END OF FILE CSharp/Runner/ExamplesSubSectionPsd.cs ---
