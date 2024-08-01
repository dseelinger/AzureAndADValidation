Import-Module Pester
$config = New-PesterConfiguration
$config.Filter.Tag = "Unit"
Invoke-Pester -Configuration $config

