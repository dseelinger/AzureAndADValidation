BeforeAll {
    . $PSScriptRoot\Confirm-AzVm.ps1

    $location = 'usgovvirginia'
    $rgName = 'rg-integration-tests'
    $testNicName = 'test-nic-name'
    $vnetName = 'test-vnet'
    $subnetName = 'test-subnet'
    $testVmName = 'test-vm-name'
    $fakeVmName = 'bad-vm-name'

    function New-SecureRandomPassword {
        param (
            [int]$length = 16
        )
    
        # Define character sets
        $upperCase = 65..90 | ForEach-Object { [char]$_ }
        $lowerCase = 97..122 | ForEach-Object { [char]$_ }
        $numbers = 48..57 | ForEach-Object { [char]$_ }
        $specialChars = "!@#$%^&*()-_=+[]{}|;:,.<>?/~" -split ''
    
        # Combine all character sets
        $allChars = $upperCase + $lowerCase + $numbers + $specialChars
    
        # Generate a random password
        $password = -join (1..$length | ForEach-Object { $allChars | Get-Random })
    
        return $password
    }
}

Describe 'Confirm-AzVm Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Virtual Machine (VM) to test against
        $resourceGroupName = $rgName
        $location = "usgovvirginia"
        $vmName = $testVmName
        $adminUsername = "LocalAdminUser"
        $randomPassword = New-SecureRandomPassword
        $adminPassword = ConvertTo-SecureString -String $randomPassword -AsPlainText -Force
        $vmSize = "Standard_DS1_v2"
        $vnetName = "MyDasVnet01"
        $subnetName = "MyDasSubnet01"
        $nicName = "MyDasNIC01"
        $imagePublisher = "MicrosoftWindowsServer"
        $imageOffer = "WindowsServer"
        $imageSku = "2019-Datacenter"

        New-AzResourceGroup -Name $resourceGroupName -Location $location
        $vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16"
        $subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
        $vnet | Set-AzVirtualNetwork

        # Retrieve the existing virtual network - This extra step is necessary to get the VNet's subnets with IDs, which
        # would otherwise be null
        $vnet = Get-AzVirtualNetwork -ResourceGroupName $rgName -Name $vnetName

        $subnet = $vnet.Subnets | Where-Object { $_.Name -eq $subnetName }

        $nic = New-AzNetworkInterface -ResourceGroupName $resourceGroupName -Location $location -Name $nicName `
            -SubnetId $subnet.Id

        $vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize `
            | Set-AzVMOperatingSystem -Windows -ComputerName $vmName `
                -Credential (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)) `
            | Set-AzVMSourceImage -PublisherName $imagePublisher -Offer $imageOffer -Skus $imageSku -Version "latest" `
            | Add-AzVMNetworkInterface -Id $nic.Id

        # Create the VM, suppressing the warnings and Write-Host output
        $null = New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig `
            -WarningAction SilentlyContinue -informationAction SilentlyContinue 6>&1
    }
    
    Context 'When the VM exists' {
        It 'returns $true' {
            # Act
            $result = Confirm-AzVm -VmName $testVmName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the VM does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzVm -VmName $fakeVmName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force
    }
}

Describe 'Confirm-AzVM Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the VM exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzVM { return @{ Name = $testVmName } }

            # Act
            $result = Confirm-AzVM -VmName $testVmName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the VM does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzVM { return $null }

            # Act
            $result = Confirm-AzVM -VmName $fakeVmName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}