BeforeAll {
    . $PSScriptRoot\Confirm-AzDisk.ps1

    $location = $env:AZURE_LOCATION
    $rgName = 'rg-integration-tests'
    $testDiskName = 'test-disk-name'
    $fakeDiskName = 'bad-disk-name'
}

Describe 'Confirm-AzDisk Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Disk to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        $diskSizeGB = 128
        $diskConfig = New-AzDiskConfig -Location $location -CreateOption Empty -DiskSizeGB $diskSizeGB
        New-AzDisk -ResourceGroupName $rgName -DiskName $testDiskName -Disk $diskConfig | Out-Null
    }
    
    Context 'When the Disk exists' {
        It 'returns $true' {

            # Act
            $result = Confirm-AzDisk -DiskName $testDiskName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Disk does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzDisk -DiskName $fakeDiskName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
    
    Context 'DiskSizeGB parameter match and non-match' {
        It 'returns $true when DiskSizeGB matches' {
            # Act
            $result = Confirm-AzDisk -DiskName $testDiskName -ResourceGroupName $rgName -DiskSizeGB $diskSizeGB

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false when DiskSizeGB does not match' {
            # Act
            $result = Confirm-AzDisk -DiskName $testDiskName -ResourceGroupName $rgName -DiskSizeGB 256

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force
    }
}

Describe 'Confirm-AzDisk Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the Disk exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzDisk { return @{ Name = $testDiskName } }

            # Act
            $result = Confirm-AzDisk -DiskName $testDiskName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Disk does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzDisk { return $null }

            # Act
            $result = Confirm-AzDisk -DiskName $fakeDiskName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'DiskSizeGB parameter match and non-match' {
        It 'returns $true when DiskSizeGB matches' {
            # Arrange
            function Get-AzDisk { return @{ Name = $testDiskName; DiskSizeGB = 128 } }

            # Act
            $result = Confirm-AzDisk -DiskName $testDiskName -ResourceGroupName $rgName -DiskSizeGB 128

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false when DiskSizeGB does not match' {
            # Arrange
            function Get-AzDisk { return @{ Name = $testDiskName; DiskSizeGB = 128 } }

            # Act
            $result = Confirm-AzDisk -DiskName $testDiskName -ResourceGroupName $rgName -DiskSizeGB 256

            # Assert
            $result | Should -BeFalse
        }
    }
}
