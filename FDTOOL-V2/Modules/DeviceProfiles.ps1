# FDTOOL V2 - Manufacturer and device-family identification
# Identification is heuristic and based only on properties exposed by Android/bootloader.

function Get-ManufacturerProfile {
    [CmdletBinding()]
    param(
        [string]$Manufacturer,
        [string]$Brand,
        [string]$Model,
        [string]$Product
    )

    $identity = (@($Manufacturer, $Brand, $Model, $Product) -join " ").ToLowerInvariant()
    $family = "Other / Unknown"
    $brandName = "Unknown"
    if (-not [string]::IsNullOrWhiteSpace($Brand)) { $brandName = $Brand.Trim() }
    elseif (-not [string]::IsNullOrWhiteSpace($Manufacturer)) { $brandName = $Manufacturer.Trim() }
    $notes = "No manufacturer-specific workflow is enabled yet. Use read-only diagnostics and verify the exact model before any maintenance."

    switch -Regex ($identity) {
        "samsung|galaxy|sm-[a-z0-9]" {
            $family = "Samsung"
            $notes = "Samsung device detected. Use official Samsung firmware and drivers for the exact model/region. Odin/Download Mode operations are not part of this diagnostic module."
            break
        }
        "motorola|moto |motorola" {
            $family = "Motorola"
            $notes = "Motorola device detected. Confirm the exact model and software channel before consulting official recovery resources."
            break
        }
        "xiaomi|redmi|poco" {
            $family = "Xiaomi / Redmi / POCO"
            $notes = "Xiaomi-family device detected. Verify the codename, regional variant and bootloader state; do not assume firmware packages are interchangeable."
            break
        }
        "huawei|honor" {
            $family = "Huawei / HONOR"
            $notes = "Huawei/HONOR device detected. Confirm model suffix and region; use manufacturer-supported recovery resources where available."
            break
        }
        "oppo|realme|oneplus" {
            $family = "OPPO / realme / OnePlus"
            $notes = "OPPO-family device detected. Confirm model and region because firmware and service procedures can differ between variants."
            break
        }
        "vivo|iqoo" {
            $family = "vivo / iQOO"
            $notes = "vivo-family device detected. Confirm the exact regional model before using any service or firmware package."
            break
        }
        "google|pixel" {
            $family = "Google Pixel"
            $notes = "Google Pixel detected. Prefer official Google factory images and Android Flash Tool documentation for supported models."
            break
        }
        "sony|xperia" {
            $family = "Sony"
            $notes = "Sony Xperia detected. Confirm the exact model variant and use official Sony support resources."
            break
        }
        "nokia|hmd" {
            $family = "Nokia / HMD"
            $notes = "Nokia/HMD device detected. Confirm product code and region before any recovery procedure."
            break
        }
        "tecno|infinix|itel" {
            $family = "Transsion (TECNO / Infinix / itel)"
            $notes = "Transsion-family device detected. Confirm exact model and board variant; similarly named devices may use different firmware."
            break
        }
        "asus|rog phone" {
            $family = "ASUS"
            $notes = "ASUS device detected. Confirm exact model and region using ASUS support documentation."
            break
        }
        "lenovo|legion" {
            $family = "Lenovo"
            $notes = "Lenovo device detected. Confirm model and region before consulting official firmware or support resources."
            break
        }
        "zte|nubia|redmagic" {
            $family = "ZTE / nubia"
            $notes = "ZTE-family device detected. Confirm exact model and regional variant before maintenance."
            break
        }
        "nothing" {
            $family = "Nothing"
            $notes = "Nothing device detected. Confirm the model and software version using official Nothing support resources."
            break
        }
    }

    if ([string]::IsNullOrWhiteSpace($brandName)) { $brandName = "Unknown" }

    [pscustomobject]@{
        ManufacturerFamily = $family
        Brand = $brandName
        Detection = "Android/bootloader properties (heuristic)"
        SupportNote = $notes
    }
}
