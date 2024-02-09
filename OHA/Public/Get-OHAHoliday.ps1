<#PSScriptInfo

.VERSION 1.0.0

.GUID 2743a312-485f-4bc6-a36b-314586d6e502

.AUTHOR Dieter Koch

.COMPANYNAME

.COPYRIGHT (c) 2024 Dieter Koch

.TAGS openholidaysapi

.LICENSEURI https://github.com/admins-little-helper/OHA/blob/main/LICENSE

.PROJECTURI https://github.com/admins-little-helper/OHA

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
    1.0.0
    Initial release

#>



<#

.DESCRIPTION
OpenHolidaysApi PowerShell Module.

.LINK
https://github.com/admins-little-helper/OHA

.LINK
https://www.openholidaysapi.org/

#>


<#

Tried to use ArgumentCompleter here and putting the actual code into separate functions, then calling the functions in the ArgumentCompleter's scriptblock.
However, this does not work as expected.
Putting it in their own function scope and then calling the function in the ArgumentCompleter script block only works if the function is exported to the global scope as part of the module.
That's not what I wanted.

This seems a known issue, see links below for more details.
https://github.com/PowerShell/PowerShell/issues/7265
https://github.com/PowerShell/PowerShell/issues/7071

#>


function Get-OHAHoliday {
    <#
    .SYNOPSIS
        Retrieves public holidays or school holiday using the API from https://www.openholidaysapi.org/.

    .DESCRIPTION
        The 'Get-OHAHoliday' function retrieves public holidays or school holiday using the API from https://www.openholidaysapi.org/.

    .PARAMETER HolidayType
        Specifies the type of holiday to retrieve. Can be set to either 'PublicHolidays' or 'SchoolHolidays'.

    .PARAMETER Country
        Specifies the two letter ISO code for the country for which to return holiday data.

    .PARAMETER Subdivision
        Specifies the code for the subdivision of a country for which to return holiday data.
        Subdivisions are only available for some country. Call 'Get-OHASubdivision -Country <Country>' to get a list of valid subdivision codes for a specific country.
        Supports tab completion. Limits the available values if a value for the 'Country' parameter was already specified.

    .PARAMETER Language
        Specifies the language in which the holiday names should be displayed. This is either the officially supported languages for a country or English.

    .PARAMETER StartDate
        Specifies the start date for the timeframe for which holidays should be returned.

    .PARAMETER EndDate
        Specifies the end date for the timeframe for which holidays should be returned.

    .PARAMETER TimeFrame
        Allows to specify a timeframe instead of start and end dates.
        Support values are: "ThisYear", "NextYear", "LastYear", "ThisQuarter", "NextQuarter", "LastQuarter", "ThisMonth", "NextMonth", "LastMonth"

    .PARAMETER SaveAsIcal
        If specified, the result will be a string in ICAL format.

    .EXAMPLE
        Get-OHAHoliday

        Returns public holidays for the country and in the language based on the OS language settings.
        Holidays will be queried for the current year by default.

    .EXAMPLE
        Get-OHAHoliday -Country DE

        Returns public holidays for all subdivisions in Germany in the language based on the OS language settings.
        If the language configured on the system (as it is returned by 'Get-Culture') does not match any of the offical languages for the specified country, it will use English instead.
        Holidays will be quried for the current year by default.

    .EXAMPLE
        Get-OHAHoliday -Country DE -Subdivision DE-BW -Language DE -StartDate (Get-Date -Day 1 -Month 1 -Year 2025)

        Returns public holidays for Germany in 2025. Showing holiday names in German language. The result will be limited to the federal state of Baden-Wuerttemberg.

    .EXAMPLE
        Get-OHAHoliday -HolidayType SchoolHoliday -Country AT -Language DE -TimeFrame NextYear

        Returns school holidays for all subdivisions in Austria for the next year.

    .INPUTS
        Nothing

    .OUTPUTS
        PSCustomObject

    .NOTES
        Author:     Dieter Koch
        Email:      diko@admins-little-helper.de

    .LINK
        https://github.com/admins-little-helper/OHA/blob/main/Help/Get-OHAHoliday.txt
    #>

    [OutputType([PSCustomObject])]
    [CmdletBinding(DefaultParameterSetName = "Default")]
    Param (
        [ValidateSet('PublicHolidays', 'SchoolHolidays')]
        [String]
        $HolidayType = 'PublicHolidays',

        [ArgumentCompleter({
                Param (
                    $Command,
                    $Parameter,
                    $WordToComplete,
                    $CommandAst,
                    $FakeBoundParameters
                )

                # Get the session variable content.
                $OHASessionTemp = Get-OHASession

                # Get the list of countries retrieved from the session variable.
                $CountryList = $OHASessionTemp.OHAData.Countries.isoCode

                # Return a list of countries starting with the charaters already typed for the parameter.
                $CountryList.where({ $_ -like "$WordToComplete*" })
            })]
        [String]
        $Country = (Get-Culture).twoletterISOLanguageName.ToUpper(),

        [ArgumentCompleter({
                Param (
                    $Command,
                    $Parameter,
                    $WordToComplete,
                    $CommandAst,
                    $FakeBoundParameters
                )

                # Get the session variable content.
                $OHASessionTemp = Get-OHASession

                # Get the list of subdivisions retrieved from the session variable.
                # In case the 'Country' parameter was already specified, the subdivisions are limited to the specified country.
                # Otherwise subdivisions for all contries are returned for tab completion.
                if ($FakeBoundParameters.ContainsKey('Country')) {
                    $SubdivisionList = ($OHASessionTemp.OHAData.Subdivisions.where({ $_.Country -eq $FakeBoundParameters.Country })).Subdivisions.Code
                }
                else {
                    $SubdivisionList = $OHASessionTemp.OHAData.Subdivisions.Subdivisions.Code.where({ -not [string]::IsNullOrEmpty($_) })
                }

                # Return a list of subdivisions starting with the charaters already typed for the parameter.
                $SubdivisionList.where({ $_ -like "$WordToComplete*" })
            })]
        [String]
        $Subdivision,

        [ArgumentCompleter({
                Param (
                    $Command,
                    $Parameter,
                    $WordToComplete,
                    $CommandAst,
                    $FakeBoundParameters
                )

                # Get the session variable content.
                $OHASessionTemp = Get-OHASession

                # Get the list of langauges retrieved from the session variable.
                # In case the 'Country' parameter was already specified, the languages are limited to the specified country.
                # Otherwise languages for all contries are returned for tab completion.
                if ($FakeBoundParameters.ContainsKey('Country')) {
                    $LanguageList = [array]($OHASessionTemp.OHAData.Countries.where({ $_.isoCode -eq $FakeBoundParameters.Country })).officialLanguages
                }
                else {
                    $LanguageList = [array]$OHASessionTemp.OHAData.Languages.isoCode
                }

                # Add the English language because that is supported by default for all countries, but it's not necessarly returned as supported language for a country by the API.
                $LanguageList += "EN"
                # Return a list of subdivisions starting with the charaters already typed for the parameter.
                $LanguageList.where({ $_ -like "$WordToComplete*" })
            })]
        [String]
        $Language = (Get-Culture).twoletterISOLanguageName.ToUpper(),

        [Parameter(ParameterSetName = "StartEndDate")]
        [DateTime]
        $StartDate = $(Get-Date -Month 1 -Day 1),

        [Parameter(ParameterSetName = "StartEndDate")]
        [DateTime]
        $EndDate = $StartDate.AddMonths(12).AddDays(-1),

        [Parameter(ParameterSetName = "TimeFrame")]
        [ValidateSet("ThisYear", "NextYear", "LastYear", "ThisQuarter", "NextQuarter", "LastQuarter", "ThisMonth", "NextMonth", "LastMonth")]
        [String]
        $TimeFrame,

        [ValidateNotNull()]
        [System.IO.DirectoryInfo]
        $SaveAsIcal,

        [Switch]
        $Raw
    )

    $Params = @{
        Method  = "Get"
        Uri     = $Script:OHASession.ApiBaseUri + "/$HolidayType"
        Body    = @{}
        Headers = @{'accept' = 'text/json' }
    }

    if ($PSBoundParameters.ContainsKey("SaveAsIcal")) {
        # Change the type of data that should be returned.
        $Params.Headers = @{'accept' = 'text/calendar' }
    }

    try {
        Write-Verbose -Message "Setting country to query data for to [$Country]."
        # Append the two letter iso code for the country that was specified by the 'Country' parameter.
        $Params.Uri += "?countryIsoCode=$($Country.ToUpper())"

        # In case a subdivision was specified, add it to the query.
        if ($PSCmdlet.MyInvocation.BoundParameters.Keys.Contains("Subdivision")) {
            Write-Verbose -Message "Setting subdivision to query data for to [$Subdivision]."
            $Params.Uri += "&subdivisionCode=$($Subdivision.ToUpper())"
        }

        Write-Verbose -Message "Setting language to query data for to [$Language]."
        $Params.Uri += "&languageIsoCode=$($Language.ToUpper())"

        if ($PsCmdlet.ParameterSetName -eq "TimeFrame") {
            $DateValue = Get-Date

            switch ($TimeFrame) {
                "ThisYear" {
                    $DateValue = $DateValue.AddYears(0)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month 1 -Day 1 )
                    $EndDate = $StartDate.AddMonths(12).AddDays(-1)
                }
                "LastYear" {
                    $DateValue = $DateValue.AddYears(-1)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month 1 -Day 1 )
                    $EndDate = $StartDate.AddMonths(12).AddDays(-1)
                }
                "NextYear" {
                    $DateValue = $DateValue.AddYears(+1)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month 1 -Day 1 )
                    $EndDate = $StartDate.AddMonths(12).AddDays(-1)
                }
                "ThisQuarter" {
                    # Step 1: Get the current date and add 0 months to it for the target quarter.
                    # Step 2a: [math]::Ceiling($DateValue.Month / 3) --> This will get the number of the target quarter
                    # Step 2b: Multiple the quarter number with 4 to get the month number of the last month in the target quarter
                    # Step 2c: Substract 2 months from to get the month number of the first month in the target quarter
                    $DateValue = $DateValue.AddMonths(0)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month $([math]::Ceiling($DateValue.Month / 3) * 3 - 2) -Day 1 )
                    $EndDate = $StartDate.AddMonths(3).AddDays(-1)
                }
                "LastQuarter" {
                    $DateValue = $DateValue.AddMonths(-3)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month $([math]::Ceiling($DateValue.Month / 3) * 3 - 2) -Day 1 )
                    $EndDate = $StartDate.AddMonths(3).AddDays(-1)
                }
                "NextQuarter" {
                    $DateValue = $DateValue.AddMonths(+3)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month $([math]::Ceiling($DateValue.Month / 3) * 3 - 2) -Day 1 )
                    $EndDate = $StartDate.AddMonths(3).AddDays(-1)
                }
                "ThisMonth" {
                    $DateValue = $DateValue.AddMonths(0)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month $DateValue.Month -Day 1 )
                    $EndDate = $StartDate.AddMonths(1).AddDays(-1)
                }
                "LastMonth" {
                    $DateValue = $DateValue.AddMonths(-1)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month $DateValue.Month -Day 1 )
                    $EndDate = $StartDate.AddMonths(1).AddDays(-1)
                }
                "NextMonth" {
                    $DateValue = $DateValue.AddMonths(+1)
                    $StartDate = $(Get-Date -Year $DateValue.Year -Month $DateValue.Month -Day 1 )
                    $EndDate = $StartDate.AddMonths(1).AddDays(-1)
                }
                default {
                    $StartDate = $(Get-Date -Month 1 -Day 1)
                    $EndDate = $StartDate.AddMonths(12).AddDays(-1)
                }
            }
        }

        Write-Verbose -Message "Setting start date to query data for to [$($StartDate.ToString("yyyy-MM-dd"))]."
        $Params.Uri += "&validFrom=$($StartDate.ToString("yyyy-MM-dd"))"

        Write-Verbose -Message "Setting end date to query data for to [$($EndDate.ToString("yyyy-MM-dd"))]."
        $Params.Uri += "&validTo=$($EndDate.ToString("yyyy-MM-dd"))"

        Write-Verbose -Message "Trying to call URI: $($Params.Uri)"
        # Finally try to get a result by quering the API.
        $Result = Invoke-RestMethod @Params

        if ($PSBoundParameters.ContainsKey("SaveAsIcal")) {
            $OutFileParams = @{
                FilePath = "$SaveAsIcal\OHA_$($Country)_$($HolidayType)_$($StartDate.ToString("yyyy-MM-dd"))_$($EndDate.ToString("yyyy-MM-dd")).ics"
                Encoding = "utf8"
            }
            Write-Verbose -Message "Trying to save data to ICal file [$($OutFileParams.FilePath)]."
            $Result | Out-File @OutFileParams
            Write-Information -MessageData "ICal file saved to [$($OutFileParams.FilePath)]." -InformationAction Continue
        }
        elseif ($Raw.IsPresent) {
            Write-Verbose -Message "Returning data in raw format."
            $Result
        }
        else {
            Write-Verbose -Message "Returning data in custom format."
            $ConvertedResult = foreach ($Item in $Result) {
                $ConvertedItem = [PSCustomObject]@{
                    ID           = $Item.id
                    StartDate    = Get-Date -Date ($Item.startDate)
                    EndDate      = Get-Date -Date ($Item.endDate)
                    Type         = $Item.type
                    Name         = $Item.name.text
                    Nationwide   = $Item.nationwide
                    Subdivisions = $Item.subdivisions.code
                    Comment      = $Item.comment.text
                }
                $ConvertedItem.PSObject.TypeNames.Insert(0, "OHAHoliday$HolidayType")
                $ConvertedItem
            }
            $ConvertedResult
        }
    }
    catch {
        Write-Verbose -Message "An error occured."
        $_
    }
}
