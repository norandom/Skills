# lib.ps1 — shared helpers for install.ps1.
# Dot-source this file; do not execute it directly.
#
# State knobs (set in the caller before invoking helpers):
#   $script:LibDryRun = $true   print actions, do not run them
#   $script:LibForce  = $true   replace existing links/files when linking
#   $env:LIB_DESC_MAX = 1024    override the skill-description char cap

$script:LibRoot    = $PSScriptRoot
$script:LibDescMax = if ($env:LIB_DESC_MAX) { [int]$env:LIB_DESC_MAX } else { 1024 }
if ($null -eq $script:LibDryRun) { $script:LibDryRun = $false }
if ($null -eq $script:LibForce)  { $script:LibForce  = $false }

function Invoke-Lib {
    param([string]$Description, [scriptblock]$Block)
    if ($script:LibDryRun) {
        Write-Host "DRY: $Description"
    } else {
        & $Block
    }
}

# Skills: top-level dirs containing a SKILL.md.
# If $script:LibSkills is set (array of names), only those are emitted, letting a
# caller install/uninstall a chosen subset instead of everything.
function Get-SkillNames {
    Get-ChildItem -LiteralPath $script:LibRoot -Directory -ErrorAction SilentlyContinue |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf } |
        ForEach-Object { $_.Name } |
        Where-Object { -not $script:LibSkills -or ($script:LibSkills -contains $_) }
}

# Extract the YAML `description:` value from a SKILL.md and return its length.
# Handles plain, "quoted", 'quoted', and `>` / `|` folded-block scalar forms.
function Get-SkillDescriptionLength {
    param([Parameter(Mandatory)][string]$Path)
    $buf = ''
    $inBlock = $false
    foreach ($line in (Get-Content -LiteralPath $Path)) {
        if (-not $inBlock) {
            if ($line -match '^description:\s*(.*)$') {
                $rest = $Matches[1]
                $rest = $rest -replace '^[>|][-+]?\s*', ''   # strip block-scalar indicator
                $rest = $rest -replace '^"(.*)"\s*$', '$1'   # strip surrounding double quotes
                $rest = $rest -replace "^'(.*)'\s*$", '$1'   # strip surrounding single quotes
                if ([string]::IsNullOrEmpty($rest)) {
                    $inBlock = $true
                } else {
                    $buf = $rest
                    break
                }
            }
            continue
        }
        if ($line -match '^---\s*$') { break }
        if ($line -match '^\S')      { break }
        $trimmed = $line.TrimStart()
        $buf = if ($buf -eq '') { $trimmed } else { "$buf $trimmed" }
    }
    return $buf.Length
}

# Validate every skill's description against $script:LibDescMax.
# Prints one WARN line per oversize skill and returns $true when all pass.
function Test-SkillDescriptions {
    $ok = $true
    foreach ($name in Get-SkillNames) {
        $file = Join-Path $script:LibRoot "$name/SKILL.md"
        $len  = Get-SkillDescriptionLength -Path $file
        if ($len -gt $script:LibDescMax) {
            Write-Warning ("{0,-24}  description {1} chars > {2} — Claude Desktop / Code will silently drop this skill" -f $name, $len, $script:LibDescMax)
            $ok = $false
        }
    }
    return $ok
}

# Null-safe Join-Path off the user profile. Returns $null when no home is set.
function Join-UserProfile {
    param([Parameter(Mandatory)][string]$Relative)
    $base = if ($env:USERPROFILE) { $env:USERPROFILE } elseif ($env:HOME) { $env:HOME } else { $null }
    if (-not $base) { return $null }
    return (Join-Path $base $Relative)
}

# Normalize an NT-style symlink target ("\??\C:\path") to a plain Win32 path.
function ConvertFrom-NtPath {
    param([string]$P)
    if ($null -eq $P) { return $null }
    return ($P -replace '^\\\?\?\\','')
}

function Test-SameTarget {
    param([string]$A, [string]$B)
    if (-not $A -or -not $B) { return $false }
    try {
        return ([IO.Path]::GetFullPath((ConvertFrom-NtPath $A))) -ieq ([IO.Path]::GetFullPath((ConvertFrom-NtPath $B)))
    } catch { return $false }
}

# Create one directory link, preferring a SymbolicLink and falling back to a
# Junction when SymbolicLink is denied (no Developer Mode / not elevated).
function New-DirLink {
    param([string]$Link, [string]$Target)
    try {
        New-Item -ItemType SymbolicLink -Path $Link -Target $Target -ErrorAction Stop | Out-Null
        return 'symlink'
    } catch {
        New-Item -ItemType Junction -Path $Link -Target $Target -ErrorAction Stop | Out-Null
        return 'junction'
    }
}

# Symlink every skill folder into <parent>\skills\.
# Honors $script:LibDryRun and $script:LibForce.
function Install-LibTarget {
    param([Parameter(Mandatory)][string]$Label, [string]$Parent)
    if ([string]::IsNullOrEmpty($Parent)) {
        Write-Host ("skip   {0,-16}  (no path for this platform)" -f $Label); return
    }
    if (-not (Test-Path -LiteralPath $Parent -PathType Container)) {
        Write-Host ("skip   {0,-16}  (parent missing: {1})" -f $Label, $Parent); return
    }
    $dstDir = Join-Path $Parent 'skills'
    if (-not (Test-Path -LiteralPath $dstDir -PathType Container)) {
        Invoke-Lib "mkdir $dstDir" { New-Item -ItemType Directory -Path $dstDir -Force | Out-Null }
    }
    Write-Host ("link   {0,-16}  -> {1}" -f $Label, $dstDir)

    foreach ($name in Get-SkillNames) {
        $link   = Join-Path $dstDir $name
        $target = Join-Path $script:LibRoot $name

        if (Test-Path -LiteralPath $link) {
            $item = Get-Item -LiteralPath $link -Force
            $linkType = $item.LinkType
            $cur = @($item.Target) | Select-Object -First 1
            if ($linkType -in @('SymbolicLink','Junction') -and (Test-SameTarget $cur $target)) {
                Write-Host ("         = {0} (already linked)" -f $name); continue
            }
            if ($script:LibForce) {
                Invoke-Lib "rm $link" { Remove-Item -LiteralPath $link -Recurse -Force }
            } elseif ($linkType -in @('SymbolicLink','Junction')) {
                Write-Warning ("{0} (exists -> {1}; -Force to replace)" -f $name, (ConvertFrom-NtPath $cur))
                continue
            } else {
                Write-Warning ("{0} (exists, not a link; -Force to replace)" -f $name); continue
            }
        }

        $kind = $null
        Invoke-Lib "ln -s $target $link" { $script:_last = New-DirLink -Link $link -Target $target }
        if (-not $script:LibDryRun) { $kind = $script:_last }
        $suffix = if ($kind -eq 'junction') { ' (junction; SymbolicLink denied — enable Developer Mode for true symlinks)' } else { '' }
        Write-Host ("         + {0}{1}" -f $name, $suffix)
    }
}

# Remove repo-managed links from <parent>\skills\. Leaves unrelated files alone.
function Uninstall-LibTarget {
    param([Parameter(Mandatory)][string]$Label, [string]$Parent)
    $dstDir = if ($Parent) { Join-Path $Parent 'skills' } else { $null }
    if (-not $dstDir -or -not (Test-Path -LiteralPath $dstDir -PathType Container)) {
        Write-Host ("skip   {0,-16}  (nothing installed)" -f $Label); return
    }
    Write-Host ("uninst {0,-16}  -> {1}" -f $Label, $dstDir)
    foreach ($name in Get-SkillNames) {
        $link = Join-Path $dstDir $name
        if (-not (Test-Path -LiteralPath $link)) { continue }
        $item = Get-Item -LiteralPath $link -Force
        if ($item.LinkType -in @('SymbolicLink','Junction')) {
            Invoke-Lib "rm $link" { Remove-Item -LiteralPath $link -Force }
            Write-Host ("         - {0}" -f $name)
        }
    }
}
