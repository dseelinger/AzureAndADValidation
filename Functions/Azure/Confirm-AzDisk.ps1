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
    Confirm-AzDisk -Name "MyDisk01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .EXAMPLE
    Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .EXAMPLE
    # Check if a disk named "MyDisk01" exists in the resource group "MyResourceGroup01" and store the result in a variable
    $exists = Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01"
    if ($exists) {
        Write-Output "Disk MyDisk01 exists in Resource Group MyResourceGroup01."
    } else {
        Write-Output "Disk MyDisk01 does not exist in Resource Group MyResourceGroup01."
    }

    .EXAMPLE
    # Use the function in a script to perform an action if the disk exists
    if (Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01") {
        Remove-AzDisk -ResourceGroupName "MyResourceGroup01" -DiskName "MyDisk01" -Force
    } else {
        Write-Output "Disk MyDisk01 not found in Resource Group MyResourceGroup01."
    }

    .EXAMPLE
    # Check multiple disks in a loop
    $diskNames = @("Disk01", "Disk02", "Disk03")
    $resourceGroupName = "MyResourceGroup01"
    foreach ($disk in $diskNames) {
        if (Confirm-AzDisk -DiskName $disk -ResourceGroupName $resourceGroupName) {
            Write-Output "Disk $disk exists in Resource Group $resourceGroupName."
        } else {
            Write-Output "Disk $disk does not exist in Resource Group $resourceGroupName."
        }
    }

    .EXAMPLE
    # Check if a disk exists and take different actions based on the result
    switch (Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01") {
        $true { Write-Output "Disk MyDisk01 exists in Resource Group MyResourceGroup01." }
        $false { Write-Output "Disk MyDisk01 does not exist in Resource Group MyResourceGroup01." }
    }

    .EXAMPLE
    # Check if a disk named "MyDisk01" with a size of 128 GB exists in the resource group "MyResourceGroup01"
    if (Confirm-AzDisk -DiskName "MyDisk01" -ResourceGroupName "MyResourceGroup01" -DiskSizeGB 128) {
        Write-Output "Disk MyDisk01 with size 128 GB exists in Resource Group MyResourceGroup01."
    } else {
        Write-Output "Disk MyDisk01 with size 128 GB does not exist in Resource Group MyResourceGroup01."
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
