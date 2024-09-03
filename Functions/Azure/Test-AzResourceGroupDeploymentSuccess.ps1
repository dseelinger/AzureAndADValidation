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
        # Check if a deployment named "MyDeployment01" was successful in the resource group "MyResourceGroup01"
        Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
        # Check if a deployment named "MyDeployment01" was successful in the resource group "MyResourceGroup01" and store the 
        # result in a variable.
        $success = Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName `
            "MyResourceGroup01"
        if ($success) {
            Write-Output "MyDeployment01 was successful in the MyResourceGroup01 Resource Group."
        } else {
            Write-Output "MyDeployment01 was not successful in the MyResourceGroup01 Resource Group."
        }

    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyDeployment01 Deployment" {
            It "Should be successful in the MyResourceGroup01 Resource Group" {
                Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName `
                    "MyResourceGroup01" | Should -Be $true
            }
        }

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