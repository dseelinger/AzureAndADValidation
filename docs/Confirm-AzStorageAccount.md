---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzStorageAccount

## SYNOPSIS
Confirms the existence of an Azure Storage account.

## SYNTAX

```
Confirm-AzStorageAccount [-StorageAccountName] <String> [-ResourceGroupName] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
# Check if a Storage Account named "MyStorageAccount" exists in the resource group "MyResourceGroup"
Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount" -ResourceGroupName "MyResourceGroup"
```

### EXAMPLE 2
```
# Check if a Storage Account named "MyStorageAccount" exists in the resource group "MyResourceGroup" and store the 
# result in a variable.
$exists = Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount" -ResourceGroupName "MyResourceGroup"
if ($exists) {
    Write-Output "MyStorageAccount exists in the MyResourceGroup Resource Group."
} else {
    Write-Output "MyStorageAccount does not exist in the MyResourceGroup Resource Group."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "MyStorageAccount Storage Account" {
    It "Should exist in the MyResourceGroup Resource Group" {
        Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount" -ResourceGroupName "MyResourceGroup" `
            | Should -Be $true
    }
}
```

## PARAMETERS

### -StorageAccountName
The name of the Storage Account to look for.

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
The name of the Resource Group that the Storage Account is supposed to be in.

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
