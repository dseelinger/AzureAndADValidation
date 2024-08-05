function Test-MappedDrive {
    <#
    .SYNOPSIS
    Tests for the presence of a specific mapped drive on the current computer for the current user.

    .DESCRIPTION
    The Test-MappedDrive function takes a Path (UNC or local) or mapped drive letter (or both) and tests whether that mapped drive 
    exists on the current computer for the currently logged-in user or not. Either one or both parameters must be present.

    .PARAMETER Path
    The Path for the mapped drive

    .PARAMETER DriveLetter
    The Drive Letter for the mapped drive

    .EXAMPLE
    Test-MappedDrive -Path "\\someMachine\c$\some\path"

    Returns $true if any mapped drive with that path is found on the current machine.

    .EXAMPLE
    Test-MappedDrive -DriveLetter "Q:"

    Returns $true if any mapped drive with that drive letter is found on the current machine. Drive letter may optionally 
    omit the colon (:).

    .EXAMPLE
    Test-MappedDrive -Path "\\someMachine\c$\some\path" -DriveLetter "Q:"

    Returns $true if any mapped drive with that path and drive letter is found on the current machine.

    .NOTES
    Author: Doug Seelinger
    #>
    [CmdletBinding()]
    param (
        [string]$Path,
        [string]$DriveLetter
    )
    begin {
    }
    process {
        if ($DriveLetter -and $DriveLetter -match ':') {
            $DriveLetter = $DriveLetter -replace ':', ''
        }

        if ($DriveLetter -and -not $Path) {
            $mappedDrive = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Name -eq $DriveLetter }
        } elseif ($Path -and -not $DriveLetter) {
            $mappedDrive = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -eq $Path }
        } elseif ($Path -and $DriveLetter) {
            $mappedDrive = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -eq $Path -and $_.Name -eq $DriveLetter }
        } else {
            throw 'You must provide either a Path or a DriveLetter parameter.'
        }

        return $null -ne $mappedDrive
    }
    end {
    }
}
