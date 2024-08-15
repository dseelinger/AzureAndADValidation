BeforeAll {
    . $PSScriptRoot\Confirm-AzNic.ps1

    $location = 'usgovvirginia'
    $rgName = 'rg-integration-tests'
    $testNicName = 'test-nic-name'
    $fakeNicName = 'bad-nic-name'
    $vnetName = 'test-vnet'
    $subnetName = 'test-subnet'
}

Describe 'Confirm-AzNic Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Network Interface Card (NIC) to test against, starting with a Resource Group
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null

        # Create a virtual network
        $vnet = New-AzVirtualNetwork -ResourceGroupName $rgName -Location $location -Name $vnetName `
            -AddressPrefix '10.0.0.0/16'

        # Create a subnet
        Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix '10.0.0.0/24' -VirtualNetwork $vnet | Out-Null
        Set-AzVirtualNetwork -VirtualNetwork $vnet | Out-Null

        # Retrieve the existing virtual network - This extra step is necessary to get the VNet's subnets with IDs, which
        # would otherwise be null
        $vnet = Get-AzVirtualNetwork -ResourceGroupName $rgName -Name $vnetName

        # Retrieve the subnet within the virtual network
        $subnet = $vnet.Subnets | Where-Object { $_.Name -eq $subnetName }

        # Create the network interface
        New-AzNetworkInterface -ResourceGroupName $rgName -Location $location -Name $testNicName -SubnetId $subnet.Id `
            | Out-Null
    }
    
    Context 'When the NIC exists' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzNic -NicName $testNicName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the NIC does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzNic -NicName $fakeNicName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        # Clean up - Remove the created NIC, Virtual Network, and Resource Group
        Remove-AzResourceGroup -Name $rgName -Force | Out-Null
    }
}

Describe 'Confirm-AzNic Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the NIC exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzNetworkInterface { return @{ Name = $testNicName } }

            # Act
            $result = Confirm-AzNic -NicName $testNicName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the NIC does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzNetworkInterface { return $null }

            # Act
            $result = Confirm-AzNic -NicName $fakeNicName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}