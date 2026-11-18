# FDTOOL V2 - Safe device diagnostics
# Compatible with Windows PowerShell 5.1 and PowerShell 7+
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$script:Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$script:PlatformTools = Join-Path $script:Root "tools\platform-tools"
$script:Adb = $null
$script:Fastboot = $null
$script:ProfilesPath = Join-Path $script:Root "Modules\DeviceProfiles.ps1"
if (Test-Path -LiteralPath $script:ProfilesPath -PathType Leaf) { . $script:ProfilesPath }
$script:ServiceModulePath = Join-Path $script:Root "Modules\ServiceProcedures.ps1"
if (Test-Path -LiteralPath $script:ServiceModulePath -PathType Leaf) { . $script:ServiceModulePath }
$script:ServiceEnginePath = Join-Path $script:Root "Modules\ServiceEngine.ps1"
if (Test-Path -LiteralPath $script:ServiceEnginePath -PathType Leaf) { . $script:ServiceEnginePath }
$script:AppsModulePath = Join-Path $script:Root "Modules\PreinstalledApps.ps1"
if (Test-Path -LiteralPath $script:AppsModulePath -PathType Leaf) { . $script:AppsModulePath }

function Write-Title {
    Clear-Host
    Write-Host ""
    Write-Host "  FDTOOL V2 | Mobile Device Diagnostics" -ForegroundColor Cyan
    Write-Host "  -------------------------------------" -ForegroundColor DarkCyan
    Write-Host "  Safe mode: read-only device inspection" -ForegroundColor Green
    Write-Host ""
}

function Resolve-Tool {
    param([Parameter(Mandatory=$true)][string]$Name)
    $localPath = Join-Path $script:PlatformTools ($Name + ".exe")
    if (Test-Path -LiteralPath $localPath -PathType Leaf) { return $localPath }
    $command = Get-Command ($Name + ".exe") -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    return $null
}

function Invoke-ExternalTool {
    param(
        [Parameter(Mandatory=$true)][string]$Executable,
        [Parameter(Mandatory=$true)][string[]]$Arguments
    )
    if (-not (Test-Path -LiteralPath $Executable -PathType Leaf)) {
        throw "No se encuentra el ejecutable: $Executable"
    }
    $output = @(& $Executable @Arguments 2>&1)
    $exitCode = $LASTEXITCODE
    [pscustomobject]@{
        ExitCode = $exitCode
        Output = @($output | ForEach-Object { "$_" })
    }
}

function Get-AdbDevices {
    if (-not $script:Adb) { return @() }
    $result = Invoke-ExternalTool -Executable $script:Adb -Arguments @("devices", "-l")
    if ($result.ExitCode -ne 0) {
        Write-Warning "ADB devolvió un error: $($result.Output -join ' ')"
        return @()
    }

    $devices = @()
    foreach ($line in $result.Output) {
        if ($line -match '^\s*(\S+)\s+(device|unauthorized|offline)(?:\s+(.*))?$') {
            $devices += [pscustomobject]@{
                Serial = $Matches[1]
                State = $Matches[2]
                Details = $Matches[3]
                Mode = "ADB"
            }
        }
    }
    return $devices
}

function Get-FastbootDevices {
    if (-not $script:Fastboot) { return @() }
    $result = Invoke-ExternalTool -Executable $script:Fastboot -Arguments @("devices")
    if ($result.ExitCode -ne 0) {
        Write-Warning "Fastboot devolvió un error: $($result.Output -join ' ')"
        return @()
    }

    $devices = @()
    foreach ($line in $result.Output) {
        if ($line -match '^\s*(\S+)\s+(fastboot)\s*$') {
            $devices += [pscustomobject]@{
                Serial = $Matches[1]
                State = "fastboot"
                Details = ""
                Mode = "Fastboot"
            }
        }
    }
    return $devices
}

function Get-AdbProperty {
    param([string]$Serial, [string]$Property)
    $result = Invoke-ExternalTool -Executable $script:Adb -Arguments @("-s", $Serial, "shell", "getprop", $Property)
    if ($result.ExitCode -eq 0) { return (($result.Output -join "").Trim()) }
    return ""
}

function Show-DeviceDetails {
    param([Parameter(Mandatory=$true)]$Device)
    Write-Host ""
    Write-Host "  Dispositivo: $($Device.Serial)" -ForegroundColor Cyan
    Write-Host "  Modo:        $($Device.Mode)"
    Write-Host "  Estado:      $($Device.State)"

    if ($Device.Mode -eq "ADB" -and $Device.State -eq "device") {
        $properties = [ordered]@{
            Fabricante = "ro.product.manufacturer"
            Marca = "ro.product.brand"
            Modelo = "ro.product.model"
            Dispositivo = "ro.product.device"
            Producto = "ro.product.name"
            Android = "ro.build.version.release"
            SDK = "ro.build.version.sdk"
        }
        $deviceInfo = @{}
        foreach ($entry in $properties.GetEnumerator()) {
            $value = Get-AdbProperty -Serial $Device.Serial -Property $entry.Value
            if ([string]::IsNullOrWhiteSpace($value)) { $value = "No disponible" }
            $deviceInfo[$entry.Key] = $value
            Write-Host ("  {0,-13} {1}" -f ($entry.Key + ":"), $value)
        }
        if (Get-Command Get-ManufacturerProfile -ErrorAction SilentlyContinue) {
            $profile = Get-ManufacturerProfile -Manufacturer $deviceInfo["Fabricante"] -Brand $deviceInfo["Marca"] -Model $deviceInfo["Modelo"] -Product $deviceInfo["Producto"]
            Write-Host ("  Familia:      {0}" -f $profile.ManufacturerFamily) -ForegroundColor Cyan
            Write-Host ("  Nota:         {0}" -f $profile.SupportNote) -ForegroundColor DarkGray
        }
    }
    elseif ($Device.Mode -eq "ADB" -and $Device.State -eq "unauthorized") {
        Write-Host "  Autoriza la depuración USB en la pantalla del teléfono." -ForegroundColor Yellow
    }
    elseif ($Device.Mode -eq "ADB" -and $Device.State -eq "offline") {
        Write-Host "  El dispositivo está desconectado o ADB no responde." -ForegroundColor Yellow
    }
    elseif ($Device.Mode -eq "Fastboot") {
        $result = Invoke-ExternalTool -Executable $script:Fastboot -Arguments @("-s", $Device.Serial, "getvar", "product")
        $product = ($result.Output | Where-Object { $_ -match 'product:' } | Select-Object -First 1)
        if ($product) { Write-Host "  $($product.Trim())" }
        else { Write-Host "  Producto: no informado por el bootloader" -ForegroundColor DarkYellow }
        if (Get-Command Get-ManufacturerProfile -ErrorAction SilentlyContinue) {
            $fastbootProduct = if ($product) { $product.Trim() } else { "" }
            $profile = Get-ManufacturerProfile -Product $fastbootProduct
            Write-Host ("  Familia probable: {0}" -f $profile.ManufacturerFamily) -ForegroundColor Cyan
        }
        Write-Host "  Nota: algunos fabricantes no permiten consultar todos los datos en Fastboot." -ForegroundColor DarkGray
    }
}

function Show-Scan {
    Write-Title
    Write-Host "  Buscando dispositivos..." -ForegroundColor Yellow
    $adbDevices = @(Get-AdbDevices)
    $fastbootDevices = @(Get-FastbootDevices)
    $all = @($adbDevices) + @($fastbootDevices)

    if ($all.Count -eq 0) {
        Write-Host ""
        Write-Host "  No se detectaron dispositivos." -ForegroundColor Yellow
        Write-Host "  Comprueba el cable USB, los controladores y el modo del teléfono."
    }
    else {
        for ($i = 0; $i -lt $all.Count; $i++) {
            $d = $all[$i]
            Write-Host ("  [{0}] {1} | {2} | {3}" -f ($i + 1), $d.Mode, $d.State, $d.Serial) -ForegroundColor Green
        }
        Write-Host ""
        $choice = Read-Host "  Número para ver detalles (Enter para volver)"
        if ($choice -match '^\d+$') {
            $index = [int]$choice - 1
            if ($index -ge 0 -and $index -lt $all.Count) {
                Show-DeviceDetails -Device $all[$index]
            }
            else { Write-Host "  Selección fuera de rango." -ForegroundColor Yellow }
        }
    }
    Write-Host ""
    [void](Read-Host "  Pulsa Enter para continuar")
}


function Start-PreinstalledAppManager {
    if (-not $script:Adb) {
        Write-Host "  ADB no está disponible. Instala Android Platform-Tools." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter para continuar")
        return
    }

    $devices = @(Get-AdbDevices | Where-Object { $_.State -eq "device" })
    if ($devices.Count -eq 0) {
        Write-Host "  No hay dispositivos ADB autorizados. Activa Depuración USB y acepta la autorización en el teléfono." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter para continuar")
        return
    }

    Write-Host ""
    for ($i = 0; $i -lt $devices.Count; $i++) {
        Write-Host ("  [{0}] {1} ({2})" -f ($i + 1), $devices[$i].Serial, $devices[$i].Details)
    }
    $choice = Read-Host "  Selecciona el dispositivo (Enter para cancelar)"
    if ($choice -notmatch '^\d+$') { return }
    $index = [int]$choice - 1
    if ($index -lt 0 -or $index -ge $devices.Count) {
        Write-Host "  Selección no válida." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter")
        return
    }

    Invoke-PreinstalledAppManager -AdbPath $script:Adb -Serial $devices[$index].Serial -OutputDirectory (Join-Path $script:Root "reports")
}


function Start-ServiceProcedureBrowser {
    if (-not $script:Adb) {
        Write-Host "  ADB no está disponible. Instala Android Platform-Tools." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter para continuar")
        return
    }
    $devices = @(Get-AdbDevices | Where-Object { $_.State -eq "device" })
    if ($devices.Count -eq 0) {
        Write-Host "  No hay dispositivos ADB autorizados. Esta consulta requiere lectura autorizada." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter para continuar")
        return
    }
    for ($i = 0; $i -lt $devices.Count; $i++) {
        Write-Host ("  [{0}] {1} ({2})" -f ($i + 1), $devices[$i].Serial, $devices[$i].Details)
    }
    $choice = Read-Host "  Selecciona dispositivo (Enter para cancelar)"
    if ($choice -notmatch '^\d+$') { return }
    $index = [int]$choice - 1
    if ($index -lt 0 -or $index -ge $devices.Count) {
        Write-Host "  Selección no válida." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter")
        return
    }
    $serial = $devices[$index].Serial
    $deviceInfo = [ordered]@{
        Manufacturer = Get-AdbProperty -Serial $serial -Property "ro.product.manufacturer"
        Brand = Get-AdbProperty -Serial $serial -Property "ro.product.brand"
        Model = Get-AdbProperty -Serial $serial -Property "ro.product.model"
        Product = Get-AdbProperty -Serial $serial -Property "ro.product.name"
        Device = Get-AdbProperty -Serial $serial -Property "ro.product.device"
        AndroidVersion = Get-AdbProperty -Serial $serial -Property "ro.build.version.release"
    }
    $profile = Get-ManufacturerProfile -Manufacturer $deviceInfo.Manufacturer -Brand $deviceInfo.Brand -Model $deviceInfo.Model -Product $deviceInfo.Product -Device $deviceInfo.Device -AndroidVersion $deviceInfo.AndroidVersion
    $device = [pscustomobject]@{
        ManufacturerFamily = $profile.ManufacturerFamily
        Model = $profile.Model
        DeviceCodename = $profile.DeviceCodename
        AndroidVersion = $profile.AndroidVersion
    }
    $catalogPath = Join-Path $script:Root "Data\service-procedures.json"
    try {
        $catalog = Import-ServiceProcedureCatalog -Path $catalogPath
    }
    catch {
        Write-Host "  No se pudo cargar el catálogo: $_" -ForegroundColor Red
        [void](Read-Host "  Pulsa Enter")
        return
    }
    $matches = @(Get-CompatibleServiceProcedures -Catalog $catalog -Device $device)
    Write-Host ""
    Write-Host ("  Dispositivo: {0} | {1} | Android {2}" -f $profile.ManufacturerFamily, $profile.Model, $profile.AndroidVersion) -ForegroundColor Cyan
    Write-Host ("  Confianza de identificación: {0}" -f $profile.Confidence)
    if ($matches.Count -eq 0) {
        Write-Host "  No hay procedimientos compatibles en el catálogo local." -ForegroundColor Yellow
    }
    foreach ($item in $matches) {
        $procedure = $item.Procedure
        Write-Host ""
        Write-Host ("  {0} [{1}]" -f $procedure.title, $item.Match.MatchLevel) -ForegroundColor Green
        Write-Host ("  Estado: {0} | Categoría: {1}" -f $procedure.status, $procedure.category)
        Write-Host ("  {0}" -f $procedure.summary)
        Write-Host ("  Revisión manual requerida: {0}" -f $(if ($item.Match.ReviewRequired) { "Sí" } else { "No" }))
        Write-Host ("  Automatización permitida: {0}" -f $(if ($item.Match.CanAutomate) { "No en esta versión; solo presentación" } else { "No" }))
        Write-Host ("  Motivo: {0}" -f $item.Match.Reason)
        Write-Host "  Pasos informativos:"
        foreach ($step in $procedure.steps) { Write-Host ("   - {0}" -f $step) }
        if ($procedure.limitations) {
            Write-Host "  Limitaciones:"
            foreach ($limitation in $procedure.limitations) { Write-Host ("   - {0}" -f $limitation) }
        }
        Write-Host ("  Fuente: {0} - {1}" -f $procedure.source.name, $procedure.source.url) -ForegroundColor DarkGray
    }
    Write-Host ""
    [void](Read-Host "  Pulsa Enter para continuar")
}


function Start-ServiceCapabilityOverview {
    $adbDevices = @(Get-AdbDevices)
    $fastbootDevices = @(Get-FastbootDevices)
    $devices = @($adbDevices) + @($fastbootDevices)
    if ($devices.Count -eq 0) {
        Write-Host "  No se detectaron dispositivos ADB/Fastboot." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter para continuar")
        return
    }
    for ($i = 0; $i -lt $devices.Count; $i++) {
        Write-Host ("  [{0}] {1} | {2} | {3}" -f ($i + 1), $devices[$i].Mode, $devices[$i].State, $devices[$i].Serial)
    }
    $choice = Read-Host "  Selecciona dispositivo para consultar capacidades (Enter para cancelar)"
    if ($choice -notmatch '^\d+$') { return }
    $index = [int]$choice - 1
    if ($index -lt 0 -or $index -ge $devices.Count) {
        Write-Host "  Selección no válida." -ForegroundColor Yellow
        [void](Read-Host "  Pulsa Enter")
        return
    }

    $selected = $devices[$index]
    $profile = $null
    $authorized = ($selected.Mode -eq "ADB" -and $selected.State -eq "device")
    if ($authorized) {
        $info = @{
            Manufacturer = Get-AdbProperty -Serial $selected.Serial -Property "ro.product.manufacturer"
            Brand = Get-AdbProperty -Serial $selected.Serial -Property "ro.product.brand"
            Model = Get-AdbProperty -Serial $selected.Serial -Property "ro.product.model"
            Product = Get-AdbProperty -Serial $selected.Serial -Property "ro.product.name"
            Device = Get-AdbProperty -Serial $selected.Serial -Property "ro.product.device"
            AndroidVersion = Get-AdbProperty -Serial $selected.Serial -Property "ro.build.version.release"
            SDK = Get-AdbProperty -Serial $selected.Serial -Property "ro.build.version.sdk"
            BuildFingerprint = Get-AdbProperty -Serial $selected.Serial -Property "ro.build.fingerprint"
        }
        $profile = Get-ManufacturerProfile @info
    }
    elseif ($selected.Mode -eq "Fastboot") {
        $productResult = Invoke-ExternalTool -Executable $script:Fastboot -Arguments @("-s", $selected.Serial, "getvar", "product")
        $productLine = $productResult.Output | Where-Object { $_ -match "product:" } | Select-Object -First 1
        $product = if ($productLine) { $productLine.Trim() } else { "" }
        $profile = Get-ManufacturerProfile -Product $product
    }
    else {
        $profile = Get-ManufacturerProfile
    }

    $catalogPath = Join-Path $script:Root "Data\service-procedures.json"
    $catalogAvailable = Test-Path -LiteralPath $catalogPath -PathType Leaf
    $capabilities = @(Get-FdtoolServiceCapabilities -DeviceProfile $profile -ConnectionMode $selected.Mode -AdbAuthorized $authorized -FastbootAvailable ([bool]$script:Fastboot) -ServiceCatalogAvailable $catalogAvailable)

    Write-Host ""
    Write-Host ("  FDTOOL Service Engine | {0} | {1}" -f $profile.ManufacturerFamily, $profile.Model) -ForegroundColor Cyan
    Write-Host ("  Conexión: {0} / {1} | Confianza: {2}" -f $selected.Mode, $selected.State, $profile.Confidence)
    Write-Host ""
    foreach ($capability in $capabilities) {
        $color = if ($capability.Status -eq "available") { "Green" } elseif ($capability.Status -eq "available-with-confirmation") { "Yellow" } else { "DarkGray" }
        Write-Host ("  [{0}] {1} — {2}" -f $capability.Status, $capability.Name, $capability.Risk) -ForegroundColor $color
        Write-Host ("       {0}" -f $capability.Reason) -ForegroundColor DarkGray
    }
    Write-Host ""
    Write-Host "  Nota: esta pantalla informa de capacidades; no ejecuta operaciones de servicio." -ForegroundColor Yellow
    [void](Read-Host "  Pulsa Enter para continuar")
}

function Protect-Serial {
    param([string]$Serial)
    if ([string]::IsNullOrWhiteSpace($Serial)) { return "No disponible" }
    if ($Serial.Length -le 4) { return ("*" * $Serial.Length) }
    return (("*" * ($Serial.Length - 4)) + $Serial.Substring($Serial.Length - 4))
}

function New-DiagnosticReport {
    Write-Title
    Write-Host "  Generando informe de diagnóstico..." -ForegroundColor Yellow

    $adbDevices = @(Get-AdbDevices)
    $fastbootDevices = @(Get-FastbootDevices)
    $deviceReports = @()

    foreach ($device in (@($adbDevices) + @($fastbootDevices))) {
        $entry = [ordered]@{
            Mode = $device.Mode
            State = $device.State
            SerialMasked = Protect-Serial -Serial $device.Serial
            Details = $device.Details
        }

        if ($device.Mode -eq "ADB" -and $device.State -eq "device") {
            $entry.Manufacturer = Get-AdbProperty -Serial $device.Serial -Property "ro.product.manufacturer"
            $entry.Brand = Get-AdbProperty -Serial $device.Serial -Property "ro.product.brand"
            $entry.Model = Get-AdbProperty -Serial $device.Serial -Property "ro.product.model"
            $entry.Device = Get-AdbProperty -Serial $device.Serial -Property "ro.product.device"
            $entry.Product = Get-AdbProperty -Serial $device.Serial -Property "ro.product.name"
            $entry.AndroidVersion = Get-AdbProperty -Serial $device.Serial -Property "ro.build.version.release"
            $entry.SDK = Get-AdbProperty -Serial $device.Serial -Property "ro.build.version.sdk"
            $entry.BuildFingerprint = Get-AdbProperty -Serial $device.Serial -Property "ro.build.fingerprint"
            if (Get-Command Get-ManufacturerProfile -ErrorAction SilentlyContinue) {
                $profile = Get-ManufacturerProfile -Manufacturer $entry.Manufacturer -Brand $entry.Brand -Model $entry.Model -Product $entry.Product
                $entry.ManufacturerFamily = $profile.ManufacturerFamily
                $entry.SupportNote = $profile.SupportNote
            }
        }
        elseif ($device.Mode -eq "Fastboot") {
            $productResult = Invoke-ExternalTool -Executable $script:Fastboot -Arguments @("-s", $device.Serial, "getvar", "product")
            $productLine = $productResult.Output | Where-Object { $_ -match 'product:' } | Select-Object -First 1
            if ($productLine) { $entry.Product = $productLine.Trim() } else { $entry.Product = "Not reported" }
            if (Get-Command Get-ManufacturerProfile -ErrorAction SilentlyContinue) {
                $profile = Get-ManufacturerProfile -Product $entry.Product
                $entry.ManufacturerFamily = $profile.ManufacturerFamily
                $entry.SupportNote = $profile.SupportNote
            }
        }
        $deviceReports += [pscustomobject]$entry
    }

    $windows = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue
    $adbVersion = if ($script:Adb) { (Invoke-ExternalTool -Executable $script:Adb -Arguments @("version")).Output -join " " } else { "Not found" }
    $fastbootVersion = if ($script:Fastboot) { (Invoke-ExternalTool -Executable $script:Fastboot -Arguments @("--version")).Output -join " " } else { "Not found" }
    $windowsText = [System.Environment]::OSVersion.VersionString
    if ($windows) { $windowsText = "$($windows.Caption) ($($windows.Version))" }

    $report = [pscustomobject]@{
        Application = "FDTOOL V2"
        ReportDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")
        Computer = $env:COMPUTERNAME
        Windows = $windowsText
        PowerShell = $PSVersionTable.PSVersion.ToString()
        ADB = $adbVersion
        Fastboot = $fastbootVersion
        DeviceCount = $deviceReports.Count
        Devices = @($deviceReports)
        Privacy = "Serial numbers masked by default. No personal files or account data collected."
    }

    $reportDirectory = Join-Path $script:Root "reports"
    if (-not (Test-Path -LiteralPath $reportDirectory)) {
        New-Item -ItemType Directory -Path $reportDirectory -Force | Out-Null
    }
    $fileName = "FDTOOL-Diagnostic-{0}.json" -f (Get-Date -Format "yyyyMMdd-HHmmss")
    $reportPath = Join-Path $reportDirectory $fileName
    $report | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $reportPath -Encoding UTF8

    Write-Host ""
    Write-Host "  Informe guardado:" -ForegroundColor Green
    Write-Host "  $reportPath"
    Write-Host "  Identificadores de serie enmascarados." -ForegroundColor Green
    Write-Host ""
    [void](Read-Host "  Pulsa Enter para continuar")
}

$script:Adb = Resolve-Tool -Name "adb"
$script:Fastboot = Resolve-Tool -Name "fastboot"

while ($true) {
    Write-Title
    Write-Host ("  ADB:      {0}" -f $(if ($script:Adb) { "Disponible" } else { "No encontrado" })) -ForegroundColor $(if ($script:Adb) { "Green" } else { "Yellow" })
    Write-Host ("  Fastboot: {0}" -f $(if ($script:Fastboot) { "Disponible" } else { "No encontrado" })) -ForegroundColor $(if ($script:Fastboot) { "Green" } else { "Yellow" })
    Write-Host ""
    Write-Host "  1. Detectar dispositivos (ADB / Fastboot)"
    Write-Host "  2. Volver a comprobar herramientas"
    Write-Host "  3. Generar informe de diagnóstico (JSON)"
    Write-Host "  4. Gestionar aplicaciones preinstaladas (sin root)"
    Write-Host "  5. Consultar procedimientos de servicio compatibles"
    Write-Host "  0. Salir"
    Write-Host ""
    $option = Read-Host "  Selecciona una opción"
    if ($option -eq "0") { break }
    switch ($option) {
        "1" { Show-Scan }
        "2" {
            $script:Adb = Resolve-Tool -Name "adb"
            $script:Fastboot = Resolve-Tool -Name "fastboot"
        }
        "3" { New-DiagnosticReport }
        "4" { Start-PreinstalledAppManager }
        "5" { Start-ServiceProcedureBrowser }
        default { Write-Host "  Opción no válida." -ForegroundColor Yellow; Start-Sleep -Seconds 1 }
    }
}
