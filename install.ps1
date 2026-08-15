#requires -Version 5
<#
.SYNOPSIS
Install every skill folder into each selected tool's skills\ dir.

.DESCRIPTION
Targets (default -All; only dirs whose parent exists get touched):
  -Codex           %USERPROFILE%\.codex\skills                       (Codex)
  -Claude          %USERPROFILE%\.claude\skills                       (Claude Code)
  -Hermes          %USERPROFILE%\.hermes\skills
  -Opencode        %USERPROFILE%\.config\opencode\skills
  -Deepseek        %USERPROFILE%\.deepseek\skills                     (DeepSeek TUI)
  -Agy             %USERPROFILE%\.gemini\antigravity-cli\skills       (Antigravity CLI)
  -All             every target above

Flags:
  -DryRun     preview without changing anything
  -Force      replace existing entries at the destination
  -Link       use directory links instead of managed copies
  -Uninstall  remove installer-managed copies or links

Windows installs managed directory copies by default, so Developer Mode and
administrator rights are not required. Re-run the installer to refresh those
copies after updating the source. -Link retains the old link-based behavior;
it prefers symbolic links and falls back to NTFS directory junctions.

.EXAMPLE
.\install.ps1                       # auto-detect every tool whose dir exists
.\install.ps1 -Codex -Claude        # just these two
.\install.ps1 -DryRun               # preview
.\install.ps1 -Force                # replace whatever's there
.\install.ps1 -Link                 # opt into links instead of copies
.\install.ps1 -Uninstall -All       # tear down
#>
[CmdletBinding()]
param(
    [switch]$Codex,
    [switch]$Claude,
    [switch]$Hermes,
    [switch]$Opencode,
    [switch]$Deepseek,
    [switch]$Agy,
    [switch]$All,
    [switch]$DryRun,
    [switch]$Force,
    [switch]$Link,
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
# Updates are intentionally unattended. This is scoped to the script process
# and prevents PowerShell profiles or caller preferences from prompting once
# per skill for installer-owned replace operations.
$ConfirmPreference = 'None'
. (Join-Path $PSScriptRoot 'lib.ps1')

$script:LibDryRun = [bool]$DryRun
$script:LibForce  = [bool]$Force
$script:LibUseLinks = [bool]$Link

$explicit = $Codex -or $Claude -or $Hermes -or $Opencode -or $Deepseek -or $Agy -or $All
if (-not $explicit -or $All) {
    $Codex = $true; $Claude = $true; $Hermes = $true
    $Opencode = $true; $Deepseek = $true; $Agy = $true
}

if (-not $Uninstall) {
    if (-not (Test-SkillDescriptions)) {
        Write-Host '       (installing anyway; trim the description or these skills will not load in Claude Code)'
    }
}

$action = if ($Uninstall) { 'Uninstall-LibTarget' } else { 'Install-LibTarget' }

if ($Codex)         { & $action 'codex'          (Join-UserProfile '.codex') }
if ($Claude)        { & $action 'claude'         (Join-UserProfile '.claude') }
if ($Hermes)        { & $action 'hermes'         (Join-UserProfile '.hermes') }
if ($Opencode)      { & $action 'opencode'       (Join-UserProfile '.config\opencode') }
if ($Deepseek)      { & $action 'deepseek'       (Join-UserProfile '.deepseek') }
if ($Agy)           { & $action 'agy'            (Join-UserProfile '.gemini\antigravity-cli') }
