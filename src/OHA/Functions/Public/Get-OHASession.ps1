<#PSScriptInfo

.VERSION 1.0.0

.GUID ac70d001-aba7-45cd-a319-486c6e22d4bf

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


function Get-OHASession {
    <#
    .SYNOPSIS
        Returns the session variable hashtable.

    .DESCRIPTION
        The 'Get-OHASession' function returns the session variable hashtable.

    .EXAMPLE
        Get-OHASession

        Returns the session variable hashtable.

    .INPUTS
        Nothing

    .OUTPUTS
        Nothing

    .NOTES
        Author:     Dieter Koch
        Email:      diko@admins-little-helper.de

    .LINK
        https://github.com/admins-little-helper/OHA/blob/main/docs/Get-OHASession.md
    #>

    return $Script:OHASession
}