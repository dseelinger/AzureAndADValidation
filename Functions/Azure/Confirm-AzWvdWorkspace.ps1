function Confirm-AzWvdWorkspace {
    <#
    .SYNOPSIS
        Tests for the existence of a Windows Virtual Desktop Workspace in Azure.

    .DESCRIPTION
        The Confirm-AzWvdWorkspace function takes the name of a Workspace as input and returns $true if it is found,
        otherwise returns $false.

    .PARAMETER WorkspaceName
        The name of the Windows Virtual Desktop Workspace to look for.

    .PARAMETER ResourceGroupName
        The name of the Resource Group that the Workspace is supposed to be in.

    .EXAMPLE
        Confirm-AzWvdWorkspace -WorkspaceName "MyWvdWorkspace" -ResourceGroupName "MyResourceGroup"
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
        Import-Module Az.DesktopVirtualization
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }
    }
    process {
        try {
            $workspace = Get-AzWvdWorkspace -Name $WorkspaceName -ResourceGroupName $ResourceGroupName `
                -ErrorAction Stop
            return $null -ne $workspace
        } catch {
            return $false
        }
    }
    end {
    }
}