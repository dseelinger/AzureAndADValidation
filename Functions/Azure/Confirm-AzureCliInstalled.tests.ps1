BeforeAll {
    . $PSScriptRoot\Confirm-AzureCliInstalled.ps1
}

# Iteration tests are more trouble than they're worth for this function, so we'll just unittest the two possible outcomes.

Describe 'Confirm-AzureCliInstalled Unit Tests' -Tag 'Unit', 'Azure' {
    Context 'When the Azure CLI is present on the current machine' {
        It 'returns $true' {
            # Arrange
            function Get-Command { return @{ Name = 'az' } }

            # Act
            $result = Confirm-AzureCliInstalled

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Azure CLI is NOT present on the current machine' {
        It 'returns $false' {
            # Arrange
            function Get-Command { return $null }

            # Act
            $result = Confirm-AzureCliInstalled

            # Assert
            $result | Should -BeFalse
        }
    }
}