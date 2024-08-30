# Import required modules
Import-Module Pester
Import-Module .\AzureAndADValidation.psd1

# Create a Pester configuration object
$config = [PesterConfiguration]::Default
$config.CodeCoverage.Enabled = $true
$config.Filter.ExcludeTag = @('AD-Integration')

# Run Pester with the configuration object and collect code coverage
Invoke-Pester -Configuration $config

# # Get the code coverage percentage
# $codeCoverage = $testResults.CodeCoverage.CoveragePercent

# # Check if any tests failed
# if ($testResults.FailedCount -gt 0) {
#     Write-Error "Some tests failed."
#     exit 1
# }

# # Check if code coverage is below 75%
# if ($codeCoverage -lt 75) {
#     Write-Error "Code coverage is below 75%. Actual: $codeCoverage%"
#     exit 1
# }

# Write-Output "All tests passed and code coverage is $codeCoverage%"