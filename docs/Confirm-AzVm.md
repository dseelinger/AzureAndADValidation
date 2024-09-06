---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzVm

## SYNOPSIS
Tests for the existence of a Virtual Machine in Azure.

## SYNTAX

```
Confirm-AzVm [-VmName] <String> [-ResourceGroupName] <String> [[-Location] <String>] [[-VMSize] <String>]
 [[-OsType] <String>] [[-SourceImagePublisherName] <String>] [[-SourceImageOffer] <String>]
 [[-SourceImageSku] <String>] [[-SourceImageVersion] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzVm function takes the name of an Azure Virtual Machine as input and returns $true if it is found,
otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzVm -VmName "MyVm01" -ResourceGroupName "MyResourceGroup01"
Returns $true or $false
```

## PARAMETERS

### -VmName
The name of the Virtual Machine to look for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The name of the Resource Group that the Virtual Machine is supposed to be in.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Optional. The location of the Virtual Machine. If provided, the function will look for the Virtual Machine in the 
specified location.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMSize
Optional. The size of the Virtual Machine. If provided, the function will look for the Virtual Machine with the
specified size.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OsType
Optional. The OS type of the Virtual Machine. If provided, the function will look for the Virtual Machine with the
specified OS type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceImagePublisherName
Optional. The publisher name of the source image of the Virtual Machine. If provided, the function will look for the
Virtual Machine with the specified source image publisher name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceImageOffer
Optional. The offer of the source image of the Virtual Machine. If provided, the function will look for the Virtual
Machine with the specified source image offer.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceImageSku
Optional. The SKU of the source image of the Virtual Machine. If provided, the function will look for the Virtual
Machine with the specified source image SKU.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceImageVersion
Optional. The version of the source image of the Virtual Machine. If provided, the function will look for the Virtual
Machine with the specified source image version.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Doug Seelinger

## RELATED LINKS
