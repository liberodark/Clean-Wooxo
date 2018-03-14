#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         liberodark

 Script Function:
	Clean WooxoBackup and YouBackup.

#ce ----------------------------------------------------------------------------

#include <WinApi.au3>
#include <GuiConstants.au3>
#include <GUIConstantsEx.au3>
#include <File.au3>
#include <FileConstants.au3>
#include <7zaExe.au3>
#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Misc.au3>

; ==================
;Hotkey to close

HotKeySet("{Esc}","Quit")
Func Quit()
    Exit
EndFunc

; ==================
;Check if there is another instance launched, so we exit this application

Local $Title = "Clean Wooxo"
Local $ErrorMsg = "Another instance of this program is already running"
If _Singleton(StringTrimRight(@ScriptName,4),1) = 0 Then Exit MsgBox(48,$Title,$ErrorMsg)
DirCopy ("C:\wooxo", "C:\wooxo.save", 1)
DirCopy ("C:\Wooxo", "C:\Wooxo.old", 1)

; ==================
; YouBackup Install

If MsgBox(4, "Remove YooBackup Lite", "You want to remove just Yoobackup ?") = 6 Then
RunWait("sc stop YooIT")
RunWait("sc stop YooBackup")
RunWait("sc stop WXB")
ShellExecute (@ScriptDir & "\install\setup_box_win.exe")
ProcessWaitClose("setup_box_win.exe")
RunWait("sc start YooIT")
RunWait("sc start YooBackup")
RunWait("sc start WXB")
Endif

If MsgBox(4, "Remove YooBackup Full", "You want to remove Yoobackup and db, services, folders ?") = 6 Then
DirRemove("C:/wooxo/", 1)
RunWait("sc stop YooIT && sc delete YouIT")
RunWait("sc stop YooBackup && sc delete YouBackup")
RunWait("sc stop WXB && sc delete WXB")
ShellExecute (@ScriptDir & "\install\setup_box_win.exe")
ProcessWaitClose("setup_box_win.exe")
Endif

; ==================
; WooxoBackup Install

If MsgBox(4, "Remove WooxoBackup Lite", "You want to remove just WooxoBackup ?") = 6 Then
RunWait("sc stop dsr")
RunWait("sc stop wooxobackup")
RunWait("sc stop Data Safe Restore")
RunWait("sc stop WXB")
ShellExecute (@ScriptDir & "\install\wooxo-install.exe")
ProcessWaitClose("wooxo-install.exe")
RunWait("sc start dsr")
RunWait("sc start wooxobackup")
RunWait("sc start Data Safe Restore")
RunWait("sc start WXB")
Endif

If MsgBox(4, "Remove WooxoBackup Full", "You want to remove WooxoBackup and db, services, folders ?") = 6 Then
DirRemove("C:/wooxo/", 1)
RunWait("sc stop dsr && sc delete dsr")
RunWait("sc stop wooxobackup && sc delete wooxobackup")
RunWait("sc stop Data Safe Restore && sc delete Data Safe Restore")
RunWait("sc stop WXB && sc delete WXB")
ShellExecute (@ScriptDir & "\install\wooxo-install.exe")
ProcessWaitClose("wooxo-install.exe")
Endif

; ==================
; Clean All

If MsgBox(4, "Remove YooBackup and WooxoBacukup Full", "You want to remove YooBackup / WooxoBackup and db, services, folders ?") = 6 Then
DirRemove("C:/wooxo/", 1)
RunWait("sc stop dsr && sc delete dsr")
RunWait("sc stop wooxobackup && sc delete wooxobackup")
RunWait("sc stop Data Safe Restore && sc delete Data Safe Restore")
RunWait("sc stop YooIT && sc delete YouIT")
RunWait("sc stop YooBackup && sc delete YouBackup")
RunWait("sc stop WXB && sc delete WXB")
ShellExecute (@ScriptDir & "\install\setup_box_win.exe")
ProcessWaitClose("setup_box_win.exe")
Endif

Exit