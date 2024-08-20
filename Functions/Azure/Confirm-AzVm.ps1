function Confirm-AzVm {
    <#
    .SYNOPSIS
    Tests for the existence of a Virtual Machine in Azure.

    .DESCRIPTION
    The Confirm-AzVm function takes the name of an Azure Virtual Machine as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER VmName
    The name of the Virtual Machine to look for.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the Virtual Machine is supposed to be in.

    .EXAMPLE
    Confirm-AzVm -VmName "MyVm01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$VmName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Compute
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $vm = Get-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            return $null -ne $vm
        } catch {
            return $false
        }
    }
    end {
    }
}