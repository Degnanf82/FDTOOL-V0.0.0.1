# FDTOOL V2 – Mobile Device Diagnostics

A new, isolated modernization track for the original FDTOOL project. The legacy version remains unchanged on `main`.

## Current status

The first V2 module is a **read-only diagnostic launcher** for Windows 10/11. It can:

- Locate ADB and Fastboot from the bundled `tools/platform-tools` folder or the system PATH.
- List devices connected in ADB and Fastboot modes.
- Identify ADB authorization and offline states.
- Read basic Android properties from an authorized ADB device: manufacturer, brand, model, device codename, Android release and SDK level.
- Query the product identifier from Fastboot where the bootloader supports it.\n- Export a JSON diagnostic report containing Windows/tool versions and connected device details. Serial numbers are masked automatically.

## Manufacturer identification\n\nFDTOOL uses Android properties (`manufacturer`, `brand`, `model`, `device`, and `product`) and the Fastboot product string to classify common device families, including Samsung, Motorola, Xiaomi/Redmi/POCO, Huawei/HONOR, OPPO/realme/OnePlus, vivo/iQOO, Google Pixel, Sony, Nokia/HMD, TECNO/Infinix/itel, ASUS, Lenovo, ZTE/nubia and Nothing. This is a best-effort identification, not a definitive model/firmware compatibility check.\n\nRun the lightweight profile tests with:\n\n```powershell\npowershell.exe -NoProfile -File .\\Tests\\Test-DeviceProfiles.ps1\n```\n\n## Requirements

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

## Planned next steps

1. Add structured diagnostic reports with sensitive identifiers masked by default.
2. Add driver and Platform-Tools version checks.
3. Add manufacturer-specific diagnostic modules.
4. Add verified, user-confirmed maintenance workflows with explicit warnings and compatibility checks.\n\n## Diagnostic report privacy\n\nReports are saved locally under `reports/`. Device serial numbers are masked by default (only the last four characters remain visible). Reports may include device model, Android version, build fingerprint, Windows version, and tool versions. Review a report before sharing it with anyone.
