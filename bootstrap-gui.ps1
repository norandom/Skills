#requires -Version 5
<#
.SYNOPSIS
Streams a native Windows GUI that installs or updates the Skills repo.

.DESCRIPTION
Run directly from GitHub without first downloading an installer:

  irm https://raw.githubusercontent.com/norandom/Skills/main/bootstrap-gui.ps1 | iex

The launcher itself is fileless, but the repo is intentionally persisted under
%LOCALAPPDATA%\Skills (or SKILLS_HOME) as the update source for the managed
skill copies. Re-running this command refreshes the source before opening the
installer.

Env overrides:
  SKILLS_HOME   where to unpack      (default: %LOCALAPPDATA%\Skills)
  SKILLS_REPO   owner/name           (default: norandom/Skills)
  SKILLS_REF    branch, tag, or SHA  (default: main)
#>
[CmdletBinding()]
param([switch]$GuiSmokeTest)

$ErrorActionPreference = 'Stop'

function Show-BootstrapError {
    param([Parameter(Mandatory)][string]$Message)
    try {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            $Message, 'Skills Installer',
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    } catch {
        Write-Error $Message
    }
}

$progressForm = $null
$tmp = $null
try {
    try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 } catch {}
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Repo = if ($env:SKILLS_REPO) { $env:SKILLS_REPO } else { 'norandom/Skills' }
    $Ref  = if ($env:SKILLS_REF)  { $env:SKILLS_REF }  else { 'main' }
    $Dest = if ($env:SKILLS_HOME) { $env:SKILLS_HOME } else { Join-Path $env:LOCALAPPDATA 'Skills' }
    if (-not $Dest) { throw 'Could not determine the install directory. Set SKILLS_HOME and try again.' }

    $progressForm = New-Object System.Windows.Forms.Form
    $progressForm.Text = 'Skills Installer'
    $progressForm.ClientSize = New-Object System.Drawing.Size(430, 105)
    $progressForm.StartPosition = 'CenterScreen'
    $progressForm.FormBorderStyle = 'FixedDialog'
    $progressForm.ControlBox = $false
    $progressForm.TopMost = $true

    $status = New-Object System.Windows.Forms.Label
    $status.Location = New-Object System.Drawing.Point(18, 18)
    $status.Size = New-Object System.Drawing.Size(394, 22)
    $status.Text = "Downloading Skills ($Repo@$Ref)..."

    $bar = New-Object System.Windows.Forms.ProgressBar
    $bar.Location = New-Object System.Drawing.Point(18, 55)
    $bar.Size = New-Object System.Drawing.Size(394, 18)
    $bar.Style = 'Marquee'
    $bar.MarqueeAnimationSpeed = 25
    $progressForm.Controls.AddRange(@($status, $bar))
    $progressForm.Show()
    $progressForm.Refresh()
    [System.Windows.Forms.Application]::DoEvents()

    $Url = "https://github.com/$Repo/archive/$Ref.zip"
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ('skills-' + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Force -Path $tmp -Confirm:$false | Out-Null
    $zip = Join-Path $tmp 'src.zip'
    Invoke-WebRequest -Uri $Url -OutFile $zip -UseBasicParsing

    $status.Text = "Updating $Dest..."
    $progressForm.Refresh()
    [System.Windows.Forms.Application]::DoEvents()
    Expand-Archive -Path $zip -DestinationPath $tmp -Force -Confirm:$false

    $extracted = Get-ChildItem -Path $tmp -Directory | Select-Object -First 1
    if (-not $extracted) { throw 'The downloaded archive did not contain a source directory.' }
    New-Item -ItemType Directory -Force -Path $Dest -Confirm:$false | Out-Null
    Copy-Item -Path (Join-Path $extracted.FullName '*') -Destination $Dest -Recurse -Force -Confirm:$false

    $gui = Join-Path $Dest 'install-gui.ps1'
    if (-not (Test-Path -LiteralPath $gui -PathType Leaf)) {
        throw "The downloaded repo does not contain install-gui.ps1: $Dest"
    }

    $progressForm.Close()
    $progressForm.Dispose()
    $progressForm = $null
    if ($GuiSmokeTest) {
        & $gui -GuiSmokeTest
    } else {
        & $gui -NoConsoleFallback
    }
} catch {
    if ($progressForm) {
        $progressForm.Close()
        $progressForm.Dispose()
    }
    Show-BootstrapError -Message ("Installation failed.`r`n`r`n" + $_.Exception.Message)
} finally {
    if ($tmp) { Remove-Item -LiteralPath $tmp -Recurse -Force -Confirm:$false -ErrorAction SilentlyContinue }
}
