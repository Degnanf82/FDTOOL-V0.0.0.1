# Lightweight tests for DeviceProfiles.ps1 (no Pester dependency required)
[CmdletBinding()]
param()

$modulePath = Join-Path (Split-Path -Parent $PSScriptRoot) "Modules\DeviceProfiles.ps1"
. $modulePath

$cases = @(
    @{ Name = "Samsung Galaxy"; Manufacturer = "samsung"; Brand = "samsung"; Model = "SM-S928B"; Expected = "Samsung" },
    @{ Name = "Motorola"; Manufacturer = "motorola"; Brand = "motorola"; Model = "XT-xxxx"; Expected = "Motorola" },
    @{ Name = "Xiaomi Redmi"; Manufacturer = "Xiaomi"; Brand = "Redmi"; Model = "Note"; Expected = "Xiaomi / Redmi / POCO" },
    @{ Name = "Google Pixel"; Manufacturer = "Google"; Brand = "google"; Model = "Pixel"; Expected = "Google Pixel" },
    @{ Name = "Unknown"; Manufacturer = ""; Brand = ""; Model = ""; Expected = "Other / Unknown" }
)

$failures = @()
foreach ($case in $cases) {
    $actual = Get-ManufacturerProfile -Manufacturer $case.Manufacturer -Brand $case.Brand -Model $case.Model
    if ($actual.ManufacturerFamily -ne $case.Expected) {
        $failures += "$($case.Name): expected '$($case.Expected)', got '$($actual.ManufacturerFamily)'"
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "All manufacturer profile tests passed ($($cases.Count) cases)." -ForegroundColor Green
