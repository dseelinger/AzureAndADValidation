---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-ADComputer

## SYNOPSIS
Tests for the existence of an AD Computer object in Active Directory.

## SYNTAX

```
Confirm-ADComputer [-Name] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-ADComputer function takes a computer name as input and returns $true if the computer is found, otherwise 
returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a computer named "VirtualMachine01" exists in Active Directory
Confirm-ADComputer -Name "VirtualMachine01"
```

### EXAMPLE 2
```
# Use the result in a script to perform an action if the computer exists
if (Confirm-ADComputer -Name "VirtualMachine01") {
    Write-Output "Computer VirtualMachine01 exists in Active Directory."
} else {
    Write-Output "Computer VirtualMachine01 does not exist in Active Directory."
}
```

### EXAMPLE 3
```
# Use in a Pester Test
Describe "VirtualMachine01" {
    It "Should exist" {
        Confirm-ADComputer -Name "VirtualMachine01" | Should -Be $true
    }
}
```

## PARAMETERS

### -Name
The name of the AD Computer object to look for.

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
