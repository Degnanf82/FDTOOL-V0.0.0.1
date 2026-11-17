# FDTOOL V2 - Non-root preinstalled app manager
# Uses Android Package Manager through authorized ADB. No root, no system partition writes.

function Test-SafePackageName {
    param([Parameter(Mandatory=$true)][AllowEmptyString()][string]$PackageName)
    return ($PackageName -match '^[A-Za-z0-9_]+(\.[A-Za-z0-9_]+)+$')
}

function Test-ProtectedPackage {
    param([Parameter(Mandatory=$true)][string]$PackageName)

    $protectedExact = @(
        "android",
        "com.android.systemui",
        "com.android.settings",
        "com.android.phone",
        "com.android.server.telecom",
        "com.android.providers.settings",
        "com.android.providers.telephony",
        "com.android.providers.contacts",
        "com.android.providers.media",
        "com.android.providers.downloads",
        "com.android.documentsui",
        "com.android.permissioncontroller",
        "com.android.bluetooth",
        "com.android.nfc",
        "com.android.launcher3",
        "com.android.packageinstaller",
        "com.google.android.gms",
        "com.google.android.gsf",
        "com.google.android.permissioncontroller",
        "com.google.android.packageinstaller",
        "com.google.android.webview",
        "com.android.vending"
    )

    if ($protectedExact -contains $PackageName) { return $true }

    $protectedPatterns = @(
        '^com\.android\.providers\.',
        '^com\.android\.server\.',
        '^com\.android\.systemui\.',
        '^com\.android\.inputdevices$',
        '^com\.android\.shell$',
        '^com\.android\.keychain$',
        '^com\.android\.externalstorage$',
        '^com\.android\.location\.fusion$',
        '^com\.google\.android\.ext\.services$'
    )
    foreach ($pattern in $protectedPatterns) {
        if ($PackageName -match $pattern) { return $true }
    }
    return $false
}

function Get-AdbHomeLauncherPackage {
    param(
        [Parameter(Mandatory=$true)][string]$AdbPath,
        [Parameter(Mandatory=$true)][string]$Serial
    )

    $output = @(& $AdbPath -s $Serial shell cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME 2>&1)
    if ($LASTEXITCODE -ne 0) { return "" }

    foreach ($line in $output) {
        $text = "$line".Trim()
        if ($text -match '^([A-Za-z0-9_.]+)/') { return $Matches[1] }
    }
    return ""
}

function Get-AdbSystemPackages {
    param(
        [Parameter(Mandatory=$true)][string]$AdbPath,
        [Parameter(Mandatory=$true)][string]$Serial
    )

    $output = @(& $AdbPath -s $Serial shell pm list packages -s 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "No se pudo consultar la lista de aplicaciones del sistema: $($output -join ' ')"
    }

    $homeLauncher = Get-AdbHomeLauncherPackage -AdbPath $AdbPath -Serial $Serial
    $packages = @()
    foreach ($line in $output) {
        $text = "$line".Trim()
        if ($text -match '^package:([A-Za-z0-9_.]+)$') {
            $name = $Matches[1]
            $packages += [pscustomobject]@{
                PackageName = $name
                Protected = ((Test-ProtectedPackage -PackageName $name) -or ($homeLauncher -and $name -eq $homeLauncher))
            }
        }
    }
    return @($packages | Sort-Object PackageName -Unique)
}

function Invoke-PreinstalledAppManager {
    param(
        [Parameter(Mandatory=$true)][string]$AdbPath,
        [Parameter(Mandatory=$true)][string]$Serial
    )

    while ($true) {
        Clear-Host
        Write-Host ""
        Write-Host "  FDTOOL V2 | Aplicaciones preinstaladas (sin root)" -ForegroundColor Cyan
        Write-Host "  ------------------------------------------------" -ForegroundColor DarkCyan
        Write-Host "  Solo afecta al usuario Android 0. No borra el APK de la partición del sistema." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  1. Listar aplicaciones del sistema"
        Write-Host "  2. Desinstalar para el usuario actual"
        Write-Host "  3. Restaurar una aplicación del sistema"
        Write-Host "  0. Volver"
        $action = Read-Host "  Selecciona una opción"

        if ($action -eq "0") { return }

        if ($action -eq "1" -or $action -eq "2") {
            try {
                $packages = @(Get-AdbSystemPackages -AdbPath $AdbPath -Serial $Serial)
            }
            catch {
                Write-Host "  Error: $_" -ForegroundColor Red
                [void](Read-Host "  Pulsa Enter")
                continue
            }

            if ($action -eq "1") {
                Write-Host ""
                foreach ($item in $packages) {
                    $tag = if ($item.Protected) { "[PROTEGIDA]" } else { "[sistema]" }
                    $color = if ($item.Protected) { "DarkYellow" } else { "Gray" }
                    Write-Host ("  {0,-14} {1}" -f $tag, $item.PackageName) -ForegroundColor $color
                }
                Write-Host ""
                Write-Host ("  Total: {0} aplicaciones del sistema; {1} protegidas por FDTOOL." -f $packages.Count, @($packages | Where-Object Protected).Count)
                [void](Read-Host "  Pulsa Enter para continuar")
                continue
            }

            $removable = @($packages | Where-Object { -not $_.Protected })
            if ($removable.Count -eq 0) {
                Write-Host "  No hay paquetes disponibles para esta operación." -ForegroundColor Yellow
                [void](Read-Host "  Pulsa Enter")
                continue
            }

            Write-Host ""
            Write-Host "  Aplicaciones candidatas (la compatibilidad depende del fabricante):" -ForegroundColor Yellow
            for ($i = 0; $i -lt $removable.Count; $i++) {
                Write-Host ("  [{0}] {1}" -f ($i + 1), $removable[$i].PackageName)
            }
            $choice = Read-Host "  Número de paquete (Enter para cancelar)"
            if ($choice -notmatch '^\d+$') { continue }
            $index = [int]$choice - 1
            if ($index -lt 0 -or $index -ge $removable.Count) {
                Write-Host "  Selección no válida." -ForegroundColor Yellow
                [void](Read-Host "  Pulsa Enter")
                continue
            }

            $selected = $removable[$index].PackageName
            Write-Host ""
            Write-Host "  ADVERTENCIA: desinstalar una app del sistema puede afectar funciones del teléfono." -ForegroundColor Yellow
            Write-Host "  La operación se limita al usuario 0 y normalmente puede revertirse."
            Write-Host "  Para confirmar, escribe exactamente el nombre del paquete:"
            $confirmation = Read-Host "  $selected"
            if ($confirmation -cne $selected) {
                Write-Host "  Operación cancelada." -ForegroundColor DarkYellow
                [void](Read-Host "  Pulsa Enter")
                continue
            }

            $result = @(& $AdbPath -s $Serial shell pm uninstall --user 0 $selected 2>&1)
            $exitCode = $LASTEXITCODE
            Write-Host ""
            if ($exitCode -eq 0 -and (($result -join " ") -match 'Success')) {
                Write-Host "  Aplicación desinstalada para el usuario 0." -ForegroundColor Green
                Write-Host "  No se ha borrado el APK de la partición del sistema."
            }
            else {
                Write-Host "  Android no confirmó la operación:" -ForegroundColor Yellow
                $result | ForEach-Object { Write-Host "  $_" }
            }
            [void](Read-Host "  Pulsa Enter para continuar")
            continue
        }

        if ($action -eq "3") {
            $package = Read-Host "  Nombre exacto del paquete a restaurar"
            if (-not (Test-SafePackageName -PackageName $package)) {
                Write-Host "  Nombre de paquete no válido." -ForegroundColor Yellow
                [void](Read-Host "  Pulsa Enter")
                continue
            }
            if (Test-ProtectedPackage -PackageName $package) {
                Write-Host "  El paquete está protegido por FDTOOL; no se ejecutará ninguna acción." -ForegroundColor Red
                [void](Read-Host "  Pulsa Enter")
                continue
            }
            $confirm = Read-Host "  Escribe RESTAURAR para volver a habilitar $package para el usuario 0"
            if ($confirm -cne "RESTAURAR") { continue }

            $result = @(& $AdbPath -s $Serial shell cmd package install-existing --user 0 $package 2>&1)
            $exitCode = $LASTEXITCODE
            if ($exitCode -ne 0 -or (($result -join " ") -match 'Unknown command|not installed')) {
                $result = @(& $AdbPath -s $Serial shell pm install-existing --user 0 $package 2>&1)
                $exitCode = $LASTEXITCODE
            }
            Write-Host ""
            $result | ForEach-Object { Write-Host "  $_" }
            if ($exitCode -eq 0) { Write-Host "  Solicitud de restauración completada." -ForegroundColor Green }
            else { Write-Host "  No se pudo restaurar el paquete." -ForegroundColor Yellow }
            [void](Read-Host "  Pulsa Enter para continuar")
            continue
        }

        Write-Host "  Opción no válida." -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
}
