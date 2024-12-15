<#PSScriptInfo

.VERSION 1.0.0

.GUID 7073c093-c8e5-4916-9130-dba4d9c08791

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


function Get-OHASubdivision {
    <#
    .SYNOPSIS
        Returns a list of subdivisions for a given country for which holiday information can be queried from https://www.openholidaysapi.org/.

    .DESCRIPTION
        The 'Get-OHASubdivision' function returns a list of subdivisions for a given country for which holiday information can be queried from https://www.openholidaysapi.org/.

    .PARAMETER Raw
        If specified, raw json data is returned as it's delivered from the API.

    .EXAMPLE
        Get-OHASubdivision -Country DE

        Returns a list of all subdivisions for Germany that are supported by the API in a custom table format.

    .EXAMPLE
        Get-OHASubdivision -Country AT -Raw

        Returns a list of all subdivisions for Austria that are supported by the API in a raw json format as it is retrieved from the API.

    .INPUTS
        Nothing

    .OUTPUTS
        Nothing

    .NOTES
        Author:     Dieter Koch
        Email:      diko@admins-little-helper.de

    .LINK
        https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHASubdivision.md
    #>

    [CmdletBinding()]
    Param (
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

        [Switch]
        $Raw
    )

    # Define paramters for retrieving subdivisions from OHA Rest API.
    $Params = @{
        Method  = "Get"
        Uri     = $Script:OHASession.ApiBaseUri + "/Subdivisions?countryIsoCode=$($Country.ToUpper())"
        Body    = @{}
        Headers = @{'accept' = 'text/json' }
    }

    # Try to download.
    $Result = Invoke-RestMethod @Params

    # Either present the raw data result, or return it in a customized format.
    if ($Raw.IsPresent) {
        Write-Verbose -Message "Returning data in raw format."
        $Result
    }
    else {
        Write-Verbose -Message "Returning data in custom format."
        $ConvertedResult = foreach ($Item in $Result) {
            $ConvertedItem = [PSCustomObject]@{
                Code              = $Item.Code
                IsoCode           = $Item.isoCode
                ShortName         = $Item.shortName
                Category          = $Item.Category
                Name              = ($Item.Name.where({ $_.language -eq 'EN' })).text
                LocalName         = ($Item.Name.where({ $_.language -eq $Item.officialLanguages[0] })).text
                OfficialLanguages = $Item.officialLanguages
                # Children          = Get-OHASubdivision
            }
            $ConvertedItem.PSObject.TypeNames.Insert(0, "OHASubdivision")
            $ConvertedItem
        }
        $ConvertedResult
    }
}