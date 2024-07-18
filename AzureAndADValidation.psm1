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
    * Confirm-ADComputer
    * Confirm-ADOU
    * Confirm-ADUser
    * Confirm-ADGroup
    * Confirm-AzApplicationGroup
    * Confirm-AzDisk
    * Confirm-AzHostPool
    * Confirm-AzNsgRule
    * Confirm-AzPermission
    * Confirm-AzResourceGroup
    * Confirm-AzureCliInstalled
    * Confirm-AzKeyVault
    * Confirm-AzLogAnalyticsWorkspace
    * Confirm-AzNic
    * Confirm-AzStorageAccount
    * Confirm-AzVm
    * Confirm-AzWvdWorkspace
    * Confirm-BicepSuccessfullyDeployed
    * Confirm-MappedDrive
    * Confirm-SecurityGroup
    * Confirm-SecurityGroupMember

.EXAMPLE
    Import-Module .\AzureAndADValidation.psm1
    AzApplicationGroupShouldExist -AppId "62975602-70e3-4f0d-91df-1abe9266bec9"
    AzDiskShouldExist -DiskName "test-disk-01" -ResourceGroupName "test-rg-01"

.LINK
    https://github.com/dseelinger/AzureAndADValidation

#>

# MyModule.psm1

. $PSScriptRoot\Functions\Confirm-ADComputer.ps1
. $PSScriptRoot\Functions\Confirm-ADOU.ps1
. $PSScriptRoot\Functions\Confirm-ADUser.ps1
. $PSScriptRoot\Functions\Confirm-ADGroup.ps1
. $PSScriptRoot\Functions\Confirm-AzApplicationGroup.ps1
. $PSScriptRoot\Functions\Confirm-AzDisk.ps1
. $PSScriptRoot\Functions\Confirm-AzHostPool.ps1
. $PSScriptRoot\Functions\Confirm-AzNsgRule.ps1
. $PSScriptRoot\Functions\Confirm-AzPermission.ps1
. $PSScriptRoot\Functions\Confirm-AzResourceGroup.ps1
. $PSScriptRoot\Functions\Confirm-AzureCliInstalled.ps1
. $PSScriptRoot\Functions\Confirm-AzKeyVault.ps1
. $PSScriptRoot\Functions\Confirm-AzLogAnalyticsWorkspace.ps1
. $PSScriptRoot\Functions\Confirm-AzNic.ps1
. $PSScriptRoot\Functions\Confirm-AzStorageAccount.ps1
. $PSScriptRoot\Functions\Confirm-AzVm.ps1
. $PSScriptRoot\Functions\Confirm-AzWvdWorkspace.ps1
. $PSScriptRoot\Functions\Confirm-BicepSuccessfullyDeployed.ps1
. $PSScriptRoot\Functions\Confirm-MappedDrive.ps1
. $PSScriptRoot\Functions\Confirm-SecurityGroup.ps1
. $PSScriptRoot\Functions\Confirm-SecurityGroupMember.ps1

# Export the functions you want to make available
Export-ModuleMember -Function Confirm-ADComputer, Confirm-ADOU, Confirm-ADUser, Confirm-ADGroup, Confirm-AzApplicationGroup `
    , Confirm-AzDisk, Confirm-AzHostPool, Confirm-AzNsgRule, Confirm-AzPermission, Confirm-AzResourceGroup `
    , Confirm-AzureCliInstalled, Confirm-AzKeyVault, Confirm-AzLogAnalyticsWorkspace, Confirm-AzNic `
    , Confirm-AzStorageAccount, Confirm-AzVm, Confirm-AzWvdWorkspace, Confirm-BicepSuccessfullyDeployed `
    , Confirm-MappedDrive, Confirm-SecurityGroup, Confirm-SecurityGroupMember
