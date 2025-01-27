---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzLogAnalyticsWorkspace

## SYNOPSIS
Tests for the existence of a Log Analytics Workspace in Azure.

## SYNTAX

```
Confirm-AzLogAnalyticsWorkspace [-WorkspaceName] <String> [-ResourceGroupName] <String> [[-Location] <String>]
 [[-Sku] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzLogAnalyticsWorkspace function takes the name of an Azure Log Analytics Workspace and a Resource Group 
name as input and returns $true if it is found, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a Log Analytics Workspace named "MyLogAnalyticsWorkspace01" exists in the resource group 
# "MyResourceGroup01"
Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01"
```

### EXAMPLE 2
```
# Check if a Log Analytics Workspace named "MyLogAnalyticsWorkspace01" exists in the resource group 
# "MyResourceGroup01" and store the result in a variable.
$exists = Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" `
    -ResourceGroupName "MyResourceGroup01"
if ($exists) {
    Write-Output "MyLogAnalyticsWorkspace01 exists in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyLogAnalyticsWorkspace01 does not exist in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 3
```
# Check with a specific location
Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01" `
    -Location "eastus"
```

### EXAMPLE 4
```
# Check with a specific SKU
Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01" `
    -Sku "PerGB2018"
```

### EXAMPLE 5
```
# How to use this in a Pester test
Describe "MyLogAnalyticsWorkspace01 Log Analytics Workspace" {
    It "Should exist in the MyResourceGroup01 Resource Group" {
        Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" `
            -ResourceGroupName "MyResourceGroup01" | Should -Be $true
    }
}
```

## PARAMETERS

### -WorkspaceName
The name of the Log Analytics Workspace to look for.

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
The name of the Resource Group that the Log Analytics Workspace is supposed to be in.

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
The location of the Log Analytics Workspace.
If provided, the function will look for the Log Analytics 
Workspace

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

### -Sku
Optional.
The SKU of the Log Analytics Workspace.
If provided, the function will look for the Log Analytics Workspace

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
