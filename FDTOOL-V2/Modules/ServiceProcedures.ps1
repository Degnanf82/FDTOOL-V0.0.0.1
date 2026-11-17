# FDTOOL V2 - Local service procedure compatibility matcher
# Catalog entries are data only. This module never executes procedure steps.

function Import-ServiceProcedureCatalog {
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "No existe el catálogo: $Path" }
    $catalog = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
    if (-not $catalog.schemaVersion -or $null -eq $catalog.procedures) { throw "Formato de catálogo no válido." }
    foreach ($procedure in $catalog.procedures) {
        foreach ($required in @("id","title","category","status","match","summary","steps","source")) {
            if ($null -eq $procedure.$required) { throw "Procedimiento '$($procedure.id)' sin campo obligatorio '$required'." }
        }
        if ($procedure.status -notin @("verified","limited","research","deprecated")) {
            throw "Estado no permitido en procedimiento '$($procedure.id)'."
        }
        if ($procedure.steps.Count -lt 1 -or -not $procedure.source.url) {
            throw "Procedimiento '$($procedure.id)' sin pasos o fuente."
        }
    }
    return $catalog
}

function Test-ProcedureDeviceMatch {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]$Procedure,
        [Parameter(Mandatory=$true)]$Device
    )
    $manufacturer = [string]$Device.ManufacturerFamily
    $model = [string]$Device.Model
    $codename = [string]$Device.DeviceCodename
    $android = [string]$Device.AndroidVersion
    $match = $Procedure.match
    $manufacturerMatch = @($match.manufacturers | Where-Object { $_ -ieq $manufacturer }).Count -gt 0
    if (-not $manufacturerMatch) {
        return [pscustomobject]@{ ProcedureId=$Procedure.id; MatchLevel="no-match"; Compatible=$false; ReviewRequired=$true; CanAutomate=$false; Reason="Fabricante/familia no incluido en el procedimiento." }
    }

    $hasModelRules = (@($match.models).Count -gt 0) -or (@($match.modelCodes).Count -gt 0)
    $modelMatch = $false
    if (@($match.models).Count -gt 0) {
        $modelMatch = @($match.models | Where-Object { $_ -ieq $model }).Count -gt 0
    }
    if (@($match.modelCodes).Count -gt 0 -and $codename -and $codename -ne "Unknown") {
        $modelMatch = $modelMatch -or (@($match.modelCodes | Where-Object { $_ -ieq $codename }).Count -gt 0)
    }
    if ($hasModelRules -and -not $modelMatch) {
        return [pscustomobject]@{ ProcedureId=$Procedure.id; MatchLevel="no-match"; Compatible=$false; ReviewRequired=$true; CanAutomate=$false; Reason="El modelo/codename no coincide con los identificadores declarados." }
    }

    if (@($match.androidVersions).Count -gt 0 -and $android -and $android -ne "Unknown") {
        if (@($match.androidVersions | Where-Object { $_ -ieq $android }).Count -eq 0) {
            return [pscustomobject]@{ ProcedureId=$Procedure.id; MatchLevel="no-match"; Compatible=$false; ReviewRequired=$true; CanAutomate=$false; Reason="La versión Android no está incluida." }
        }
    }
    elseif (@($match.androidVersions).Count -gt 0) {
        return [pscustomobject]@{ ProcedureId=$Procedure.id; MatchLevel="review-required"; Compatible=$false; ReviewRequired=$true; CanAutomate=$false; Reason="Falta la versión Android para validar compatibilidad." }
    }

    $exact = $hasModelRules -and $modelMatch
    $verified = $Procedure.status -eq "verified"
    $level = if ($exact) { "exact-model-match" } else { "family-match" }
    $review = (-not $exact) -or (-not $verified)
    $reason = if ($exact -and $verified) { "Modelo coincidente y procedimiento marcado verified; revisar requisitos y fuente antes de cualquier acción." } elseif ($exact) { "Modelo coincidente, pero el procedimiento no está verificado para ejecución." } else { "Coincidencia de familia únicamente; confirmar modelo, variante y región manualmente." }
    [pscustomobject]@{
        ProcedureId=$Procedure.id
        MatchLevel=$level
        Compatible=$true
        ReviewRequired=$review
        CanAutomate=($exact -and $verified -and $Procedure.connection -in @("adb-read-only","fastboot-read-only","none"))
        Reason=$reason
    }
}

function Get-CompatibleServiceProcedures {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]$Catalog,
        [Parameter(Mandatory=$true)]$Device
    )
    foreach ($procedure in $Catalog.procedures) {
        $result = Test-ProcedureDeviceMatch -Procedure $procedure -Device $Device
        if ($result.Compatible -or $result.MatchLevel -eq "review-required") {
            [pscustomobject]@{ Procedure=$procedure; Match=$result }
        }
    }
}
