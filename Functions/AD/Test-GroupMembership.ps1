function Test-GroupMembership {
    <#
    .SYNOPSIS
    Tests to see if one AD object is in the [member] property of an AD Group.

    .DESCRIPTION
    The Test-GroupMembership function takes a group name and a member name and returns $true if the member name is found in the member property for the group, otherwise returns $false.

    .PARAMETER GroupName
    The name of the AD Group to look for.

    .PARAMETER MemberName
    The name of the member to search for within the group.

    .EXAMPLE
    Test-GroupMembership -GroupName "MyGroup01" -MemberName "MySAMAccountName01"
    Returns $true or $false

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
    }
    process {
    }
    end {
    }
}
