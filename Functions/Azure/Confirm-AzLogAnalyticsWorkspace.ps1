function Confirm-AzLogAnalyticsWorkspace {
    <#
    .SYNOPSIS
    Tests for the existence of a Log Analytics Workspace in Azure.

    .DESCRIPTION
    The Confirm-AzLogAnalyticsWorkspace function takes the name of an Azure Log Analytics Workspace and a Resource Group name
    as input and returns $true if it is found, otherwise returns $false.

    .PARAMETER WorkspaceName
    The name of the Log Analytics Workspace to look for.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the Log Analytics Workspace is supposed to be in.

    .EXAMPLE
    Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyWorkspace01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$WorkspaceName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.OperationalInsights
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $workspace = Get-AzOperationalInsightsWorkspace -Name $WorkspaceName -ResourceGroupName $ResourceGroupName `
                -ErrorAction Stop
            return $null -ne $workspace
        } catch {
            return $false
        }
    }
    end {
    }
}