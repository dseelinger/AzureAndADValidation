# AzureAndADValidation

This PowerShell module provides a set of cmdlets for confirming that Azure and Active Directory resources have been provisioned correctly. It includes functions to validate the existence and configuration of various Azure resources, such as Network Security Groups (NSGs), role assignments, and resource group deployments.

## Installation

To install the `AzureAndADValidation` module, use the following command:

```powershell
Install-Module -Name AzureAndADValidation -Scope CurrentUser
```

## Testing

To run the automated tests, log in to you desired Azure environment and set an environment variable for the location you want the tests to use when creating temporary testing Azure objects per the following example.

```powershell
$env:AZURE_LOCATION = 'westus'
```


## Contributing
Contributions are welcome! Please submit a pull request or open an issue to discuss any changes you would like to make.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Author
Doug Seelinger
