BeforeAll {
    . $PSScriptRoot\Confirm-ADOU.ps1

    function Get-CurrentUserOU {
        $currentUsername = $env:USERNAME
        $user = Get-ADUser -Identity $currentUsername
        $userDN = $user.DistinguishedName
        return ($userDN -split ",", 2)[1]
    }
}

Describe 'Confirm-ADOU Integration Tests' -Tag 'Integration', 'AD' {
    Context 'When the OU exists' {
        It 'returns $true' {
            # Arrange
            $realOUDN = Get-CurrentUserOU

            # Act
            $result = Confirm-ADOU -OUDN $realOUDN

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the OU does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeOUName = 'thisOUDoesNotExist'

            # Act
            $result = Confirm-ADOU -OUDN $fakeOUName

            # Assert
            $result | Should -BeFalse
        }
    }
}

Describe 'Confirm-ADOU Unit Tests' -Tag 'Unit', 'AD' {
    BeforeAll {
        function Import-Module {}
    }

    Context 'When the OU exists' {
        It 'returns $true' {
            # Arrange
            $realOUName = 'OU=YourOU,DC=YourDomain,DC=com'
            function Get-ADOrganizationalUnit {}

            # Act
            $result = Confirm-ADOU -OUDN $realOUName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the OU does not exist' {
        It 'returns $false' {
            # Arrange
            $fakeOUName = 'OU=thisOU,DC=DoesNotExist,DC=com'
            function Get-ADOrganizationalUnit { throw 'Exception'}

            # Act
            $result = Confirm-ADOU -OUDN $fakeOUName

            # Assert
            $result | Should -BeFalse
        }
    }
}