BeforeAll {
    . $PSScriptRoot\Confirm-ADUser.ps1
}

Describe 'Confirm-ADUser Integration Tests' -Tag 'Integration', 'AD', 'AD-Integration' {
    Context 'When the User exists' {
        It 'returns $true' {
            # Arrange
            $realUsername = $env:USERNAME

            # Act
            $result = Confirm-ADUser -Name $realUsername

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the User does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeUserName = 'notARealUser'

            # Act
            $result = Confirm-ADUser -Name $fakeUserName

            # Assert
            $result | Should -BeFalse
        }
    }
}

Describe 'Confirm-ADUser Unit Tests' -Tag 'Unit', 'AD' {
    BeforeAll {
        function Import-Module {}
    }

    Context 'When the User exists' {
        It 'returns $true' {
            # Arrange
            $realUserName = 'johnsmith'
            function Get-ADUser {}

            # Act
            $result = Confirm-ADUser -Name $realUserName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the User does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeUserName = 'notARealUser'
            function Get-ADUser { throw 'Exception'}

            # Act
            $result = Confirm-ADUser -Name $fakeUserName

            # Assert
            $result | Should -BeFalse
        }
    }
}