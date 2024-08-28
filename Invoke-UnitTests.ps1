Import-Module Pester
$config = New-PesterConfiguration
$config.Filter.Tag = "Unit"
$config.CodeCoverage.Enabled = $true
Invoke-Pester -Configuration $config

