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
    Optional. The location of the HostPool. If provided, the function will look for the HostPool in the specified location.

    .PARAMETER HostPoolType
    Optional. The type of HostPool to look for. If provided, the function will look for the HostPool with the specified type.

    .PARAMETER LoadBalancerType
    Optional. The type of Load Balancer to look for. If provided, the function will look for the HostPool with the specified 
    Load Balancer type.

    .PARAMETER MaxSessionLimit
    Optional. The maximum number of sessions allowed in the HostPool. If provided, the function will check that the HostPool 
    has the same MaxSessionLimit.

    .PARAMETER PreferredAppGroupType
    Optional. The preferred App Group type for the HostPool. If provided, the function will check that the HostPool has the 
    same PreferredAppGroupType.

    .EXAMPLE
    Confirm-AzHostPool -HostPoolName "MyHostPool" -ResourceGroupName "MyResourceGroup"
    Returns $true if the HostPool named "MyHostPool" is found in the Resource Group named "MyResourceGroup".

    .EXAMPLE
    Confirm-AzHostPool -HostPoolName "MyHostPool" -ResourceGroupName "MyResourceGroup" -Location "East US"
    Returns $true if the HostPool named "MyHostPool" is found in the Resource Group named "MyResourceGroup" and is located in
    the "East US" region.

    .EXAMPLE
    Confirm-AzHostPool -HostPoolName "MyHostPool" -ResourceGroupName "MyResourceGroup" -HostPoolType "Pooled"
    Returns $true if the HostPool named "MyHostPool" is found in the Resource Group named "MyResourceGroup" and is of type 
    "Pooled".

    .EXAMPLE
    Confirm-AzHostPool -HostPoolName "MyHostPool" -ResourceGroupName "MyResourceGroup" -LoadBalancerType "BreadthFirst"
    Returns $true if the HostPool named "MyHostPool" is found in the Resource Group named "MyResourceGroup" and has a
    Load Balancer type of "BreadthFirst".

    .EXAMPLE
    Confirm-AzHostPool -HostPoolName "MyHostPool" -ResourceGroupName "MyResourceGroup" -MaxSessionLimit 10
    Returns $true if the HostPool named "MyHostPool" is found in the Resource Group named "MyResourceGroup" and has a
    MaxSessionLimit of 10.

    .EXAMPLE
    Confirm-AzHostPool -HostPoolName "MyHostPool" -ResourceGroupName "MyResourceGroup" -PreferredAppGroupType "Desktop"
    Returns $true if the HostPool named "MyHostPool" is found in the Resource Group named "MyResourceGroup" and has a
    PreferredAppGroupType of "Desktop".

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
