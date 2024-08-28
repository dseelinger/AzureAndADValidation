BeforeAll {
    . $PSScriptRoot\Confirm-AzStorageAccount.ps1

    $location = $env:AZURE_LOCATION
    $testResourceGroupName = 'test-ResourceGroup-name'
    $testStorageAccountName = 'absintegrationteststorag'
    $fakeStorageAccountName = 'fakestorageaccount'
}

Describe 'Confirm-AzStorageAccount Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Resource Group and a Storage Account to test against
        New-AzResourceGroup -Name $testResourceGroupName -Location $location | Out-Null

        # Create a Storage Account
        $storageAccountParams = @{
            ResourceGroupName = $testResourceGroupName
            Name              = $testStorageAccountName
            Location          = $location
            SkuName           = 'Standard_LRS'
            Kind              = 'StorageV2'
        }
        New-AzStorageAccount @storageAccountParams | Out-Null
    }
    
    Context 'When the Storage Account exists' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzStorageAccount -StorageAccountName $testStorageAccountName `
                -ResourceGroupName $testResourceGroupName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Storage Account does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzStorageAccount -StorageAccountName $fakeStorageAccountName `
                -ResourceGroupName $testResourceGroupName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        # Clean up - Remove the Resource Group and Storage Account
        Remove-AzResourceGroup -Name $testResourceGroupName -Force | Out-Null
    }
}

Describe 'Confirm-AzStorageAccount Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the Storage Account exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzStorageAccount { return @{ Name = $testStorageAccountName } }

            # Act
            $result = Confirm-AzStorageAccount -StorageAccountName $testStorageAccountName `
                -ResourceGroupName $testResourceGroupName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Storage Account does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzStorageAccount { return $null }

            # Act
            $result = Confirm-AzStorageAccount -StorageAccountName $fakeStorageAccountName `
                -ResourceGroupName $testResourceGroupName

            # Assert
            $result | Should -BeFalse
        }
    }
}