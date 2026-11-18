# Lightweight tests for DeviceProfiles.ps1 (no Pester dependency required)
[CmdletBinding()]
param()
$modulePath = Join-Path (Split-Path -Parent $PSScriptRoot) "Modules\DeviceProfiles.ps1"
. $modulePath
$cases = @(
    @{ Name="Samsung Galaxy"; Manufacturer="samsung"; Brand="samsung"; Model="SM-S928B"; Expected="Samsung"; Confidence="High" },
    @{ Name="Motorola"; Manufacturer="motorola"; Brand="motorola"; Model="XT-xxxx"; Expected="Motorola"; Confidence="High" },
    @{ Name="Xiaomi Redmi"; Manufacturer="Xiaomi"; Brand="Redmi"; Model="Note"; Expected="Xiaomi / Redmi / POCO"; Confidence="High" },
    @{ Name="Google Pixel"; Manufacturer="Google"; Brand="google"; Model="Pixel"; Expected="Google Pixel"; Confidence="High" },
    @{ Name="Huawei"; Manufacturer="HUAWEI"; Brand="HUAWEI"; Model="P"; Expected="Huawei / HONOR"; Confidence="High" },
    @{ Name="OPPO"; Manufacturer="OPPO"; Brand="OPPO"; Model="CPH"; Expected="OPPO / realme / OnePlus"; Confidence="High" },
    @{ Name="vivo"; Manufacturer="vivo"; Brand="vivo"; Model="V"; Expected="vivo / iQOO"; Confidence="High" },
    @{ Name="Unknown"; Manufacturer=""; Brand=""; Model=""; Expected="Other / Unknown"; Confidence="Low" }
)
$failures = @()
foreach ($case in $cases) {
    $actual = Get-ManufacturerProfile -Manufacturer $case.Manufacturer -Brand $case.Brand -Model $case.Model
    if ($actual.ManufacturerFamily -ne $case.Expected) { $failures += "$($case.Name): expected '$($case.Expected)', got '$($actual.ManufacturerFamily)'" }
    if ($actual.Confidence -ne $case.Confidence) { $failures += "$($case.Name): expected confidence '$($case.Confidence)', got '$($actual.Confidence)'" }
}
$codename = Get-ManufacturerProfile -Manufacturer "Google" -Brand "google" -Model "Pixel 8" -Device "shiba" -AndroidVersion "14" -SDK "34"
if ($codename.DeviceCodename -ne "shiba" -or $codename.SDK -ne "34") { $failures += "Codename/SDK fields were not retained." }
if ($failures.Count -gt 0) { $failures | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host "All manufacturer profile tests passed ($($cases.Count) cases plus metadata)." -ForegroundColor Green
