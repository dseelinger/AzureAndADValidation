function Confirm-ADUser {
    <#
    .SYNOPSIS
    Tests for the existence of an AD User object in Active Directory.

    .DESCRIPTION
    The Confirm-ADUser function takes a user name as input and returns $true if it is found, otherwise returns $false.

    .PARAMETER Name
    The name of the AD User to look for.

    .EXAMPLE
    Confirm-ADUser -Name "MySAMAccountName01"
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
