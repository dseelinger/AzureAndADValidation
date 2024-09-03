function Confirm-AzStorageAccount {
    <#
    .SYNOPSIS
        Confirms the existence of an Azure Storage account.

    .PARAMETER StorageAccountName
        The name of the Storage Account to look for.

    .PARAMETER ResourceGroupName
        The name of the Resource Group that the Storage Account is supposed to be in.

    .EXAMPLE
        # Check if a Storage Account named "MyStorageAccount" exists in the resource group "MyResourceGroup"
        Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount" -ResourceGroupName "MyResourceGroup"

    .EXAMPLE
        # Check if a Storage Account named "MyStorageAccount" exists in the resource group "MyResourceGroup" and store the 
        # result in a variable.
        $exists = Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount" -ResourceGroupName "MyResourceGroup"
        if ($exists) {
            Write-Output "MyStorageAccount exists in the MyResourceGroup Resource Group."
        } else {
            Write-Output "MyStorageAccount does not exist in the MyResourceGroup Resource Group."
        }

    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyStorageAccount Storage Account" {
            It "Should exist in the MyResourceGroup Resource Group" {
                Confirm-AzStorageAccount -StorageAccountName "MyStorageAccount" -ResourceGroupName "MyResourceGroup" `
                    | Should -Be $true
            }
        }

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
            $storageAccount = Get-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName `
                -ErrorAction Stop
            return $null -ne $storageAccount
        } catch {
            return $false
        }
    }
    end {
    }
}