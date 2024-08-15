function Confirm-AzNic {
    <#
    .SYNOPSIS
    Tests for the existence of a Network Interface Card (NIC) in Azure.

    .DESCRIPTION
    The Confirm-AzNic function takes the name of an Azure NIC as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER NicName
    The name of the Network Interface Card (NIC) to look for.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the NIC is supposed to be in.

    .EXAMPLE
    Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$NicName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Network
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            return $null -ne $nic
        } catch {
            return $false
        }
    }
    end {
    }
}