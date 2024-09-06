# Import required modules
Import-Module Pester
Import-Module .\AzureAndADValidation.psd1

# Create a Pester configuration object
$config = [PesterConfiguration]::Default
$config.CodeCoverage.Enabled = $true
# $config.Filter.ExcludeTag = @('AD-Integration', 'Skip-on-GitHub')
$config.Filter.ExcludeTag = @('Skip-on-GitHub')

# Run Pester with the configuration object and collect code coverage
Invoke-Pester -Configuration $config
