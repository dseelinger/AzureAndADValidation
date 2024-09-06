---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-ADGroup

## SYNOPSIS
Tests for the existence of an AD Group object in Active Directory.

## SYNTAX

```
Confirm-ADGroup [-Name] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-ADGroup function takes a group name as input and returns $true if it is found, otherwise it returns 
$false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a group named "MyGroup01" exists in AD
Confirm-ADGroup -Name "MyGroup01"
```

### EXAMPLE 2
```
# Check if a group named "Admins" exists in AD and store the result in a variable
$exists = Confirm-ADGroup -Name "Admins"
if ($exists) {
    Write-Output "Admins group exists in Active Directory."
} else {
    Write-Output "Admins group does not exist in Active Directory."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "Foo Group" {
    It "Should exist at this point" {
        Confirm-ADGroup -Name "Foo" | Should -Be $true
    }
}
```

## PARAMETERS

### -Name
The name of the AD Group to look for.

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
