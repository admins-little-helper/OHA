---
external help file: OHA-help.xml
Module Name: OHA
online version: https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHASubdivision.md
schema: 2.0.0
---

# Get-OHASubdivision

## SYNOPSIS

Returns a list of subdivisions for a given country for which holiday information can be queried from <https://www.openholidaysapi.org/>.

## SYNTAX

```PowerShell
Get-OHASubdivision [[-Country] <String>] [-Raw] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The 'Get-OHASubdivision' function returns a list of subdivisions for a given country for which holiday information can be queried from <https://www.openholidaysapi.org/>.

## EXAMPLES

### EXAMPLE 1

```PowerShell
Get-OHASubdivision -Country DE
```

Returns a list of all subdivisions for Germany that are supported by the API in a custom table format.

### EXAMPLE 2

```PowerShell
Get-OHASubdivision -Country AT -Raw
```

Returns a list of all subdivisions for Austria that are supported by the API in a raw json format as it is retrieved from the API.

## PARAMETERS

### -Country

Get the session variable content.
Get the list of countries retrieved from the session variable.
Return a list of countries starting with the charaters already typed for the parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-Culture).twoletterISOLanguageName.ToUpper()
Accept pipeline input: False
Accept wildcard characters: False
```

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

[https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHASubdivision.md](https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHASubdivision.md)
