BeforeAll {
    . $PSScriptRoot\Confirm-AzDisk.ps1

    $location = 'usgovvirginia'
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
}
