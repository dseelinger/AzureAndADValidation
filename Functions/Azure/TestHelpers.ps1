function Get-AzureLocationEnvironmentVariable {
    $location = $env:AZURE_LOCATION
    if (-not $location) {
        throw "The environment variable 'AZURE_LOCATION' is not set."
    }

    return $location
}

function Get-RandomDigits {
    param(
        [int]$length
    )

    $random = New-Object System.Random
    $randomDigits = -join (0..$length | ForEach-Object { $random.Next(0, 10) })
    return $randomDigits
}