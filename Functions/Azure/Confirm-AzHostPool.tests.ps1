BeforeAll {
    . $PSScriptRoot\Confirm-AzHostPool.ps1

    $location = $env:AZURE_LOCATION
    $rgName = 'rg-integration-tests'
    $goodHostPoolName = 'good-host-pool'
    $badHostPoolName = 'bad-host-pool'
}

Describe 'Confirm-AzHostPool Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a HostPool to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        New-AzWvdHostPool -ResourceGroupName $rgName -Name $goodHostPoolName -Location $location -HostPoolType "Pooled" `
            -LoadBalancerType "BreadthFirst" -MaxSessionLimit 10 -PreferredAppGroupType 'Desktop'| Out-Null

    }
    
    Context 'When the HostPool does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $badHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When app parameters are not provided' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the HostPool location does not match' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -Location 'eastus'

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the HostPool type does not match' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -HostPoolType 'Personal'

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the HostPool LoadBalancerType does not match' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -LoadBalancerType 'DepthFirst'

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the HostPool MaxSessionLimit does not match' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -MaxSessionLimit 5

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the HostPool PreferredAppGroupType does not match' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -PreferredAppGroupType 'Mobile'

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When all parameters match' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -Location $location -HostPoolType 'Pooled' `
                -LoadBalancerType 'BreadthFirst' -MaxSessionLimit 10 -PreferredAppGroupType 'Desktop'

            # Assert
            $result | Should -BeTrue
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
    Context 'When app parameters are not provided' {
        It 'returns $true' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = $location; HostPoolType = 'Pooled' } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }
    Context 'When the HostPool location does not match' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = 'eastus'; HostPoolType = 'Pooled' } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -Location $location

            # Assert
            $result | Should -BeFalse
        }
    }
    Context 'When the HostPool type does not match' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = $location; HostPoolType = 'Personal' } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -HostPoolType 'Pooled'

            # Assert
            $result | Should -BeFalse
        }
    }
    Context 'When the HostPool LoadBalancerType does not match' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = $location; HostPoolType = 'Pooled'; LoadBalancerType = 'DepthFirst' } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -LoadBalancerType 'BreadthFirst'

            # Assert
            $result | Should -BeFalse
        }
    }
    Context 'When the HostPool MaxSessionLimit does not match' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = $location; HostPoolType = 'Pooled'; LoadBalancerType = 'BreadthFirst'; MaxSessionLimit = 5 } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -MaxSessionLimit 10

            # Assert
            $result | Should -BeFalse
        }
    }
    Context 'When the HostPool PreferredAppGroupType does not match' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = $location; HostPoolType = 'Pooled'; LoadBalancerType = 'BreadthFirst'; MaxSessionLimit = 10; PreferredAppGroupType = 'Mobile' } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -PreferredAppGroupType 'Desktop'

            # Assert
            $result | Should -BeFalse
        }
    }
    Context 'When all parameters match' {
        It 'returns $true' {
            # Arrange
            function Get-AzWvdHostPool { return @{ Location = $location; HostPoolType = 'Pooled'; LoadBalancerType = 'BreadthFirst'; MaxSessionLimit = 10; PreferredAppGroupType = 'Desktop' } }

            # Act
            $result = Confirm-AzHostPool -HostPoolName $goodHostPoolName -ResourceGroupName $rgName -Location $location -HostPoolType 'Pooled' `
                -LoadBalancerType 'BreadthFirst' -MaxSessionLimit 10 -PreferredAppGroupType 'Desktop'

            # Assert
            $result | Should -BeTrue
        }
    }
}
