function Confirm-AzureCliInstalled {
    <#
    .SYNOPSIS
        Tests for the presence of an installation of the Azure CLI.

    .DESCRIPTION
        The Confirm-AzureCliInstalled function tests the current machine to see if the Azure CLI has been installed and 
        returns $true if it is found, otherwise returns $false.

    .EXAMPLE
        # Check if the Azure CLI is installed
        Confirm-AzureCliInstalled

    .EXAMPLE
        # Check if the Azure CLI is installed and store the result in a variable.
        $exists = Confirm-AzureCliInstalled
        if ($exists) {
            Write-Output "The Azure CLI is installed."
        } else {
            Write-Output "The Azure CLI is not installed."
        }

    .EXAMPLE
        # How to use this in a Pester test
        Describe "Azure CLI" {
            It "Should be installed" {
                Confirm-AzureCliInstalled | Should -Be $true
            }
        }

    .NOTES
        Author: Doug Seelinger
    #>
    begin {
    }
    process {
        try {
            $cmd = Get-Command -Name az -ErrorAction Stop
            if ($cmd) {
                return $true
            } 
            return $false
        } catch {
            return $false
        }
    }
    end {
    }
}
