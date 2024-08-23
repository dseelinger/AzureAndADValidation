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
The Test-GroupMembership function takes a group name and a member name and returns $true if the member name is found in the member property for the group, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
Test-GroupMembership -GroupName "MyGroup01" -MemberName "MySAMAccountName01"
Returns $true or $false
```

### EXAMPLE 2
```
Test-GroupMembership -GroupName "Admins" -MemberName "JohnDoe"
Checks if the user "JohnDoe" is a member of the "Admins" group and returns $true or $false.
```

### EXAMPLE 3
```
$result = Test-GroupMembership -GroupName "HR" -MemberName "JaneSmith"
if ($result) {
    Write-Output "JaneSmith is a member of the HR group."
} else {
    Write-Output "JaneSmith is not a member of the HR group."
}
Checks if "JaneSmith" is a member of the "HR" group and outputs a message accordingly.
```

### EXAMPLE 4
```
$isMember = Test-GroupMembership -GroupName "ITSupport" -MemberName "AliceW"
Write-Output "Membership status: $isMember"
Stores the result of the membership check in a variable and outputs the membership status.
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
