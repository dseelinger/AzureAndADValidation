BeforeAll {
    . $PSScriptRoot\Test-AzResourceGroupDeploymentSuccess.ps1

    $location = $env:AZURE_LOCATION
    $rgName = 'rg-integration-tests'
    $deploymentName = 'test-deployment'
    $fakeDeploymentName = 'bad-deployment'
    $templateFilePath = "$PSScriptRoot\storageAccountTemplate.json"
}

Describe 'Test-AzResourceGroupDeploymentSuccess Integration Tests' -Tag 'Integration', 'Azure' {
    BeforeAll {
        # Arrange - Create a Resource Group and a Deployment to test against
        New-AzResourceGroup -Name $rgName -Location $location | Out-Null
        
        # Create the deployment
        New-AzResourceGroupDeployment -ResourceGroupName $rgName -Name $deploymentName -TemplateFile $templateFilePath `
            -TemplateParameterObject @{} | Out-Null
    }
    
    Context 'When the Deployment exists and is successful' {
        It 'returns $true' {
            # Act
            $result = Test-AzResourceGroupDeploymentSuccess -DeploymentName $deploymentName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Deployment does not exist' {
        It 'returns $false' {
            # Act
            $result = Test-AzResourceGroupDeploymentSuccess -DeploymentName $fakeDeploymentName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    AfterAll {
        # Cleanup - Remove the Resource Group
        Remove-AzResourceGroup -Name $rgName -Force | Out-Null
    }
}

Describe 'Test-AzResourceGroupDeploymentSuccess Unit Tests' -Tag 'Unit', 'Azure' {
    BeforeAll {
        function Get-AzContext { return $true }
    }

    Context 'When the Deployment exists and is successful' {
        It 'returns $true' {
            # Arrange
            function Get-AzResourceGroupDeployment {
                return @{
                    ProvisioningState = 'Succeeded'
                }
            }

            # Act
            $result = Test-AzResourceGroupDeploymentSuccess -DeploymentName $deploymentName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeTrue
        }
    }

    Context 'When the Deployment does not exist' {
        It 'returns $false' {
            # Arrange
            function Get-AzResourceGroupDeployment {
                return $null
            }

            # Act
            $result = Test-AzResourceGroupDeploymentSuccess -DeploymentName $fakeDeploymentName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }

    Context 'When the Deployment exists but is not successful' {
        It 'returns $false' {
            # Arrange
            function Get-AzResourceGroupDeployment {
                return @{
                    ProvisioningState = 'Failed'
                }
            }

            # Act
            $result = Test-AzResourceGroupDeploymentSuccess -DeploymentName $deploymentName -ResourceGroupName $rgName

            # Assert
            $result | Should -BeFalse
        }
    }
}