function Confirm-AzKeyVault {
    <#
    .SYNOPSIS
        Tests for the existence of a Key Vault in Azure.

    .DESCRIPTION
        The Confirm-AzKeyVault function takes the name of an Azure KeyVault as input and returns $true if it is found,
        otherwise returns $false.

    .PARAMETER KeyVaultName
        The name of the Key Vault to look for.

    .PARAMETER ResourceGroupName
        The name of the Resource Group that the Key Vault is supposed to be in.

    .PARAMETER Location
        Optional. The location of the Key Vault. If provided, the function will look for the Key Vault in the specified 
        location.

    .EXAMPLE
        # Check if a Key Vault named "MyKeyVault01" exists in the resource group "MyResourceGroup01"
        Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
        # Check if a Key Vault named "MyKeyVault01" exists in the resource group "MyResourceGroup01" and store the result in 
        # a variable.
        $exists = Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01"
        if ($exists) {
            Write-Output "MyKeyVault exists in the MyResourceGroup01 Resource Group."
        } else {
            Write-Output "MyKeyVault does not exist in the MyResourceGroup01 Resource Group."
        }

    .EXAMPLE
        # Check with a specific location
        Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01" -Location "eastus"

    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyKeyVault01 Key Vault" {
            It "Should exist in the MyResourceGroup01 Resource Group" {
                Confirm-AzKeyVault -KeyVaultName "MyKeyVault01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
            }
        }

    .NOTES
        Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$KeyVaultName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$Location
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.KeyVault
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        $keyVault = Get-AzKeyVault -VaultName $KeyVaultName -ResourceGroupName $ResourceGroupName `
            -ErrorAction SilentlyContinue
        if ($keyVault) {
            if ($Location -and $keyVault.Location -ne $Location) {
                return $false
            }
            return $true
        }
        return $false
    }
    end {
    }
}
