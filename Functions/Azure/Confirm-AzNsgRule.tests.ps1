BeforeAll {
    . $PSScriptRoot\Confirm-AzNsgRule.ps1

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
        New-AzResourceGroup -Name $resourceGroupName -Location $location `
            | New-AzNetworkSecurityGroup -Name $nsgName `
            | Add-AzNetworkSecurityRuleConfig -Name $ruleName -Priority $priority -SourceAddressPrefix $sourceAddressPrefix `
                -SourcePortRange $sourcePortRange -DestinationAddressPrefix $destinationAddressPrefix `
                -DestinationPortRange $destinationPortRange -Protocol $protocol -Access $access -Direction $direction `
            | Set-AzNetworkSecurityGroup `
            | Out-Null
    }
    
    Context 'When the NSG Rule does not exist at all (no name match)' {
        It 'returns $false' {

            # Act
            $result = Confirm-AzNsgRule -Name 'rule-name-does-not-exist' 
            
            # -Priority $priority `
            # -SourceAddressPrefix $sourceAddressPrefix -SourcePortRange $sourcePortRange `
            # -DestinationAddressPrefix $destinationAddressPrefix -DestinationPortRange $destinationPortRange `
            # -Protocol $protocol -Access $access -Direction $direction

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $resourceGroupName -Force
    }
}
