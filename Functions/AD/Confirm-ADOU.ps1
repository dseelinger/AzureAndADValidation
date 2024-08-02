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
    Confirm-ADOU -OUDN "OU=YourOU,DC=YourDomain,DC=com"
    Returns $true if found or $false if not found

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
