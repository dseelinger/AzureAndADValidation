function Confirm-ADOU {
    <#
    .SYNOPSIS
    Tests for the existence of an AD Organizational Unit (OU) object in Active Directory.

    .DESCRIPTION
    The Confirm-ADOU function takes an OU name as input and returns $true if it is found, otherwise returns $false.

    .PARAMETER Name
    The name of the AD OU to look for.

    .EXAMPLE
    Confirm-ADOU -Name "MyOU01"
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
