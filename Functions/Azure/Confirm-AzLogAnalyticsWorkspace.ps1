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

    .PARAMETER Location
    Optional. The location of the Log Analytics Workspace. If provided, the function will look for the Log Analytics 
    Workspace

    .PARAMETER Sku
    Optional. The SKU of the Log Analytics Workspace. If provided, the function will look for the Log Analytics Workspace

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
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$Location,
        [Parameter(Mandatory=$false)]
        [string]$Sku
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
            $workspace = Get-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $WorkspaceName `
                -ErrorAction SilentlyContinue
            if ($workspace) {
                if ($Location -and $workspace.Location -ne $Location) {
                    return $false
                }
                if ($Sku -and $workspace.Sku -ne $Sku) {
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