# FDTOOL V2 - Device hardware intelligence tests
[CmdletBinding()]
param()
$root = Split-Path -Parent $PSScriptRoot
. (Join-Path $root "Modules\DeviceIntelligence.ps1")

$cases = @(
    @{ Name="Qualcomm"; Properties=@{"ro.soc.manufacturer"="Qualcomm";"ro.soc.model"="SM8550";"ro.board.platform"="kalama"}; Vendor="Qualcomm"; Family="Snapdragon / Qualcomm" },
    @{ Name="MediaTek"; Properties=@{"ro.board.platform"="mt6985";"ro.hardware"="mt6985"}; Vendor="MediaTek"; Family="Dimensity / Helio / MediaTek" },
    @{ Name="Exynos"; Properties=@{"ro.board.platform"="s5e9925"}; Vendor="Samsung"; Family="Exynos" },
    @{ Name="Tensor"; Properties=@{"ro.soc.model"="Tensor G3";"ro.hardware"="tensor"}; Vendor="Google"; Family="Tensor" },
    @{ Name="UNISOC"; Properties=@{"ro.board.platform"="ums9230"}; Vendor="UNISOC"; Family="UNISOC" },
    @{ Name="Kirin"; Properties=@{"ro.hardware"="kirin9000"}; Vendor="HiSilicon"; Family="Kirin / HiSilicon" }
)
foreach ($case in $cases) {
    $profile = Get-FdtoolHardwareProfile -Properties $case.Properties
    if ($profile.SoCVendor -ne $case.Vendor) { throw "$($case.Name): expected vendor $($case.Vendor), got $($profile.SoCVendor)." }
    if ($profile.SoCFamily -ne $case.Family) { throw "$($case.Name): family mismatch." }
    if ($profile.ExactChipsetVerified) { throw "$($case.Name): heuristic profile must not claim exact chipset verification." }
}
$unknown = Get-FdtoolHardwareProfile -Properties @{}
if ($unknown.SoCVendor -ne "Unknown") { throw "Empty properties must not invent a chipset vendor." }
if ($unknown.Confidence -ne "Low") { throw "Unknown hardware confidence must be Low." }
Write-Host "All Device Intelligence tests passed." -ForegroundColor Green
