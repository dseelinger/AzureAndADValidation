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

    .EXAMPLE
    $nicExists = Confirm-AzNic -NicName "WebServerNic" -ResourceGroupName "WebResourceGroup"
    if ($nicExists) {
        Write-Output "The NIC 'WebServerNic' exists in the 'WebResourceGroup' resource group."
    } else {
        Write-Output "The NIC 'WebServerNic' does not exist in the 'WebResourceGroup' resource group."
    }
    Checks if the NIC "WebServerNic" exists in the "WebResourceGroup" and outputs a message accordingly.

    .EXAMPLE
    $result = Confirm-AzNic -NicName "DatabaseNic" -ResourceGroupName "DatabaseResourceGroup"
    Write-Output "NIC existence: $result"
    Stores the result of the NIC existence check in a variable and outputs the result.

    .EXAMPLE
    if (Confirm-AzNic -NicName "AppServerNic" -ResourceGroupName "AppResourceGroup") {
        Write-Output "NIC 'AppServerNic' found."
    } else {
        Write-Output "NIC 'AppServerNic' not found."
    }
    Directly checks the existence of the NIC "AppServerNic" in the "AppResourceGroup" and outputs a message.

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