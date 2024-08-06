function Confirm-AzDisk {
    <#
    .SYNOPSIS
    Tests for the existence of a disk in Azure.

    .DESCRIPTION
    The Confirm-AzDisk function takes the name of an Azure disk as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER DiskName
    The name of the Disk to look for.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the disk is supposed to be in.

    .EXAMPLE
    Confirm-AzDisk -Name "MyDisk01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$DiskName,
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
            $disk = Get-AzDisk -Name $DiskName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            return $null -ne $disk
        } catch {
            return $false
        }
    }
    end {
    }
}
