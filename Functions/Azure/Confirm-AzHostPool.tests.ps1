BeforeAll {
    . $PSScriptRoot\Confirm-AzHostPool.ps1

    $location = 'usgovvirginia'
    $rgName = 'rg-integration-tests'
    $goodHostPoolName = 'good-host-pool'
    $badHostPoolName = 'bad-host-pool'
}

Describe 'Confirm-AzHostPool Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Host Pool and Application Group to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        New-AzWvdHostPool -ResourceGroupName $rgName -Name $goodHostPoolName -Location $location -HostPoolType "Pooled" `
            -LoadBalancerType "BreadthFirst" -MaxSessionLimit 10 -PreferredAppGroupType 'Desktop'| Out-Null

    }
    
    Context 'When the HostPool exists' {
        It 'returns $true' {

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the HostPool does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $badHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force
    }
}

Describe 'Confirm-AzHostPool Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the HostPool exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Name = $goodHostPoolName } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the HostPool does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdHostPool { return $null }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $badHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}
