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
Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01"
Returns $true or $false
```

### EXAMPLE 2
```
$nicExists = Confirm-AzNic -NicName "WebServerNic" -ResourceGroupName "WebResourceGroup"
if ($nicExists) {
    Write-Output "The NIC 'WebServerNic' exists in the 'WebResourceGroup' resource group."
} else {
    Write-Output "The NIC 'WebServerNic' does not exist in the 'WebResourceGroup' resource group."
}
Checks if the NIC "WebServerNic" exists in the "WebResourceGroup" and outputs a message accordingly.
```

### EXAMPLE 3
```
$result = Confirm-AzNic -NicName "DatabaseNic" -ResourceGroupName "DatabaseResourceGroup"
Write-Output "NIC existence: $result"
Stores the result of the NIC existence check in a variable and outputs the result.
```

### EXAMPLE 4
```
if (Confirm-AzNic -NicName "AppServerNic" -ResourceGroupName "AppResourceGroup") {
    Write-Output "NIC 'AppServerNic' found."
} else {
    Write-Output "NIC 'AppServerNic' not found."
}
Directly checks the existence of the NIC "AppServerNic" in the "AppResourceGroup" and outputs a message.
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
Optional. The location of the NIC. If provided, the function will look for the NIC in the specified location.

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
