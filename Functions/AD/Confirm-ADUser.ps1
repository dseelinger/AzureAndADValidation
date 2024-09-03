function Confirm-ADUser {
    <#
    .SYNOPSIS
        Tests for the existence of an AD User object in Active Directory.

    .DESCRIPTION
        The Confirm-ADUser function takes a user name as input and returns $true if it is found, otherwise returns $false.

    .PARAMETER Name
        The username of the AD User to look for.

    .EXAMPLE
        # Check if a user named "MySAMAccountName01" exists in AD
        Confirm-ADUser -Name "MySAMAccountName01"

    .EXAMPLE
        # Check if a user named "jdoe" exists in AD and store the result in a variable
        $exists = Confirm-ADUser -Name "jdoe"
        if ($exists) {
            Write-Output "User jdoe exists in Active Directory."
        } else {
            Write-Output "User jdoe does not exist in Active Directory."
        }

    .EXAMPLE
        # How to use this in a Pester test
        Describe "jdoe User" {
            It "Should exist at this point" {
                Confirm-ADUser -Name "jdoe" | Should -Be $true
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
            Get-ADUser -Identity $Name -ErrorAction Stop | Out-Null
            $true
        } catch {
            $false
        }
    }
    end {
    }
}
