function Confirm-AzureCliInstalled {
    <#
    .SYNOPSIS
    Tests for the presence of an installation of the Azure CLI.

    .DESCRIPTION
    The Confirm-AzureCliInstalled function tests the current machine to see if the Azure CLI has been installed and returns 
    $true if it is found, otherwise returns $false.

    .EXAMPLE
    Confirm-AzureCliInstalled
    Returns $true or $false

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
