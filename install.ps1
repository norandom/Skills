#requires -Version 5
<#
.SYNOPSIS
Symlink every skill folder into each selected tool's skills\ dir.

.DESCRIPTION
Targets (default -All; only dirs whose parent exists get touched):
  -Claude          %USERPROFILE%\.claude\skills                       (Claude Code)
  -Hermes          %USERPROFILE%\.hermes\skills
  -Opencode        %USERPROFILE%\.config\opencode\skills
  -Deepseek        %USERPROFILE%\.deepseek\skills                     (DeepSeek TUI)
  -Agy             %USERPROFILE%\.gemini\antigravity-cli\skills       (Antigravity CLI)
  -All             every target above

Flags:
  -DryRun     preview without changing anything
  -Force      replace existing entries at the destination
  -Uninstall  remove links instead of creating them

Symlinks need either Developer Mode (Settings > Privacy & security > For
developers) or an elevated PowerShell session. Without either, the script
falls back to NTFS directory junctions, which work without elevation and
behave the same for skill discovery.

.EXAMPLE
.\install.ps1                       # auto-detect every tool whose dir exists
.\install.ps1 -Claude -Opencode     # just these two
.\install.ps1 -DryRun               # preview
.\install.ps1 -Force                # replace whatever's there
.\install.ps1 -Uninstall -All       # tear down
#>
[CmdletBinding()]
param(
    [switch]$Claude,
    [switch]$Hermes,
    [switch]$Opencode,
    [switch]$Deepseek,
    [switch]$Agy,
    [switch]$All,
    [switch]$DryRun,
    [switch]$Force,
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib.ps1')

$script:LibDryRun = [bool]$DryRun
$script:LibForce  = [bool]$Force

$explicit = $Claude -or $Hermes -or $Opencode -or $Deepseek -or $Agy -or $All
if (-not $explicit -or $All) {
    $Claude = $true; $Hermes = $true
    $Opencode = $true; $Deepseek = $true; $Agy = $true
}

if (-not $Uninstall) {
    if (-not (Test-SkillDescriptions)) {
        Write-Host '       (linking anyway; trim the description or these skills will not load in Claude Code)'
    }
}

$action = if ($Uninstall) { 'Uninstall-LibTarget' } else { 'Install-LibTarget' }

if ($Claude)        { & $action 'claude'         (Join-UserProfile '.claude') }
if ($Hermes)        { & $action 'hermes'         (Join-UserProfile '.hermes') }
if ($Opencode)      { & $action 'opencode'       (Join-UserProfile '.config\opencode') }
if ($Deepseek)      { & $action 'deepseek'       (Join-UserProfile '.deepseek') }
if ($Agy)           { & $action 'agy'            (Join-UserProfile '.gemini\antigravity-cli') }
