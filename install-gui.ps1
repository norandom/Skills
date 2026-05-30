# install-gui.ps1 — point-and-click installer for Windows (WinForms).
#
# Launch by double-clicking install-gui.cmd (a .ps1 opens in an editor on
# double-click; the .cmd shim runs it with the right execution policy).
#
# Wraps the same lib.ps1 logic install.ps1 uses, behind a native dialog:
#   choose Install/Uninstall, tick tools and skills, Preview the dry run,
#   then Apply. Falls back to a console wizard if WinForms is unavailable.
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib.ps1')

# ---- target table: keep in lockstep with install.ps1 -----------------------
$Targets = @(
    [pscustomobject]@{ Key='claude';   Name='Claude Code';     Path=(Join-UserProfile '.claude') }
    [pscustomobject]@{ Key='hermes';   Name='Hermes';          Path=(Join-UserProfile '.hermes') }
    [pscustomobject]@{ Key='opencode'; Name='opencode';        Path=(Join-UserProfile '.config\opencode') }
    [pscustomobject]@{ Key='deepseek'; Name='DeepSeek TUI';    Path=(Join-UserProfile '.deepseek') }
    [pscustomobject]@{ Key='agy';      Name='Antigravity CLI'; Path=(Join-UserProfile '.gemini\antigravity-cli') }
)

# Run the chosen action over the selected tools, capturing all host output.
function Invoke-Run {
    param([bool]$DryRun, [string]$Mode, [string[]]$Tools, [string[]]$Skills)
    $script:LibDryRun = $DryRun
    $script:LibSkills = $Skills
    $sb = {
        if ($Mode -eq 'Install') { [void](Test-SkillDescriptions) }
        foreach ($t in ($Targets | Where-Object { $Tools -contains $_.Key })) {
            if ($Mode -eq 'Install') { Install-LibTarget -Label $t.Key -Parent $t.Path }
            else                     { Uninstall-LibTarget -Label $t.Key -Parent $t.Path }
        }
    }
    return (& $sb *>&1 | Out-String)
}

# ---- console fallback -------------------------------------------------------
function Start-ConsoleWizard {
    Write-Host "Skills Installer`n"
    $mode = if ((Read-Host "1) Install  2) Uninstall  [1]") -eq '2') { 'Uninstall' } else { 'Install' }

    Write-Host "`nTools (parent dir detected marked *):"
    foreach ($t in $Targets) {
        $mark = if (Test-Path -LiteralPath $t.Path) { '*' } else { ' ' }
        Write-Host ("  {0} {1,-10} {2}" -f $mark, $t.Key, $t.Path)
    }
    $ans = Read-Host "Tool keys to use (space-separated, blank = all detected)"
    $tools = if ($ans.Trim()) { $ans -split '\s+' } else { ($Targets | Where-Object { Test-Path -LiteralPath $_.Path }).Key }

    $allSkills = @(Get-SkillNames)
    Write-Host "`nSkills: $($allSkills -join ', ')"
    $ans = Read-Host "Skill names to link (space-separated, blank = all)"
    $skills = if ($ans.Trim()) { $ans -split '\s+' } else { $allSkills }

    Write-Host "`n----- preview (dry run) -----"
    Write-Host (Invoke-Run -DryRun $true -Mode $mode -Tools $tools -Skills $skills)
    if ((Read-Host "Apply these changes? [y/N]") -notmatch '^[Yy]') { Write-Host 'Cancelled.'; return }

    Write-Host "`n$mode complete.`n"
    Write-Host (Invoke-Run -DryRun $false -Mode $mode -Tools $tools -Skills $skills)
}

# ---- WinForms wizard --------------------------------------------------------
function Start-GuiWizard {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Skills Installer'
    $form.Size = New-Object System.Drawing.Size(560, 620)
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = 'FixedDialog'
    $form.MaximizeBox = $false

    $modeLabel = New-Object System.Windows.Forms.Label
    $modeLabel.Text = 'Action'; $modeLabel.Location = '16,14'; $modeLabel.AutoSize = $true
    $form.Controls.Add($modeLabel)

    $rbInstall = New-Object System.Windows.Forms.RadioButton
    $rbInstall.Text = 'Install'; $rbInstall.Location = '90,12'; $rbInstall.Checked = $true; $rbInstall.AutoSize = $true
    $rbUninstall = New-Object System.Windows.Forms.RadioButton
    $rbUninstall.Text = 'Uninstall'; $rbUninstall.Location = '180,12'; $rbUninstall.AutoSize = $true
    $form.Controls.AddRange(@($rbInstall, $rbUninstall))

    $toolsLabel = New-Object System.Windows.Forms.Label
    $toolsLabel.Text = 'Tools (detected ones pre-checked)'; $toolsLabel.Location = '16,46'; $toolsLabel.AutoSize = $true
    $form.Controls.Add($toolsLabel)

    $toolsList = New-Object System.Windows.Forms.CheckedListBox
    $toolsList.Location = '16,68'; $toolsList.Size = New-Object System.Drawing.Size(516, 130)
    $toolsList.CheckOnClick = $true
    foreach ($t in $Targets) {
        $detected = Test-Path -LiteralPath $t.Path
        $suffix = if ($detected) { "($($t.Path))" } else { "(not detected: $($t.Path))" }
        [void]$toolsList.Items.Add("$($t.Key) — $($t.Name) $suffix", $detected)
    }
    $form.Controls.Add($toolsList)

    $skillsLabel = New-Object System.Windows.Forms.Label
    $skillsLabel.Text = 'Skills'; $skillsLabel.Location = '16,208'; $skillsLabel.AutoSize = $true
    $form.Controls.Add($skillsLabel)

    $skillsList = New-Object System.Windows.Forms.CheckedListBox
    $skillsList.Location = '16,230'; $skillsList.Size = New-Object System.Drawing.Size(516, 210)
    $skillsList.CheckOnClick = $true
    foreach ($s in (Get-SkillNames)) { [void]$skillsList.Items.Add($s, $true) }
    $form.Controls.Add($skillsList)

    $preview = New-Object System.Windows.Forms.Button
    $preview.Text = 'Preview (dry run)'; $preview.Location = '16,452'; $preview.Size = '150,30'
    $apply = New-Object System.Windows.Forms.Button
    $apply.Text = 'Apply'; $apply.Location = '350,452'; $apply.Size = '90,30'
    $cancel = New-Object System.Windows.Forms.Button
    $cancel.Text = 'Cancel'; $cancel.Location = '442,452'; $cancel.Size = '90,30'
    $cancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancel
    $form.Controls.AddRange(@($preview, $apply, $cancel))

    $output = New-Object System.Windows.Forms.TextBox
    $output.Location = '16,492'; $output.Size = New-Object System.Drawing.Size(516, 80)
    $output.Multiline = $true; $output.ScrollBars = 'Vertical'; $output.ReadOnly = $true
    $output.Font = New-Object System.Drawing.Font('Consolas', 8)
    $form.Controls.Add($output)

    $getSel = {
        $mode = if ($rbUninstall.Checked) { 'Uninstall' } else { 'Install' }
        $tools = @()
        foreach ($i in $toolsList.CheckedIndices) { $tools += $Targets[$i].Key }
        $skills = @($skillsList.CheckedItems)
        [pscustomobject]@{ Mode=$mode; Tools=$tools; Skills=$skills }
    }

    $preview.Add_Click({
        $s = & $getSel
        if (-not $s.Tools) { [System.Windows.Forms.MessageBox]::Show('Pick at least one tool.'); return }
        $output.Text = (Invoke-Run -DryRun $true -Mode $s.Mode -Tools $s.Tools -Skills $s.Skills)
    })

    $apply.Add_Click({
        $s = & $getSel
        if (-not $s.Tools) { [System.Windows.Forms.MessageBox]::Show('Pick at least one tool.'); return }
        if (-not $s.Skills) { [System.Windows.Forms.MessageBox]::Show('Pick at least one skill.'); return }
        $text = (Invoke-Run -DryRun $false -Mode $s.Mode -Tools $s.Tools -Skills $s.Skills)
        $output.Text = $text
        [System.Windows.Forms.MessageBox]::Show("$($s.Mode) complete.", 'Skills Installer') | Out-Null
    })

    [void]$form.ShowDialog()
    $form.Dispose()
}

try {
    Start-GuiWizard
} catch {
    Write-Warning "GUI unavailable ($($_.Exception.Message)); falling back to console."
    Start-ConsoleWizard
}
