# FDTOOL V2 - Device hardware intelligence (read-only property analysis)
# Platform inference is heuristic and must not be used as firmware compatibility proof.

function Get-FdtoolHardwareProfile {
    [CmdletBinding()]
    param(
        [hashtable]$Properties = @{}
    )

    $keys = @(
        "ro.soc.manufacturer",
        "ro.soc.model",
        "ro.board.platform",
        "ro.hardware",
        "ro.boot.hardware",
        "ro.product.board",
        "ro.build.fingerprint",
        "ro.product.model",
        "ro.product.device"
    )
    $values = @{}
    foreach ($key in $keys) {
        $value = ""
        if ($Properties.ContainsKey($key) -and $null -ne $Properties[$key]) {
            $value = ([string]$Properties[$key]).Trim()
        }
        $values[$key] = $value
    }

    $socManufacturer = $values["ro.soc.manufacturer"]
    $socModel = $values["ro.soc.model"]
    $platform = $values["ro.board.platform"]
    $hardware = $values["ro.hardware"]
    $bootHardware = $values["ro.boot.hardware"]
    $board = $values["ro.product.board"]
    $identity = (@($socManufacturer,$socModel,$platform,$hardware,$bootHardware,$board) -join " ").ToLowerInvariant()

    $vendor = "Unknown"
    $family = "Unknown / not reported"
    $confidence = "Low"
    $matchedBy = @()
    $platformId = if ($platform) { $platform } elseif ($hardware) { $hardware } elseif ($bootHardware) { $bootHardware } else { "Not reported" }

    $rules = @(
        @{ Pattern="qualcomm|qcom|snapdragon|sm[0-9]{3,}|sdm[0-9]+|msm[0-9]+"; Vendor="Qualcomm"; Family="Snapdragon / Qualcomm" },
        @{ Pattern="mediatek|mt[0-9]{3,}|dimensity|helio"; Vendor="MediaTek"; Family="Dimensity / Helio / MediaTek" },
        @{ Pattern="exynos|s5e[0-9]+"; Vendor="Samsung"; Family="Exynos" },
        @{ Pattern="tensor|gs[0-9]+"; Vendor="Google"; Family="Tensor" },
        @{ Pattern="unisoc|spreadtrum|ums[0-9]+|uis[0-9]+"; Vendor="UNISOC"; Family="UNISOC" },
        @{ Pattern="kirin|hisilicon|hi[0-9]{3,}"; Vendor="HiSilicon"; Family="Kirin / HiSilicon" },
        @{ Pattern="broadcom|bcm[0-9]+"; Vendor="Broadcom"; Family="Broadcom" }
    )
    foreach ($rule in $rules) {
        if ($identity -match $rule.Pattern) {
            $vendor = $rule.Vendor
            $family = $rule.Family
            foreach ($key in $keys) {
                if ($values[$key] -and $values[$key] -match $rule.Pattern) { $matchedBy += $key }
            }
            if ($socManufacturer -or $socModel) { $confidence = "Medium" }
            elseif ($platform -or $hardware -or $bootHardware) { $confidence = "Medium" }
            else { $confidence = "Low" }
            break
        }
    }

    if ($socManufacturer -and $socManufacturer -match "qualcomm|mediatek|samsung|google|unisoc|hisilicon|broadcom") {
        $confidence = "High"
    }

    [pscustomobject]@{
        SoCVendor = $vendor
        SoCFamily = $family
        SoCModel = if ($socModel) { $socModel } else { "Not reported" }
        PlatformId = $platformId
        BoardId = if ($board) { $board } else { "Not reported" }
        HardwareId = if ($hardware) { $hardware } else { "Not reported" }
        Confidence = $confidence
        MatchedBy = @($matchedBy)
        Evidence = "Android read-only system properties"
        ExactChipsetVerified = $false
        CompatibilityNote = "Inferred platform family only. Confirm exact SoC, board revision, device variant and firmware source before any maintenance."
    }
}
