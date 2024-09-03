function Confirm-ADGroup {
    <#
    .SYNOPSIS
        Tests for the existence of an AD Group object in Active Directory.

    .DESCRIPTION
        The Confirm-ADGroup function takes a group name as input and returns $true if it is found, otherwise it returns $false.

    .PARAMETER Name
        The name of the AD Group to look for.

    .EXAMPLE
        # Check if a group named "MyGroup01" exists in AD
        Confirm-ADGroup -Name "MyGroup01"

    .EXAMPLE
        # Check if a group named "Admins" exists in AD and store the result in a variable
        $exists = Confirm-ADGroup -Name "Admins"
        if ($exists) {
            Write-Output "Admins group exists in Active Directory."
        } else {
            Write-Output "Admins group does not exist in Active Directory."
        }

    .EXAMPLE
        # How to use this in a Pester test
        Describe "Foo Group" {
            It "Should exist at this point" {
                Confirm-ADGroup -Name "Foo" | Should -Be $true
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
            Get-ADGroup -Identity $Name -ErrorAction Stop | Out-Null
            $true
        } catch {
            $false
        }
    }
    end {
    }
}
