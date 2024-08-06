BeforeAll {
    . $PSScriptRoot\Confirm-AzApplicationGroup.ps1

    $rgName = 'rg-integration-tests'
    $testAppGroupName = 'testAppGroup'
    $fakeAppGroupName = 'notARealAppGroup'
}

Describe 'Confirm-AzApplicationGroup Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Host Pool and Application Group to test against
        $location = 'usgovvirginia'
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        $hostPoolName = "testHostPool"
        New-AzWvdHostPool -ResourceGroupName $rgName -Name $hostPoolName -Location $location -HostPoolType "Pooled" `
            -LoadBalancerType "BreadthFirst" -MaxSessionLimit 10 -PreferredAppGroupType 'Desktop'| Out-Null

        $hostPoolArmPath = (Get-AzWvdHostPool -ResourceGroupName $rgName -Name $hostPoolName).Id
        New-AzWvdApplicationGroup -ResourceGroupName $rgName -Name $testAppGroupName -Location $location `
            -HostPoolArmPath $hostPoolArmPath -ApplicationGroupType RemoteApp | Out-Null    
    }
    
    Context 'When the Application Group exists' {
        It 'returns $true' {

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Application Group does not exist' {
        It 'returns $false' {
            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $fakeAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        Remove-AzResourceGroup -Name $rgName -Force
    }
}

Describe 'Confirm-AzApplicationGroup Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }
    Context 'When the Application Group exists' {
        It 'returns $true' {
            # Arrange
            function Get-AzWvdApplicationGroup { return [PSCustomObject]@{Name = "Name"; ResourceGroupName = "group" } }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Application Group does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzWvdApplicationGroup { return $null }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $fakeAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}

