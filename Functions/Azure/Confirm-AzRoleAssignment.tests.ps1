BeforeAll {
    . $PSScriptRoot\Confirm-AzRoleAssignment.ps1

    # Arrange - Set up variables
    $location = $env:AZURE_LOCATION
    $resourceGroupName = "rg-integration-tests"
    $principalDisplayName = "sp-integration-tests"
    $roleDefinitionName = "Contributor"
    $context = Get-AzContext
    $subscriptionId = $context.Subscription.Id
    $scope = "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName"
}

Describe 'Confirm-AzRoleAssignment Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a service principal and assign it the Contributor role
        $sp = New-AzADServicePrincipal -DisplayName $principalDisplayName
        $principalId = $sp.Id
        New-AzResourceGroup -Name $resourceGroupName -Location $location
        $roleAssignment = New-AzRoleAssignment -ObjectId $principalId -RoleDefinitionName $roleDefinitionName -Scope $scope
        $roleAssignmentName = $roleAssignment.RoleAssignmentName
    }

    Context 'When the RoleAssignment does not exist at all (no role assignment name, resource group, or principal ID match)' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName 'role-assignment-does-not-exist' `
                -ResourceGroupName $resourceGroupName -PrincipalDisplayName $principalDisplayName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the RoleAssignment rule exists for the specified PrincipalId in the correct resource group... ' {
        It 'returns $true if no other parameters are provided' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName `
                -ResourceGroupName $resourceGroupName -PrincipalDisplayName $principalDisplayName

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $true if all parameters match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName `
                -ResourceGroupName $resourceGroupName -PrincipalDisplayName $principalDisplayName `
                -RoleDefinitionName $roleDefinitionName -Scope $scope

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if the RoleDefinition does not match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName `
                -ResourceGroupName $resourceGroupName -PrincipalDisplayName $principalDisplayName `
                -RoleDefinitionName 'Reader' -Scope $scope

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the Scope does not match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName `
                -ResourceGroupName $resourceGroupName -PrincipalDisplayName $principalDisplayName `
                -RoleDefinitionName $roleDefinitionName -Scope "/subscriptions/$subscriptionId"

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $resourceGroupName -Force
        Remove-AzADServicePrincipal -ObjectId $principalId
    }
}

Describe 'Confirm-AzRoleAssignment Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Import-Module {}
        function Get-AzContext { return $true }
        $roleAssignmentName = 'role-assignment-name'
    }
    
    Context 'When the role assignment does not exist at all (no role name, principal name, or resource group match)' {
        It 'returns $false' {
            # Arrange
            function Get-AzRoleAssignment { return $null }

            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName 'role-assignment-does-not-exist' -PrincipalDisplayName $principalDisplayName `
            -RoleDefinitionName $roleDefinitionName -Scope $scope -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the role assignment exists in the correct scope (and resource group)... ' {
        BeforeAll {
            # Arrange - Create a mock role assignment to test against
            $mockRoleAssignment = [PSCustomObject]@{
                RoleAssignmentName = $roleAssignmentName
                DisplayName = $principalDisplayName
                RoleDefinitionName = $roleDefinitionName
                Scope = $scope
                ResourceGroupName = $resourceGroupName
            }

            function Get-AzRoleAssignment { return $mockRoleAssignment }
        }
        It 'returns $true if no other parameters are provided' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName -PrincipalDisplayName $principalDisplayName `
            -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $true if all parameters match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName -PrincipalDisplayName $principalDisplayName `
            -RoleDefinitionName $roleDefinitionName -Scope $scope -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if the role definition name does not match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName -PrincipalDisplayName $principalDisplayName `
            -RoleDefinitionName 'DifferentRoleDefinitionName' -Scope $scope -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the scope does not match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName -PrincipalDisplayName $principalDisplayName `
            -RoleDefinitionName $roleDefinitionName -Scope 'DifferentScope' -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the principal display name does not match' {
            # Act
            $result = Confirm-AzRoleAssignment -RoleAssignmentName $roleAssignmentName -PrincipalDisplayName 'DifferentPrincipalDisplayName' `
            -RoleDefinitionName $roleDefinitionName -Scope $scope -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeFalse
        }
    }
}
