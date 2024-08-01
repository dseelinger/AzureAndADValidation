BeforeAll {
    . $PSScriptRoot\Confirm-ADComputer.ps1
}

Describe 'Confirm-ADComputer Integration Tests' -Tag 'Integration', 'AD' {
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

Describe 'Confirm-ADComputer Unit Tests' -Tag 'Unit', 'AD' {
    BeforeAll {
        function Import-Module {}
    }

    Context 'When the computer exists' {
        It 'returns $true' {
            # Arrange
            $realComputerName = $env:COMPUTERNAME
            function Get-ADComputer {}

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
            function Get-ADComputer { throw 'Exception'}

            # Act
            $result = Confirm-ADComputer -Name $fakeComputerName

            # Assert
            $result | Should -BeFalse
        }
    }
}