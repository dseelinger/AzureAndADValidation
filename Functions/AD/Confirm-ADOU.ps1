function Confirm-ADOU {
    <#
    .SYNOPSIS
        Tests for the existence of an AD Organizational Unit (OU) object in Active Directory.

    .DESCRIPTION
        The Confirm-ADOU function takes an LDAP Path for an OU as input and returns $true if the OU is found, otherwise 
        returns $false.

    .PARAMETER OUDN
        The LDAP path (aka OU's "Distinguished Name" (DN)) of the OU object to look for.

    .EXAMPLE
        # Check if an OU named "YourOU" exists in AD
        Confirm-ADOU -OUDN "OU=YourOU,DC=YourDomain,DC=com"
        
    .EXAMPLE
        # Check if an OU named "Sales" exists in AD and store the result in a variable
        $exists = Confirm-ADOU -OUDN "OU=Sales,DC=YourDomain,DC=com"
        if ($exists) {
            Write-Output "Sales OU exists in Active Directory."
        } else {
            Write-Output "Sales OU does not exist in Active Directory."
        }

    .EXAMPLE
        # How to use this in a Pester test, checking that an OU that should exist actually does
        Describe "Sales OU" {
            It "Should exists" {
                Confirm-ADOU -OUDN "OU=Sales,DC=YourDomain,DC=com" | Should -Be $true
            }
        }

    .NOTES
        Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$OUDN
    )
    begin {
        Import-Module ActiveDirectory
    }
    process {
        try {
            Get-ADOrganizationalUnit -Identity $OUDN -ErrorAction Stop | Out-Null
            $true
        } catch {
            $false
        }
    }
    end {
    }
}
