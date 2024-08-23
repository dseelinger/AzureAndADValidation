function Confirm-AzRoleAssignment {
    <#
    .SYNOPSIS
    Tests for the existence of an Azure Role Assignment and (optionally) its specific configuration in Azure.

    .DESCRIPTION
    The Confirm-AzRoleAssignment function takes several parameters and returns $true if it is found and matches the specified 
    configuration, otherwise it returns $false.

    .PARAMETER RoleAssignmentName
    The name of the Role Assignment to look for. This parameter is required.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the Role Assignment is supposed to be in. This parameter is required.

    .PARAMETER PrincipalDisplayName
    The Display Name for the principal (user, group, or service principal) assigned to the role. This parameter is required.

    .PARAMETER RoleDefinitionName
    The name of the role definition (e.g., "Contributor", "Reader"). This parameter is optional.

    .PARAMETER Scope
    The scope of the role assignment (e.g., subscription, resource group, or resource). This parameter is optional.

    .EXAMPLE
    $roleExists = Confirm-AzRoleAssignment -PrincipalId "11111111-1111-1111-1111-111111111111" -RoleDefinitionName "Reader" -Scope "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/MyResourceGroup"
    if ($roleExists) {
        Write-Output "The role assignment 'Reader' exists for the principal in the specified scope."
    } else {
        Write-Output "The role assignment 'Reader' does not exist for the principal in the specified scope."
    }
    Checks if the role assignment "Reader" exists for the specified principal in the given scope and outputs a message accordingly.

    .EXAMPLE
    $result = Confirm-AzRoleAssignment -PrincipalId "22222222-2222-2222-2222-222222222222" -RoleDefinitionName "Owner" -Scope "/subscriptions/22222222-2222-2222-2222-222222222222/resourceGroups/AnotherResourceGroup"
    Write-Output "Role assignment existence: $result"
    Stores the result of the role assignment existence check in a variable and outputs the result.

    .EXAMPLE
    if (Confirm-AzRoleAssignment -PrincipalId "33333333-3333-3333-3333-333333333333" -RoleDefinitionName "Contributor" -Scope "/subscriptions/33333333-3333-3333-3333-333333333333/resourceGroups/YetAnotherResourceGroup") {
        Write-Output "Role assignment 'Contributor' found."
    } else {
        Write-Output "Role assignment 'Contributor' not found."
    }
    Directly checks the existence of the role assignment "Contributor" for the specified principal in the given scope and outputs a message.

    .EXAMPLE
    Confirm-AzRoleAssignment -PrincipalId "44444444-4444-4444-4444-444444444444" -RoleDefinitionName "Reader" -Scope "/subscriptions/44444444-4444-4444-4444-444444444444/resourceGroups/SomeResourceGroup/resources/SomeResource"
    Checks if the role assignment "Reader" exists for the specified principal in the given resource scope.

    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$RoleAssignmentName,

        [Parameter(Mandatory = $true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [string]$PrincipalDisplayName,

        [Parameter(Mandatory = $false)]
        [string]$RoleDefinitionName,

        [Parameter(Mandatory = $false)]
        [string]$Scope
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Resources
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        # Get the role assignments in the specified resource group
        $roleAssignments = Get-AzRoleAssignment -ResourceGroupName $ResourceGroupName

        # Filter the role assignments based on the provided parameters
        $filteredAssignments = $roleAssignments | Where-Object {
            $_.RoleAssignmentName -eq $RoleAssignmentName -and
            $_.DisplayName -eq $PrincipalDisplayName -and
            ([string]::IsNullOrEmpty($RoleDefinitionName) -or $_.RoleDefinitionName -eq $RoleDefinitionName) -and
            ([string]::IsNullOrEmpty($Scope) -or $_.Scope -eq $Scope)
        }

        # Return $true if the role assignment is found, otherwise return $false
        return $filteredAssignments.Count -gt 0
    }
    end {
    }
}
