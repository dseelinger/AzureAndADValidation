BeforeAll {
    . $PSScriptRoot\Confirm-ADGroup.ps1

}

Describe 'Confirm-ADGroup Integration Tests' -Tag 'Integration', 'AD', 'AD-Integration' {
    Context 'When the Group exists' {
        It 'returns $true' {
            # Arrange
            $groups = Get-ADGroup -Filter *
            $randomGroup = $groups | Get-Random
            $realGroupname = $randomGroup.Name

            # Act
            $result = Confirm-ADGroup -Name $realGroupname

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Group does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeGroupName = 'notARealGroup'

            # Act
            $result = Confirm-ADGroup -Name $fakeGroupName

            # Assert
            $result | Should -BeFalse
        }
    }
}

Describe 'Confirm-ADGroup Unit Tests' -Tag 'Unit', 'AD' {
    BeforeAll {
        function Import-Module {}
    }

    Context 'When the Group exists' {
        It 'returns $true' {
            # Arrange
            $realGroupName = 'MyGroup01'
            function Get-ADGroup {}

            # Act
            $result = Confirm-ADGroup -Name $realGroupName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Group does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeGroupName = 'notARealGroup'
            function Get-ADGroup { throw 'Exception'}

            # Act
            $result = Confirm-ADGroup -Name $fakeGroupName

            # Assert
            $result | Should -BeFalse
        }
    }
}