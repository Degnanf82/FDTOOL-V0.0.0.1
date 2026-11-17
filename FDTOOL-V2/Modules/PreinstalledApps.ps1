# FDTOOL V2 - Non-root preinstalled app manager
# Uses Android Package Manager through authorized ADB. No root, no system partition writes.

function Get-AppFriendlyName {
    param([Parameter(Mandatory=$true)][string]$PackageName)

    $catalog = @{
        "com.samsung.android.app.notes" = "Samsung Notes"
        "com.samsung.android.app.spage" = "Samsung Free / Samsung Daily"
        "com.samsung.android.bixby.agent" = "Bixby"
        "com.samsung.android.bixby.service" = "Bixby Voice Service"
        "com.samsung.android.visionintelligence" = "Bixby Vision"
        "com.samsung.android.game.gamehome" = "Game Launcher"
        "com.samsung.android.game.gametools" = "Game Booster"
        "com.samsung.android.email.provider" = "Samsung Email"
        "com.samsung.android.calendar" = "Samsung Calendar"
        "com.samsung.android.voc" = "Samsung Members"
        "com.samsung.android.oneconnect" = "SmartThings"
        "com.samsung.android.kidsinstaller" = "Samsung Kids"
        "com.sec.android.app.sbrowser" = "Samsung Internet"
        "com.sec.android.easyMover" = "Samsung Smart Switch"
        "com.google.android.apps.photos" = "Google Photos"
        "com.google.android.youtube" = "YouTube"
        "com.google.android.apps.maps" = "Google Maps"
        "com.google.android.apps.tachyon" = "Google Meet"
        "com.google.android.apps.docs" = "Google Drive"
        "com.google.android.gm" = "Gmail"
        "com.google.android.music" = "YouTube Music (legacy package)"
        "com.google.android.videos" = "Google TV / Play Movies"
        "com.google.android.apps.wellbeing" = "Digital Wellbeing"
        "com.google.android.apps.tips" = "Pixel Tips"
        "com.google.android.apps.walletnfcrel" = "Google Wallet"
        "com.google.android.apps.chromecast.app" = "Google Home"
        "com.google.android.apps.subscriptions.red" = "Google One"
        "com.motorola.help" = "Moto Help"
        "com.motorola.moto" = "Moto App"
        "com.motorola.launcher3" = "Moto Launcher"
        "com.motorola.ccc.ota" = "Motorola System Updates"
        "com.miui.player" = "Xiaomi Music"
        "com.miui.videoplayer" = "Xiaomi Video"
        "com.miui.weather2" = "Xiaomi Weather"
        "com.miui.notes" = "Xiaomi Notes"
        "com.miui.analytics" = "MIUI Analytics"
        "com.xiaomi.mipicks" = "GetApps"
        "com.xiaomi.midrop" = "ShareMe"
        "com.oplus.games" = "OPPO / OnePlus Games"
        "com.coloros.video" = "OPPO Video"
        "com.coloros.gallery3d" = "OPPO Photos"
        "com.heytap.market" = "App Market"
        "com.heytap.browser" = "OPPO Browser"
        "com.facebook.katana" = "Facebook"
        "com.facebook.services" = "Facebook Services"
        "com.facebook.system" = "Facebook App Manager"
        "com.spotify.music" = "Spotify"
        "com.netflix.mediaclient" = "Netflix"
        "com.microsoft.office.officehubrow" = "Microsoft 365"
        "com.linkedin.android" = "LinkedIn"
        "com.amazon.mShop.android.shopping" = "Amazon Shopping"
    }

    if ($catalog.ContainsKey($PackageName)) { return $catalog[$PackageName] }

    if ($PackageName -match '^com\.samsung\.') { return "Samsung app (name not mapped)" }
    if ($PackageName -match '^com\.motorola\.') { return "Motorola app (name not mapped)" }
    if ($PackageName -match '^com\.miui\.|^com\.xiaomi\.') { return "Xiaomi app (name not mapped)" }
    if ($PackageName -match '^com\.google\.') { return "Google app (name not mapped)" }
    if ($PackageName -match '^com\.coloros\.|^com\.heytap\.|^com\.oplus\.') { return "OPPO / OnePlus app (name not mapped)" }

    return "Name not mapped"
}


function Get-AppCleanupRecommendation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string]$PackageName,
        [Parameter(Mandatory=$true)][string]$ManufacturerFamily
    )

    if (Test-ProtectedPackage -PackageName $PackageName) {
        return [pscustomobject]@{ Status = "Protegida"; Reason = "Paquete Android/Google crítico protegido por FDTOOL." }
    }

    # Only well-known optional user-facing apps are listed. This is a review hint,
    # never a claim that removal is universally safe on every regional firmware.
    $optional = @{
        "Samsung" = @{
            "com.samsung.android.app.notes" = "Aplicación de notas; comprueba antes si contiene datos que necesitas."
            "com.samsung.android.app.spage" = "Panel Samsung Free/Daily; puede estar integrado con la pantalla de inicio."
            "com.samsung.android.game.gamehome" = "Centro de juegos; revisa dependencias de Game Booster."
            "com.samsung.android.voc" = "Samsung Members; puede incluir diagnóstico y soporte del fabricante."
            "com.samsung.android.email.provider" = "Cliente de correo Samsung; conserva si gestionas correo con él."
        }
        "Motorola" = @{
            "com.motorola.help" = "Ayuda de Motorola; conserva si utilizas soporte y guías del fabricante."
            "com.motorola.moto" = "Aplicación Moto; algunas funciones del dispositivo pueden depender de ella."
        }
        "Xiaomi / Redmi / POCO" = @{
            "com.miui.player" = "Reproductor de música; revisa si es tu reproductor predeterminado."
            "com.miui.videoplayer" = "Reproductor de vídeo; revisa asociaciones y funciones multimedia."
            "com.miui.weather2" = "Aplicación del tiempo; puede estar vinculada a widgets."
            "com.miui.notes" = "Notas Xiaomi; conserva si contiene información."
            "com.xiaomi.mipicks" = "Tienda GetApps; puede gestionar actualizaciones de apps del fabricante."
            "com.xiaomi.midrop" = "ShareMe; transferencia de archivos entre dispositivos."
        }
    }

    if ($optional.ContainsKey($ManufacturerFamily) -and $optional[$ManufacturerFamily].ContainsKey($PackageName)) {
        return [pscustomobject]@{
            Status = "Opcional - revisar"
            Reason = $optional[$ManufacturerFamily][$PackageName]
        }
    }

    return [pscustomobject]@{
        Status = "No evaluada - conservar"
        Reason = "FDTOOL no tiene una recomendación específica y validada para esta combinación de fabricante y paquete."
    }
}

function Get-AdbManufacturerFamily {
    param(
        [Parameter(Mandatory=$true)][string]$AdbPath,
        [Parameter(Mandatory=$true)][string]$Serial
    )
    $manufacturer = @(& $AdbPath -s $Serial shell getprop ro.product.manufacturer 2>&1) -join ""
    $brand = @(& $AdbPath -s $Serial shell getprop ro.product.brand 2>&1) -join ""
    $identity = "$manufacturer $brand".ToLowerInvariant()
    if ($identity -match "samsung") { return "Samsung" }
    if ($identity -match "motorola") { return "Motorola" }
    if ($identity -match "xiaomi|redmi|poco") { return "Xiaomi / Redmi / POCO" }
    return "Other / Unknown"
}

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
    $manufacturerFamily = Get-AdbManufacturerFamily -AdbPath $AdbPath -Serial $Serial
    $packages = @()
    foreach ($line in $output) {
        $text = "$line".Trim()
        if ($text -match '^package:([A-Za-z0-9_.]+)$') {
            $name = $Matches[1]
            $packages += [pscustomobject]@{
                PackageName = $name
                Protected = ((Test-ProtectedPackage -PackageName $name) -or ($homeLauncher -and $name -eq $homeLauncher))
                Recommendation = (Get-AppCleanupRecommendation -PackageName $name -ManufacturerFamily $manufacturerFamily)
            }
        }
    }
    return @($packages | Sort-Object PackageName -Unique)
}

function ConvertFrom-AdbPackageInventory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string[]]$PackageLines,
        [string[]]$SystemPackages = @(),
        [string[]]$ThirdPartyPackages = @(),
        [Parameter(Mandatory=$true)][string]$ManufacturerFamily
    )
    $systemLookup = @{}
    foreach ($name in $SystemPackages) { if ($name) { $systemLookup[$name] = $true } }
    $thirdPartyLookup = @{}
    foreach ($name in $ThirdPartyPackages) { if ($name) { $thirdPartyLookup[$name] = $true } }
    $items = @()
    foreach ($line in $PackageLines) {
        $text = "$line".Trim()
        if ([string]::IsNullOrWhiteSpace($text) -or -not $text.StartsWith("package:")) { continue }
        $apkPath = ""
        $packageName = ""
        $payload = $text.Substring(8)
        $separator = $payload.LastIndexOf("=")
        if ($separator -ge 0) {
            $apkPath = $payload.Substring(0, $separator)
            $candidate = $payload.Substring($separator + 1)
            if (Test-SafePackageName -PackageName $candidate) { $packageName = $candidate }
        }
        elseif (Test-SafePackageName -PackageName $payload) {
            $packageName = $payload
        }
        if ([string]::IsNullOrWhiteSpace($packageName)) { continue }
        $type = "No determinado"
        if ($systemLookup.ContainsKey($packageName)) { $type = "Sistema" }
        elseif ($thirdPartyLookup.ContainsKey($packageName)) { $type = "Usuario" }
        $recommendation = Get-AppCleanupRecommendation -PackageName $packageName -ManufacturerFamily $ManufacturerFamily
        $items += [pscustomobject]@{
            PackageName = $packageName
            ApkPath = $apkPath
            AppName = Get-AppFriendlyName -PackageName $packageName
            Type = $type
            Recommendation = $recommendation.Status
            RecommendationReason = $recommendation.Reason
            ManufacturerFamily = $ManufacturerFamily
        }
    }
    return @($items | Sort-Object PackageName -Unique)
}

function Get-AdbPackageNamesFromOutput {
    param([string[]]$Lines)
    $names = @()
    foreach ($line in $Lines) {
        $text = "$line".Trim()
        if (-not $text.StartsWith("package:")) { continue }
        $candidate = $text.Substring(8)
        if (Test-SafePackageName -PackageName $candidate) { $names += $candidate }
    }
    return @($names | Sort-Object -Unique)
}

function Export-AdbAppInventory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string]$AdbPath,
        [Parameter(Mandatory=$true)][string]$Serial,
        [Parameter(Mandatory=$true)][string]$OutputDirectory
    )
    $allOutput = @(& $AdbPath -s $Serial shell pm list packages -f 2>&1)
    $allExit = $LASTEXITCODE
    if ($allExit -ne 0) { throw "No se pudo obtener el inventario ADB: $($allOutput -join ' ')" }
    $systemOutput = @(& $AdbPath -s $Serial shell pm list packages -s 2>&1)
    $systemExit = $LASTEXITCODE
    if ($systemExit -ne 0) { throw "No se pudo clasificar las aplicaciones del sistema: $($systemOutput -join ' ')" }
    $thirdPartyOutput = @(& $AdbPath -s $Serial shell pm list packages -3 2>&1)
    $thirdPartyExit = $LASTEXITCODE
    if ($thirdPartyExit -ne 0) { throw "No se pudo clasificar las aplicaciones de usuario: $($thirdPartyOutput -join ' ')" }

    $manufacturer = @(& $AdbPath -s $Serial shell getprop ro.product.manufacturer 2>&1) -join ""
    $brand = @(& $AdbPath -s $Serial shell getprop ro.product.brand 2>&1) -join ""
    $model = @(& $AdbPath -s $Serial shell getprop ro.product.model 2>&1) -join ""
    $android = @(& $AdbPath -s $Serial shell getprop ro.build.version.release 2>&1) -join ""
    $manufacturerFamily = Get-AdbManufacturerFamily -AdbPath $AdbPath -Serial $Serial
    $serialMasked = if ($Serial.Length -le 4) { "*" * $Serial.Length } else { ("*" * ($Serial.Length - 4)) + $Serial.Substring($Serial.Length - 4) }
    $apps = @(ConvertFrom-AdbPackageInventory -PackageLines $allOutput -SystemPackages (Get-AdbPackageNamesFromOutput -Lines $systemOutput) -ThirdPartyPackages (Get-AdbPackageNamesFromOutput -Lines $thirdPartyOutput) -ManufacturerFamily $manufacturerFamily)
    if ($apps.Count -eq 0) { throw "ADB no devolvió paquetes reconocibles; no se generó ningún archivo." }
    if (-not (Test-Path -LiteralPath $OutputDirectory -PathType Container)) {
        New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    }
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $baseName = "FDTOOL-AppInventory-$stamp"
    $csvPath = Join-Path $OutputDirectory ($baseName + ".csv")
    $jsonPath = Join-Path $OutputDirectory ($baseName + ".json")
    $metadata = [ordered]@{
        Application = "FDTOOL V2"
        ExportDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")
        Manufacturer = $manufacturer.Trim()
        Brand = $brand.Trim()
        ManufacturerFamily = $manufacturerFamily
        Model = $model.Trim()
        AndroidVersion = $android.Trim()
        SerialMasked = $serialMasked
        AppCount = $apps.Count
        Privacy = "No app data, contacts, messages, account credentials or full serial number collected."
        Apps = @($apps)
    }
    $apps | Select-Object PackageName, AppName, Type, ApkPath, Recommendation, RecommendationReason, ManufacturerFamily |
        Export-Csv -LiteralPath $csvPath -NoTypeInformation -Encoding UTF8
    $metadata | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $jsonPath -Encoding UTF8
    return [pscustomobject]@{ CsvPath = $csvPath; JsonPath = $jsonPath; AppCount = $apps.Count; Manufacturer = $manufacturer.Trim(); Model = $model.Trim() }
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
        Write-Host "  1. Listar aplicaciones del sistema (nombre + paquete)"
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
                    $friendlyName = Get-AppFriendlyName -PackageName $item.PackageName
                    Write-Host ("  {0,-14} {1,-30} {2,-48} {3}" -f $tag, $item.Recommendation.Status, $friendlyName, $item.PackageName) -ForegroundColor $color
                    if ($item.Recommendation.Status -eq "Opcional - revisar") { Write-Host ("                  Motivo: {0}" -f $item.Recommendation.Reason) -ForegroundColor DarkGray }
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
            Write-Host "  Candidatas: las no protegidas siguen requiriendo revisión individual." -ForegroundColor Yellow
            for ($i = 0; $i -lt $removable.Count; $i++) {
                $friendlyName = Get-AppFriendlyName -PackageName $removable[$i].PackageName
                Write-Host ("  [{0}] [{1}] {2}  ({3})" -f ($i + 1), $removable[$i].Recommendation.Status, $friendlyName, $removable[$i].PackageName)
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
            $selectedName = Get-AppFriendlyName -PackageName $selected
            Write-Host ("  Aplicación: {0}" -f $selectedName) -ForegroundColor Cyan
            $recommendation = Get-AppCleanupRecommendation -PackageName $selected -ManufacturerFamily (Get-AdbManufacturerFamily -AdbPath $AdbPath -Serial $Serial)
            Write-Host ("  Evaluación FDTOOL: {0}" -f $recommendation.Status) -ForegroundColor Yellow
            Write-Host ("  Motivo: {0}" -f $recommendation.Reason) -ForegroundColor DarkGray
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
