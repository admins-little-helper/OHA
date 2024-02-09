<#PSScriptInfo

.VERSION 1.0.0

.GUID 45ca29e8-d882-4829-9e6f-ae439a1895f4

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


function Initialize-OHASession {
    <#
    .SYNOPSIS
        Initializes the module session variable that is used to store some data for all functions in the module.

    .DESCRIPTION
        The 'Initialize-OHASession' function initializes the module session variable that is used to store some data for all functions in the module.
        This function is actually only used within the module and therefore could be made private. However, it has to be exported to the global
        scope in order have the session variable available in all functions.

    .PARAMETER Force
        If specified, data stored in the session variable is updated, no matter if the validity time period has expired.

    .EXAMPLE
        Initialize-OHASession -Force

        Update the data stored in the session variable.

    .INPUTS
        Nothing

    .OUTPUTS
        Nothing

    .NOTES
        Author:     Dieter Koch
        Email:      diko@admins-little-helper.de

    .LINK
        https://github.com/admins-little-helper/OHA/blob/main/Help/Initialize-OHASession.txt
    #>

    Param(
        [Switch]
        $Force
    )

    try {
        # Make sure the script stops on all errors by default.
        $ErrorActionPreference = "Stop"
        # Make sure that 'Write-Information' will always show the MessageData on the screen without specifying it on each function call.
        $InformationPreference = "Continue"

        # Define the maximum age for session data in minutes.
        $OHADataMaxAgeMinutes = 5

        if ($Force.IsPresent) {
            # Only initilize the session variable if the 'Force' parameter was specifid.

            # Store some data in the session variable that's reused in multiple module functions.
            # It's also used to buffer some data retrieved from the API for handling dynamic parameters.

            # Define the API's base URI.
            $Script:OHASession.ApiBaseUri = "https://openholidaysapi.org"

            # Store the timestamp of data update.
            $Script:OHASession.OHAData.LastUpdate = Get-Date

            # Retrieve the list of countries.
            $Script:OHASession.OHAData.Countries = Get-OHACountry -Raw

            # Retrieve the list of languages.
            $Script:OHASession.OHAData.Languages = Get-OHALanguage -Raw

            # Retrieve the list of subdivisions for all countries.
            $Script:OHASession.OHAData.Subdivisions = foreach ($Country in $Script:OHASession.OHAData.Countries) {
                [PSCustomObject]@{
                    Country      = $Country.isoCode
                    SubDivisions = Get-OHASubDivision -Country $Country.isoCode -Raw
                }
            }
        }
        else {
            # If the 'Force' parameter was not specified, check if the session variable already was initialized.
            if ($null -eq $Script:OHASession.OHAData.LastUpdate) {
                Write-Verbose -Message "OHASession has no data yet."
                # Force initialization.
                Initialize-OHASession -Force
            }
            elseif ($null -eq $Script:OHASession.OHAData.Countries) {
                Write-Verbose -Message "OHASession has no country data yet."
                # Force initialization.
                Initialize-OHASession -Force
            }
            elseif ($null -eq $Script:OHASession.OHAData.Languages) {
                Write-Verbose -Message "OHASession has no language data yet."
                # Force initialization.
                Initialize-OHASession -Force
            }
            elseif ($null -eq $Script:OHASession.OHAData.Subdivisions) {
                Write-Verbose -Message "OHASession has no subdivision data yet."
                # Force initialization.
                Initialize-OHASession -Force
            }
            elseif ((((Get-Date) - $Script:OHASession.OHAData.LastUpdate).TotalMinutes) -gt $OHADataMaxAgeMinutes) {
                Write-Verbose -Message "OHASession data is outdated (older than $OHADataMaxAgeMinutes minutes). Retrieving updated data."
                # Re-new data by forcing initialization.
                Initialize-OHASession -Force
            }
            else {
                # Do nothing.
                Write-Verbose -Message "OHASessions was initialized and data is still within validity period."
            }
        }
    }
    catch {
        $_
    }
}
