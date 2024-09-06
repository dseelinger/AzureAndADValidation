---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzDisk

## SYNOPSIS
Tests for the existence of a disk in Azure.

## SYNTAX

```
Confirm-AzDisk [-DiskName] <String> [-ResourceGroupName] <String> [[-DiskSizeGB] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzDisk function takes the name of an Azure disk as input and returns $true if it is found,
otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a disk named "MyDisk01" exists in the resource group "MyResourceGroup01"
Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01"
```

### EXAMPLE 2
```
# How to use the DiskSizeGB parameter
Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01" -DiskSizeGB 128
```

### EXAMPLE 3
```
# Check if a disk named "MyDisk01" exists in the resource group "MyResourceGroup01" and store the result in a
# variable.
$exists = Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01"
if ($exists) {
    Write-Output "MyDisk01 exists in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyDisk01 does not exist in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 4
```
# How to use this in a Pester test
Describe "MyDisk01 Disk" {
    It "Should exist in the MyResourceGroup01 Resource Group" {
        Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
    }
}
```

## PARAMETERS

### -DiskName
The name of the Disk to look for.

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
The name of the Resource Group that the disk is supposed to be in.

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

### -DiskSizeGB
{{ Fill DiskSizeGB Description }}

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
