<#PSScriptInfo

.VERSION 1.0.0

.GUID f60df659-76b7-43d5-bfda-a850c9864a27

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


function Get-OHALanguage {
    <#
    .SYNOPSIS
        Returns a list of languages supported by https://www.openholidaysapi.org/.

    .DESCRIPTION
        The 'Get-OHALanguage' function returns a list of languages supported by https://www.openholidaysapi.org/.

    .PARAMETER Raw
        If specified, raw json data is returned as it's delivered from the API.

    .EXAMPLE
        Get-OHALanguage

        Returns a list of all languages supported by the API in a custom table format.

    .EXAMPLE
        Get-OHALanguage -Raw

        Returns a list of all languages supported by the API in a raw json format as it is retrieved from the API.

    .INPUTS
        Nothing

    .OUTPUTS
        Nothing

    .NOTES
        Author:     Dieter Koch
        Email:      diko@admins-little-helper.de

    .LINK
        https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHALanguage.md
    #>

    [CmdletBinding()]
    Param (
        [Switch]
        $Raw
    )

    # Define paramters for retrieving languages from OHA Rest API.
    $Params = @{
        Method  = "Get"
        Uri     = $Script:OHASession.ApiBaseUri + "/Languages"
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
                IsoCode   = $Item.isoCode
                Name      = ($Item.Name.where({ $_.language -eq 'EN' })).text
                LocalName = ($Item.Name.where({ $_.language -eq $Item.isoCode })).text
            }
            $ConvertedItem.PSObject.TypeNames.Insert(0, "OHALanguage")
            $ConvertedItem
        }
        $ConvertedResult
    }
}