# Lightweight safety tests for PreinstalledApps.ps1
[CmdletBinding()]
param()

$modulePath = Join-Path (Split-Path -Parent $PSScriptRoot) "Modules\PreinstalledApps.ps1"
. $modulePath

$friendlyCases = @{
    "com.samsung.android.app.notes" = "Samsung Notes"
    "com.google.android.apps.photos" = "Google Photos"
    "com.motorola.help" = "Moto Help"
}
foreach ($package in $friendlyCases.Keys) {
    $actual = Get-AppFriendlyName -PackageName $package
    if ($actual -ne $friendlyCases[$package]) {
        throw "Friendly-name mismatch for $package. Expected $($friendlyCases[$package]), got $actual"
    }
}

$protected = @(
    "android",
    "com.android.systemui",
    "com.android.settings",
    "com.google.android.gms",
    "com.android.providers.telephony"
)
foreach ($name in $protected) {
    if (-not (Test-ProtectedPackage -PackageName $name)) {
        throw "Expected protected package: $name"
    }
}

$allowed = @(
    "com.samsung.android.app.notes",
    "com.google.android.apps.photos",
    "com.motorola.help"
)
foreach ($name in $allowed) {
    if (Test-ProtectedPackage -PackageName $name) {
        throw "Unexpected protected package: $name"
    }
    if (-not (Test-SafePackageName -PackageName $name)) {
        throw "Expected valid package name: $name"
    }
}

$invalid = @("", "com", "com..broken", "contains spaces", "com/unsafe")
foreach ($name in $invalid) {
    if (Test-SafePackageName -PackageName $name) {
        throw "Unexpected valid package name: '$name'"
    }
}


$recommendationCases = @(
    @{ Package = "com.samsung.android.app.notes"; Family = "Samsung"; Expected = "Opcional - revisar" },
    @{ Package = "com.motorola.help"; Family = "Motorola"; Expected = "Opcional - revisar" },
    @{ Package = "com.xiaomi.mipicks"; Family = "Xiaomi / Redmi / POCO"; Expected = "Opcional - revisar" },
    @{ Package = "com.android.systemui"; Family = "Samsung"; Expected = "Protegida" },
    @{ Package = "com.samsung.unknown.service"; Family = "Samsung"; Expected = "No evaluada - conservar" },
    @{ Package = "com.samsung.android.app.notes"; Family = "Motorola"; Expected = "No evaluada - conservar" }
)
foreach ($case in $recommendationCases) {
    $actual = Get-AppCleanupRecommendation -PackageName $case.Package -ManufacturerFamily $case.Family
    if ($actual.Status -ne $case.Expected) {
        throw "Cleanup recommendation mismatch for $($case.Package) / $($case.Family): expected $($case.Expected), got $($actual.Status)"
    }
}


$inventoryLines = @(
    "package:/system/priv-app/Settings/Settings.apk=com.android.settings",
    "package:/data/app/~~random/base.apk=com.samsung.android.app.notes",
    "package:com.google.android.apps.photos",
    "  not-a-package-line"
)
$inventory = @(ConvertFrom-AdbPackageInventory -PackageLines $inventoryLines -SystemPackages @("com.android.settings") -ThirdPartyPackages @("com.samsung.android.app.notes", "com.google.android.apps.photos") -ManufacturerFamily "Samsung")
if ($inventory.Count -ne 3) { throw "Expected 3 parsed inventory packages, got $($inventory.Count)" }
$settings = $inventory | Where-Object PackageName -eq "com.android.settings"
if ($settings.Type -ne "Sistema" -or $settings.ApkPath -notmatch "/system/") { throw "System package parsing/classification failed." }
$notes = $inventory | Where-Object PackageName -eq "com.samsung.android.app.notes"
if ($notes.Type -ne "Usuario" -or $notes.AppName -ne "Samsung Notes") { throw "Third-party package parsing/classification failed." }
$photos = $inventory | Where-Object PackageName -eq "com.google.android.apps.photos"
if ($photos.Type -ne "Usuario") { throw "Package line without APK path should still parse and classify." }

Write-Host "Preinstalled app safety tests passed." -ForegroundColor Green
