function Confirm-AzResourceGroup {
    <#
    .SYNOPSIS
    Tests for the existence of a resource group in Azure.

    .DESCRIPTION
    The Confirm-AzResourceGroup function takes the name of an Azure Resource Group as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER ResourceGroupName
    The name of the Resource Group to look for.

    .EXAMPLE
    # Check if a Resource Group named "MyResourceGroup01" exists
    Confirm-AzResourceGroup -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
    # Check if a Resource Group named "MyResourceGroup01" exists and store the result in a variable.
    $exists = Confirm-AzResourceGroup -ResourceGroupName "MyResourceGroup01"
    if ($exists) {
        Write-Output "MyResourceGroup01 exists."
    } else {
        Write-Output "MyResourceGroup01 does not exist."
    }

    .EXAMPLE
    # How to use this in a Pester test
    Describe "MyResourceGroup01 Resource Group" {
        It "Should exist" {
            Confirm-AzResourceGroup -ResourceGroupName "MyResourceGroup01" | Should -Be $true
        }
    }

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.Resources
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $ResourceGroup = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction Stop
            return $null -ne $ResourceGroup
        } catch {
            return $false
        }
    }
    end {
    }
}
