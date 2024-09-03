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
        # Check if a computer named "VirtualMachine01" exists in Active Directory
        Confirm-ADComputer -Name "VirtualMachine01"

    .EXAMPLE
        # Use the result in a script to perform an action if the computer exists
        if (Confirm-ADComputer -Name "VirtualMachine01") {
            Write-Output "Computer VirtualMachine01 exists in Active Directory."
        } else {
            Write-Output "Computer VirtualMachine01 does not exist in Active Directory."
        }

    .EXAMPLE
        # Use in a Pester Test
        Describe "VirtualMachine01" {
            It "Should exist" {
                Confirm-ADComputer -Name "VirtualMachine01" | Should -Be $true
            }
        }

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
