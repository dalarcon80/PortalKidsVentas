
param(
  [Parameter(Mandatory=$true)][string]$PortalPath,
  [Parameter(Mandatory=$true)][string]$VaultPath,
  [Parameter(Mandatory=$true)][string]$Salt,
  [Parameter(Mandatory=$true)][string]$VentasCodename,
  [Parameter(Mandatory=$true)][string]$OpsCodename
)
function Get-Hash16([string]$text){
  $sha1=[System.Security.Cryptography.SHA1]::Create()
  $bytes=[System.Text.Encoding]::UTF8.GetBytes($text)
  $hash=$sha1.ComputeHash($bytes)
  ($hash|%{ $_.ToString('x2') }) -join '' | Out-Null
  $hex=($hash|%{ $_.ToString('x2') }) -join ''
  return $hex.Substring(0,16)
}
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$tplRoot = Join-Path $here "..\..\templates\missions"

$combos = @(
  @{Role='VENTAS'; Prev='M1'; Code='M2'; Codename=$VentasCodename},
  @{Role='OPERACIONES'; Prev='M1'; Code='M2'; Codename=$OpsCodename},
  @{Role='VENTAS'; Prev='M2'; Code='M3'; Codename=$VentasCodename},
  @{Role='OPERACIONES'; Prev='M2'; Code='M3'; Codename=$OpsCodename},
  @{Role='VENTAS'; Prev='M3'; Code='V4'; Codename=$VentasCodename},
  @{Role='OPERACIONES'; Prev='M3'; Code='O4'; Codename=$OpsCodename},
  @{Role='VENTAS'; Prev='M4'; Code='V5'; Codename=$VentasCodename},
  @{Role='OPERACIONES'; Prev='M4'; Code='O5'; Codename=$OpsCodename},
  @{Role='VENTAS'; Prev='M5'; Code='V6'; Codename=$VentasCodename},
  @{Role='OPERACIONES'; Prev='M5'; Code='O6'; Codename=$OpsCodename},
  @{Role='VENTAS'; Prev='M6'; Code='F1'; Codename=$VentasCodename},
  @{Role='OPERACIONES'; Prev='M6'; Code='F1'; Codename=$OpsCodename}
)

New-Item -ItemType Directory -Path $PortalPath -Force | Out-Null

foreach($x in $combos){
  $hash = Get-Hash16("$($x.Role):$($x.Prev):$($x.Codename):$Salt")
  $dst  = Join-Path $PortalPath $hash
  New-Item -ItemType Directory -Path $dst -Force | Out-Null

  $mdSrc = Join-Path $tplRoot "$($x.Code).md"
  $mdTxt = Get-Content $mdSrc -Raw -Encoding UTF8

  # 1) Guardar el MD en el baúl (para que 'next' lo copie al proyecto)
  $mdOut = Join-Path $VaultPath ($hash + ".md")
  Set-Content -Path $mdOut -Value $mdTxt -Encoding UTF8

  # 2) Generar HTML amigable
  $html = @"
<!doctype html><html><head><meta charset="utf-8">
<title>$($x.Code) — Tienda de Bloques</title>
<style>
body{font-family:Arial,Helvetica,sans-serif;max-width:900px;margin:40px auto;line-height:1.6}
pre{white-space:pre-wrap;background:#f6f8fa;padding:12px;border-radius:8px}
.notice{background:#fff7cc;padding:8px;border-radius:6px;border:1px solid #e5d87b}
</style>
</head><body>
<h1>$($x.Code)</h1>
<p class="notice">Eres <strong>$($x.Role)</strong>. Esta misión se desbloquea después de <strong>$($x.Prev)</strong>.
Vuelve a tu equipo y usa <code>python src/quest.py next</code> para guardar esta misión en <code>docs/next_mission.md</code>.</p>
<pre>$([System.Net.WebUtility]::HtmlEncode($mdTxt))</pre>
<p><a href="/portal/">← Volver al portal</a></p>
</body></html>
"@
  Set-Content -Path (Join-Path $dst "index.html") -Value $html -Encoding UTF8
  Write-Host "Misiones listas: $hash ($($x.Role) -> $($x.Code))"
}

Write-Host "Portal preparado y baúl con MD publicados."
