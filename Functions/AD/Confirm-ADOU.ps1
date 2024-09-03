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
    # Use the function in a script to perform an action if the OU exists
    if (Confirm-ADOU -OUDN "OU=IT,DC=YourDomain,DC=com") {
        New-ADUser -Name "John Doe" -Path "OU=IT,DC=YourDomain,DC=com" -SamAccountName "jdoe" -UserPrincipalName "jdoe@YourDomain.com"
    } else {
        Write-Output "IT OU not found in Active Directory."
    }

    .EXAMPLE
    # Check multiple OUs in a loop
    $ouDNs = @("OU=HR,DC=YourDomain,DC=com", "OU=Finance,DC=YourDomain,DC=com", "OU=IT,DC=YourDomain,DC=com")
    foreach ($ouDN in $ouDNs) {
        if (Confirm-ADOU -OUDN $ouDN) {
            Write-Output "$ouDN exists in Active Directory."
        } else {
            Write-Output "$ouDN does not exist in Active Directory."
        }
    }

    .EXAMPLE
    # Check if an OU exists and take different actions based on the result
    switch (Confirm-ADOU -OUDN "OU=Marketing,DC=YourDomain,DC=com") {
        $true { Write-Output "Marketing OU exists." }
        $false { Write-Output "Marketing OU does not exist." }
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
