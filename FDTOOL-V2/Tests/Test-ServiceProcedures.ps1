# Lightweight tests for service procedure catalog and compatibility matcher
[CmdletBinding()]
param()
$root = Split-Path -Parent $PSScriptRoot
. (Join-Path $root "Modules\ServiceProcedures.ps1")
$catalogPath = Join-Path $root "Data\service-procedures.json"
$catalog = Import-ServiceProcedureCatalog -Path $catalogPath
$device = [pscustomobject]@{ ManufacturerFamily="Samsung"; Model="SM-A546B"; DeviceCodename="a54x"; AndroidVersion="14" }
$match = @(Get-CompatibleServiceProcedures -Catalog $catalog -Device $device)
if ($match.Count -ne 1) { throw "Expected one family-compatible diagnostic procedure, got $($match.Count)." }
if ($match[0].Match.MatchLevel -ne "family-match") { throw "Expected family-match, got '$($match[0].Match.MatchLevel)'." }
if ($match[0].Match.CanAutomate) { throw "Limited manual procedure must never be automatable." }
$unknown = [pscustomobject]@{ ManufacturerFamily="Unknown OEM"; Model="Unknown"; DeviceCodename="Unknown"; AndroidVersion="Unknown" }
$unknownMatch = @(Get-CompatibleServiceProcedures -Catalog $catalog -Device $unknown)
if ($unknownMatch.Count -ne 0) { throw "Unknown manufacturer must not receive a compatible procedure." }
$invalidPath = Join-Path $env:TEMP "fdtool-invalid-catalog.json"
'{"schemaVersion":"1.0.0","procedures":[{"id":"broken"}]}' | Set-Content -LiteralPath $invalidPath -Encoding UTF8
$thrown = $false
try { Import-ServiceProcedureCatalog -Path $invalidPath | Out-Null } catch { $thrown = $true }
Remove-Item -LiteralPath $invalidPath -Force -ErrorAction SilentlyContinue
if (-not $thrown) { throw "Invalid catalog should be rejected." }
Write-Host "All service procedure tests passed." -ForegroundColor Green
