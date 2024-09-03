function Confirm-AzHostPool {
    <#
    .SYNOPSIS
        Tests for the existence of a HostPool in Azure.

    .DESCRIPTION
        The Confirm-AzHostPool function takes the name of an Azure HostPool as input and returns $true if it is found,
        otherwise returns $false.

    .PARAMETER HostPoolName
        The name of the HostPool to look for.

    .PARAMETER ResourceGroupName
        The name of the Resource Group that the HostPool is supposed to be in.

    .PARAMETER Location
        Optional. The location of the HostPool. If provided, the function will look for the HostPool in the specified 
        location.

    .PARAMETER HostPoolType
        Optional. The type of HostPool to look for. If provided, the function will look for the HostPool with the specified 
        type.

    .PARAMETER LoadBalancerType
        Optional. The type of Load Balancer to look for. If provided, the function will look for the HostPool with the 
        specified Load Balancer type.

    .PARAMETER MaxSessionLimit
        Optional. The maximum number of sessions allowed in the HostPool. If provided, the function will check that the 
        HostPool has the same MaxSessionLimit.

    .PARAMETER PreferredAppGroupType
        Optional. The preferred App Group type for the HostPool. If provided, the function will check that the HostPool has 
        the same PreferredAppGroupType.

    .EXAMPLE
        # Check if a HostPool named "MyHostPool01" exists in the resource group "MyResourceGroup01"
        Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01"

    .EXAMPLE
        # Check if a HostPool named "MyHostPool01" exists in the resource group "MyResourceGroup01" and store the result in 
        # a variable.
        $exists = Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01"
        if ($exists) {
            Write-Output "MyHostPool01 exists in the MyResourceGroup01 Resource Group."
        } else {
            Write-Output "MyHostPool01 does not exist in the MyResourceGroup01 Resource Group."
        }

    .EXAMPLE
        # Check with a specific location
        Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01" -Location "eastus"

    .EXAMPLE
        # Check with a specific HostPoolType
        Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01" -HostPoolType "Pooled"

    .EXAMPLE
        # Check with a specific LoadBalancerType
        Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01" `
            -LoadBalancerType "BreadthFirst"

    .EXAMPLE
        # Check with a specific MaxSessionLimit
        Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01" -MaxSessionLimit 10

    .EXAMPLE
        # Check with a specific PreferredAppGroupType
        Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01" `
            -PreferredAppGroupType "Desktop"

    .EXAMPLE
        # How to use this in a Pester test
        Describe "MyHostPool01 Host Pool" {
            It "Should exist in the MyResourceGroup01 Resource Group" {
                Confirm-AzHostPool -HostPoolName "MyHostPool01" -ResourceGroupName "MyResourceGroup01" | Should -Be $true
            }
        }

    .NOTES
        Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$HostPoolName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$Location,
        [Parameter(Mandatory=$false)]
        [string]$HostPoolType,
        [Parameter(Mandatory=$false)]
        [string]$LoadBalancerType,
        [Parameter(Mandatory=$false)]
        [int]$MaxSessionLimit,
        [Parameter(Mandatory=$false)]
        [string]$PreferredAppGroupType
    )

    # Confirm HostPool exists, checking for optional parameters as well
    $hostPool = Get-AzWvdHostPool -ResourceGroupName $ResourceGroupName -Name $HostPoolName -ErrorAction SilentlyContinue
    if ($null -eq $hostPool) {
        return $false
    }
    # Check for optional parameters
    if ($Location -and $hostPool.Location -ne $Location) {
        return $false
    }
    if ($HostPoolType -and $hostPool.HostPoolType -ne $HostPoolType) {
        return $false
    }
    if ($LoadBalancerType -and $hostPool.LoadBalancerType -ne $LoadBalancerType) {
        return $false
    }
    if ($MaxSessionLimit -and $hostPool.MaxSessionLimit -ne $MaxSessionLimit) {
        return $false
    }
    if ($PreferredAppGroupType -and $hostPool.PreferredAppGroupType -ne $PreferredAppGroupType) {
        return $false
    }
    return $true
}
