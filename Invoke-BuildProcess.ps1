# Create the .\_build\AzureAndADValidation folder if it doesn't exist
$null = New-Item -Path .\_build\AzureAndADValidation -ItemType Directory -Force

# Function to update the minor version number in the .psd1 file
function Update-MinorVersion {
    param (
        [string]$psd1Path
    )

    # Read the content of the .psd1 file
    $content = Get-Content -Path $psd1Path -Raw

    # Break the content into lines
    $lines = $content -split '\r?\n'

    # Find the line that matches "# Version number of this module."
    $lineIndex = $lines.IndexOf('# Version number of this module.')

    # Get the next line's text
    $moduleVersionLine = $lines[$lineIndex + 1]

    # Get the major version number
    $major = $moduleVersionLine -replace '.*''(\d+)\.(\d+)\.(\d+)''.*', '$1'

    # Get the minor version number
    $minor = $moduleVersionLine -replace '.*''(\d+)\.(\d+)\.(\d+)''.*', '$2'

    # Get the patch version number as an integer
    $patch = [int]($moduleVersionLine -replace '.*''(\d+)\.(\d+)\.(\d+)''.*', '$3')
    
    # Increment the patch version number
    $patch++

    # Update the content with the new version number
    $moduleVersionLine = "ModuleVersion = '$major.$minor.$patch'"
    
    # Update the line in the array
    $lines[$lineIndex + 1] = $moduleVersionLine

    # Join the lines back together
    $newContent = $lines -join "`r`n"

    # Write the updated content back to the .psd1 file
    Set-Content -Path $psd1Path -Value $newContent
}

# Path to the .psd1 file
$psd1Path = ".\AzureAndADValidation.psd1"

# Update the minor version number in the .psd1 file
Update-MinorVersion -psd1Path $psd1Path

# Copy the AzureAndADValidation.psd1 file to the .\_build\AzureAndADValidation folder
Copy-Item -Path $psd1Path -Destination .\_build\AzureAndADValidation\AzureAndADValidation.psd1 -Force

# Copy the AzureAndADValidation.psm1 file to the .\_build\AzureAndADValidation folder
Copy-Item -Path .\AzureAndADValidation.psm1 -Destination .\_build\AzureAndADValidation\AzureAndADValidation.psm1 -Force

# Copy the Functions folder to the .\_build\AzureAndADValidation folder
Copy-Item -Path .\Functions -Destination .\_build\AzureAndADValidation\Functions -Recurse -Force

# Remove the Pester test files from the functions folder we just copied to, including all subfolders
Get-ChildItem -Path .\_build\AzureAndADValidation\Functions -Filter *.Tests.ps1 -Recurse | Remove-Item -Force