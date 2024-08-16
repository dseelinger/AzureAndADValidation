function Confirm-AzStorageAccount {
    <#
    .SYNOPSIS
        Confirms the existence of an Azure Storage account.

    .PARAMETER StorageAccountName
        The name of the Storage Account to look for.

    .PARAMETER ResourceGroupName
        The name of the Resource Group that the Storage Account is supposed to be in.

    .EXAMPLE
        Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount01" -ResourceGroupName "MyResourceGroup01"
        Returns $true or $false

    .NOTES
        Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$StorageAccountName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Storage
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $storageAccount = Get-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            return $null -ne $storageAccount
        } catch {
            return $false
        }
    }
    end {
    }
}