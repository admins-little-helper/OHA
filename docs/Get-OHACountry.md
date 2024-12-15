---
external help file: OHA-help.xml
Module Name: OHA
online version: https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHACountry.md
schema: 2.0.0
---

# Get-OHACountry

## SYNOPSIS

Returns a list of countries for which holiday information can be queried from <https://www.openholidaysapi.org/>.

## SYNTAX

```PowerShell
Get-OHACountry [-Raw] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The 'Get-OHACountry' function returns a list of countries for which holiday information can be queried from <https://www.openholidaysapi.org/>.

## EXAMPLES

### EXAMPLE 1

```PowerShell
Get-OHACountry
```

Returns a list of all countries supported by the API in a custom table format.

### EXAMPLE 2

```PowerShell
Get-OHACountry -Raw
```

Returns a list of all countries supported by the API in a raw json format as it is retrieved from the API.

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

[https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHACountry.md](https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHACountry.md)
