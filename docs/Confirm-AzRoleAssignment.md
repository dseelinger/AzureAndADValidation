---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzRoleAssignment

## SYNOPSIS
Tests for the existence of an Azure Role Assignment and (optionally) its specific configuration in Azure.

## SYNTAX

```
Confirm-AzRoleAssignment [-RoleAssignmentName] <String> [-ResourceGroupName] <String>
 [-PrincipalDisplayName] <String> [[-RoleDefinitionName] <String>] [[-Scope] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzRoleAssignment function takes several parameters and returns $true if it is found and matches the
specified configuration, otherwise it returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if a role assignment named "MyRoleAssignment01" exists in the resource group "MyResourceGroup01"
Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
    -PrincipalDisplayName "MyUser01"
```

### EXAMPLE 2
```
# Check if a role assignment named "MyRoleAssignment01" exists in the resource group "MyResourceGroup01" and store 
# the result in a variable.
$exists = Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
    -PrincipalDisplayName "MyUser01
if ($exists) {
    Write-Output "MyRoleAssignment01 exists in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyRoleAssignment01 does not exist in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 3
```
# Check with a specific role definition
Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
    -PrincipalDisplayName "MyUser01" -RoleDefinitionName "Contributor"
```

### EXAMPLE 4
```
# Check with a specific scope
Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
    -PrincipalDisplayName "MyUser01" -Scope "/subscriptions/00000000-0000-0000-0000-000000000000"
```

### EXAMPLE 5
```
# How to use this in a Pester test
Describe "MyRoleAssignment01 Role Assignment" {
    It "Should exist in the MyResourceGroup01 Resource Group" {
        Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
            -PrincipalDisplayName "MyUser01" | Should -Be $true
    }
}
```

## PARAMETERS

### -RoleAssignmentName
The name of the Role Assignment to look for.
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
The name of the Resource Group that the Role Assignment is supposed to be in.
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

### -PrincipalDisplayName
The Display Name for the principal (user, group, or service principal) assigned to the role.
This parameter is 
required.

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

### -RoleDefinitionName
The name of the role definition (e.g., "Contributor", "Reader").
This parameter is optional.

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

### -Scope
The scope of the role assignment (e.g., subscription, resource group, or resource).
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
