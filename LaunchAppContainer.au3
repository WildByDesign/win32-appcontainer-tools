#Region ; *** Dynamically added Include files ***
#include <ButtonConstants.au3>                               ; added:12/10/24 21:49:28
#include <GUIConstantsEx.au3>                                ; added:12/10/24 21:49:28
#include <WindowsConstants.au3>                              ; added:12/10/24 21:52:00
#include <ColorConstants.au3>                                ; added:12/10/24 22:21:06
#include <WinAPIConv.au3>                                    ; added:12/11/24 06:05:30
#include <WinAPIGdiInternals.au3>                            ; added:12/11/24 06:05:30
#include <MsgBoxConstants.au3>                               ; added:12/11/24 08:43:45
#include <GuiListView.au3>                                   ; added:12/11/24 09:22:02
#include <ListViewConstants.au3>                             ; added:12/11/24 09:22:02
#include <Array.au3>                                         ; added:12/11/24 09:45:11
#include <FontConstants.au3>                                 ; added:12/11/24 12:03:11
#include <WinAPISysInternals.au3>                            ; added:12/12/24 16:21:03
#include <GuiToolTip.au3>                                    ; added:12/13/24 22:47:37
#include <WinAPITheme.au3>                                   ; added:12/14/24 05:55:06
#include <EditConstants.au3>                                 ; added:12/14/24 06:51:00
#include <AutoItConstants.au3>                               ; added:12/14/24 07:55:31
#include <StringConstants.au3>                               ; added:12/14/24 07:55:31
#include <WinAPIProc.au3>                                    ; added:12/14/24 07:55:31
#include <Misc.au3>                                          ; added:01/10/25 07:48:01
#EndRegion ; *** Dynamically added Include files ***

#NoTrayIcon

#pragma compile(Out, _build\LaunchAppContainer.exe)

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=app.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Launch AppContainer
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=1.0.0
#AutoIt3Wrapper_Res_ProductName=LaunchAppContainer
#AutoIt3Wrapper_Res_LegalCopyright=@ 2024 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#AutoIt3Wrapper_Res_Icon_Add=app.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstants.au3>
#include <File.au3>

#include "includes\ExtMsgBox.au3"
#include "includes\GuiCtrls_HiDpi.au3"
#include "includes\GUIDarkMode_v0.02mod.au3"
#include "includes\GUIListViewEx.au3"

_HiDpi_Ctrl_LazyInit(-4)

If _Singleton("LaunchAppContainer", 1) = 0 Then
        $sMsg = " An instance of Launch AppContainer is already running. " & @CRLF
		MsgBox($MB_SYSTEMMODAL, "Launch AppContainer", $sMsg)
        Exit
EndIf


$GetDPI = _GetDPI()

; 96 DPI = 100% scaling
; 120 DPI = 125% scaling
; 144 DPI = 150% scaling
; 192 DPI = 200% scaling

If $GetDPI = 96 Then
	$DPIScale = 100
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 3
	$ButtonSpaceHor = 10
	$SectionSpaceHor = 30
	$ListViewWidth = 340
	;$ListViewHeight = 362
	$ListViewHeight = @DesktopHeight / 2.5
	$ListViewHeightAdjust = 20
	$GUIWidth = 200
	$GUIHeight = 200
	$CheckboxTitleFix = 2
	$OutputBoxHeight = 88
	$ClientAreaTitlebar = 24
	$ScrollbarWidth = 22
	$BigInputBox = @DesktopWidth / 4
	$SmallInputBox = @DesktopWidth / 7
ElseIf $GetDPI = 120 Then
	$DPIScale = 125
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 16
	$TextPosFixVert = 2
	$ButtonSpaceHor = 10
	$SectionSpaceHor = 30
	;$ListViewWidth = 388
	;$ListViewHeight = 430
	$ListViewWidth = 388
	$ListViewHeight = @DesktopHeight / 2.5
	$ListViewHeightAdjust = 20
	;$ListViewHeight = 380
	$GUIWidth = 200
	$GUIHeight = 200
	$CheckboxTitleFix = 2
	$OutputBoxHeight = 88
	$ClientAreaTitlebar = 30
	$ScrollbarWidth = 27
	$BigInputBox = @DesktopWidth / 3.5
	$SmallInputBox = @DesktopWidth / 6.5
ElseIf $GetDPI = 144 Then
	$DPIScale = 150
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$SectionSpaceHor = 30
	$ListViewWidth = 482
	;$ListViewHeight = 470
	$ListViewHeight = @DesktopHeight / 2.5
	$ListViewHeightAdjust = 20
	$GUIWidth = 200
	$GUIHeight = 200
	$CheckboxTitleFix = 2
	$OutputBoxHeight = 100
	$ClientAreaTitlebar = 34
	$ScrollbarWidth = 31
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5.5
ElseIf $GetDPI = 168 Then
	$DPIScale = 175
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$SectionSpaceHor = 30
	$ListViewWidth = 482
	;$ListViewHeight = 480
	$ListViewHeight = @DesktopHeight / 2.5
	$ListViewHeightAdjust = 8
	$GUIWidth = 200
	$GUIHeight = 200
	$CheckboxTitleFix = 2
	$OutputBoxHeight = 88
	$ClientAreaTitlebar = 40
	$ScrollbarWidth = 36
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5
ElseIf $GetDPI = 192 Then
	$DPIScale = 200
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$SectionSpaceHor = 30
	$ListViewWidth = 388
	;$ListViewHeight = 354
	$ListViewHeight = @DesktopHeight / 2.5
	$ListViewHeightAdjust = 0
	$GUIWidth = 200
	$GUIHeight = 200
	$CheckboxTitleFix = 2
	$OutputBoxHeight = 88
	$ClientAreaTitlebar = 48
	$ScrollbarWidth = 42
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5
Else
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$SectionSpaceHor = 30
	$ListViewWidth = 388
	;$ListViewHeight = 354
	$ListViewHeight = @DesktopHeight / 2.5
	$ListViewHeightAdjust = 0
	$GUIWidth = 200
	$GUIHeight = 200
	$CheckboxTitleFix = 2
	$OutputBoxHeight = 88
	$ClientAreaTitlebar = 48
	$ScrollbarWidth = 42
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5
EndIf



Func _GetDPI()
    Local $iDPI, $iDPIRat, $Logpixelsy = 90, $hWnd = 0
    Local $hDC = DllCall("user32.dll", "long", "GetDC", "long", $hWnd)
    Local $aRet = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $hDC[0], "long", $Logpixelsy)
    DllCall("user32.dll", "long", "ReleaseDC", "long", $hWnd, "long", $hDC)
    $iDPI = $aRet[0]
    ;; Set a ratio for the GUI dimensions based upon the current DPI value.
    If $iDPI < 145 And $iDPI > 121 Then
        $iDPIRat = $iDPI / 95
    ElseIf $iDPI < 121 And $iDPI > 84 Then
        $iDPIRat = $iDPI / 96
    ElseIf $iDPI < 84 And $iDPI > 0 Then
        $iDPIRat = $iDPI / 105
    ElseIf $iDPI = 0 Then
        $iDPI = 96
        $iDPIRat = 94
    Else
        $iDPIRat = $iDPI / 94
    EndIf
    Return SetError(0, $iDPIRat, $iDPI)
EndFunc


isDarkMode()
Func isDarkMode()
Global $isDarkMode = _WinAPI_ShouldAppsUseDarkMode()
Endfunc

If $isDarkMode = True Then
	_ExtMsgBoxSet(Default)
	;_ExtMsgBoxSet(1, 5, -1, -1, -1, "Consolas", 800, 800)
	_ExtMsgBoxSet(1, 4, 0x202020, 0xe0e0e0, 9, -1, 1200)
Else
	_ExtMsgBoxSet(Default)
	;_ExtMsgBoxSet(1, 5, -1, -1, -1, "Consolas", 800, 800)
	_ExtMsgBoxSet(1, 4, -1, -1, 9, -1, 1200)
EndIf


Local Const $sSegUIVar = @WindowsDir & "\fonts\SegUIVar.ttf"
Local $SegUIVarExists = FileExists($sSegUIVar)

If $SegUIVarExists Then
	Global $MainFont = "Segoe UI Variable Display"
	GUISetFont(10, $FW_NORMAL, -1, $MainFont)
Else
	Global $MainFont = "Segoe UI"
	GUISetFont(10, $FW_NORMAL, -1, $MainFont)
EndIf


Global $IsLPAC, $isWin32k, $isDeleteAC, $LPAC, $Win32k, $DeleteAC, $MonikerCLI, $ACNameNew, $checkpermissive
Global $LaunchAppContainer = @ScriptDir & '\bin\LaunchAppContainer.exe'
Global $StartupFolder = ""

Global $aWords
$file = @ScriptDir & "\data\capslist.txt"

_FileReadToArray($file, $aWords)

_ArrayDelete($aWords, 0)
_ArrayColInsert($aWords, 0)
_ArrayColDelete($aWords, 0)


If IsAdmin() Then
	$hGUI = GUICreate("Launch AppContainer [Administrator]", $GUIWidth, $GUIHeight, -1, -1, $WS_SIZEBOX + $WS_SYSMENU + $WS_MINIMIZEBOX + $WS_MAXIMIZEBOX)
	GUISetFont(10, $FW_NORMAL, -1, $MainFont)
Else
	$hGUI = GUICreate("Launch AppContainer", $GUIWidth, $GUIHeight, -1, -1, $WS_SIZEBOX + $WS_SYSMENU + $WS_MINIMIZEBOX + $WS_MAXIMIZEBOX)
	GUISetFont(10, $FW_NORMAL, -1, $MainFont)
EndIf



Local $hToolTip2 = _GUIToolTip_Create(0)
_GUIToolTip_SetMaxTipWidth($hToolTip2, 400)

If $isDarkMode = True Then
	_WinAPI_SetWindowTheme($hToolTip2, "", "")
	_GUIToolTip_SetTipBkColor($hToolTip2, 0x202020)
	_GUIToolTip_SetTipTextColor($hToolTip2, 0xe0e0e0)
Else
	_WinAPI_SetWindowTheme($hToolTip2, "", "")
	_GUIToolTip_SetTipBkColor($hToolTip2, 0xffffff)
	_GUIToolTip_SetTipTextColor($hToolTip2, 0x000000)
EndIf

; LABEL
$AppContainerNameLabel = GUICtrlCreateLabel("AppContainer Name:", 15, 20, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hAppContainerNameLabel = GUICtrlGetHandle($AppContainerNameLabel)
$aPos = ControlGetPos($hGUI, "", $AppContainerNameLabel)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$AppContainerNamePosV = $aPos[1] + 34
$AppContainerNamePosH = $aPos[0] + $aPos[2]
$AppContainerNameHeight = $aPos[1] + $aPos[3]
$AutoTextHeight = $aPos[3]

;GUICtrlSetFont($AppContainerNameLabel, 10, $FW_BOLD, -1, "Segoe UI")

;GUICtrlSetFont($CapabilitiesList, 9, -1, -1, "Segoe UI")

;$cLabel = GUICtrlCreateLabel("", 14, 53, 302, 22)
;GUICtrlSetState($cLabel, $GUI_DISABLE)
;GUICtrlSetBkColor($cLabel, 0xFF0000)

$iniFilePath = @ScriptDir & '\LaunchAppContainer.ini'

; Read the INI file for the value of 'Name' in the section labelled 'LaunchAppContainer'.
$ACNameRead = IniRead($iniFilePath, "LaunchAppContainer", "Name", "AppContainer.Testing")


$AppContainerNameText = GUICtrlCreateInput($ACNameRead, 15, $AppContainerNameHeight + $TitleSpaceVert, $SmallInputBox, $AutoTextHeight, -1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hAppContainerNameText = GUICtrlGetHandle($AppContainerNameText)
$aPos = ControlGetPos($hGUI, "", $AppContainerNameText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$AppContainerNameTextPosV = $aPos[1] + $aPos[3]
$AppContainerNameTextPosH = $aPos[0] + $aPos[2]
$AppContainerNameTextHeight = $aPos[1] + $aPos[3]
$AppContainerNameTextPosV2 = $aPos[1]

If $isDarkMode = True Then
	$cLabel = GUICtrlCreateLabel("", 15, $AppContainerNameTextPosV, $SmallInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel, 0x828790)
Else
	$cLabel = GUICtrlCreateLabel("", 15, $AppContainerNameTextPosV, $SmallInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel, 0x000000)
EndIf


$LPACCheckbox = GUICtrlCreateCheckbox(" ", 15, $AppContainerNameTextHeight + $SectionSpaceVert + $TitleSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hLPACCheckbox = GUICtrlGetHandle($LPACCheckbox)
$aPos = ControlGetPos($hGUI, "", $LPACCheckbox)

$LPACCheckboxPosV = $aPos[1]
$LPACCheckboxPosH = $aPos[0] + $aPos[2]
$LPACCheckboxHeight = $aPos[1] + $aPos[3]

$LPACLabel = GUICtrlCreateLabel("Enable Less Privileged AppContainer (LPAC)", $LPACCheckboxPosH, $LPACCheckboxPosV + $CheckboxTitleFix, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hLPACLabel = GUICtrlGetHandle($LPACLabel)
$aPos = ControlGetPos($hGUI, "", $LPACLabel)

$LPACLabelInfoPosV = $aPos[1]
$LPACLabelInfoPosH = $aPos[0] + $aPos[2]
$LPACLabelInfoHeight = $aPos[1] + $aPos[3]


GUISetFont(10, -1, -1, "Segoe MDL2 Assets")


$LPACLabelInfo = GUICtrlCreateLabel("", $LPACLabelInfoPosH, $LPACLabelInfoPosV + 4, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$LPACLabelInfo = GUICtrlCreateLabel("", $LPACLabelInfoPosH, $LPACLabelInfoPosV, 22, 22, $WS_BORDER)
$hLPACLabelInfo = GUICtrlGetHandle($LPACLabelInfo)
;GUICtrlSetFont($LPACLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")

GUISetFont(10, $FW_NORMAL, -1, $MainFont)


;_GUIToolTip_AddTool($hToolTip2, 0, " LPAC is a more restrictive version of AppContainer. " & @CRLF & @CRLF & " To run GUI programs, as a minimum, you will need " & @CRLF & " the following Capabilities: lpacAppExperience, " & @CRLF & " lpacCom and registryRead ", $hLPACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" LPAC is a more restrictive version of AppContainer. " & @CRLF & @CRLF & _
		" To run GUI programs, as a minimum, you will need " & @CRLF & _
		" the following Capabilities: lpacAppExperience, " & @CRLF & _
		" lpacCom and registryRead ", $hLPACLabelInfo)


$Win32kCheckbox = GUICtrlCreateCheckbox(" ", 15, $LPACCheckboxHeight + 2, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hWin32kCheckbox = GUICtrlGetHandle($Win32kCheckbox)
$aPos = ControlGetPos($hGUI, "", $Win32kCheckbox)

$Win32kCheckboxPosV = $aPos[1]
$Win32kCheckboxPosH = $aPos[0] + $aPos[2]
$Win32kCheckboxHeight = $aPos[1] + $aPos[3]


$Win32kLabel = GUICtrlCreateLabel("Enable Win32k Lockdown Mitigation Policy", $Win32kCheckboxPosH, $Win32kCheckboxPosV + $CheckboxTitleFix, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hWin32kLabel = GUICtrlGetHandle($Win32kLabel)
$aPos = ControlGetPos($hGUI, "", $Win32kLabel)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$Win32kInfoPosV = $aPos[1] + 4
$Win32kInfoPosH = $aPos[0] + $aPos[2]
$Win32kInfoHeight = $aPos[1] + $aPos[3]

;MsgBox($MB_SYSTEMMODAL, "", $Win32kInfoPos)

GUISetFont(10, -1, -1, "Segoe MDL2 Assets")

$Win32kLabelInfo = GUICtrlCreateLabel("", $Win32kInfoPosH, $Win32kInfoPosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$Win32kLabelInfo = GUICtrlCreateLabel("", $Win32kInfoPosH, $Win32kInfoPosV, -1, -1)
$hWin32kLabelInfo = GUICtrlGetHandle($Win32kLabelInfo)
;GUICtrlSetFont($Win32kLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

;_GUIToolTip_AddTool($hToolTip2, 0, " Win32k Lockdown Mitigation Policy is intended to " & @CRLF & " work with command line tools only. GUI programs " & @CRLF & " will fail to start if this is selected. ", $hWin32kLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" Win32k Lockdown Mitigation Policy is intended to " & @CRLF & _
		" work with command line tools only. GUI programs " & @CRLF & _
		" will fail to start if this is selected. ", $hWin32kLabelInfo)

$DeleteACCheckbox = GUICtrlCreateCheckbox(" ", 15, $Win32kCheckboxHeight + 2, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hDeleteACCheckbox = GUICtrlGetHandle($DeleteACCheckbox)

$aPos = ControlGetPos($hGUI, "", $DeleteACCheckbox)

$DeleteACCheckboxPosV = $aPos[1]
$DeleteACCheckboxPosH = $aPos[0] + $aPos[2]
$DeleteACCheckboxHeight = $aPos[1] + $aPos[3]

$DeleteACLabel = GUICtrlCreateLabel("Delete AppContainer Profile On Exit", $DeleteACCheckboxPosH, $DeleteACCheckboxPosV + $CheckboxTitleFix, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $DeleteACLabel)
$hDeleteACLabel = GUICtrlGetHandle($DeleteACLabel)

$DeleteACPosV = $aPos[1] + 4
$DeleteACPosH = $aPos[0] + $aPos[2]

GUISetFont(10, -1, -1, "Segoe MDL2 Assets")


$DeleteACLabelInfo = GUICtrlCreateLabel("", $DeleteACPosH, $DeleteACPosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$DeleteACLabelInfo = GUICtrlCreateLabel("", $DeleteACPosH, $DeleteACPosV, -1, -1)
;GUICtrlSetFont($DeleteACLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")
$hDeleteACLabelInfo = GUICtrlGetHandle($DeleteACLabelInfo)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

;_GUIToolTip_AddTool($hToolTip2, 0, " This option will delete the AppContainer profile " & @CRLF & " folder upon exit of the sandboxed program. ", $hDeleteACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" This option will delete the AppContainer profile " & @CRLF & _
		" folder upon exit of the sandboxed program. ", $hDeleteACLabelInfo)



; test getting permissive here


$PermissiveModeCheckbox = GUICtrlCreateCheckbox(" ", 15, $DeleteACCheckboxHeight + 2, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hPermissiveModeCheckbox = GUICtrlGetHandle($PermissiveModeCheckbox)

$aPos = ControlGetPos($hGUI, "", $PermissiveModeCheckbox)

$PermissiveModeCheckboxPosV = $aPos[1]
$PermissiveModeCheckboxPosH = $aPos[0] + $aPos[2]
$PermissiveModeCheckboxHeight = $aPos[1] + $aPos[3]

$PermissiveModeLabel = GUICtrlCreateLabel("Enable Permissive Learning Mode", $PermissiveModeCheckboxPosH, $PermissiveModeCheckboxPosV + $CheckboxTitleFix, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $PermissiveModeLabel)
$hPermissiveModeLabel = GUICtrlGetHandle($PermissiveModeLabel)

$PermissiveModePosV = $aPos[1] + 4
$PermissiveModePosH = $aPos[0] + $aPos[2]

GUISetFont(10, -1, -1, "Segoe MDL2 Assets")


$PermissiveModeLabelInfo = GUICtrlCreateLabel("", $PermissiveModePosH, $PermissiveModePosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$DeleteACLabelInfo = GUICtrlCreateLabel("", $DeleteACPosH, $DeleteACPosV, -1, -1)
;GUICtrlSetFont($DeleteACLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")
$hPermissiveModeLabelInfo = GUICtrlGetHandle($PermissiveModeLabelInfo)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

;_GUIToolTip_AddTool($hToolTip2, 0, " This option will delete the AppContainer profile " & @CRLF & " folder upon exit of the sandboxed program. ", $hDeleteACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" Permissive Learning Mode utilizes the permissiveLearningMode " & @CRLF & _
		" capability to perform a kernel ETW trace of any objects " & @CRLF & _
		" that would normally fail as ACCESS DENIED. " & @CRLF & @CRLF & _
		" WARNING: There are no AppContainer restrictions when " & @CRLF & _
		" using Permissive Learning Mode. " & @CRLF & @CRLF & _
		" To begin using Permissive Learning Mode, open the  " & @CRLF & _
		" Learning Mode tool and click Start Learning first. Once " & @CRLF & _
		" started, you can now start a program within an AppContainer " & @CRLF & _
		" with the Enable Permissive Learning Mode option selected. " & @CRLF & @CRLF & _
		" You can run subsequent Learning Mode traces by adding " & @CRLF & _
		" additional capabilities and/or ACLs to see the difference " & @CRLF & _
		" in the Learning Mode output. ", $hPermissiveModeLabelInfo)


; test above


; LABEL
$ProgramLabel = GUICtrlCreateLabel("Program and Arguments:", 15, $PermissiveModeCheckboxHeight + $SectionSpaceVert + $TitleSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hProgramLabel = GUICtrlGetHandle($ProgramLabel)
$aPos = ControlGetPos($hGUI, "", $ProgramLabel)

$ProgramLabelPosV = $aPos[1]
$ProgramLabelPosH = $aPos[0] + $aPos[2]
$ProgramLabelHeight = $aPos[1] + $aPos[3]


; Input
;$ProgramText = GUICtrlCreateInput("", 15, $ProgramLabelHeight + $TitleSpaceVert, 480, $AutoTextHeight, -1, 0)
$ProgramText = GUICtrlCreateInput("", 15, $ProgramLabelHeight + $TitleSpaceVert, $BigInputBox, $AutoTextHeight, -1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hProgramText = GUICtrlGetHandle($ProgramText)
$aPos = ControlGetPos($hGUI, "", $ProgramText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$ProgramTextPosV = $aPos[1] + $aPos[3]
$ProgramTextPosH = $aPos[0] + $aPos[2]
$ProgramTextHeight = $aPos[1] + $aPos[3]
$ProgramTextWidth = $aPos[2]

If $isDarkMode = True Then
	$cLabel2 = GUICtrlCreateLabel("", 15, $ProgramTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel2, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel2, 0x828790)
Else
	$cLabel2 = GUICtrlCreateLabel("", 15, $ProgramTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel2, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel2, 0x000000)
EndIf


GUISetFont(12, $FW_NORMAL, -1, "Segoe MDL2 Assets")

$ProgramButton = GUICtrlCreateButton("", $ProgramTextPosH + $ButtonSpaceHor, $ProgramLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$hProgramButton = GUICtrlGetHandle($ProgramButton)
$aPos = ControlGetPos($hGUI, "", $ProgramButton)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$ProgramButtonPosV = $aPos[1] + $aPos[3]
$ProgramButtonPosH = $aPos[0] + $aPos[2]
$ProgramButtonHeight = $aPos[1] + $aPos[3]
$ProgramButtonWidth = $aPos[2]

GUISetFont(10, $FW_NORMAL, -1, $MainFont)


$StartupDirLabel = GUICtrlCreateLabel("Startup Directory (can be empty):", 15, $ProgramTextHeight + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetFont($StartupDirLabel, 10, $FW_BOLD, -1, "Segoe UI")
$aPos = ControlGetPos($hGUI, "", $StartupDirLabel)
$hStartupDirLabel = GUICtrlGetHandle($StartupDirLabel)
$StartupDirLabelPosV = $aPos[1] + $aPos[3]
$StartupDirLabelPosH = $aPos[0] + $aPos[2]

$StartupDirText = GUICtrlCreateInput("", 15, $StartupDirLabelPosV + $TitleSpaceVert, $BigInputBox, $AutoTextHeight, -1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hStartupDirText = GUICtrlGetHandle($StartupDirText)
$aPos = ControlGetPos($hGUI, "", $StartupDirText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$StartupDirTextPosV = $aPos[1] + $aPos[3]
$StartupDirTextPosH = $aPos[0] + $aPos[2]

If $isDarkMode = True Then
	$cLabel3 = GUICtrlCreateLabel("", 15, $StartupDirTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel3, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel3, 0x828790)
Else
	$cLabel3 = GUICtrlCreateLabel("", 15, $StartupDirTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel3, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel3, 0x000000)
EndIf

GUISetFont(12, $FW_NORMAL, -1, "Segoe MDL2 Assets")
$StartupDirButton = GUICtrlCreateButton("", $StartupDirTextPosH + $ButtonSpaceHor, $StartupDirLabelPosV + $TitleSpaceVert, -1, $AutoTextHeight)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)


$LaunchButtonAlignHelper2 = 15 + $ProgramTextWidth + $ButtonSpaceHor + $ProgramButtonWidth + $SectionSpaceHor


$testbutton3 = GUICtrlCreateButton(" Set AppContainer ACLs ", 100, $StartupDirTextPosV + $SectionSpaceVert, -1, -1, $BS_VCENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$htestbutton3 = GUICtrlGetHandle($testbutton3)
$aPos = ControlGetPos($hGUI, "", $testbutton3)
$ButtonPosition3 = $aPos[2]
GUICtrlSetState($testbutton3, $GUI_DISABLE + $GUI_HIDE)

$LaunchButtonPosition3 = $LaunchButtonAlignHelper2 - $ButtonPosition3
$LaunchButtonPosition4 = $LaunchButtonPosition3 / 2


$testbutton2 = GUICtrlCreateButton(" Permissive Learning Mode ", 100, $StartupDirTextPosV + $SectionSpaceVert, -1, -1, $BS_VCENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$htestbutton2 = GUICtrlGetHandle($testbutton2)
$aPos = ControlGetPos($hGUI, "", $testbutton2)
$ButtonPosition2 = $aPos[2]
GUICtrlSetState($testbutton2, $GUI_DISABLE + $GUI_HIDE)


$TwoButtonAlignHelper = $ButtonPosition2 + $ButtonPosition3 + $ButtonSpaceHor + $ButtonSpaceHor
$TwoButtonAlignHelper1 = $LaunchButtonAlignHelper2 - $TwoButtonAlignHelper
$TwoButtonAlignHelper2 = $TwoButtonAlignHelper1 / 2


$SetAppContainACLButton = GUICtrlCreateButton(" Set AppContainer ACLs ", $TwoButtonAlignHelper2, $StartupDirTextPosV + $SectionSpaceVert + $SectionSpaceVert, -1, -1, $BS_VCENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hSetAppContainACLButton = GUICtrlGetHandle($SetAppContainACLButton)
;GUICtrlSetState($SetAppContainACLButton, $GUI_ONTOP)
$aPos = ControlGetPos($hGUI, "", $SetAppContainACLButton)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$SetAppContainACLPosV = $aPos[1] + $aPos[3]
$SetAppContainACLPosH = $aPos[0] + $aPos[2]
;$ACLareatest = GUICtrlCreateLabel("", 10, 365, 580, 180, $WS_BORDER + $WS_CLIPSIBLINGS)
;GUICtrlSetState($ACLareatest, $GUI_DISABLE)


$LearningModeButton = GUICtrlCreateButton(" Permissive Learning Mode ", $SetAppContainACLPosH + $ButtonSpaceHor + $ButtonSpaceHor, $StartupDirTextPosV + $SectionSpaceVert + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hLearningModeButton = GUICtrlGetHandle($LearningModeButton)
;GUICtrlSetState($LearningModeButton, $GUI_ONTOP)
$aPos = ControlGetPos($hGUI, "", $LearningModeButton)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$LearningModeButtonPosV2 = $aPos[1]
$LearningModeButtonPosV = $aPos[1] + $aPos[3]
$LearningModeButtonPosH = $aPos[0] + $aPos[2]
$LearningModeButtonHeight = $aPos[3]
$LearningModeButtonWidth = $aPos[2]
$LearningModeButtonHeight2 = $LearningModeButtonHeight / 3


$LaunchButtonAlignHelper = 15 + $ProgramTextWidth + $ButtonSpaceHor + $ProgramButtonWidth + $SectionSpaceHor


;MsgBox($MB_SYSTEMMODAL, "", $LaunchButtonAlignHelper)

GUISetFont(12, $FW_NORMAL, -1, $MainFont)

$testbutton = GUICtrlCreateButton("  Launch AppContainer  ", 100, $SetAppContainACLPosV + $SectionSpaceVert, -1, -1, $BS_VCENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$htestbutton = GUICtrlGetHandle($testbutton)
$aPos = ControlGetPos($hGUI, "", $testbutton)
$ButtonPosition = $aPos[2]
GUICtrlSetState($testbutton, $GUI_DISABLE + $GUI_HIDE)

$LaunchButtonPosition = $LaunchButtonAlignHelper - $ButtonPosition
$LaunchButtonPosition2 = $LaunchButtonPosition / 2

;$RUN_1 = GUICtrlCreateButton("  Launch AppContainer  ", $CapabilitiesListPosH2 + $LaunchButtonPos + $ButtonSpaceHor + $ButtonSpaceHor, 474, -1, 40)
$RUN_1 = GUICtrlCreateButton("  Launch AppContainer  ", $LaunchButtonPosition2, $LearningModeButtonPosV + $SectionSpaceVert, -1, -1, $BS_VCENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetState($RUN_1, $GUI_ONTOP)
$hRUN_1 = GUICtrlGetHandle($RUN_1)
$aPos = ControlGetPos($hGUI, "", $RUN_1)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$RUN_1PosV = $aPos[1] + $aPos[3]
$RUN_1PosH = $aPos[0] + $aPos[2]
$RUN_1PosH2 = $aPos[0]
$RUN_1Height = $aPos[3]
$RUN_1PosV2 = $aPos[1]

GUISetFont(10, $FW_NORMAL, -1, $MainFont)


$ButtonAreaHeight = $LearningModeButtonHeight + $RUN_1Height + $SectionSpaceVert


$AreaMeasureForLVHeight = $RUN_1PosV - $AppContainerNameTextPosV2
;MsgBox($MB_SYSTEMMODAL, "title", $AreaMeasureForLVHeight)


$CapabilitiesLabelMain = GUICtrlCreateLabel("Capabilities:", $ProgramButtonPosH + $SectionSpaceHor, 20, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hCapabilitiesLabelMain = GUICtrlGetHandle($CapabilitiesLabelMain)
$aPos = ControlGetPos($hGUI, "", $CapabilitiesLabelMain)

$CapabilitiesLabelMainPosV = $aPos[1] + $aPos[3]
$CapabilitiesLabelMainHeight = $aPos[3]
$CapabilitiesLabelMainWidth = $aPos[2]

; LABEL
;$CapabilitiesLabel = GUICtrlCreateLabel("Capabilities:", $ProgramButtonPosH + $SectionSpaceHor, 20, -1, -1)
;$CapabilitiesLabel = GUICtrlCreateLabel("Capabilities:", $ProgramButtonPosH + $SectionSpaceHor, 20, -1, -1, $WS_BORDER + $WS_CLIPSIBLINGS)
$CapabilitiesLabel = GUICtrlCreateCheckbox("packageWriteRedirectionCompatibilityShim", $ProgramButtonPosH + $SectionSpaceHor + 6, 20, -1, -1, $WS_BORDER)


GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hCapabilitiesLabel = GUICtrlGetHandle($CapabilitiesLabel)
$aPos = ControlGetPos($hGUI, "", $CapabilitiesLabel)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$CapabilitiesLabelPosV = $aPos[1] + $aPos[3]
$CapabilitiesLabelHeight = $aPos[3]
$CapabilitiesLabelWidth = $aPos[2]
GUICtrlSetState($CapabilitiesLabel, $GUI_DISABLE + $GUI_HIDE)
;MsgBox($MB_SYSTEMMODAL, "test", $CapabilitiesLabelWidth)
;GUICtrlSetFont($CapabilitiesLabel, 10, $FW_BOLD, -1, "Segoe UI")

;$exStyles = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES), $CapabilitiesList


$CapabilitiesListWidth = 6 + $CapabilitiesLabelWidth + $ScrollbarWidth + 26

$CapabilitiesList = GUICtrlCreateListView(" ", $ProgramButtonPosH + $SectionSpaceHor, $CapabilitiesLabelPosV + $TitleSpaceVert, $CapabilitiesListWidth, $AreaMeasureForLVHeight - $ListViewHeightAdjust, $LVS_NOCOLUMNHEADER + $LVS_SORTASCENDING + $LVS_SHOWSELALWAYS + $LVS_SINGLESEL)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$hCapabilitiesList = GUICtrlGetHandle($CapabilitiesList)
$aPos = ControlGetPos($hGUI, "", $CapabilitiesList)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$CapabilitiesListPosV = $aPos[1] + $aPos[3]
$CapabilitiesListPosH = $aPos[0] + $aPos[2]
$CapabilitiesListPosH2 = $aPos[0]
$CapabilitiesListWidth = $aPos[2]
$CapabilitiesListHeight = $aPos[3]

;$idItem1 = GUICtrlCreateListViewItem("test", $CapabilitiesList)
;_GUICtrlListView_SetExtendedListViewStyle($hCapabilitiesList, $exStyles)
_GUICtrlListView_SetExtendedListViewStyle($CapabilitiesList, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlListView_AddArray($hCapabilitiesList,$aWords)

;_GUICtrlListView_SetColumnWidth($hCapabilitiesList, 0, $LVSCW_AUTOSIZE_USEHEADER)
;_GUICtrlListView_SetColumnWidth($hCapabilitiesList, 0, $LVSCW_AUTOSIZE)
$capsbuttonsloc = $ListViewWidth / 4


$LaunchButtonPos = $CapabilitiesListWidth / 4



;$LearningModeButton = GUICtrlCreateButton(" Permissive Learning Mode ", $LearningAlign3, $CapabilitiesListPosV + $SectionSpaceVert, -1, -1)
;GUICtrlSetResizing(-1, $GUI_DOCKALL)
;$hLearningModeButton = GUICtrlGetHandle($LearningModeButton)
;GUICtrlSetState($LearningModeButton, $GUI_ONTOP)
;$aPos = ControlGetPos($hGUI, "", $LearningModeButton)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

;$LearningModeButtonPosV2 = $aPos[1]
;$LearningModeButtonPosV = $aPos[1] + $aPos[3]
;$LearningModeButtonPosH = $aPos[0] + $aPos[2]
;$LearningModeButtonHeight = $aPos[3]
;$LearningModeButtonWidth = $aPos[2]
;$LearningModeButtonHeight2 = $LearningModeButtonHeight / 3


GUISetFont(10, $FW_NORMAL, -1, $MainFont)





$OutputBoxWidthHelper = $ProgramTextWidth + $ButtonSpaceHor + $ProgramButtonWidth + $SectionSpaceHor + $CapabilitiesListWidth


$OutputLabel = GUICtrlCreateLabel("Output:", 15, $CapabilitiesListPosV + $SectionSpaceVert + $SectionSpaceVert + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $OutputLabel)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$OutputLabelPosV = $aPos[1] + $aPos[3]
$OutputLabelPosH = $aPos[0] + $aPos[2]
$OutputLabelHeight = $aPos[3]
;GUICtrlSetFont($OutputLabel, 10, $FW_BOLD, -1, "Segoe UI")
;$OutputText = GUICtrlCreateInput("", 15, 500, 985, 88, $ES_MULTILINE + $ES_AUTOVSCROLL + $WS_VSCROLL, 0)

$OutputText = GUICtrlCreateInput("", 15, $OutputLabelPosV + $TitleSpaceVert, $OutputBoxWidthHelper, $OutputBoxHeight, $ES_MULTILINE + $ES_AUTOVSCROLL, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


$hOutputText = GUICtrlGetHandle($OutputText)
$aPos = ControlGetPos($hGUI, "", $OutputText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$OutputTextPosV = $aPos[1] + $aPos[3]
$OutputTextPosH = $aPos[0] + $aPos[2]
$OutputTextHeight = $aPos[3]

If $isDarkMode = True Then
	$cLabel5 = GUICtrlCreateLabel("", 15, $OutputTextPosV, $OutputBoxWidthHelper, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel5, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel5, 0x828790)
Else
	$cLabel5 = GUICtrlCreateLabel("", 15, $OutputTextPosV, $OutputBoxWidthHelper, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel5, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel5, 0x000000)
EndIf


;$RUN_1 = GUICtrlCreateButton("  Launch AppContainer  ", 700, 474, -1, 40)
;GUICtrlSetFont($RUN_1, 9, -1, -1, "Segoe UI")

ApplyThemeColor()
Func ApplyThemeColor()

If $isDarkMode = True Then
	GuiDarkmodeApply($hGUI)
	;_GUISetDarkTheme($hGUI)
	;_GUICtrlSetDarkTheme($hDeleteACCheckbox)
Else
	Local $bEnableDarkTheme = False
    GuiLightmodeApply($hGUI)
EndIf

;_WinAPI_SetWindowTheme($hLearningModeCheckbox, "", "")
;_GUICtrlSetDarkTheme($hLearningModeCheckbox, False)

Endfunc


;ApplyThemeColortest()
Func ApplyThemeColortest()

;_WinAPI_SetWindowTheme($hLPACCheckbox, "", "")
;_WinAPI_SetWindowTheme($hLPACCheckbox, 0, 0)

;_WinAPI_SetWindowTheme($hWin32kCheckbox, "", "")
;_WinAPI_SetWindowTheme($hWin32kCheckbox, 0, 0)

;_WinAPI_SetWindowTheme($hDeleteACCheckbox, "", "")
;_WinAPI_SetWindowTheme($hDeleteACCheckbox, 0, 0)

;_WinAPI_SetWindowTheme($hCapabilitiesLabel, "", "")
;_WinAPI_SetWindowTheme($hCapabilitiesLabel, 0, 0)

;_WinAPI_SetWindowTheme($hCapabilitiesList, "", "")
;GUICtrlSetBkColor($CapabilitiesList, $GUI_BKCOLOR_TRANSPARENT)


;_WinAPI_SetWindowTheme($hLearningModeCheckbox, 0, 0)
;GuiDarkmodeApply($hGUI)
;_GUICtrlSetDarkTheme($LPACCheckbox, False)
;$LPACCheckbox
;_WinAPI_SetWindowTheme($hLearningModeCheckbox, "", "")
;_GUICtrlSetDarkTheme($hLearningModeCheckbox, False)

Endfunc


If $isDarkMode = True Then
	GUICtrlSetBkColor($AppContainerNameText, 0x282828)
	GUICtrlSetBkColor($ProgramText, 0x282828)
	GUICtrlSetBkColor($OutputText, 0x282828)
	GUICtrlSetBkColor($StartupDirText, 0x282828)
Else
	GUICtrlSetBkColor($AppContainerNameText, 0xffffff)
	GUICtrlSetBkColor($ProgramText, 0xffffff)
	GUICtrlSetBkColor($OutputText, 0xffffff)
	GUICtrlSetBkColor($StartupDirText, 0xffffff)
EndIf

_GUICtrlListView_SetColumnWidth($hCapabilitiesList, 0, $LVSCW_AUTOSIZE_USEHEADER)

;GUICtrlSetState($ProgramText, $GUI_FOCUS)


$ClientAreaWidth = $OutputBoxWidthHelper + 15 + 15
;$ClientAreaHeight = $GUIHeight
$ClientAreaHeight = 20 + $CapabilitiesLabelMainHeight + $TitleSpaceVert + $CapabilitiesListHeight + $SectionSpaceVert + $SectionSpaceVert + $SectionSpaceVert + $OutputLabelHeight + $TitleSpaceVert + $OutputTextHeight + 20 + 3

;GUISetState(@SW_HIDE)
;GUISetState()

;GUICtrlSetState($ProgramText, $GUI_FOCUS)
;GUISetState()
;Sleep(1000)

;WinMove($hGUI, "", 100, 100, $ClientAreaWidth, $ClientAreaHeight)
;WinMove($hGUI,'', -1, -1, $ClientAreaWidth, $ClientAreaHeight)

;GUISetState()

WinMove($hGUI,'',(@Desktopwidth - WinGetPos($hGUI)[2]) / 2,(@Desktopheight - WinGetPos($hGUI)[3]) / 2, $ClientAreaWidth + 6, $ClientAreaHeight + $ClientAreaTitlebar)

;Sleep(500)

;GUISetState()

GUISetStyle($GUI_SS_DEFAULT_GUI, -1)

WinMove($hGUI,'', (@Desktopwidth - WinGetPos($hGUI)[2]) / 2,(@Desktopheight - WinGetPos($hGUI)[3]) / 2)

GUISetState(@SW_SHOWMINIMIZED)
GUISetState(@SW_RESTORE)

WinSetOnTop($hGUI, "", $WINDOWS_ONTOP)
WinSetOnTop($hGUI, "", $WINDOWS_NOONTOP)

GUICtrlSetState($ProgramText, $GUI_FOCUS)

;_WinAPI_SetFocus(ControlGetHandle($hGUI, "", $hProgramText))
;GUICtrlSetState($ProgramText, $GUI_FOCUS)

;$hGUI = GUICreate("Launch AppContainer [Administrator]", 1015, 690, -1, -1)
;WinMove($hGUI, "", -1, -1, 1200, 800)


Func UpdateACNameIni()

	$Moniker = GUICtrlRead($AppContainerNameText)
	If $Moniker = $ACNameRead Then
		Return
	Else
		$ACNameNew = $Moniker
		Local $iniWriteCheck = IniWrite($iniFilePath, "LaunchAppContainer", "Name", $ACNameNew)
		If $iniWriteCheck = 1 Then
			$ACNameRead = $ACNameNew
		ElseIf $iniWriteCheck = 0 Then
			_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", "Failed to write updated AppContainer Name to INI file." & @CRLF)
		EndIf
	EndIf
EndFunc


Func BrowsePrograms()
Local $mFile

$mFile = FileOpenDialog("Select executable program", @ScriptDir, "Executables (*.exe)", 1)
If @error Then
    ConsoleWrite("error")
Else
	;MsgBox($MB_SYSTEMMODAL, "", $mFile)
	$EXEFile = '"' & $mFile & '"'
	GUICtrlSetData($ProgramText, $EXEFile)
EndIf
EndFunc

Func StartupDir()
Local $mFolder

$mFolder = FileSelectFolder("Select a folder", @ScriptDir)
If @error Then
    ConsoleWrite("error")
Else
	;MsgBox($MB_SYSTEMMODAL, "", $mFile)
	;GUICtrlSetData($FolderACLText, $mFolder)
	;Global $StartupFolder = '"' & $mFolder & '"'
	Global $StartupFolder = $mFolder
	GUICtrlSetData($StartupDirText, $StartupFolder)
	;MsgBox($MB_SYSTEMMODAL, "", $StartupFolder)

EndIf
EndFunc


Func ACNameCheck()

Global $Moniker = GUICtrlRead($AppContainerNameText)
Global $MonikerLower = StringLower($Moniker)

If $Moniker = '' Then
_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", "Please enter an AppContainer Name." & @CRLF)
Else
Global $MonikerCLI = ' -m ' & $Moniker
PrepareCLI()
EndIf

Endfunc


Func CheckPermissive()
	$ispermissive = GUICtrlRead($PermissiveModeCheckbox)
	;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $ispermissive & @CRLF)
	If $ispermissive = 1 Then
		$checkpermissive = 'permissiveLearningMode'
	ElseIf $ispermissive = 4 Then
		$checkpermissive = ''
	EndIf
;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $checkpermissive & @CRLF)
Endfunc


Func PrepareCLI()

$ACCWD = @LocalAppDataDir & "\Packages\" & $MonikerLower & "\AC"

Local $o_Pid2 = Run(@ComSpec & " /c " & @ScriptDir & "\bin\AppContainerSid.exe" & " " & $Moniker, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

ProcessWaitClose($o_Pid2)
$out2 = StdoutRead($o_Pid2)

Global $ACSID = StringStripWS($out2, $STR_STRIPSPACES + $STR_STRIPLEADING + $STR_STRIPTRAILING)

;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $ACSID)

$IsLPAC = GUICtrlRead($LPACCheckbox)
If $IsLPAC = 1 Then
$LPAC = ' -l'
Else
$LPAC = ''
EndIf

$isWin32k = GUICtrlRead($Win32kCheckbox)
If $isWin32k = 1 Then
$Win32k = ' -k'
Else
$Win32k = ''
EndIf

$isDeleteAC = GUICtrlRead($DeleteACCheckbox)
If $isDeleteAC = 1 Then
$DeleteAC = ' -w -r'
Else
$DeleteAC = ''
EndIf

CheckPermissive()

Local $sReturn = ''
For $i = 0 To _GUICtrlListView_GetItemCount($CapabilitiesList) - 1
; Capabilities are in column 1
$CapabilitiesChecked = _GUICtrlListView_GetItemText($CapabilitiesList, $i, 0)
If _GUICtrlListView_GetItemChecked($CapabilitiesList, $i) Then
$sReturn &= $CapabilitiesChecked & ';'
EndIf
Next

$CapsTrimmed = StringTrimRight($sReturn, 1)
;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $CapsTrimmed & @CRLF)


If $CapsTrimmed = '' Then
	If $checkpermissive = '' Then
		$CapabilitiesCLI = ''
	Else
		$CapabilitiesCLI = ' -c ' & 'permissiveLearningMode'
	EndIf
Else
	If $checkpermissive = '' Then
		$CapabilitiesCLI = ' -c ' & $CapsTrimmed
	Else
		$CapabilitiesCLI = ' -c ' & $CapsTrimmed & ';permissiveLearningMode'
	EndIf
EndIf


;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $checkpermissive & @CRLF)

$EXE = GUICtrlRead($ProgramText)
$EXECLI = ' -i ' & $EXE

If $EXE = '' Then
	_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", "Program and Arguments is blank." & @CRLF)
	Return
Else


Local $sRemoveQuotes = StringReplace($EXE, '"', '')
Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""
Local $aPathSplit = _PathSplit($sRemoveQuotes, $sDrive, $sDir, $sFileName, $sExtension)
;_ArrayDisplay($aPathSplit, "test")
;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $aPathSplit[1])

If $aPathSplit[1] = "" Then
	$CWDfromEXEPath = ""
Else
	;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $aPathSplit[1] & $aPathSplit[2])
	$CWDfromEXEPath = $aPathSplit[1] & $aPathSplit[2]
EndIf



;MsgBox($MB_SYSTEMMODAL, "", $LaunchAppContainer & $MonikerCLI & $LPAC & $Win32k & $DeleteAC)
;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $LaunchAppContainer & $MonikerCLI & $CapabilitiesCLI & $LPAC & $Win32k & $DeleteAC & $EXECLI)
$FullCommand = $LaunchAppContainer & $MonikerCLI & $CapabilitiesCLI & $LPAC & $Win32k & $DeleteAC & $EXECLI
;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $FullCommand)


$StartupCWDtemp = GUICtrlRead($StartupDirText)
If $StartupCWDtemp = "" Then
	$StartupCWD = $CWDfromEXEPath
Else
	Local $sRemoveQuotes2 = StringReplace($StartupCWDtemp, '"', '')
	$StartupCWD = $sRemoveQuotes2
EndIf

$CheckWin32k = StringInStr($FullCommand, "-k")
If $CheckWin32k <> 0 Then
Local $o_Pid = Run(@ComSpec & " /c " & $FullCommand, $StartupCWD)
Else
; Original working command
Local $o_Pid = Run(@ComSpec & " /c " & $FullCommand, $StartupCWD, @SW_HIDE, $STDOUT_CHILD)
EndIf
; Testing command specifically for Win32k Lockdown
;Local $o_Pid = Run(@ComSpec & " /c " & $FullCommand, 'C:\Users\tiffanyanddave\AppData\Local\Packages\appcontainer.launcher\AC')

EndIf

$CheckWaitRemove = StringInStr($FullCommand, "-w -r")

If $CheckWaitRemove <> 0 Then
;GUICtrlSetData($OutputText, "Waiting for AppContainer process to exit... AppContainer profile will be deleted upon exit." & @CRLF & "AppContainer SID: " & @TAB & $ACSID & @CRLF & "AppContainer Dir: " & @TAB & @LocalAppDataDir & "\Packages\" & $MonikerLower)
GUICtrlSetData($OutputText, "AppContainer SID: " & @TAB & $ACSID & @CRLF & "AppContainer Dir: " & @TAB & @LocalAppDataDir & "\Packages\" & $MonikerLower & @CRLF & @CRLF & "Waiting for AppContainer process to exit... AppContainer profile will be deleted upon exit.")

EndIf

ProcessWaitClose($o_Pid)
$out = StdoutRead($o_Pid)

Local $string0 = StringStripWS($out, $STR_STRIPSPACES + $STR_STRIPLEADING + $STR_STRIPTRAILING)

Local $GetPID = StringReplace($string0, "Successfully started AppContainer process, pid: ", "")

Local $ProcessExists = ProcessExists($GetPID)

If $ProcessExists = 0 And $CheckWaitRemove = 0 Then
GUICtrlSetData($OutputText, "AppContainer process likely failed or Win32k Lockdown is enabled.")
Else
	;GUICtrlSetData($OutputText, "AppContainer process likely failed.")
EndIf


If $ProcessExists <> 0 And $CheckWaitRemove = 0 Then

;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", $ProcessCWD)

;GUICtrlSetData($OutputText, $string0 & @CRLF & "AppContainer SID: " & @TAB & $ACSID & @CRLF & "AppContainer Dir: " & @TAB & @LocalAppDataDir & "\Packages\" & $MonikerLower)

GUICtrlSetData($OutputText, "AppContainer PID: " & @TAB & $GetPID & @CRLF & "AppContainer SID: " & @TAB & $ACSID & @CRLF & "AppContainer Dir: " & @TAB & @LocalAppDataDir & "\Packages\" & $MonikerLower)

;GUICtrlSetData($OutputText, "AppContainer process likely failed.")

EndIf

EndFunc


Func CheckPermissive2()
    Local $sReturn = ''
    For $i = 0 To _GUICtrlListView_GetItemCount($CapabilitiesList) - 1
        ; IsSystemPolicy is column 8
		$permissivecheck = _GUICtrlListView_GetItemText($CapabilitiesList, $i, 0)
		If $permissivecheck = 'permissiveLearningMode' Then
			;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", "permissiveLearningMode found." & @CRLF)
			If _GUICtrlListView_GetItemChecked($CapabilitiesList, $i) = True Then
				;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", "permissiveLearningMode box is checked." & @CRLF)
				_GUICtrlListView_SetItemChecked($CapabilitiesList, $i, False)
			ElseIf _GUICtrlListView_GetItemChecked($CapabilitiesList, $i) = False Then
				;_ExtMsgBox (0 & ";" & @ScriptDir & "\LaunchAppContainer.exe", 0, "Launch AppContainer", "Don't forget to check the permissiveLearningMode capability box prior to starting the learning trace." & @CRLF)
				_GUICtrlListView_SetItemChecked($CapabilitiesList, $i)
			EndIf
				;_GUICtrlListView_SetItemChecked
		Else
			;MsgBox($MB_SYSTEMMODAL, "Title", "permissiveLearningMode NOT FOUND!")
		EndIf
		;If _GUICtrlListView_GetItemChecked($CapabilitiesList, $i) Then
        ;    $sReturn &= $systempol & '|'

        ;EndIf
	Next

Endfunc


While 1
    $MSG = GUIGetMsg()
    Select
        Case $MSG = $GUI_EVENT_CLOSE
            Exit
        Case $MSG = $StartupDirButton
			StartupDir()
		Case $MSG = $ProgramButton
			BrowsePrograms()
		Case $MSG = $SetAppContainACLButton
			UpdateACNameIni()
			Run('SetAppContainerACL.exe', @ScriptDir)
		Case $MSG = $LearningModeButton
			UpdateACNameIni()
			Run('LearningMode.exe', @ScriptDir)
		Case $MSG = $RUN_1
			UpdateACNameIni()
			GUICtrlSetData($OutputText, '')
            ACNameCheck()
			;CapabilityTest()
    EndSelect

WEnd

