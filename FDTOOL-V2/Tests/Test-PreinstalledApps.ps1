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

Write-Host "Preinstalled app safety tests passed." -ForegroundColor Green
