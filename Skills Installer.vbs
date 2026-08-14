' Skills Installer - no-console launcher for Windows.
'
' Double-click this file to run the WinForms wizard with no console window
' (the Windows equivalent of "Skills Installer.app" on macOS). The .ps1 opens
' an editor on double-click, and the .cmd shim flashes a console; this .vbs
' starts PowerShell hidden so only the dialogs appear.
'
' Prefers PowerShell 7 (pwsh) and falls back to Windows PowerShell.
Option Explicit

Dim sh, fso, scriptDir, ps1, args
Set sh  = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1 = scriptDir & "\install-gui.ps1"

If Not fso.FileExists(ps1) Then
  MsgBox "Could not find install-gui.ps1 next to this launcher." & vbCrLf & _
         "Keep this file inside the cloned Skills repo.", vbCritical, "Skills Installer"
  WScript.Quit 1
End If

' Window style 0 = hidden; False = don't wait. The WinForms dialogs still show.
args = " -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File " & """" & ps1 & """" & " -NoConsoleFallback"

On Error Resume Next
sh.Run "pwsh" & args, 0, False
If Err.Number <> 0 Then
  Err.Clear
  sh.Run "powershell" & args, 0, False
End If
