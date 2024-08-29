# Import required modules
Import-Module Pester
Import-Module .\AzureAndADValidation.psd1

$config = New-PesterConfiguration
$config.Filter.Tag = "Unit"
$config.CodeCoverage.Enabled = $true
Invoke-Pester -Configuration $config

