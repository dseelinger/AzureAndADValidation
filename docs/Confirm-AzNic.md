---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzNic

## SYNOPSIS
Tests for the existence of a Network Interface Card (NIC) in Azure.

## SYNTAX

```
Confirm-AzNic [-NicName] <String> [-ResourceGroupName] <String> [[-Location] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzNic function takes the name of an Azure NIC as input and returns $true if it is found,
otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a NIC named "MyNic01" exists in the resource group "MyResourceGroup01"
Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01"
```

### EXAMPLE 2
```
# Check if a NIC named "MyNic01" exists in the resource group "MyResourceGroup01" and store the result in a variable.
$exists = Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01"
if ($exists) {
    Write-Output "MyNic01 exists in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyNic01 does not exist in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 3
```
# Check with a specific location
Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01" -Location "eastus"
```

### EXAMPLE 4
```
# How to use this in a Pester test
Describe "MyNic01 Network Interface Card" {
    It "Should exist in the MyResourceGroup01 Resource Group" {
        Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
    }
}
```

## PARAMETERS

### -NicName
The name of the Network Interface Card (NIC) to look for.

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
The name of the Resource Group that the NIC is supposed to be in.

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
Optional.
The location of the NIC.
If provided, the function will look for the NIC in the specified location.

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
