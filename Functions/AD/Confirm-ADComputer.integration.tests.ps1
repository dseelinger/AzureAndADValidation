BeforeAll {
    . $PSScriptRoot\Confirm-ADComputer.ps1
}

Describe 'Confirm-ADComputer Integration Tests' -Tag 'Integration' {
    Context 'When the computer exists' {
        It 'returns $true' {
            # Arrange
            $realComputerName = $env:COMPUTERNAME

            # Act
            $result = Confirm-ADComputer -Name $realComputerName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the computer does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeComputerName = 'thisComputerDoesNotExist'

            # Act
            $result = Confirm-ADComputer -Name $fakeComputerName

            # Assert
            $result | Should -BeFalse
        }
    }
}