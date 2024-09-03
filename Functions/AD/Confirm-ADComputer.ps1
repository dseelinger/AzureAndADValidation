function Confirm-ADComputer {
    <#
    .SYNOPSIS
    Tests for the existence of an AD Computer object in Active Directory.

    .DESCRIPTION
    The Confirm-ADComputer function takes a computer name as input and returns $true if the computer is found, otherwise 
    returns $false.

    .PARAMETER Name
    The name of the AD Computer object to look for.

    .EXAMPLE
    Confirm-ADComputer -Name "VirtualMachine01"
    Returns $true if found or $false if not found

    .EXAMPLE
    Confirm-ADComputer -Name "VirtualMachine01" | Out-Null

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    begin {
        Import-Module ActiveDirectory
    }
    process {
        try {
            Get-ADComputer -Identity $name -ErrorAction Stop | Out-Null
            $true
        } catch {
            $false
        }
    }
    end {
    }
}
