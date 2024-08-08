BeforeAll {
    . $PSScriptRoot\Confirm-AzNsgRule.ps1

    # Arrange - Set up variables
    $location = 'usgovvirginia'
    $resourceGroupName = "rg-integration-tests"
    $nsgName = "myNSG"
    $ruleName = "AllowHTTP"
    $priority = 100
    $sourceAddressPrefix = "*"
    $sourcePortRange = "*"
    $destinationAddressPrefix = "*"
    $destinationPortRange = "80"
    $protocol = "Tcp"
    $access = "Allow"
    $direction = "Inbound"    
}

Describe 'Confirm-AzNsgRule Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a NSG Rule to test against
        New-AzResourceGroup -Name $resourceGroupName -Location $location
        $nsg = New-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $resourceGroupName -Location $location
        $nsgRule = New-AzNetworkSecurityRuleConfig -Name $ruleName -Priority $priority `
            -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction
        $nsg.SecurityRules.Add($nsgRule)
        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
    }
    
    Context 'When the NSG Rule does not exist at all (no rule name, NSG name, or resource group match)' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzNsgRule -Name 'rule-name-does-not-exist' -NsgName $nsgName `
            -ResourceGroupName $resourceGroupName -Priority $priority -SourceAddressPrefix $sourceAddressPrefix `
            -SourcePortRange $sourcePortRange -DestinationAddressPrefix $destinationAddressPrefix `
            -DestinationPortRange $destinationPortRange -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the NSG rule exists in the correct NSG (and resource group)... ' {
        It 'returns $true if no other parameters are provided' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $true if all parameters match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if the priority does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority 200 -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the source address prefix does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix '192.168.1.0/24' -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -SourcePortRange does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange '1000-2000' `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -DestinationAddressPrefix does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix '192.168.1.0/24' -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -DestinationAddressPrefix does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange '1000-2000' `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -Protocol does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol 'Udp' -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -Access does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access 'Deny' -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -Direction does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction "Outbound"

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $resourceGroupName -Force
    }
}

Describe 'Confirm-AzNsgRule Integration Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Import-Module {}
        function Get-AzContext { return $true }
    }
    
    Context 'When the NSG Rule does not exist at all (no rule name, NSG name, or resource group match)' {
        It 'returns $false' {
            # Arrange
            function Get-AzNetworkSecurityGroup { return $null }

            # Act
            $result = Confirm-AzNsgRule -Name 'rule-name-does-not-exist' -NsgName $nsgName `
            -ResourceGroupName $resourceGroupName -Priority $priority -SourceAddressPrefix $sourceAddressPrefix `
            -SourcePortRange $sourcePortRange -DestinationAddressPrefix $destinationAddressPrefix `
            -DestinationPortRange $destinationPortRange -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the NSG rule exists in the correct NSG (and resource group)... ' {
        BeforeAll {
            # Arrange - Create a mock NSG to test against
            $mockNsg = [PSCustomObject]@{
                Name = $nsgName
                ResourceGroupName = $resourceGroupName
                Location = $location
                SecurityRules = @(
                    [PSCustomObject]@{
                        Name = $ruleName
                        Priority = $priority
                        SourceAddressPrefix = $sourceAddressPrefix
                        SourcePortRange = $sourcePortRange
                        DestinationAddressPrefix = $destinationAddressPrefix
                        DestinationPortRange = $destinationPortRange
                        Protocol = $protocol
                        Access = $access
                        Direction = $direction
                    }
                )
            }

            function Get-AzNetworkSecurityGroup { return $mockNsg }
        }
        It 'returns $true if no other parameters are provided' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $true if all parameters match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeTrue
        }

        It 'returns $false if the priority does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority 200 -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the source address prefix does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix '192.168.1.0/24' -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -SourcePortRange does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange '1000-2000' `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -DestinationAddressPrefix does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix '192.168.1.0/24' -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -DestinationAddressPrefix does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange '1000-2000' `
            -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -Protocol does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol 'Udp' -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -Access does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access 'Deny' -Direction $direction

            # Assert
            $result | Should -BeFalse
        }

        It 'returns $false if the -Direction does not match' {
            # Act
            $result = Confirm-AzNsgRule -Name $ruleName -NsgName $nsgName -ResourceGroupName $resourceGroupName `
            -Priority $priority -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            -Protocol $protocol -Access $access -Direction "Outbound"

            # Assert
            $result | Should -BeFalse
        }
    }
}
