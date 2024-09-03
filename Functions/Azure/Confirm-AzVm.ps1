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

    .PARAMETER Location
        Optional. The location of the Virtual Machine. If provided, the function will look for the Virtual Machine in the 
        specified location.

    .PARAMETER VMSize
        Optional. The size of the Virtual Machine. If provided, the function will look for the Virtual Machine with the
        specified size.

    .PARAMETER OsType
        Optional. The OS type of the Virtual Machine. If provided, the function will look for the Virtual Machine with the
        specified OS type.

    .PARAMETER SourceImagePublisherName
        Optional. The publisher name of the source image of the Virtual Machine. If provided, the function will look for the
        Virtual Machine with the specified source image publisher name.

    .PARAMETER SourceImageOffer
        Optional. The offer of the source image of the Virtual Machine. If provided, the function will look for the Virtual
        Machine with the specified source image offer.

    .PARAMETER SourceImageSku
        Optional. The SKU of the source image of the Virtual Machine. If provided, the function will look for the Virtual
        Machine with the specified source image SKU.

    .PARAMETER SourceImageVersion
        Optional. The version of the source image of the Virtual Machine. If provided, the function will look for the Virtual
        Machine with the specified source image version.


    .EXAMPLE
        # Check if a Virtual Machine named "MyVM01" exists in the resource group "MyResourceGroup01"
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
        # How to use the Location parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" -Location "East US"

    .EXAMPLE
        # How to use the VMSize parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" -VMSize "Standard_DS1_v2"

    .EXAMPLE
        # How to use the OsType parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" -OsType "Windows"

    .EXAMPLE
        # How to use the SourceImagePublisherName parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" `
            -SourceImagePublisherName "MicrosoftWindowsServer"

    .EXAMPLE
        # How to use the SourceImageOffer parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" -SourceImageOffer "WindowsServer"

    .EXAMPLE
        # How to use the SourceImageSku parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" -SourceImageSku "2019-Datacenter"

    .EXAMPLE
        # How to use the SourceImageVersion parameter
        Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" -SourceImageVersion "latest"

    .EXAMPLE
        # Check if a Virtual Machine named "MyVM01" exists in the resource group "MyResourceGroup01" and store the result in 
        # a variable.
        $exists = Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01"
        if ($exists) {
            Write-Output "MyVM01 exists in the MyResourceGroup01 Resource Group."
        } else {
            Write-Output "MyVM01 does not exist in the MyResourceGroup01 Resource Group."
        }

    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyVM01 Virtual Machine" {
            It "Should exist in the MyResourceGroup01 Resource Group" {
                Confirm-AzVm -VmName "MyVM01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
            }
        }

    .NOTES
        Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$VmName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$Location,
        [Parameter(Mandatory=$false)]
        [string]$VMSize,
        [Parameter(Mandatory=$false)]
        [string]$OsType,
        [Parameter(Mandatory=$false)]
        [string]$SourceImagePublisherName,
        [Parameter(Mandatory=$false)]
        [string]$SourceImageOffer,
        [Parameter(Mandatory=$false)]
        [string]$SourceImageSku,
        [Parameter(Mandatory=$false)]
        [string]$SourceImageVersion
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
            $vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -ErrorAction SilentlyContinue
            if ($vm) {
                if ($Location -and $vm.Location -ne $Location) {
                    return $false
                }
                if ($VMSize -and $vm.HardwareProfile.VmSize -ne $VMSize) {
                    return $false
                }
                if ($OsType -and $vm.StorageProfile.OsDisk.OsType -ne $OsType) {
                    return $false
                }
                if ($SourceImagePublisherName -and $vm.StorageProfile.ImageReference.Publisher -ne $SourceImagePublisherName) 
                {
                    return $false
                }
                if ($SourceImageOffer -and $vm.StorageProfile.ImageReference.Offer -ne $SourceImageOffer) {
                    return $false
                }
                if ($SourceImageSku -and $vm.StorageProfile.ImageReference.Sku -ne $SourceImageSku) {
                    return $false
                }
                if ($SourceImageVersion -and $vm.StorageProfile.ImageReference.Version -ne $SourceImageVersion) {
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