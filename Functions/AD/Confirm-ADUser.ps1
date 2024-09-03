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
    # Use the function in a script to perform an action if the user exists
    if (Confirm-ADUser -Name "jdoe") {
        Set-ADUser -Identity "jdoe" -Title "Senior Developer"
    } else {
        Write-Output "User jdoe not found in Active Directory."
    }

    .EXAMPLE
    # Check multiple users in a loop
    $userNames = @("jdoe", "asmith", "mjones")
    foreach ($user in $userNames) {
        if (Confirm-ADUser -Name $user) {
            Write-Output "User $user exists in Active Directory."
        } else {
            Write-Output "User $user does not exist in Active Directory."
        }
    }

    .EXAMPLE
    # Check if a user exists and take different actions based on the result
    switch (Confirm-ADUser -Name "jdoe") {
        $true { Write-Output "User jdoe exists." }
        $false { Write-Output "User jdoe does not exist." }
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
