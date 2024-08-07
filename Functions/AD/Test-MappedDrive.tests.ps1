BeforeAll {
    . $PSScriptRoot\Test-MappedDrive.ps1

}

Describe 'Test-MappedDrive Integration Tests' -Tag 'Integration' {
    BeforeAll {
        # Arrange - Create a mapped drive
        $driveLetter = 'W'
        $localPath = 'C:\Windows'
        New-PSDrive -Name $driveLetter -PSProvider FileSystem -Root $localPath | Out-Null
    }

    Context 'With just a Mapped Driveletter' {
        It 'returns $true if it exists' {
            # Act
            $result = Test-MappedDrive -DriveLetter $driveLetter

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if it does not exist' {
            # Arrange
            $nonExistentDriveLetter = 'Q'

            # Act
            $result = Test-MappedDrive -driveLetter $nonExistentDriveLetter

            # Assert
            $result | Should -BeFalse
        }
    }


    Context 'With just a specific Path' {
        It 'returns $true if it exists' {
            # Arrange
            $mappedPath = 'C:\Windows'

            # Act
            $result = Test-MappedDrive -Path $mappedPath

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if it does not exist' {
            # Arrange
            $mappedPath = 'C:\Users'

            # Act
            $result = Test-MappedDrive -Path $mappedPath

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'With both a Driveletter with a Path' {
        It 'returns $true if both exist' {
            # Arrange
            $mappedPath = 'C:\Windows'

            # Act
            $result = Test-MappedDrive -Path $mappedPath -DriveLetter $driveLetter

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if either the drive letter or path does not exist' {
            # Arrange
            $mappedPath = 'C:\Users'

            # Act
            $result = Test-MappedDrive -Path $mappedPath -DriveLetter $driveLetter

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'With a Driveletter that has a colon' {
        It 'returns $true if it exists' {
            # Arrange
            $driveLetterWithColon = 'W:'

            # Act
            $result = Test-MappedDrive -DriveLetter $driveLetterWithColon

            # Assert
            $result | Should -BeTrue
        }
    }

    AfterAll {
        Remove-PSDrive -Name $driveLetter
    }
}

Describe 'Test-MappedDrive Unit Tests' -Tag 'Unit' {
    BeforeAll {
        # Arrange
        $driveLetter = 'W'
        $localPath = 'C:\Windows'
    }

    Context 'With just a Mapped Driveletter' {
        It 'returns $true if it exists' {
            # Arrange
            function Get-PSDrive {return @{'Name' = 'W'; 'Root' = 'C:\Windows'}}

            # Act
            $result = Test-MappedDrive -DriveLetter $driveLetter

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if it does not exist' {
            # Arrange
            $nonExistentDriveLetter = 'Q'
            function Get-PSDrive {return $null}

            # Act
            $result = Test-MappedDrive -driveLetter $nonExistentDriveLetter

            # Assert
            $result | Should -BeFalse
        }
    }


    Context 'With just a specific Path' {
        It 'returns $true if it exists' {
            # Arrange
            $mappedPath = 'C:\Windows'
            function Get-PSDrive {return @{'Name' = 'W'; 'Root' = 'C:\Windows'}}

            # Act
            $result = Test-MappedDrive -Path $mappedPath

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if it does not exist' {
            # Arrange
            $mappedPath = 'C:\Users'
            function Get-PSDrive {return $null}

            # Act
            $result = Test-MappedDrive -Path $mappedPath

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'With both a Driveletter with a Path' {
        It 'returns $true if both exist' {
            # Arrange
            $mappedPath = 'C:\Windows'
            function Get-PSDrive {return @{'Name' = 'W'; 'Root' = 'C:\Windows'}}

            # Act
            $result = Test-MappedDrive -Path $mappedPath -DriveLetter $driveLetter

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if either the drive letter or path does not exist' {
            # Arrange
            $mappedPath = 'C:\Users'
            function Get-PSDrive {return $null}

            # Act
            $result = Test-MappedDrive -Path $mappedPath -DriveLetter $driveLetter

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'With no parameters' {
        It 'throws an exception' {
            # Act
            $result = { Test-MappedDrive }

            # Assert
            $result | Should -Throw
        }
    }

    Context 'With a Driveletter that has a colon' {
        It 'returns $true if it exists' {
            # Arrange
            $driveLetterWithColon = 'W:'
            function Get-PSDrive {return @{'Name' = 'W'; 'Root' = 'C:\Windows'}}

            # Act
            $result = Test-MappedDrive -DriveLetter $driveLetterWithColon

            # Assert
            $result | Should -BeTrue
        }
    }
}