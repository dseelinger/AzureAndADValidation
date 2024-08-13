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

    .EXAMPLE
    Confirm-AzKeyVault -Name "MyKeyVault01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$KeyVaultName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.KeyVault
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $KeyVault = Get-AzKeyVault -Name $KeyVaultName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            return $null -ne $KeyVault
        } catch {
            return $false
        }
    }
    end {
    }
}
