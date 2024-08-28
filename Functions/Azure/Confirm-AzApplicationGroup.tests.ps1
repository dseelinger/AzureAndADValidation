BeforeAll {
    . $PSScriptRoot\Confirm-AzApplicationGroup.ps1

    $rgName = 'rg-integration-tests'
    $testAppGroupName = 'testAppGroup'
    $fakeAppGroupName = 'notARealAppGroup'
}

Describe 'Confirm-AzApplicationGroup Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Host Pool and Application Group to test against
        $location = $env:AZURE_LOCATION
        $applicationGroupType = 'RemoteApp'

        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        $hostPoolName = "testHostPool"
        New-AzWvdHostPool -ResourceGroupName $rgName -Name $hostPoolName -Location $location -HostPoolType "Pooled" `
            -LoadBalancerType "BreadthFirst" -MaxSessionLimit 10 -PreferredAppGroupType 'Desktop'| Out-Null

        $hostPoolArmPath = (Get-AzWvdHostPool -ResourceGroupName $rgName -Name $hostPoolName).Id
        New-AzWvdApplicationGroup -ResourceGroupName $rgName -Name $testAppGroupName -Location $location `
            -HostPoolArmPath $hostPoolArmPath -ApplicationGroupType $applicationGroupType | Out-Null    
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

    Context 'Regarding the Location parameter' {
        It 'Should return true when the location matches' {
            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName `
                -Location 'usgovvirginia'
    
            # Assert
            $result | Should -Be $true
        }
    
        It 'Should return false when the location does not match' {
            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName `
            -Location 'westus'
    
            # Assert
            $result | Should -Be $false
        }
    }

    Context 'Regarding the ApplicationGroupType parameter' {
        It 'Should return true when the ApplicationGroupType matches' {
            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName `
                -ApplicationGroupType 'RemoteApp'
    
            # Assert
            $result | Should -Be $true
        }
    
        It 'Should return false when the ApplicationGroupType does not match' {
            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName `
                -ApplicationGroupType 'Desktop'
    
            # Assert
            $result | Should -Be $false
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
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Application Group does not exist' {
        It 'returns $false' {
            # Arrange
            Mock Get-AzWvdApplicationGroup { $null }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $fakeAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'Location parameter' {
        It 'Should return true when the location matches' {
            # Arrange
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName -Location 'usgovvirginia'

            # Assert
            $result | Should -Be $true
        }

        It 'Should return false when the location does not match' {
            # Arrange
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName -Location 'westus'

            # Assert
            $result | Should -Be $false
        }

        It 'Should return true when the location parameter is not provided' {
            # Arrange
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -Be $true
        }
    }

    Context 'ApplicationGroupType parameter' {
        It 'Should return true when the ApplicationGroupType matches' {
            # Arrange
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
                ApplicationGroupType = 'RemoteApp'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName -ApplicationGroupType 'RemoteApp'

            # Assert
            $result | Should -Be $true
        }

        It 'Should return false when the ApplicationGroupType does not match' {
            # Arrange
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
                ApplicationGroupType = 'Desktop'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName -ApplicationGroupType 'RemoteApp'

            # Assert
            $result | Should -Be $false
        }

        It 'Should return true when the ApplicationGroupType parameter is not provided' {
            # Arrange
            $appGroup = [PSCustomObject]@{
                Location = 'usgovvirginia'
                ApplicationGroupType = 'RemoteApp'
            }
            Mock Get-AzWvdApplicationGroup { $appGroup }

            # Act
            $result = Confirm-AzApplicationGroup -ApplicationGroupName $testAppGroupName -ResourceGroupName $rgName

            # Assert
            $result | Should -Be $true
        }
    }
}
