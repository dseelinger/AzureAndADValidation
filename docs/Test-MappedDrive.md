---
external help file: AzureAndADValidation-help.xml
Module Name: AzureAndADValidation
online version:
schema: 2.0.0
---

# Test-MappedDrive

## SYNOPSIS
Tests for the presence of a specific mapped drive on the current computer.

## SYNTAX

```
Test-MappedDrive [-UncPath] <String> [-DriveLetter] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Test-MappedDrive function takes a UNC Path or mapped drive letter (or both) and test whether that mapped drive exists
on the current computer or not.
Either one or both parameters must be present.

## EXAMPLES

### EXAMPLE 1
```
Test-MappedDrive -UncPath "\\someMachine\c$\some\path"
```

Returns $true if any mapped drive with that UNC is found on the current machine.

### EXAMPLE 2
```
Test-MappedDrive -DriveLetter "Q:"
```

Returns $true if any mapped drive with that drive letter is found on the current machine.
Drive letter optionally omit
the colon (:).

### EXAMPLE 3
```
Test-MappedDrive -UncPath "\\someMachine\c$\some\path" -DriveLetter "Q:"
```

Returns $true if any mapped drive with that UNC and drive letter is found on the current machine.

## PARAMETERS

### -UncPath
The UNC Path for the mapped drive

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

### -DriveLetter
The Drive Letter for the mapped drive

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
