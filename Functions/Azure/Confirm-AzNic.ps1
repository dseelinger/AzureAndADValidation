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

    .PARAMETER Location
        Optional. The location of the NIC. If provided, the function will look for the NIC in the specified location.

    .EXAMPLE
        # Check if a NIC named "MyNic01" exists in the resource group "MyResourceGroup01"
        Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
        # Check if a NIC named "MyNic01" exists in the resource group "MyResourceGroup01" and store the result in a variable.
        $exists = Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01"
        if ($exists) {
            Write-Output "MyNic01 exists in the MyResourceGroup01 Resource Group."
        } else {
            Write-Output "MyNic01 does not exist in the MyResourceGroup01 Resource Group."
        }

    .EXAMPLE
        # Check with a specific location
        Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01" -Location "eastus"

    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyNic01 Network Interface Card" {
            It "Should exist in the MyResourceGroup01 Resource Group" {
                Confirm-AzNic -NicName "MyNic01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
            }
        }
    
    .NOTES
        Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$NicName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$Location
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
            $nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
            if ($nic) {
                if ($Location -and $nic.Location -ne $Location) {
                    return $false
                }
                return $true
            }
            return $false
        } catch {
            return $false
        }
    }
    end {
    }
}