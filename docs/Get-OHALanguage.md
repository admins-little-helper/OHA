---
external help file: OHA-help.xml
Module Name: OHA
online version: https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHALanguage.md
schema: 2.0.0
---

# Get-OHALanguage

## SYNOPSIS

Returns a list of languages supported by <https://www.openholidaysapi.org/>.

## SYNTAX

```PowerShell
Get-OHALanguage [-Raw] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The 'Get-OHALanguage' function returns a list of languages supported by <https://www.openholidaysapi.org/>.

## EXAMPLES

### EXAMPLE 1

```PowerShell
Get-OHALanguage
```

Returns a list of all languages supported by the API in a custom table format.

### EXAMPLE 2

```PowerShell
Get-OHALanguage -Raw
```

Returns a list of all languages supported by the API in a raw json format as it is retrieved from the API.

## PARAMETERS

### -Raw

If specified, raw json data is returned as it's delivered from the API.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### Nothing

## OUTPUTS

### Nothing

## NOTES

Author:     Dieter Koch
Email:      <diko@admins-little-helper.de>

## RELATED LINKS

[https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHALanguage.md](https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHALanguage.md)
