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
    The name of the Windows Virtualization ApplicationGroup to look for.

    .EXAMPLE
    Confirm-AzApplicationGroup -Name "MyWvdAppGroup"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApplicationGroupName,
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )
    begin {
        Import-Module Az.DesktopVirtualization
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $appGroup = Get-AzWvdApplicationGroup -Name $ApplicationGroupName -ResourceGroupName $ResourceGroupName `
                -ErrorAction Stop
            return $null -ne $appGroup
        } catch {
            return $false
        }
    }
    end {
    }
}
