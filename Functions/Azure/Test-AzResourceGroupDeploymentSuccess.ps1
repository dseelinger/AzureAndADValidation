function Test-AzResourceGroupDeploymentSuccess {
    <#
    .SYNOPSIS
    Tests whether an Azure Resource Group deployment was successful.

    .DESCRIPTION
    The Test-AzResourceGroupDeploymentSuccess function takes the name of an Azure Resource Group deployment as input 
    and returns $true if the deployment was successful, otherwise returns $false.

    .PARAMETER DeploymentName
    The name of the deployment to check.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the deployment is in.

    .EXAMPLE
    Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName "MyResourceGroup01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$DeploymentName,
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
            $deployment = Get-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -Name $DeploymentName `
                -ErrorAction SilentlyContinue
            Write-Host $deployment.Properties.ProvisioningState
            if ($deployment.ProvisioningState -eq 'Succeeded') {
                return $true
            } else {
                return $false
            }
        } catch {
            Write-Error "Failed to get deployment status: $_"
            return $false
        }
    }
}