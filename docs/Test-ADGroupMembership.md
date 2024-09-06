---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Test-ADGroupMembership

## SYNOPSIS
Tests to see if one AD object is in the \[member\] property of an AD Group.

## SYNTAX

```
Test-ADGroupMembership [-GroupName] <String> [-MemberName] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Test-GroupMembership function takes a group name and a member name and returns $true if the member name is found
in the member property for the group, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a user named "jdoe" is a member of the group "FooUsers"
Test-ADGroupMembership -GroupName "FooUsers" -MemberName "jdoe"
```

### EXAMPLE 2
```
# Check if a user named "jdoe" is a member of the group "FooUsers" and store the result in a variable
$exists = Test-ADGroupMembership -GroupName "FooUsers" -MemberName "jdoe"
if ($exists) {
    Write-Output "User jdoe is a member of the FooUsers group."
} else {
    Write-Output "User jdoe is not a member of the FooUsers group."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "jdoe User" {
    It "Should be a member of the FooUsers group" {
        Test-ADGroupMembership -GroupName "FooUsers" -MemberName "jdoe" | Should -Be $true
    }
}
```

## PARAMETERS

### -GroupName
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

### -MemberName
The username of the member to search for within the group.

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
