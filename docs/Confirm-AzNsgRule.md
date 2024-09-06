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
# Check if an NSG rule named "MyNsgRule01" exists in the resource group "MyResourceGroup01" in the NSG "MyNsg01"
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01"
```

### EXAMPLE 2
```
# Check if an NSG rule named "MyNsgRule01" exists in the resource group "MyResourceGroup01" in the NSG "MyNsg01" and
# store the result in a variable.
$exists = Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01"
if ($exists) {
    Write-Output "MyNsgRule01 exists in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyNsgRule01 does not exist in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 3
```
# Check with a specific priority
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" -Priority 100
```

### EXAMPLE 4
```
# Check with a specific SourceAddressPrefix
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" `
    -SourceAddressPrefix '192.168.1.0/24'
```

### EXAMPLE 5
```
# Check with a specific SourcePortRange
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" `
    -SourcePortRange "80"
```

### EXAMPLE 6
```
# Check with a specific DestinationAddressPrefix
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" `
    -DestinationAddressPrefix '
```

### EXAMPLE 7
```
# Check with a specific DestinationPortRange
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" `
    -DestinationPortRange "80"
```

### EXAMPLE 8
```
# Check with a specific Protocol
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" -Protocol "TCP"
```

### EXAMPLE 9
```
# Check with a specific Access
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" -Access "Allow"
```

### EXAMPLE 10
```
# Check with a specific Direction
Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" -Direction "Inbound"
```

### EXAMPLE 11
```
# How to use this in a Pester test
Describe "MyNsgRule01 NSG Rule" {
    It "Should exist in the MyResourceGroup01 Resource Group" {
        Confirm-AzNsgRule -Name "MyNsgRule01" -ResourceGroupName "MyResourceGroup01" -NsgName "MyNsg01" `
            | Should -Be $true
    }
}
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
