# OpenHolidaysApi PowerShell Module

## Table of contents

- [OpenHolidaysApi PowerShell Module](#openholidaysapi-powershell-module)
  - [Table of contents](#table-of-contents)
  - [General information](#general-information)
  - [How to install this module](#how-to-install-this-module)
  - [How to use this module](#how-to-use-this-module)
    - [Examples](#examples)

## General information

This is a PowerShell Module that allows to retrieve data from from <https://www.openholidaysapi.org/>.
For more information about the API visit the API's website.

The PowerShell Module just makes use of this freely available API. There's no relationship between the API providers and the author of this PS module.

All functions parameters support tab completion with valid values as supported by the API.
It supports saving returned data as ICal file (data is retrieved in that format from the API).

## How to install this module

Install the module form PowerShell Gallery by running this:

```PowerShell
Install-Module -Name OHA -Repository PSGallery
```

## How to use this module

After installing the module, import it to the current session:

```PowerShell
Import-Module -Name OHA
```

Once the module is imported, execute the funtion ```Get-OHAHoliday``` to query the openholidaysapi.org API for data.

### Examples

Retrieve public holidays for Germany in the current year:

```PowerShell
Get-OHAHoliday -Country DE
```

Retrieve public holidays for Germany for next year and save it in an ICS file on C:\Temp:

```PowerShell
Get-OHAHoliday -Country DE -Timeframe NextYear -SaveAsIcal 'C:\Temp'
```

Retrieve public holidays for France in the next quarter:

```PowerShell
Get-OHAHoliday -Country FR -Timeframe NextQuarter
```

Retrieve public holidays for the federal state of Baden-Württemberg in Germany from 1st of June 2024 til 31st of December 2024:

```PowerShell
Get-OHAHoliday -Country DE -Subdivision DE-BW -StartDate (Get-Date -Date 2024-06-01) -EndDate (Get-Date -Date 2024-12-31)
```

Retrieve next years school holiday data for Austria (all subdivisions/federal states):

```PowerShell
Get-OHAHoliday -Country AT -Timeframe NextYear
```

Retrieve next years school holiday data for Austria (all subdivisions/federal states):

```PowerShell
Get-OHAHoliday -HolidayType SchoolHoliday -Country AT -Timeframe NextYear
```
