BeforeAll {
    . $PSScriptRoot\Test-ADGroupMembership.ps1

    function Get-GroupWithMembers {
        # Get all groups in AD
        $allGroups = Get-ADGroup -Filter *
    
        # Iterate through each group and check if it has members
        foreach ($group in $allGroups) {
            try {
                $members = Get-ADGroupMember -Identity $group -ErrorAction Stop
                if ($members.Count -gt 0) {
                    return $group
                }
            } catch {
                # Handle any errors (e.g., group does not exist or no permissions)
                continue
            }
        }
    }

    function Get-GroupAndAMember {
        $oneGroupWithAMember = Get-GroupWithMembers
        $groupName = $oneGroupWithAMember.Name
        $memberName = $oneGroupWithAMember | Get-ADGroupMember | Get-Random | Select-Object -ExpandProperty SamAccountName
        return $groupName, $memberName
    }
}

Describe 'Test-ADGroupMembership Integration Tests' -Tag 'Integration', 'AD' {
    Context 'When the User is a member of the group' {
        It 'returns $true' {
            # Arrange
            $groupName, $memberName = Get-GroupAndAMember

            # Act
            $result = Test-ADGroupMembership -GroupName $groupName -MemberName $memberName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the user is not a member of the group' {
        It 'returns $false' {
            # Arrange
            $me = $env:USERNAME
            $randomGroup = Get-GroupWithMembers

            # Act
            $result = Test-ADGroupMembership -GroupName $randomGroup -MemberName $me

            # Assert
            $result | Should -BeFalse
        }
    }
}

Describe 'Test-ADGroupMembership Unit Tests' -Tag 'Unit', 'AD' {
    BeforeAll {
        function Import-Module {}
    }

    Context 'When the user is a member of the group' {
        It 'returns $true' {
            # Arrange
            $realGroupName = 'MyGroup01'
            $realUserName = 'MySAMAccountName01'
            function Get-ADGroupMember { return @{'SamAccountName' = $realUserName} }

            # Act
            $result = Test-ADGroupMembership -GroupName $realGroupName -MemberName $realUserName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the user is NOT a member of the group' {
        It 'returns $false' {
            # Arrange
            $fakeGroupName = 'MyFakeGroup01'
            $fakeUserName = 'MyFakeSAMAccountName01'
            function Get-ADGroupMember { @() }

            # Act
            $result = Test-ADGroupMembership -GroupName $fakeGroupName -MemberName $fakeUserName

            # Assert
            $result | Should -BeFalse
        }
    }
}