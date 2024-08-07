---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-ADOU

## SYNOPSIS
Tests for the existence of an AD Organizational Unit (OU) object in Active Directory.

## SYNTAX

```
Confirm-ADOU [-OUDN] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-ADOU function takes an LDAP Path for an OU as input and returns $true if the OU is found, otherwise 
returns $false.

## EXAMPLES

### EXAMPLE 1
```
Confirm-ADOU -OUDN "OU=YourOU,DC=YourDomain,DC=com"
Returns $true if found or $false if not found
```

## PARAMETERS

### -OUDN
The LDAP path (aka OU's "Distinguished Name" (DN)) of the OU object to look for.

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
