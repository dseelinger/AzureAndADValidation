function Confirm-AzNsgRule {
    <#
    .SYNOPSIS
    Tests for the existence of an NSG rule and (optionally) its specific configuration in Azure.

    .DESCRIPTION
    The Confirm-AzNsgRule function takes several parameters and returns $true if it is found and matches the specified 
    configuration, otherwise it returns $false.

    .PARAMETER Name
    The name of the NSG rule to look for. This parameter is required.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the NSG is supposed to be in. This parameter is required.

    .PARAMETER NsgName
    The name of the Network Security Group. This parameter is required.

    .PARAMETER Priority
    The priority of the NSG rule. This parameter is optional.

    .PARAMETER SourceAddressPrefix
    The source address prefix of the NSG rule. This parameter is optional.

    .PARAMETER SourcePortRange
    The source port range of the NSG rule. This parameter is optional.

    .PARAMETER DestinationAddressPrefix
    The destination address prefix of the NSG rule. This parameter is optional.

    .PARAMETER DestinationPortRange
    The destination port range of the NSG rule. This parameter is optional.

    .PARAMETER Protocol
    The protocol of the NSG rule. This parameter is optional.

    .PARAMETER Access
    The access type of the NSG rule (Allow/Deny). This parameter is optional.

    .PARAMETER Direction
    The direction of the NSG rule (Inbound/Outbound). This parameter is optional.

    .EXAMPLE
    Confirm-AzNsgRule -Name "MyNsgRule" -ResourceGroupName "MyResourceGroup" -NsgName "MyNsg"
    Returns $true or $false

    .EXAMPLE
    $ruleExists = Confirm-AzNsgRule -Name "AllowSSH" -ResourceGroupName "ProdResourceGroup" -NsgName "ProdNsg"
    if ($ruleExists) {
        Write-Output "The NSG rule 'AllowSSH' exists in the 'ProdNsg' NSG."
    } else {
        Write-Output "The NSG rule 'AllowSSH' does not exist in the 'ProdNsg' NSG."
    }
    Checks if the NSG rule "AllowSSH" exists in the "ProdNsg" NSG and outputs a message accordingly.

    .EXAMPLE
    $result = Confirm-AzNsgRule -Name "DenyAll" -ResourceGroupName "TestResourceGroup" -NsgName "TestNsg"
    Write-Output "NSG rule existence: $result"
    Stores the result of the NSG rule existence check in a variable and outputs the result.

    .EXAMPLE
    if (Confirm-AzNsgRule -Name "AllowHTTP" -ResourceGroupName "WebResourceGroup" -NsgName "WebNsg") {
        Write-Output "NSG rule 'AllowHTTP' found."
    } else {
        Write-Output "NSG rule 'AllowHTTP' not found."
    }
    Directly checks the existence of the NSG rule "AllowHTTP" in the "WebNsg" NSG and outputs a message.

    .EXAMPLE
    Confirm-AzNsgRule -Name "AllowRDP" -ResourceGroupName "RemoteAccessGroup" -NsgName "RemoteAccessNsg" -Protocol "TCP" -SourceAddressPrefix "10.0.0.0/24" -DestinationPortRange "3389"
    Checks if the NSG rule "AllowRDP" with specific protocol, source address prefix, and destination port range exists in the "RemoteAccessNsg" NSG.

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [string]$NsgName,

        [Parameter(Mandatory=$false)]
        [int]$Priority,

        [Parameter(Mandatory=$false)]
        [string]$SourceAddressPrefix,

        [Parameter(Mandatory=$false)]
        [string]$SourcePortRange,

        [Parameter(Mandatory=$false)]
        [string]$DestinationAddressPrefix,

        [Parameter(Mandatory=$false)]
        [string]$DestinationPortRange,

        [Parameter(Mandatory=$false)]
        [string]$Protocol,

        [Parameter(Mandatory=$false)]
        [string]$Access,

        [Parameter(Mandatory=$false)]
        [string]$Direction
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Network
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        $nsg = Get-AzNetworkSecurityGroup -Name $NsgName -ResourceGroupName $ResourceGroupName
        if (-not $nsg) {
            return $false
        }

        $rule = $nsg.SecurityRules | Where-Object { $_.Name -eq $Name }
        if (-not $rule) {
            return $false
        }

        if ($Priority -and $rule.Priority -ne $Priority) {
            return $false
        }

        if ($SourceAddressPrefix -and $rule.SourceAddressPrefix -ne $SourceAddressPrefix) {
            return $false
        }

        if ($SourcePortRange -and $rule.SourcePortRange -ne $SourcePortRange) {
            return $false
        }

        if ($DestinationAddressPrefix -and $rule.DestinationAddressPrefix -ne $DestinationAddressPrefix) {
            return $false
        }

        if ($DestinationPortRange -and $rule.DestinationPortRange -ne $DestinationPortRange) {
            return $false
        }

        if ($Protocol -and $rule.Protocol -ne $Protocol) {
            return $false
        }

        if ($Access -and $rule.Access -ne $Access) {
            return $false
        }

        if ($Direction -and $rule.Direction -ne $Direction) {
            return $false
        }

        return $true
    }
    end {

    }
}