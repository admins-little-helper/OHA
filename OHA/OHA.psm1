<#PSScriptInfo

.VERSION 1.0.0

.GUID 6ef86758-7612-4224-9fa4-0876470b960c

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
This is the root module file.

.LINK
https://github.com/admins-little-helper/OHA

.LINK
https://www.openholidaysapi.org/

#>


# Adding Module variable, aka Pseudo-Namespace
# More information can be found here: https://thedavecarroll.com/powershell/how-i-implement-module-variables/
$OHASession = [ordered]@{
    ApiBaseUri = "https://openholidaysapi.org/"
    OHAData    = [ordered]@{
        LastUpdate   = $null
        Countries    = @{}
        Languages    = @{}
        Subdivisions = @{}
    }
}
New-Variable -Name OHASession -Value $OHASession -Scope Script -Force

# Get public and private function definition files.
$PublicScripts = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$PrivateScripts = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

# Dot source the files in public and private subfolders.
foreach ($ScriptToImport in @($PrivateScripts + $PublicScripts)) {
    try {
        Write-Verbose -Message "Importing script $($ScriptToImport.FullName)"
        . $ScriptToImport.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($ScriptToImport.FullName): $_"
    }
}

Export-ModuleMember -Function $PublicScripts.Basename -Alias *

# Call the function that initializes the session variable. This is required to have tab completion working properly.
Initialize-OHASession
