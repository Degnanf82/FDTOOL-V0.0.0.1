# FDTOOL V2 - Manufacturer and device-family identification
# Heuristic only: never treat family identification as model/firmware compatibility.

function Get-ManufacturerProfile {
    [CmdletBinding()]
    param(
        [string]$Manufacturer,
        [string]$Brand,
        [string]$Model,
        [string]$Product,
        [string]$Device,
        [string]$AndroidVersion,
        [string]$SDK,
        [string]$BuildFingerprint
    )

    $signals = @(
        @{ Value=$Manufacturer; Field="manufacturer" },
        @{ Value=$Brand; Field="brand" },
        @{ Value=$Model; Field="model" },
        @{ Value=$Product; Field="product" },
        @{ Value=$Device; Field="device" },
        @{ Value=$BuildFingerprint; Field="buildFingerprint" }
    ) | Where-Object { -not [string]::IsNullOrWhiteSpace($_.Value) }
    $identity = (($signals | ForEach-Object { $_.Value }) -join " ").ToLowerInvariant()
    $family = "Other / Unknown"
    $matchedBy = @()
    $brandName = "Unknown"
    if (-not [string]::IsNullOrWhiteSpace($Brand)) { $brandName = $Brand.Trim() }
    elseif (-not [string]::IsNullOrWhiteSpace($Manufacturer)) { $brandName = $Manufacturer.Trim() }

    $rules = @(
        @{ Pattern="samsung|galaxy|sm-[a-z0-9]"; Family="Samsung" },
        @{ Pattern="motorola|moto"; Family="Motorola" },
        @{ Pattern="xiaomi|redmi|poco"; Family="Xiaomi / Redmi / POCO" },
        @{ Pattern="huawei|honor"; Family="Huawei / HONOR" },
        @{ Pattern="oppo|realme|oneplus"; Family="OPPO / realme / OnePlus" },
        @{ Pattern="vivo|iqoo"; Family="vivo / iQOO" },
        @{ Pattern="google|pixel"; Family="Google Pixel" },
        @{ Pattern="sony|xperia"; Family="Sony" },
        @{ Pattern="nokia|hmd"; Family="Nokia / HMD" },
        @{ Pattern="tecno|infinix|itel"; Family="Transsion (TECNO / Infinix / itel)" },
        @{ Pattern="asus|rog phone"; Family="ASUS" },
        @{ Pattern="lenovo|legion"; Family="Lenovo" },
        @{ Pattern="zte|nubia|redmagic"; Family="ZTE / nubia" },
        @{ Pattern="nothing"; Family="Nothing" }
    )
    foreach ($rule in $rules) {
        if ($identity -match $rule.Pattern) {
            $family = $rule.Family
            $matchedBy = @($signals | Where-Object { $_.Value -match $rule.Pattern } | ForEach-Object { $_.Field })
            break
        }
    }

    $confidence = "Low"
    if ($matchedBy.Count -gt 0) {
        if (($matchedBy -contains "manufacturer") -or ($matchedBy -contains "brand")) { $confidence = "High" }
        else { $confidence = "Medium" }
    }
    $supportNote = "No manufacturer-specific workflow is enabled. Verify exact model, variant and region before maintenance."
    switch ($family) {
        "Samsung" { $supportNote = "Samsung family identified. Verify exact SM model, CSC/region and firmware before consulting official Samsung resources." }
        "Motorola" { $supportNote = "Motorola family identified. Verify exact XT model and software channel before maintenance." }
        "Xiaomi / Redmi / POCO" { $supportNote = "Xiaomi family identified. Verify exact model, codename, region and bootloader state; firmware is not interchangeable by family." }
        "Huawei / HONOR" { $supportNote = "Huawei/HONOR family identified. Verify model suffix and region; use supported recovery resources." }
        "OPPO / realme / OnePlus" { $supportNote = "OPPO family identified. Verify exact model and region; do not infer cross-brand firmware compatibility." }
        "vivo / iQOO" { $supportNote = "vivo family identified. Verify exact regional model before service." }
        "Google Pixel" { $supportNote = "Google Pixel family identified. Verify the exact device codename and build before using official Google images or tools." }
        "Sony" { $supportNote = "Sony family identified. Verify Xperia model variant and region." }
        "Nokia / HMD" { $supportNote = "Nokia/HMD family identified. Verify product code and region." }
        "Transsion (TECNO / Infinix / itel)" { $supportNote = "Transsion family identified. Verify exact model and board variant." }
        "ASUS" { $supportNote = "ASUS family identified. Verify exact model and region." }
        "Lenovo" { $supportNote = "Lenovo family identified. Verify exact model and region." }
        "ZTE / nubia" { $supportNote = "ZTE family identified. Verify exact model and regional variant." }
        "Nothing" { $supportNote = "Nothing family identified. Verify exact model and software version." }
    }

    [pscustomobject]@{
        ManufacturerFamily = $family
        Brand = $brandName
        Model = if ($Model) { $Model.Trim() } else { "Unknown" }
        DeviceCodename = if ($Device) { $Device.Trim() } else { "Unknown" }
        AndroidVersion = if ($AndroidVersion) { $AndroidVersion.Trim() } else { "Unknown" }
        SDK = if ($SDK) { $SDK.Trim() } else { "Unknown" }
        BuildFingerprint = if ($BuildFingerprint) { $BuildFingerprint.Trim() } else { "Unknown" }
        Confidence = $confidence
        MatchedBy = @($matchedBy)
        Detection = "Android/bootloader properties (heuristic)"
        SupportNote = $supportNote
        ExactModelVerified = $false
    }
}
