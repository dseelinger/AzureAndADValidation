BeforeAll {
    . $PSScriptRoot\Confirm-AzResourceGroup.ps1

    $location = $env:AZURE_LOCATION
    $rgName = $env:AZURE_RESOURCE_GROUP
    $fakeResourceGroupName = 'bad-ResourceGroup-name'
}

Describe 'Confirm-AzResourceGroup Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a ResourceGroup to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
    }
    
    Context 'When the Resource Group exists' {
        It 'returns $true' {

            # Act
            $result = Confirm-AzResourceGroup -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Resource Group does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzResourceGroup -ResourceGroupName $fakeResourceGroupName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force | Out-Null
    }
}

Describe 'Confirm-AzResourceGroup Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the Resource Group exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzResourceGroup { return @{ Name = $rgName } }

            # Act
            $result = Confirm-AzResourceGroup -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Resource Group does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzResourceGroup { return $null }

            # Act
            $result = Confirm-AzResourceGroup -ResourceGroupName $fakeResourceGroupName

            # Assert
            $result | Should -BeFalse
        }
    }
}
