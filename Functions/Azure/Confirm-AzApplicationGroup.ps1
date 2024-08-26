function Confirm-AzApplicationGroup {
    <#
    .SYNOPSIS
    Tests for the existence of a Windows Virtual Desktop ApplicationGroup in Azure.

    .DESCRIPTION
    The Confirm-AzApplicationGroup function takes the name of an ApplicationGroup as input and returns $true if it is found,
    otherwise returns $false.

    .PARAMETER ApplicationGroupName
    The name of the Windows Virtualization ApplicationGroup to look for.

    .PARAMETER ResourceGroupName
    The name of the Resource Group that the ApplicationGroup is supposed to be in.

    .PARAMETER Location
    The location where the ApplicationGroup is expected to be. If not specified, the location check will be skipped.

    .PARAMETER ApplicationGroupType
    The type of the ApplicationGroup. If not specified, the type check will be skipped.

    .EXAMPLE
    Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup"
    Returns $true or $false

    .EXAMPLE
    Confirm-AzApplicationGroup -ApplicationGroupName "MyWvdAppGroup" -ResourceGroupName "MyResourceGroup" -Location "EastUS"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApplicationGroupName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,
        [Parameter(Mandatory=$false)]
        [string]$Location,
        [Parameter(Mandatory=$false)]
        [string]$ApplicationGroupType
        
    )
    begin {
        Import-Module Az.Accounts
        Import-Module Az.DesktopVirtualization
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
        $appGroup = Get-AzWvdApplicationGroup -ResourceGroupName $ResourceGroupName -Name $ApplicationGroupName -ErrorAction SilentlyContinue
        if ($null -eq $appGroup) {
            return $false
        }
        if ($Location -ne $null -and $Location -ne '' -and $appGroup.Location -ne $Location) {
            return $false
        }
        if ($ApplicationGroupType -ne $null -and $ApplicationGroupType -ne '' -and $appGroup.ApplicationGroupType -ne $ApplicationGroupType) {
            return $false
        }
        return $true
    }
}