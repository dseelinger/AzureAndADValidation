---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzHostPool

## SYNOPSIS
Tests for the existence of a HostPool in Azure.

## SYNTAX

```
Confirm-AzHostPool [-HostPoolName] <String> [-ResourceGroupName] <String> [[-Location] <String>]
 [[-HostPoolType] <String>] [[-LoadBalancerType] <String>] [[-MaxSessionLimit] <Int32>]
 [[-PreferredAppGroupType] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzHostPool function takes the name of an Azure HostPool as input and returns $true if it is found,
otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzHostPool -Name "MyHostPool01"
Returns $true or $false
```

## PARAMETERS

### -HostPoolName
The name of the HostPool to look for.

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
The name of the Resource Group that the HostPool is supposed to be in.

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
Optional. The location of the HostPool. If provided, the function will look for the HostPool in the specified 
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

### -HostPoolType
Optional. The type of HostPool to look for. If provided, the function will look for the HostPool with the specified 
type.

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

### -LoadBalancerType
Optional. The type of Load Balancer to look for. If provided, the function will look for the HostPool with the 
specified Load Balancer type.

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

### -MaxSessionLimit
Optional. The maximum number of sessions allowed in the HostPool. If provided, the function will check that the 
HostPool has the same MaxSessionLimit.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreferredAppGroupType
Optional. The preferred App Group type for the HostPool. If provided, the function will check that the HostPool has 
the same PreferredAppGroupType.

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
