function Test-ADGroupMembership {
    <#
    .SYNOPSIS
    Tests to see if one AD object is in the [member] property of an AD Group.

    .DESCRIPTION
    The Test-GroupMembership function takes a group name and a member name and returns $true if the member name is found in the member property for the group, otherwise returns $false.

    .PARAMETER GroupName
    The name of the AD Group to look for.

    .PARAMETER MemberName
    The username of the member to search for within the group.

    .EXAMPLE
    # Check if a user named "jdoe" is a member of the group "FooUsers"
    Test-ADGroupMembership -GroupName "FooUsers" -MemberName "jdoe"

    .EXAMPLE
    # Check if a user named "jdoe" is a member of the group "FooUsers" and store the result in a variable
    $exists = Test-ADGroupMembership -GroupName "FooUsers" -MemberName "jdoe"
    if ($exists) {
        Write-Output "User jdoe is a member of the FooUsers group."
    } else {
        Write-Output "User jdoe is not a member of the FooUsers group."
    }

    .EXAMPLE
    # How to use this in a Pester test
    Describe "jdoe User" {
        It "Should be a member of the FooUsers group" {
            Test-ADGroupMembership -GroupName "FooUsers" -MemberName "jdoe" | Should -Be $true
        }
    }

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$GroupName,
        [Parameter(Mandatory=$true)]
        [string]$MemberName
    )
    begin {
        Import-Module ActiveDirectory
    }
    process {
        try {
            $groupMembers = Get-ADGroupMember -Identity $GroupName -ErrorAction Stop
            $isMember = $groupMembers | Where-Object { $_.SamAccountName -eq $MemberName }

            if ($isMember) {
                $true
            } else {
                $false
            }
        } catch {
            $false
        }
    }
    end {
    }
}
