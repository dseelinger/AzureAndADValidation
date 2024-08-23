---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Test-AzResourceGroupDeploymentSuccess

## SYNOPSIS
Tests whether an Azure Resource Group deployment was successful.

## SYNTAX

```
Test-AzResourceGroupDeploymentSuccess [-DeploymentName] <String> [-ResourceGroupName] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Test-AzResourceGroupDeploymentSuccess function takes the name of an Azure Resource Group deployment as input 
and returns $true if the deployment was successful, otherwise returns $false.

## EXAMPLES

### EXAMPLE 1
```
Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName "MyResourceGroup01"
Returns $true or $false
```

### EXAMPLE 2
```
$deploymentSuccess = Test-AzResourceGroupDeploymentSuccess -DeploymentName "WebAppDeployment" -ResourceGroupName "WebAppResourceGroup"
if ($deploymentSuccess) {
    Write-Output "The deployment 'WebAppDeployment' was successful."
} else {
    Write-Output "The deployment 'WebAppDeployment' failed."
}
Checks if the deployment "WebAppDeployment" in the "WebAppResourceGroup" was successful and outputs a message accordingly.
```

### EXAMPLE 3
```
$result = Test-AzResourceGroupDeploymentSuccess -DeploymentName "DatabaseDeployment" -ResourceGroupName "DatabaseResourceGroup"
Write-Output "Deployment success: $result"
Stores the result of the deployment success check in a variable and outputs the result.
```

### EXAMPLE 4
```
if (Test-AzResourceGroupDeploymentSuccess -DeploymentName "NetworkDeployment" -ResourceGroupName "NetworkResourceGroup") {
    Write-Output "Deployment 'NetworkDeployment' was successful."
} else {
    Write-Output "Deployment 'NetworkDeployment' failed."
}
Directly checks the success of the deployment "NetworkDeployment" in the "NetworkResourceGroup" and outputs a message.
```

### EXAMPLE 5
```
Test-AzResourceGroupDeploymentSuccess -DeploymentName "StorageDeployment" -ResourceGroupName "StorageResourceGroup"
Checks if the deployment "StorageDeployment" in the "StorageResourceGroup" was successful and returns $true or $false.
```

## PARAMETERS

### -DeploymentName
The name of the deployment to check.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The name of the Resource Group that the deployment is in.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Doug Seelinger

## RELATED LINKS
