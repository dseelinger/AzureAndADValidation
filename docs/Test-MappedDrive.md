---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Test-MappedDrive

## SYNOPSIS
Tests for the presence of a specific mapped drive on the current computer for the current user.

## SYNTAX

```
Test-MappedDrive [[-Path] <String>] [[-DriveLetter] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Test-MappedDrive function takes a Path (UNC or local) or mapped drive letter (or both) and tests whether that
mapped drive exists on the current computer for the currently logged-in user or not.
Either one or both parameters 
must be present.

## EXAMPLES

### EXAMPLE 1
```
# Check if a mapped drive to a specific path exists
Test-MappedDrive -Path "\\someMachine\c$\some\path"
```

### EXAMPLE 2
```
# Check if a mapped drive with a specific drive letter exists. Drive letter may optionally omit the colon (:).
Test-MappedDrive -DriveLetter "Q:"
```

### EXAMPLE 3
```
# Check if a mapped drive with a specific drive letter and path exists    
Test-MappedDrive -Path "\\someMachine\c$\some\path" -DriveLetter "Q:"
```

### EXAMPLE 4
```
# Use in a Pester test
Describe "Mapped Drive Q:" {
    It "Should exist" {
        Test-MappedDrive -DriveLetter "Q:" | Should -Be $true
    }
}
```

## PARAMETERS

### -Path
The Path for the mapped drive

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DriveLetter
The Drive Letter for the mapped drive

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
