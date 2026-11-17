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
            Android = "ro.build.version.release"
            SDK = "ro.build.version.sdk"
        }
        foreach ($entry in $properties.GetEnumerator()) {
            $value = Get-AdbProperty -Serial $Device.Serial -Property $entry.Value
            if ([string]::IsNullOrWhiteSpace($value)) { $value = "No disponible" }
            Write-Host ("  {0,-13} {1}" -f ($entry.Key + ":"), $value)
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

$script:Adb = Resolve-Tool -Name "adb"
$script:Fastboot = Resolve-Tool -Name "fastboot"

while ($true) {
    Write-Title
    Write-Host ("  ADB:      {0}" -f $(if ($script:Adb) { "Disponible" } else { "No encontrado" })) -ForegroundColor $(if ($script:Adb) { "Green" } else { "Yellow" })
    Write-Host ("  Fastboot: {0}" -f $(if ($script:Fastboot) { "Disponible" } else { "No encontrado" })) -ForegroundColor $(if ($script:Fastboot) { "Green" } else { "Yellow" })
    Write-Host ""
    Write-Host "  1. Detectar dispositivos (ADB / Fastboot)"
    Write-Host "  2. Volver a comprobar herramientas"
    Write-Host "  0. Salir"
    Write-Host ""
    $option = Read-Host "  Selecciona una opción"
    switch ($option) {
        "1" { Show-Scan }
        "2" {
            $script:Adb = Resolve-Tool -Name "adb"
            $script:Fastboot = Resolve-Tool -Name "fastboot"
        }
        "0" { break }
        default { Write-Host "  Opción no válida." -ForegroundColor Yellow; Start-Sleep -Seconds 1 }
    }
}
