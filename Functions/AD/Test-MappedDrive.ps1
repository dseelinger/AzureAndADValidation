function Test-MappedDrive {
    <#
    .SYNOPSIS
    Tests for the presence of a specific mapped drive on the current computer.

    .DESCRIPTION
    The Test-MappedDrive function takes a UNC Path or mapped drive letter (or both) and test whether that mapped drive exists
    on the current computer or not. Either one or both parameters must be present.

    .PARAMETER UncPath
    The UNC Path for the mapped drive

    .PARAMETER DriveLetter
    The Drive Letter for the mapped drive

    .EXAMPLE
    Test-MappedDrive -UncPath "\\someMachine\c$\some\path"

    Returns $true if any mapped drive with that UNC is found on the current machine.

    .EXAMPLE
    Test-MappedDrive -DriveLetter "Q:"

    Returns $true if any mapped drive with that drive letter is found on the current machine. Drive letter optionally omit
    the colon (:).

    .EXAMPLE
    Test-MappedDrive -UncPath "\\someMachine\c$\some\path" -DriveLetter "Q:"

    Returns $true if any mapped drive with that UNC and drive letter is found on the current machine.

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$UncPath,
        [Parameter(Mandatory=$true)]
        [string]$DriveLetter
    )
    begin {
    }
    process {
        throw "Function not implemented yet."
    }
    end {
    }
}
