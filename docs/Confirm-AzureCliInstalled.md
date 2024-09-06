---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Confirm-AzureCliInstalled

## SYNOPSIS
Tests for the presence of an installation of the Azure CLI.

## SYNTAX

```
Confirm-AzureCliInstalled
```

## DESCRIPTION
The Confirm-AzureCliInstalled function tests the current machine to see if the Azure CLI has been installed and 
returns $true if it is found, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
# Check if the Azure CLI is installed
Confirm-AzureCliInstalled
```

### EXAMPLE 2
```
# Check if the Azure CLI is installed and store the result in a variable.
$exists = Confirm-AzureCliInstalled
if ($exists) {
    Write-Output "The Azure CLI is installed."
} else {
    Write-Output "The Azure CLI is not installed."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "Azure CLI" {
    It "Should be installed" {
        Confirm-AzureCliInstalled | Should -Be $true
    }
}
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES
Author: Doug Seelinger

## RELATED LINKS
