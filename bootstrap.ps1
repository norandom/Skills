#requires -Version 5
<#
.SYNOPSIS
One command to install *and* update the Skills repo on Windows. No git needed.

.DESCRIPTION
Downloads the latest source zip from GitHub, unpacks it to a managed location,
then installs managed copies of the skills into your tools. Re-running is also
how you update: it re-downloads the latest and refreshes those copies. Install
and update are the same command.

  # download and run (pass install.ps1 flags as needed):
  irm https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.ps1 | iex

  # or, to pass flags, save then run:
  iwr https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.ps1 -OutFile bootstrap.ps1
  ./bootstrap.ps1 -Claude

Env overrides:
  SKILLS_HOME   where to unpack      (default: %LOCALAPPDATA%\Skills)
  SKILLS_REPO   owner/name           (default: norandom/Skills)
  SKILLS_REF    branch, tag, or SHA  (default: main)
#>
param([Parameter(ValueFromRemainingArguments = $true)] $InstallArgs)

$ErrorActionPreference = 'Stop'
# GitHub requires TLS 1.2; Windows PowerShell 5.1 may still default lower.
try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 } catch {}

$Repo = if ($env:SKILLS_REPO) { $env:SKILLS_REPO } else { 'norandom/Skills' }
$Ref  = if ($env:SKILLS_REF)  { $env:SKILLS_REF }  else { 'main' }
$Dest = if ($env:SKILLS_HOME) { $env:SKILLS_HOME } else { Join-Path $env:LOCALAPPDATA 'Skills' }
$Url  = "https://github.com/$Repo/archive/$Ref.zip"   # works for branch, tag, or SHA

$tmp = Join-Path ([IO.Path]::GetTempPath()) ('skills-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path $tmp -Confirm:$false | Out-Null
try {
    $zip = Join-Path $tmp 'src.zip'
    Write-Host "Downloading Skills ($Repo@$Ref) -> $Dest"
    Invoke-WebRequest -Uri $Url -OutFile $zip -UseBasicParsing
    Expand-Archive -Path $zip -DestinationPath $tmp -Force -Confirm:$false

    # The zip unpacks to a single "<repo>-<ref>" folder; copy its contents to $Dest.
    $extracted = Get-ChildItem -Path $tmp -Directory | Select-Object -First 1
    New-Item -ItemType Directory -Force -Path $Dest -Confirm:$false | Out-Null
    Copy-Item -Path (Join-Path $extracted.FullName '*') -Destination $Dest -Recurse -Force -Confirm:$false
} finally {
    Remove-Item -Recurse -Force $tmp -Confirm:$false -ErrorAction SilentlyContinue
}

Write-Host "`nInstalling skills..."
& (Join-Path $Dest 'install.ps1') @InstallArgs
