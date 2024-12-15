---
external help file: OHA-help.xml
Module Name: OHA
online version: https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHAHoliday.md
schema: 2.0.0
---

# Get-OHAHoliday

## SYNOPSIS

Retrieves public holidays or school holiday using the API from <https://www.openholidaysapi.org/>.

## SYNTAX

### Default (Default)

```PowerShell
Get-OHAHoliday [-HolidayType <String>] [-Country <String>] [-Subdivision <String>] [-Language <String>]
 [-SaveAsIcal <DirectoryInfo>] [-Raw] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### StartEndDate

```PowerShell
Get-OHAHoliday [-HolidayType <String>] [-Country <String>] [-Subdivision <String>] [-Language <String>]
 [-StartDate <DateTime>] [-EndDate <DateTime>] [-SaveAsIcal <DirectoryInfo>] [-Raw]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### TimeFrame

```PowerShell
Get-OHAHoliday [-HolidayType <String>] [-Country <String>] [-Subdivision <String>] [-Language <String>]
 [-TimeFrame <String>] [-SaveAsIcal <DirectoryInfo>] [-Raw] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

The 'Get-OHAHoliday' function retrieves public holidays or school holiday using the API from <https://www.openholidaysapi.org/>.

## EXAMPLES

### EXAMPLE 1

```PowerShell
Get-OHAHoliday
```

Returns public holidays for the country and in the language based on the OS language settings.
Holidays will be queried for the current year by default.

### EXAMPLE 2

```PowerShell
Get-OHAHoliday -Country DE
```

Returns public holidays for all subdivisions in Germany in the language based on the OS language settings.
If the language configured on the system (as it is returned by 'Get-Culture') does not match any of the offical languages for the specified country, it will use English instead.
Holidays will be quried for the current year by default.

### EXAMPLE 3

```PowerShell
Get-OHAHoliday -Country DE -Subdivision DE-BW -Language DE -StartDate (Get-Date -Day 1 -Month 1 -Year 2025)
```

Returns public holidays for Germany in 2025.
Showing holiday names in German language.
The result will be limited to the federal state of Baden-Wuerttemberg.

### EXAMPLE 4

```PowerShell
Get-OHAHoliday -HolidayType SchoolHoliday -Country AT -Language DE -TimeFrame NextYear
```

Returns school holidays for all subdivisions in Austria for the next year.

## PARAMETERS

### -HolidayType

Specifies the type of holiday to retrieve.
Can be set to either 'PublicHolidays' or 'SchoolHolidays'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: PublicHolidays
Accept pipeline input: False
Accept wildcard characters: False
```

### -Country

Specifies the two letter ISO code for the country for which to return holiday data.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-Culture).twoletterISOLanguageName.ToUpper()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subdivision

Specifies the code for the subdivision of a country for which to return holiday data.
Subdivisions are only available for some country.
Call 'Get-OHASubdivision -Country \<Country\>' to get a list of valid subdivision codes for a specific country.
Supports tab completion.
Limits the available values if a value for the 'Country' parameter was already specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language

Specifies the language in which the holiday names should be displayed.
This is either the officially supported languages for a country or English.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-Culture).twoletterISOLanguageName.ToUpper()
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate

Specifies the start date for the timeframe for which holidays should be returned.

```yaml
Type: DateTime
Parameter Sets: StartEndDate
Aliases:

Required: False
Position: Named
Default value: $(Get-Date -Month 1 -Day 1)
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate

Specifies the end date for the timeframe for which holidays should be returned.

```yaml
Type: DateTime
Parameter Sets: StartEndDate
Aliases:

Required: False
Position: Named
Default value: $StartDate.AddMonths(12).AddDays(-1)
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeFrame

Allows to specify a timeframe instead of start and end dates.
Support values are: "ThisYear", "NextYear", "LastYear", "ThisQuarter", "NextQuarter", "LastQuarter", "ThisMonth", "NextMonth", "LastMonth"

```yaml
Type: String
Parameter Sets: TimeFrame
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SaveAsIcal

If specified, the result will be a string in ICAL format.

```yaml
Type: DirectoryInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw

{{ Fill Raw Description }}

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

### PSCustomObject

## NOTES

Author:     Dieter Koch
Email:      <diko@admins-little-helper.de>

## RELATED LINKS

[https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHAHoliday.md](https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHAHoliday.md)
