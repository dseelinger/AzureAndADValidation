function Confirm-AzRoleAssignment {
    <#
    .SYNOPSIS
        Tests for the existence of an Azure Role Assignment and (optionally) its specific configuration in Azure.

    .DESCRIPTION
        The Confirm-AzRoleAssignment function takes several parameters and returns $true if it is found and matches the
        specified configuration, otherwise it returns $false.

    .PARAMETER RoleAssignmentName
        The name of the Role Assignment to look for. This parameter is required.

    .PARAMETER ResourceGroupName
        The name of the Resource Group that the Role Assignment is supposed to be in. This parameter is required.

    .PARAMETER PrincipalDisplayName
        The Display Name for the principal (user, group, or service principal) assigned to the role. This parameter is 
        required.

    .PARAMETER RoleDefinitionName
        The name of the role definition (e.g., "Contributor", "Reader"). This parameter is optional.

    .PARAMETER Scope
        The scope of the role assignment (e.g., subscription, resource group, or resource). This parameter is optional.

    .EXAMPLE
        # Check if a role assignment named "MyRoleAssignment01" exists in the resource group "MyResourceGroup01"
        Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
            -PrincipalDisplayName "MyUser01"

    .EXAMPLE
        # Check if a role assignment named "MyRoleAssignment01" exists in the resource group "MyResourceGroup01" and store 
        # the result in a variable.
        $exists = Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
            -PrincipalDisplayName "MyUser01
        if ($exists) {
            Write-Output "MyRoleAssignment01 exists in the MyResourceGroup01 Resource Group."
        } else {
            Write-Output "MyRoleAssignment01 does not exist in the MyResourceGroup01 Resource Group."
        }

    .EXAMPLE
        # Check with a specific role definition
        Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
            -PrincipalDisplayName "MyUser01" -RoleDefinitionName "Contributor"

    .EXAMPLE
        # Check with a specific scope
        Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
            -PrincipalDisplayName "MyUser01" -Scope "/subscriptions/00000000-0000-0000-0000-000000000000"


    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyRoleAssignment01 Role Assignment" {
            It "Should exist in the MyResourceGroup01 Resource Group" {
                Confirm-AzRoleAssignment -RoleAssignmentName "MyRoleAssignment01" -ResourceGroupName "MyResourceGroup01" `
                    -PrincipalDisplayName "MyUser01" | Should -Be $true
            }
        }

    .NOTES
        Author: Doug Seelinger
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
