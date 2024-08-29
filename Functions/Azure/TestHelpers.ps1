function GetAzureLocationEnvironmentVariable {
    $location = $env:AZURE_LOCATION
    if (-not $location) {
        throw "The environment variable 'AZURE_LOCATION' is not set."
    }

    return $location
}