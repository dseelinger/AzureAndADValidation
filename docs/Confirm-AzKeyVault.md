---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzKeyVault

## SYNOPSIS
Tests for the existence of a Key Vault in Azure.

## SYNTAX

```
Confirm-AzKeyVault [-KeyVaultName] <String> [-ResourceGroupName] <String> [[-Location] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzKeyVault function takes the name of an Azure KeyVault as input and returns $true if it is found,
otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a Key Vault named "MyKeyVault01" exists in the resource group "MyResourceGroup01"
Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01"
```

### EXAMPLE 2
```
# Check if a Key Vault named "MyKeyVault01" exists in the resource group "MyResourceGroup01" and store the result in 
# a variable.
$exists = Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01"
if ($exists) {
    Write-Output "MyKeyVault exists in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyKeyVault does not exist in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 3
```
# Check with a specific location
Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01" -Location "eastus"
```

### EXAMPLE 4
```
# How to use this in a Pester test
Describe "MyKeyVault01 Key Vault" {
    It "Should exist in the MyResourceGroup01 Resource Group" {
        Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
    }
}
```

## PARAMETERS

### -KeyVaultName
The name of the Key Vault to look for.

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
The name of the Resource Group that the Key Vault is supposed to be in.

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
The location of the Key Vault.
If provided, the function will look for the Key Vault in the specified 
location.

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
