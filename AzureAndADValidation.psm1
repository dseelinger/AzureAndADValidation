<#
.SYNOPSIS
    This PowerShell module provides a set of functions for confirming that Azure and Active Directory resources have been \
    provisioned correctly.

.DESCRIPTION
    The AzureAndADValidation module includes functions to check common Azure Resources and Active Directory objects (users, 
    computers, etc. It is designed to act as both a validation tool as well as a library of functions that can be used in 
    automated testing scripts such as with Pester.

.AUTHOR
    Doug Seelinger

.COMPANYNAME
    Microsoft

.VERSION
    1.0.0

.RELEASE NOTES
    1.0.0 - Initial release with:
    - Confirm-ADComputer
    - Confirm-ADOU
    - Confirm-ADUser
    - Confirm-ADGroup
    - Test-ADGroupMembership
    - Test-MappedDrive
    - Confirm-AzApplicationGroup
    - Confirm-AzDisk
    - Confirm-AzHostPool
    - Confirm-AzNsgRule
    - Confirm-AzPermission
    - Confirm-AzResourceGroup
    - Confirm-AzureCliInstalled
    - Confirm-AzKeyVault
    - Confirm-AzLogAnalyticsWorkspace
    - Confirm-AzNic
    - Confirm-AzStorageAccount
    - Confirm-AzVm
    - Confirm-AzWvdWorkspace
    - Test-AzResourceGroupDeploymentTest

.EXAMPLE
    Import-Module .\AzureAndADValidation.psm1
    Confirm-AzApplicationGroup -AppId "62975602-70e3-4f0d-91df-1abe9266bec9"
    Confirm-AzDisk -DiskName "test-disk-01" -ResourceGroupName "test-rg-01"

.LINK
    https://github.com/dseelinger/AzureAndADValidation

#>

# AzureAndADValidation.psm1

. $PSScriptRoot\Functions\AD\Confirm-ADComputer.ps1
. $PSScriptRoot\Functions\AD\Confirm-ADOU.ps1
. $PSScriptRoot\Functions\AD\Confirm-ADUser.ps1
. $PSScriptRoot\Functions\AD\Confirm-ADGroup.ps1
. $PSScriptRoot\Functions\AD\Test-ADGroupMembership.ps1
. $PSScriptRoot\Functions\AD\Test-MappedDrive.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzApplicationGroup.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzDisk.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzHostPool.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzNsgRule.ps1
# . $PSScriptRoot\Functions\Azure\Confirm-AzPermission.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzResourceGroup.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzureCliInstalled.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzKeyVault.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzLogAnalyticsWorkspace.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzNic.ps1
. $PSScriptRoot\Functions\Azure\Confirm-AzStorageAccount.ps1
# . $PSScriptRoot\Functions\Azure\Confirm-AzVm.ps1
# . $PSScriptRoot\Functions\Azure\Confirm-AzWvdWorkspace.ps1
# . $PSScriptRoot\Functions\Azure\Test-AzResourceGroupDeploymentTest.ps1

# Export the functions you want to make available
Export-ModuleMember -Function Confirm-ADComputer, Confirm-ADOU, Confirm-ADUser, Confirm-ADGroup, Test-MappedDrive `
    , Test-ADGroupMembership, Confirm-AzApplicationGroup, Confirm-AzDisk, Confirm-AzHostPool, Confirm-AzNsgRule, `
    Confirm-AzResourceGroup, Confirm-AzureCliInstalled, Confirm-AzKeyVault, Confirm-AzLogAnalyticsWorkspace, Confirm-AzNic, `
    Confirm-AzStorageAccount
    # Confirm-AzPermission
    # Confirm-AzVm, Confirm-AzWvdWorkspace `
    # Test-AzResourceGroupDeploymentTest


# TODO 000: Create a GitHub Self-Hosted Runner with access to Active Directory so that we are able to run integration tests
#           with GitHub Actions. Until then we are limited to Unit Tests, and can only run Integration Tests locally,
#           assuming that AD is accessible from the dev environment.
# TODO 001: Publish module in the PowerShell Gallery (requires creation of a PowerShell Gallery account)
# TODO 002: Create GitHubActions to exercise
