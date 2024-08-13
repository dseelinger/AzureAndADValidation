function Confirm-AzResourceGroup {
    <#
    .SYNOPSIS
    Tests for the existence of a resource group in Azure.

    .DESCRIPTION
    The Confirm-AzResourceGroup function takes the name of an Azure Resource Group as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER ResourceGroupName
    The name of the Resource Group to look for.

    Confirm-AzResourceGroup -Name "MyResourceGroup01"
    Returns $true or $false

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
