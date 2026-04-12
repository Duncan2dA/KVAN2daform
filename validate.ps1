$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$errors = New-Object System.Collections.Generic.List[string]

function Assert-Exists {
    param(
        [string]$Path,
        [string]$Message
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        $errors.Add($Message)
    }
}

Assert-Exists (Join-Path $root 'index.html') 'Ontbreekt: root index.html'
Assert-Exists (Join-Path $root 'CNAME') 'Ontbreekt: CNAME'
Assert-Exists (Join-Path $root 'img') 'Ontbreekt: img-map'
Assert-Exists (Join-Path $root 'oud') 'Ontbreekt: oud-map'

$cnamePath = Join-Path $root 'CNAME'
if (Test-Path -LiteralPath $cnamePath) {
    $cname = (Get-Content -LiteralPath $cnamePath -Raw).Trim()
    if ($cname -ne 'www.archiefdag.nl') {
        $errors.Add("CNAME is ongeldig: '$cname'")
    }
}

$rootIndexPath = Join-Path $root 'index.html'
if (Test-Path -LiteralPath $rootIndexPath) {
    $rootIndex = Get-Content -LiteralPath $rootIndexPath -Raw

    foreach ($pattern in @(
        'Kom werken bij 2dA!',
        'Banenmarkt Rijk van Nijmegen',
        'Dinsdag 10 maart 2026',
        'formspree.io'
    )) {
        if ($rootIndex -notmatch [regex]::Escape($pattern)) {
            $errors.Add("Verwachte inhoud niet gevonden in root index.html: $pattern")
        }
    }
}

$allIndexFiles = Get-ChildItem -LiteralPath $root -Recurse -Filter 'index.html' -File
$unexpectedIndexFiles = $allIndexFiles | Where-Object {
    $_.FullName -ne $rootIndexPath -and $_.FullName -notlike (Join-Path $root 'oud\*')
}

foreach ($file in $unexpectedIndexFiles) {
    $errors.Add("Onverwachte extra index.html buiten oud/: $($file.FullName)")
}

if ($errors.Count -gt 0) {
    Write-Host 'VALIDATIE GEFAALD' -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host 'VALIDATIE OK' -ForegroundColor Green
Write-Host '- Root index.html aanwezig'
Write-Host '- CNAME correct'
Write-Host '- Geen extra actieve index.html-bestanden gevonden'
Write-Host '- Verwachte hoofdinhoud aanwezig'
