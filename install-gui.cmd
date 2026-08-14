@echo off
rem install-gui.cmd - double-clickable launcher for install-gui.ps1 on Windows.
rem A .ps1 opens in an editor on double-click; this shim runs it with the right
rem execution policy. Prefers PowerShell 7 (pwsh) and falls back to Windows
rem PowerShell (powershell.exe).
setlocal
set "SCRIPT=%~dp0install-gui.ps1"

where pwsh >nul 2>&1
if %ERRORLEVEL%==0 (
    pwsh -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%" %*
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%" %*
)
endlocal
