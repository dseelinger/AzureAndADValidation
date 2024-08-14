BeforeAll {
    . $PSScriptRoot\Confirm-AzLogAnalyticsWorkspace.ps1

    $location = 'usgovvirginia'
    $rgName = 'rg-integration-tests'
    $testWorkspaceName = 'test-workspace-name'
    $fakeWorkspaceName = 'bad-workspace-name'
}

Describe 'Confirm-AzLogAnalyticsWorkspace Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Log Analytics Workspace to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        New-AzOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $testWorkspaceName -Location $location -Sku PerGB2018 | Out-Null
    }
    
    Context 'When the Log Analytics Workspace exists' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Log Analytics Workspace does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $fakeWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        # Clean up - Remove the created Log Analytics Workspace and Resource Group
        Remove-AzOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $testWorkspaceName -Force | Out-Null
        Remove-AzResourceGroup -Name $rgName -Force | Out-Null
    }
}

Describe 'Confirm-AzLogAnalyticsWorkspace Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the Log Analytics Workspace exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return @{ Name = $testWorkspaceName } }

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Log Analytics Workspace does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return $null }

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $fakeWorkspaceName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}