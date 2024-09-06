---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-ADUser

## SYNOPSIS
Tests for the existence of an AD User object in Active Directory.

## SYNTAX

```
Confirm-ADUser [-Name] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-ADUser function takes a user name as input and returns $true if it is found, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a user named "MySAMAccountName01" exists in AD
Confirm-ADUser -Name "MySAMAccountName01"
```

### EXAMPLE 2
```
# Check if a user named "jdoe" exists in AD and store the result in a variable
$exists = Confirm-ADUser -Name "jdoe"
if ($exists) {
    Write-Output "User jdoe exists in Active Directory."
} else {
    Write-Output "User jdoe does not exist in Active Directory."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "jdoe User" {
    It "Should exist at this point" {
        Confirm-ADUser -Name "jdoe" | Should -Be $true
    }
}
```

## PARAMETERS

### -Name
The username of the AD User to look for.

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
