# FDTOOL V2 - Service Engine capability tests
[CmdletBinding()]
param()
$root = Split-Path -Parent $PSScriptRoot
. (Join-Path $root "Modules\ServiceEngine.ps1")

$profile = [pscustomobject]@{ ManufacturerFamily="Samsung"; Model="SM-A546B"; Confidence="High" }
$adb = @(Get-FdtoolServiceCapabilities -DeviceProfile $profile -ConnectionMode ADB -AdbAuthorized $true -FastbootAvailable $true -ServiceCatalogAvailable $true)
if ($adb.Count -ne 7) { throw "Expected seven capability records for authorized ADB, got $($adb.Count)." }
if (($adb | Where-Object Id -eq "android.diagnostics").Status -ne "available") { throw "Authorized ADB diagnostics should be available." }
if (($adb | Where-Object Id -eq "android.user-app-management").Risk -ne "moderate") { throw "App management must be marked moderate risk." }
if (($adb | Where-Object Id -eq "oem.advanced-service").Status -ne "planned") { throw "Unimplemented OEM operations must remain planned." }
if (($adb | Where-Object Id -eq "oem.advanced-service").ExecutionImplemented) { throw "Planned OEM operation must not be executable." }

$unauthorized = @(Get-FdtoolServiceCapabilities -DeviceProfile $profile -ConnectionMode ADB -AdbAuthorized $false)
if (($unauthorized | Where-Object Id -eq "android.diagnostics").Status -ne "requires-authorization") { throw "Unauthorized ADB must require authorization." }

$fastboot = @(Get-FdtoolServiceCapabilities -DeviceProfile $profile -ConnectionMode Fastboot -FastbootAvailable $true)
if (($fastboot | Where-Object Id -eq "bootloader.identification").Status -ne "available") { throw "Fastboot identification should be available in Fastboot mode." }
if (($fastboot | Where-Object Id -eq "android.diagnostics").Status -ne "requires-adb") { throw "Android diagnostics must require ADB when in Fastboot mode." }

Write-Host "All Service Engine tests passed." -ForegroundColor Green
