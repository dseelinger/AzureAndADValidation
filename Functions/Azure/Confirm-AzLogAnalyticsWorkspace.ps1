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
    # Check if a Log Analytics Workspace named "MyLogAnalyticsWorkspace01" exists in the resource group "MyResourceGroup01"
    Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
    # Check if a Log Analytics Workspace named "MyLogAnalyticsWorkspace01" exists in the resource group "MyResourceGroup01" `
    # and store the result in a variable.
    $exists = Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01"
    if ($exists) {
        Write-Output "MyLogAnalyticsWorkspace01 exists in the MyResourceGroup01 Resource Group."
    } else {
        Write-Output "MyLogAnalyticsWorkspace01 does not exist in the MyResourceGroup01 Resource Group."
    }

    .EXAMPLE
    # Check with a specific location
    Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01" `
        -Location "eastus"

    .EXAMPLE
    # Check with a specific SKU
    Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" -ResourceGroupName "MyResourceGroup01" `
        -Sku "PerGB2018"

    .EXAMPLE
    # How to use this in a Pester test
    Describe "MyLogAnalyticsWorkspace01 Log Analytics Workspace" {
        It "Should exist in the MyResourceGroup01 Resource Group" {
            Confirm-AzLogAnalyticsWorkspace -WorkspaceName "MyLogAnalyticsWorkspace01" `
                -ResourceGroupName "MyResourceGroup01" | Should -Be $true
        }
    }

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