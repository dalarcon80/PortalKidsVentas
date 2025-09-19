
$ErrorActionPreference = "Stop"
$share = "\\34.134.152.136\misiones"
$clientZip = Join-Path $share "starter\client.zip"
$destDir = "C:\MinecraftShop"
$projDir = Join-Path $destDir "minecraft_shop_project"
$kidsView = Join-Path $projDir "docs\KIDS_START_VIEW.md"
if (!(Test-Path $clientZip)) { Write-Host "No encuentro $clientZip en el share."; exit 1 }
if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir | Out-Null }
$tmpZip = Join-Path $env:TEMP "client.zip"
Copy-Item -Path $clientZip -Destination $tmpZip -Force
if (Test-Path $projDir) { Remove-Item -Recurse -Force $projDir }
Expand-Archive -LiteralPath $tmpZip -DestinationPath $destDir -Force
Start-Process notepad.exe $kidsView
Write-Host "Listo. Proyecto en $projDir y guía abierta." -ForegroundColor Green
