BeforeAll {
    . $PSScriptRoot\Confirm-AzKeyVault.ps1

    $location = $env:AZURE_LOCATION
    $rgName = 'rg-integration-tests'
    $testKeyVaultName = 'test-KeyVault-name' + (-join (1..5 | ForEach-Object { Get-Random -Minimum 0 -Maximum 10 }))
    $fakeKeyVaultName = 'bad-KeyVault-name'
}

Describe 'Confirm-AzKeyVault Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a KeyVault to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        New-AzKeyVault -ResourceGroupName $rgName -VaultName $testKeyVaultName -Location $location | Out-Null
    }
    
    Context 'When the KeyVault exists' {
        It 'returns $true' {

            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $testKeyVaultName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the KeyVault does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $fakeKeyVaultName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'Location' {
        It 'returns $false when the location does not match' {
            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $testKeyVaultName -ResourceGroupName $rgName -Location 'westus'

            # Assert
            $result | Should -BeFalse
        }
        It 'returns $true when the location matches' {
            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $testKeyVaultName -ResourceGroupName $rgName -Location $location

            # Assert
            $result | Should -BeTrue
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force
    }
}

Describe 'Confirm-AzKeyVault Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the KeyVault exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzKeyVault { return @{ Name = $testKeyVaultName } }

            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $testKeyVaultName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the KeyVault does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzKeyVault { return $null }

            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $fakeKeyVaultName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'Location' {
        It 'returns $false when the location does not match' {
            # Arrange
            function Get-AzKeyVault { return @{ Name = $testKeyVaultName; Location = 'westus' } }

            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $testKeyVaultName -ResourceGroupName $rgName -Location $location

            # Assert
            $result | Should -BeFalse
        }
        It 'returns $true when the location matches' {
            # Arrange
            function Get-AzKeyVault { return @{ Name = $testKeyVaultName; Location = $location } }

            # Act
            $result = Confirm-AzKeyVault -KeyVaultName $testKeyVaultName -ResourceGroupName $rgName -Location $location

            # Assert
            $result | Should -BeTrue
        }
    }
}
