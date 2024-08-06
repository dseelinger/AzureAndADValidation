function Confirm-AzHostPool {
    <#
    .SYNOPSIS
    Tests for the existence of a HostPool in Azure.

    .DESCRIPTION
    The Confirm-AzHostPool function takes the name of an Azure HostPool as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER HostPoolName
    The name of the HostPool to look for.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the HostPool is supposed to be in.

    .EXAMPLE
    Confirm-AzHostPool -Name "MyHostPool01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$HostPoolName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.DesktopVirtualization
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $HostPool = Get-AzWvdHostPool -Name $HostPoolName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            return $null -ne $HostPool
        } catch {
            return $false
        }
    }
    end {
    }
}
