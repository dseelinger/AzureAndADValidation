---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzNsgRule

## SYNOPSIS
Tests for the existence of an NSG rule and (optionally) its specific configuration in Azure.

## SYNTAX

```
Confirm-AzNsgRule [-Name] <String> [-ResourceGroupName] <String> [-NsgName] <String> [[-Priority] <Int32>]
 [[-SourceAddressPrefix] <String>] [[-SourcePortRange] <String>] [[-DestinationAddressPrefix] <String>]
 [[-DestinationPortRange] <String>] [[-Protocol] <String>] [[-Access] <String>] [[-Direction] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzNsgRule function takes several parameters and returns $true if it is found and matches the specified 
configuration, otherwise it returns $false.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzNsgRule -Name "MyNsgRule" -ResourceGroupName "MyResourceGroup" -NsgName "MyNsg"
Returns $true or $false
```

### EXAMPLE 2
```
$ruleExists = Confirm-AzNsgRule -Name "AllowSSH" -ResourceGroupName "ProdResourceGroup" -NsgName "ProdNsg"
if ($ruleExists) {
    Write-Output "The NSG rule 'AllowSSH' exists in the 'ProdNsg' NSG."
} else {
    Write-Output "The NSG rule 'AllowSSH' does not exist in the 'ProdNsg' NSG."
}
Checks if the NSG rule "AllowSSH" exists in the "ProdNsg" NSG and outputs a message accordingly.
```

### EXAMPLE 3
```
$result = Confirm-AzNsgRule -Name "DenyAll" -ResourceGroupName "TestResourceGroup" -NsgName "TestNsg"
Write-Output "NSG rule existence: $result"
Stores the result of the NSG rule existence check in a variable and outputs the result.
```

### EXAMPLE 4
```
if (Confirm-AzNsgRule -Name "AllowHTTP" -ResourceGroupName "WebResourceGroup" -NsgName "WebNsg") {
    Write-Output "NSG rule 'AllowHTTP' found."
} else {
    Write-Output "NSG rule 'AllowHTTP' not found."
}
Directly checks the existence of the NSG rule "AllowHTTP" in the "WebNsg" NSG and outputs a message.
```

### EXAMPLE 5
```
Confirm-AzNsgRule -Name "AllowRDP" -ResourceGroupName "RemoteAccessGroup" -NsgName "RemoteAccessNsg" -Protocol "TCP" -SourceAddressPrefix "10.0.0.0/24" -DestinationPortRange "3389"
Checks if the NSG rule "AllowRDP" with specific protocol, source address prefix, and destination port range exists in the "RemoteAccessNsg" NSG.
```

## PARAMETERS

### -Name
The name of the NSG rule to look for.
This parameter is required.

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
The name of the Resource Group that the NSG is supposed to be in.
This parameter is required.

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

### -NsgName
The name of the Network Security Group.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Priority
The priority of the NSG rule.
This parameter is optional.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceAddressPrefix
The source address prefix of the NSG rule.
This parameter is optional.

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

### -SourcePortRange
The source port range of the NSG rule.
This parameter is optional.

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

### -DestinationAddressPrefix
The destination address prefix of the NSG rule.
This parameter is optional.

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

### -DestinationPortRange
The destination port range of the NSG rule.
This parameter is optional.

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

### -Protocol
The protocol of the NSG rule.
This parameter is optional.

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

### -Access
The access type of the NSG rule (Allow/Deny).
This parameter is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Direction
The direction of the NSG rule (Inbound/Outbound).
This parameter is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
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
