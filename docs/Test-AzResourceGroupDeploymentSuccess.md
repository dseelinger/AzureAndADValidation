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
# Check if a deployment named "MyDeployment01" was successful in the resource group "MyResourceGroup01"
Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName "MyResourceGroup01"
```

### EXAMPLE 2
```
# Check if a deployment named "MyDeployment01" was successful in the resource group "MyResourceGroup01" and store the 
# result in a variable.
$success = Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName `
    "MyResourceGroup01"
if ($success) {
    Write-Output "MyDeployment01 was successful in the MyResourceGroup01 Resource Group."
} else {
    Write-Output "MyDeployment01 was not successful in the MyResourceGroup01 Resource Group."
}
```

### EXAMPLE 3
```
# How to use this in a Pester test
Describe "MyDeployment01 Deployment" {
    It "Should be successful in the MyResourceGroup01 Resource Group" {
        Test-AzResourceGroupDeploymentSuccess -DeploymentName "MyDeployment01" -ResourceGroupName `
            "MyResourceGroup01" | Should -Be $true
    }
}
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
