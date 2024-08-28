BeforeAll {
    . $PSScriptRoot\Confirm-AzWvdWorkspace.ps1

    $rgName = 'rg-integration-tests'
    $testWorkspaceName = 'testWorkspace'
    $fakeWorkspaceName = 'notARealWorkspace'
}

Describe 'Confirm-AzWvdWorkspace Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Resource Group and WVD Workspace to test against
        $location = $env:AZURE_LOCATION
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null

        # Create a WVD Workspace
        New-AzWvdWorkspace -ResourceGroupName $rgName -Name $testWorkspaceName -Location $location | Out-Null
    }
    
    Context 'When the Workspace exists' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzWvdWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Workspace does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzWvdWorkspace -WorkspaceName $fakeWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force
    }
}

Describe 'Confirm-AzWvdWorkspace Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the Workspace exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzWvdWorkspace { return [PSCustomObject]@{Name = "testWorkspace"; ResourceGroupName = "rg-integration-tests" } }

            # Act
            $result = Confirm-AzWvdWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Workspace does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdWorkspace { return $null }

            # Act
            $result = Confirm-AzWvdWorkspace -WorkspaceName $fakeWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}