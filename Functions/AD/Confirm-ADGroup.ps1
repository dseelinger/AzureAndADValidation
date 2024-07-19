function Confirm-ADGroup {
    <#
    .SYNOPSIS
    Tests for the existence of an AD Group object in Active Directory.

    .DESCRIPTION
    The Confirm-ADGroup function takes a group name as input and returns $true if it is found, otherwise returns $false.

    .PARAMETER Name
    The name of the AD Group to look for.

    .EXAMPLE
    Confirm-ADGroup -Name "MyGroup01"
    Returns $true or $false

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    begin {
    }
    process {
    }
    end {
    }
}
