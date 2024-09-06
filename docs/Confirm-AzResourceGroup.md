---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzResourceGroup

## SYNOPSIS
Tests for the existence of a resource group in Azure.

## SYNTAX

```
Confirm-AzResourceGroup [-ResourceGroupName] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzResourceGroup function takes the name of an Azure Resource Group as input and returns $true if it is 
found, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a Resource Group named "MyResourceGroup01" exists
Confirm-AzResourceGroup -ResourceGroupName "MyResourceGroup01"
```

### EXAMPLE 2
```
# Check if a Resource Group named "MyResourceGroup01" exists and store the result in a variable.
$exists = Confirm-AzResourceGroup -ResourceGroupName "MyResourceGroup01"
if ($exists) {
    Write-Output "MyResourceGroup01 exists."
} else {
    Write-Output "MyResourceGroup01 does not exist."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "MyResourceGroup01 Resource Group" {
    It "Should exist" {
        Confirm-AzResourceGroup -ResourceGroupName "MyResourceGroup01" | Should -Be $true
    }
}
```

## PARAMETERS

### -ResourceGroupName
The name of the Resource Group to look for.

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
