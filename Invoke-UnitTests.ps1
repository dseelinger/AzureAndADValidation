Import-Module Pester
Import-Module ActiveDirectory -ErrorAction Stop
Import-Module .\AzureAndADValidation.psd1
$config = New-PesterConfiguration
$config.Filter.Tag = "Unit"
$config.CodeCoverage.Enabled = $true
Invoke-Pester -Configuration $config

