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
    Test-GroupMembership -GroupName "MyGroup01" -MemberName "MySAMAccountName01"
    Returns $true or $false

    .EXAMPLE
    Test-GroupMembership -GroupName "Admins" -MemberName "JohnDoe"
    Checks if the user "JohnDoe" is a member of the "Admins" group and returns $true or $false.

    .EXAMPLE
    $result = Test-GroupMembership -GroupName "HR" -MemberName "JaneSmith"
    if ($result) {
        Write-Output "JaneSmith is a member of the HR group."
    } else {
        Write-Output "JaneSmith is not a member of the HR group."
    }
    Checks if "JaneSmith" is a member of the "HR" group and outputs a message accordingly.

    .EXAMPLE
    $isMember = Test-GroupMembership -GroupName "ITSupport" -MemberName "AliceW"
    Write-Output "Membership status: $isMember"
    Stores the result of the membership check in a variable and outputs the membership status.

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
