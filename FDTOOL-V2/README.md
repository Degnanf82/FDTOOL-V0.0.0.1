# FDTOOL V2 – Mobile Device Diagnostics

A new, isolated modernization track for the original FDTOOL project. The legacy version remains unchanged on `main`.

## Current status

The first V2 module is a **read-only diagnostic launcher** for Windows 10/11. It can:

- Locate ADB and Fastboot from the bundled `tools/platform-tools` folder or the system PATH.
- List devices connected in ADB and Fastboot modes.
- Identify ADB authorization and offline states.
- Read basic Android properties from an authorized ADB device: manufacturer, brand, model, device codename, Android release and SDK level.
- Query the product identifier from Fastboot where the bootloader supports it.
- Export a JSON diagnostic report containing Windows/tool versions and connected device details. Serial numbers are masked automatically.

## Manufacturer identification

FDTOOL uses Android properties (`manufacturer`, `brand`, `model`, `device`, and `product`) and the Fastboot product string to classify common device families, including Samsung, Motorola, Xiaomi/Redmi/POCO, Huawei/HONOR, OPPO/realme/OnePlus, vivo/iQOO, Google Pixel, Sony, Nokia/HMD, TECNO/Infinix/itel, ASUS, Lenovo, ZTE/nubia and Nothing. This is a best-effort identification, not a definitive model/firmware compatibility check.

Run the lightweight profile tests with:

```powershell
powershell.exe -NoProfile -File .\Tests\\Test-DeviceProfiles.ps1
```

## Preinstalled applications (no root)

The app manager lists Android system packages over an authorized ADB connection. It can request an uninstall for the current Android user (user 0) with `pm uninstall --user 0 PACKAGE`, and request restoration with `cmd package install-existing --user 0 PACKAGE` (with a Package Manager fallback).

Important limitations and safeguards:

- This does **not** remove the APK from the read-only system image or free the full system-partition space.
- ADB USB debugging must be enabled and authorized on the phone.
- The package list shows a friendly name when FDTOOL has a verified local mapping, alongside the exact technical package ID. Unknown names remain explicitly marked as unmapped; FDTOOL does not guess the app name.\n- The user must select one package and type its full package name to confirm each uninstall.
- Samsung, Motorola and Xiaomi-family packages receive conservative review hints: `Opcional - revisar`, `Protegida`, or `No evaluada - conservar`. These are not universal safety guarantees; unknown packages default to keeping them.
- FDTOOL blocks a list of core Android/Google packages and critical provider/system services, and detects/protects the active home launcher when Android reports it.
- OEM-specific dependencies may still exist. Removing a non-blocked package can break features; review the package name before proceeding.
- Restoration only works if the package remains available in the device's system image.
- No batch uninstall, root, bootloader unlock, FRP bypass or system-partition modification is provided.

The local name catalog currently covers common Samsung, Google, Motorola, Xiaomi, OPPO/OnePlus and popular third-party packages. Cleanup hints currently cover a small, conservative subset of Samsung, Motorola and Xiaomi-family packages. It is intentionally conservative; names can vary by region, Android version and OEM build.\n\nSafety tests:

```powershell
powershell.exe -NoProfile -File .\Tests\Test-PreinstalledApps.ps1
```


## Exportable application inventory

From the preinstalled-app manager, option 4 performs a **read-only** inventory using Android Package Manager over authorized ADB. It exports:
- CSV with package ID, mapped display name, system/user classification, APK path, conservative cleanup hint and manufacturer family.
- JSON with the same app records plus manufacturer, brand, model, Android version and masked serial number.

Files are saved under `reports/`. The export does not uninstall, disable, modify or read application data. Unknown package names remain unmapped and classification is marked as undetermined if Android does not return it in either system or third-party lists. Review reports before sharing; APK paths and device model may reveal device configuration.

## Requirements

- Windows 10 or Windows 11.
- Windows PowerShell 5.1 or PowerShell 7+.
- Android Platform-Tools (ADB/Fastboot), either in `tools/platform-tools` or available on PATH.
- USB drivers appropriate for the phone manufacturer.

## Run

Open PowerShell in this folder and run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Start-FDTOOL.ps1
```

If Windows blocks local scripts, review the file and use an execution policy appropriate for your environment. Do not disable antivirus or system protections to run FDTOOL.

## Safety principles

- This module does not unlock bootloaders, flash firmware, erase data, bypass FRP/account locks, change IMEI, disable security features or modify device settings.
- ADB property reads require the phone to be connected and USB debugging to be authorized by its owner.
- Fastboot information is limited to values exposed by the device bootloader.
- No driver installation or automatic download is performed in this initial release.

## Service procedure catalog (foundation)

The V2 service architecture now includes:
- `Data/service-procedures.schema.json`: JSON Schema contract for versioned procedures.
- `Data/service-procedures.json`: initial manual SIM-lock identification workflow.
- `Docs/Service-Procedure-Catalog.md`: proposed client/server architecture, compatibility matching, update model and safety requirements.

This is a data/catalog foundation, not an automatic SIM unlocker. The initial procedure is diagnostic and manual. ADB/Fastboot do not provide a universal network-unlock command. Future model-specific procedures must be verified against reliable manufacturer/operator documentation. No IMEI, NV/EFS, credential, anti-theft or account-lock bypass operations are part of this design.

## Planned next steps

1. Add driver and Platform-Tools version checks.
2. Expand manufacturer-specific diagnostic profiles after compatibility review.
3. Add verified, user-confirmed maintenance workflows with explicit warnings and compatibility checks.

## Diagnostic report privacy

Reports are saved locally under `reports/`. Device serial numbers are masked by default (only the last four characters remain visible). Reports may include device model, Android version, build fingerprint, Windows version, and tool versions. Review a report before sharing it with anyone.

## Device identification engine

The profile engine now returns a confidence level, matched property names, model, device codename, Android release, SDK and build fingerprint. Identification remains heuristic: family recognition is not proof of exact model, regional variant or firmware compatibility. Missing or ambiguous identifiers must be reviewed.

## Service procedure browser

Menu option 5 loads the local JSON catalog and compares its declared manufacturer, model/codename and Android constraints with the connected authorized ADB device. Results distinguish family matches from exact-model matches and show the procedure status, requirements, steps, limitations and source.

Important controls:
- The current catalog procedure is `limited` and manual. It is shown as a family-level diagnostic suggestion only.
- A family match is never presented as exact model compatibility.
- Procedures marked `research` or `deprecated` are not eligible for automation.
- This version only displays procedure data; it does not execute catalog steps or perform SIM/network unlocking.
- The matcher requires a matching manufacturer family and rejects model/Android mismatches when those constraints are declared.
- Even a future `verified` procedure will require a separately implemented, reviewed operation and explicit user confirmation; catalog text is never executable code.

Run matcher tests:

```powershell
pwsh -NoProfile -File .\Tests\Test-ServiceProcedures.ps1
```


## Central Service Engine (first implementation)

Menu option 6 shows a capability matrix for the selected ADB/Fastboot connection. It combines the detected manufacturer profile, connection authorization and local service-catalog availability to distinguish available, confirmation-required, unavailable and planned capabilities.

The engine is deliberately descriptive in this stage: it does not execute service procedures. Android diagnostics and application inventory are read-only; user-level app management is marked moderate risk and requires package-by-package confirmation. Manufacturer-specific advanced operations remain planned until exact model, regional variant, compatibility evidence and safe implementation are verified.

Run the Service Engine tests:

```powershell
pwsh -NoProfile -File .\\Tests\\Test-ServiceEngine.ps1
```


## Device Intelligence Engine (initial platform identification)

The read-only hardware profile examines Android system properties when ADB is authorized. It can infer likely platform families such as Qualcomm Snapdragon, MediaTek Dimensity/Helio, Samsung Exynos, Google Tensor, UNISOC, HiSilicon Kirin and Broadcom when exposed by the device.

The launcher capability overview now displays the inferred SoC vendor/family, reported model, platform identifier and confidence. Some manufacturers hide or omit these properties, so unknown results are valid. The engine never treats a family inference as proof of exact chipset, board revision or firmware compatibility.

Run hardware intelligence tests:

```powershell
pwsh -NoProfile -File .\\Tests\\Test-DeviceIntelligence.ps1
```
