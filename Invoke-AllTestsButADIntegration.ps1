Import-Module Pester
# Create a Pester configuration object
$config = [PesterConfiguration]::Default
$config.Filter.ExcludeTag = @('AD-Integration')

# Run Pester with the configuration object
Invoke-Pester -Configuration $config

