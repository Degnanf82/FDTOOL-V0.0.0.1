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

Write-Host "Preinstalled app safety tests passed." -ForegroundColor Green
