<#PSScriptInfo

.VERSION 1.0.0

.GUID d9cbe6ef-91d1-4bb2-8fd1-2cae12f5d221

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


function Get-OHACountry {
    <#
    .SYNOPSIS
        Returns a list of countries for which holiday information can be queried from https://www.openholidaysapi.org/.

    .DESCRIPTION
        The 'Get-OHACountry' function returns a list of countries for which holiday information can be queried from https://www.openholidaysapi.org/.

    .PARAMETER Raw
        If specified, raw json data is returned as it's delivered from the API.

    .EXAMPLE
        Get-OHACountry

        Returns a list of all countries supported by the API in a custom table format.

    .EXAMPLE
        Get-OHACountry -Raw

        Returns a list of all countries supported by the API in a raw json format as it is retrieved from the API.

    .INPUTS
        Nothing

    .OUTPUTS
        Nothing

    .NOTES
        Author:     Dieter Koch
        Email:      diko@admins-little-helper.de

    .LINK
        https://github.com/admins-little-helper/OHA/blob/main/Help/Get-OHACountry.txt
    #>

    [CmdletBinding()]
    Param (
        [Switch]
        $Raw
    )

    # Define paramters for retrieving countries from OHA Rest API.
    $Params = @{
        Method  = "Get"
        Uri     = $Script:OHASession.ApiBaseUri + "/Countries"
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
                IsoCode           = $Item.isoCode
                Name              = ($Item.Name.where({ $_.language -eq 'EN' })).text
                LocalName         = ($Item.Name.where({ $_.language -eq $Item.officialLanguages[0] })).text
                OfficialLanguages = $Item.officialLanguages
            }
            $ConvertedItem.PSObject.TypeNames.Insert(0, "OHACountry")
            $ConvertedItem
        }
        $ConvertedResult
    }
}