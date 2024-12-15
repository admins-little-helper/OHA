---
external help file: OHA-help.xml
Module Name: OHA
online version: https://github.com/admins-little-helper/OHA/blob/main/docs/Initialize-OHASession.md
schema: 2.0.0
---

# Initialize-OHASession

## SYNOPSIS

Initializes the module session variable that is used to store some data for all functions in the module.

## SYNTAX

```PowerShell
Initialize-OHASession [-Force]
```

## DESCRIPTION

The 'Initialize-OHASession' function initializes the module session variable that is used to store some data for all functions in the module.
This function is actually only used within the module and therefore could be made private.
However, it has to be exported to the global
scope in order have the session variable available in all functions.

## EXAMPLES

### EXAMPLE 1

```PowerShell
Initialize-OHASession -Force
```

Update the data stored in the session variable.

## PARAMETERS

### -Force

If specified, data stored in the session variable is updated, no matter if the validity time period has expired.

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

## INPUTS

### Nothing

## OUTPUTS

### Nothing

## NOTES

Author:     Dieter Koch
Email:      <diko@admins-little-helper.de>

## RELATED LINKS

[https://github.com/admins-little-helper/OHA/blob/main/docs/Initialize-OHASession.md](https://github.com/admins-little-helper/OHA/blob/main/docs/Initialize-OHASession.md)
