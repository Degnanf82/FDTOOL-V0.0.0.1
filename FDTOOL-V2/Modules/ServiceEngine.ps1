# FDTOOL V2 - Central service capability engine
# Reports what is genuinely available for the detected connection and profile.
# This module describes capabilities; it never executes service operations.

function Get-FdtoolServiceCapabilities {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]$DeviceProfile,
        [ValidateSet("ADB","Fastboot","None")][string]$ConnectionMode = "None",
        [bool]$AdbAuthorized = $false,
        [bool]$FastbootAvailable = $false,
        [bool]$ServiceCatalogAvailable = $false
    )

    $capabilities = @()
    $family = [string]$DeviceProfile.ManufacturerFamily
    if ([string]::IsNullOrWhiteSpace($family)) { $family = "Other / Unknown" }

    $capabilities += [pscustomobject]@{
        Id="device.identification"; Name="Device identification"; Category="Core"
        Status="available"; Risk="read-only"; ExecutionImplemented=$true
        Reason="Profile data is available. Family detection is heuristic; exact model and region remain unverified."
    }

    if ($ConnectionMode -eq "ADB" -and $AdbAuthorized) {
        $capabilities += [pscustomobject]@{
            Id="android.diagnostics"; Name="Android diagnostics"; Category="Android"
            Status="available"; Risk="read-only"; ExecutionImplemented=$true
            Reason="Authorized ADB connection supports property and device-state inspection."
        }
        $capabilities += [pscustomobject]@{
            Id="android.app-inventory"; Name="Application inventory"; Category="Android"
            Status="available"; Risk="read-only"; ExecutionImplemented=$true
            Reason="Package inventory can be read and exported without accessing application data."
        }
        $capabilities += [pscustomobject]@{
            Id="android.user-app-management"; Name="User-level preinstalled app management"; Category="Android"
            Status="available-with-confirmation"; Risk="moderate"; ExecutionImplemented=$true
            Reason="Existing manager supports user-0 uninstall/restore requests. Review package safety and confirm each package."
        }
    }
    else {
        $status = if ($ConnectionMode -eq "ADB") { "requires-authorization" } else { "requires-adb" }
        $capabilities += [pscustomobject]@{
            Id="android.diagnostics"; Name="Android diagnostics"; Category="Android"
            Status=$status; Risk="read-only"; ExecutionImplemented=$false
            Reason="Connect in ADB mode and authorize USB debugging on the device."
        }
    }

    if ($ConnectionMode -eq "Fastboot" -and $FastbootAvailable) {
        $capabilities += [pscustomobject]@{
            Id="bootloader.identification"; Name="Bootloader identification"; Category="Bootloader"
            Status="available"; Risk="read-only"; ExecutionImplemented=$true
            Reason="Only values exposed by the bootloader are queried; no flashing or unlock operation is performed."
        }
    }
    else {
        $capabilities += [pscustomobject]@{
            Id="bootloader.identification"; Name="Bootloader identification"; Category="Bootloader"
            Status="requires-fastboot"; Risk="read-only"; ExecutionImplemented=$false
            Reason="Connect a supported device in Fastboot mode to inspect exposed product information."
        }
    }

    $capabilities += [pscustomobject]@{
        Id="service.procedure-catalog"; Name="Compatible service procedures"; Category="Service"
        Status=$(if ($ServiceCatalogAvailable) { "available" } else { "catalog-unavailable" })
        Risk="informational"; ExecutionImplemented=$false
        Reason=$(if ($ServiceCatalogAvailable) { "Catalog matching is available. Procedures are displayed as information and are not executed." } else { "The local service procedure catalog could not be found." })
    }

    $capabilities += [pscustomobject]@{
        Id="oem.advanced-service"; Name=("$family advanced service"); Category="Manufacturer"
        Status="planned"; Risk="not-enabled"; ExecutionImplemented=$false
        Reason="No verified manufacturer-specific operation is enabled for this profile yet. Exact model, variant, region and source validation are required."
    }

    return @($capabilities)
}
