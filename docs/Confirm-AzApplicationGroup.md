---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzApplicationGroup

## SYNOPSIS
Tests for the existence of a Windows Virtual Desktop ApplicationGroup in Azure.

## SYNTAX

```
Confirm-AzApplicationGroup [-ApplicationGroupName] <String> [-ResourceGroupName] <String>
 [[-Location] <String>] [[-ApplicationGroupType] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzApplicationGroup function takes the name of an ApplicationGroup as input and returns $true if it is 
found, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if an ApplicationGroup named "MyWvdAppGroup" exists in the "MyResourceGroup" Resource Group
Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup"
```

### EXAMPLE 2
```
# Check if an ApplicationGroup named "MyWvdAppGroup" exists in the "MyResourceGroup" Resource Group and store the
# result in a variable
$exists = Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup"
if ($exists) {
    Write-Output "MyWvdAppGroup exists in the MyResourceGroup Resource Group."
} else {
    Write-Output "MyWvdAppGroup does not exist in the MyResourceGroup Resource Group."
}
```

### EXAMPLE 3
```
# Check with a specific location
Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup" `
    -Location "eastus"
```

### EXAMPLE 4
```
# Check with a specific ApplicationGroupType
Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup" `
    -ApplicationGroupType "DesktopApplicationGroup"
```

### EXAMPLE 5
```
# How to use this in a Pester test
Describe "MyWvdAppGroup Application Group" {
    It "Should exist in the MyResourceGroup Resource Group" {
        Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup" `
            | Should -Be $true
    }
}
```

## PARAMETERS

### -ApplicationGroupName
The name of the Windows Virtualization ApplicationGroup to look for.

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
The name of the Resource Group that the ApplicationGroup is supposed to be in.

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
The location where the ApplicationGroup is expected to be.
If not specified, the location check will be skipped.

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

### -ApplicationGroupType
The type of the ApplicationGroup.
If not specified, the type check will be skipped.

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
