BeforeAll {
    . $PSScriptRoot\Confirm-AzLogAnalyticsWorkspace.ps1

    $location = $env:AZURE_LOCATION
    $rgName = 'rg-integration-tests'
    $testWorkspaceName = 'test-workspace-name'
    $fakeWorkspaceName = 'bad-workspace-name'
}

Describe 'Confirm-AzLogAnalyticsWorkspace Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Log Analytics Workspace to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        New-AzOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $testWorkspaceName -Location $location `
            -Sku PerGB2018 | Out-Null
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

    Context 'Location' {
        It 'returns $false when the location does not match' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Location 'eastus'

            # Assert
            $result | Should -BeFalse
        }
        It 'returns $true when the location matches' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Location $location

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'Sku' {
        It 'returns $false when the SKU does not match' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Sku 'PerNode'

            # Assert
            $result | Should -BeFalse
        }
        It 'returns $true when the SKU matches' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Sku 'PerGB2018'

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When all optional parameters are provided' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Location $location -Sku 'PerGB2018'

            # Assert
            $result | Should -BeTrue
        }
    }

    AfterAll {
        # Clean up - Remove the created Log Analytics Workspace and Resource Group
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

    Context 'Location' {
        It 'returns $false when the location does not match' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return @{ Location = 'eastus'; Sku = 'PerGB2018' } }

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Location $location

            # Assert
            $result | Should -BeFalse
        }
        It 'returns $true when the location matches' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return @{ Location = $location; Sku = 'PerGB2018' } }

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Location $location

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'Sku' {
        It 'returns $false when the SKU does not match' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return @{ Location = $location; Sku = 'PerNode' } } 

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Sku 'PerGB2018'

            # Assert
            $result | Should -BeFalse
        }
        It 'returns $true when the SKU matches' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return @{ Location = $location; Sku = 'PerGB2018' } } 

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Sku 'PerGB2018'

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When all optional parameters are provided' {
        It 'returns $true' {
            # Arrange
            function Get-AzOperationalInsightsWorkspace { return @{ Location = $location; Sku = 'PerGB2018' } }

            # Act
            $result = Confirm-AzLogAnalyticsWorkspace -WorkspaceName $testWorkspaceName -ResourceGroupName $rgName `
                -Location $location -Sku 'PerGB2018'

            # Assert
            $result | Should -BeTrue
        }
    }
}
