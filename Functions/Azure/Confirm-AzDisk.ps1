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
    # Check if a disk named "MyDisk01" exists in the resource group "MyResourceGroup01"
    Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
    # How to use the DiskSizeGB parameter
    Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01" -DiskSizeGB 128

    .EXAMPLE
    # Check if a disk named "MyDisk01" exists in the resource group "MyResourceGroup01" and store the result in a variable.
    $exists = Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01"
    if ($exists) {
        Write-Output "MyDisk01 exists in the MyResourceGroup01 Resource Group."
    } else {
        Write-Output "MyDisk01 does not exist in the MyResourceGroup01 Resource Group."
    }

    .EXAMPLE
    # How to use this in a Pester test
    Describe "MyDisk01 Disk" {
        It "Should exist in the MyResourceGroup01 Resource Group" {
            Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
        }
    }    

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$DiskName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$DiskSizeGB
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Compute
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        $disk = Get-AzDisk -ResourceGroupName $ResourceGroupName -Name $DiskName -ErrorAction SilentlyContinue
        if ($null -eq $disk) {
            return $false
        }
        if ($DiskSizeGB -and $disk.DiskSizeGB -ne $DiskSizeGB) {
            return $false
        }
        return $true
    }
    end {
    }
}
