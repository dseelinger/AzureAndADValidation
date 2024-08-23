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
Confirm-AzLogAnalyticsWorkspace [-WorkspaceName] <String> [-ResourceGroupName] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzLogAnalyticsWorkspace function takes the name of an Azure Log Analytics Workspace and a Resource Group name
as input and returns $true if it is found, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyWorkspace01" -ResourceGroupName "MyResourceGroup01"
Returns $true or $false
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
