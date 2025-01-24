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
#include <Misc.au3>                                          ; added:01/10/25 07:50:07
#EndRegion ; *** Dynamically added Include files ***

#NoTrayIcon

#pragma compile(Out, _build\SetAppContainerACL.exe)
#pragma compile(OriginalFilename, SetAppContainerACL.exe)
#pragma compile(Icon, app.ico)
#pragma compile(x64, true)
#pragma compile(FileDescription, Set AppContainer ACL)
#pragma compile(FileVersion, 1.0.0)
#pragma compile(ProductVersion, 1.0.0)
#pragma compile(ProductName, SetAppContainerACL)
#pragma compile(LegalCopyright, @ 2025 WildByDesign)
#pragma compile(Compatibility, win10)

#include <GUIConstants.au3>
#include <File.au3>

#include "includes\ExtMsgBox.au3"
#include "includes\GuiCtrls_HiDpi.au3"
#include "includes\GUIDarkMode_v0.02mod.au3"
#include "includes\GUIListViewEx.au3"

#include "includes\GUIComboBoxColor.au3"
#include "includes\GUIComboBoxFont.au3"

; System aware DPI awareness
DllCall("User32.dll", "bool", "SetProcessDPIAware")

; Per-monitor V2 DPI awareness
;DllCall("User32.dll", "bool", "SetProcessDpiAwarenessContext" , "HWND", "DPI_AWARENESS_CONTEXT" -4)

If _Singleton("SetAppContainerACL", 1) = 0 Then
        $sMsg = " An instance of Set AppContainer ACL is already running. " & @CRLF
		MsgBox($MB_SYSTEMMODAL, "Set AppContainer ACL", $sMsg)
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
	$ListViewWidth = 340
	$ListViewHeight = 362
	$GUIWidth = 690
	$GUIHeight = 483
	$OutputBoxWidth = 660
	$ClientAreaTitlebar = 24
	$BigInputBox = @DesktopWidth / 4
	$SmallInputBox = @DesktopWidth / 7
	$BigComboWidth = 64
	$SmallComboWidth = 50
ElseIf $GetDPI = 120 Then
	$DPIScale = 125
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 16
	$TextPosFixVert = 2
	$ButtonSpaceHor = 10
	$ListViewWidth = 388
	$ListViewHeight = 254
	$GUIWidth = 710
	$GUIHeight = 554
	$OutputBoxWidth = 680
	$ClientAreaTitlebar = 30
	$BigInputBox = @DesktopWidth / 3.5
	$SmallInputBox = @DesktopWidth / 6.5
	$BigComboWidth = 74
	$SmallComboWidth = 60
ElseIf $GetDPI = 144 Then
	$DPIScale = 150
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$ListViewWidth = 482
	$ListViewHeight = 356
	$GUIWidth = 710
	$GUIHeight = 554
	$OutputBoxWidth = 680
	$ClientAreaTitlebar = 34
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5.5
	$BigComboWidth = 90
	$SmallComboWidth = 70
ElseIf $GetDPI = 168 Then
	$DPIScale = 175
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$ListViewWidth = 482
	$ListViewHeight = 356
	$GUIWidth = 710
	$GUIHeight = 554
	$OutputBoxWidth = 680
	$ClientAreaTitlebar = 40
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5
	$BigComboWidth = 105
	$SmallComboWidth = 80
ElseIf $GetDPI = 192 Then
	$DPIScale = 200
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$ListViewWidth = 388
	$ListViewHeight = 354
	$GUIWidth = 710
	$GUIHeight = 554
	$OutputBoxWidth = 680
	$ClientAreaTitlebar = 48
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5
	$BigComboWidth = 120
	$SmallComboWidth = 100
Else
	$InputBoxHeight = -1
	$TitleSpaceVert = 4
	$SectionSpaceVert = 12
	$TextPosFixVert = 1
	$ButtonSpaceHor = 10
	$ListViewWidth = 388
	$ListViewHeight = 354
	$GUIWidth = 710
	$GUIHeight = 554
	$OutputBoxWidth = 680
	$ClientAreaTitlebar = 48
	$BigInputBox = @DesktopWidth / 3
	$SmallInputBox = @DesktopWidth / 5
	$BigComboWidth = 120
	$SmallComboWidth = 100
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


Global $IsLPAC, $isWin32k, $isDeleteAC, $LPAC, $Win32k, $DeleteAC, $MonikerCLI
Global $LaunchAppContainer = @ScriptDir & '\bin\LaunchAppContainer.exe'
Global $StartupFolder = ""


If IsAdmin() Then
	$hGUI = GUICreate("Set AppContainer ACL [Administrator]", $GUIWidth, $GUIHeight, -1, -1, $WS_SIZEBOX + $WS_SYSMENU + $WS_MINIMIZEBOX + $WS_MAXIMIZEBOX)
	GUISetFont(10, $FW_NORMAL, -1, $MainFont)
Else
	$hGUI = GUICreate("Set AppContainer ACL", $GUIWidth, $GUIHeight, -1, -1, $WS_SIZEBOX + $WS_SYSMENU + $WS_MINIMIZEBOX + $WS_MAXIMIZEBOX)
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
$AppContainerNameTextHeight2 = $aPos[3]

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


GUISetFont(10, $FW_NORMAL, -1, $MainFont)

;$ACLareatest = GUICtrlCreateLabel("", 10, 365, 580, 180, $WS_BORDER + $WS_CLIPSIBLINGS)
;GUICtrlSetState($ACLareatest, $GUI_DISABLE)


$FolderACLLabel = GUICtrlCreateLabel("Add Folder ACL Permissions:", 15, $AppContainerNameTextPosV + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetFont($FolderACLLabel, 10, $FW_BOLD, -1, "Segoe UI")
$aPos = ControlGetPos($hGUI, "", $FolderACLLabel)
$hFolderACLLabel = GUICtrlGetHandle($FolderACLLabel)

$FolderACLLabelPosV = $aPos[1] + 4
$FolderACLLabelPosH = $aPos[0] + $aPos[2]
$FolderACLLabelHeight = $aPos[1] + $aPos[3]
$FolderACLLabelHeight2 = $aPos[3]

GUISetFont(10, -1, -1, "Segoe MDL2 Assets")


$FolderACLLabelInfo = GUICtrlCreateLabel("", $FolderACLLabelPosH, $FolderACLLabelPosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$FolderACLLabelInfo = GUICtrlCreateLabel("", $FolderACLLabelPosH, $FolderACLLabelPosV, -1, -1)
;GUICtrlSetFont($FolderACLLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")
$hFolderACLLabelInfo = GUICtrlGetHandle($FolderACLLabelInfo)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

GUICtrlCreateLabel(" ", $FolderACLLabelPosH + 50, $FolderACLLabelPosV - 4, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

;_GUIToolTip_AddTool($hToolTip2, 0, " This option will delete the AppContainer profile " & @CRLF & " folder upon exit of the sandboxed program. ", $hDeleteACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" This will add Full Control to the ACL permissions " & @CRLF & _
		" specifically for the SID associated with the AppContainer " & @CRLF & _
		" Name chosen to the directory selected. " & @CRLF & @CRLF & _
		" All files and sub-directories within the selected folder " & @CRLF & _
		" will inherit the same permissions. " & @CRLF & @CRLF & _
		" Note: Some areas of the filesystem will require this " & @CRLF & _
		" to be run as Admin. ", $hFolderACLLabelInfo)

$FolderACLText = GUICtrlCreateInput("", 15, $FolderACLLabelHeight + $TitleSpaceVert, $BigInputBox, $AutoTextHeight, -1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hFolderACLText = GUICtrlGetHandle($FolderACLText)
$aPos = ControlGetPos($hGUI, "", $FolderACLText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$FolderACLTextPosV = $aPos[1] + $aPos[3]
$FolderACLTextPosH = $aPos[0] + $aPos[2]
$FolderACLTextHeight = $aPos[3]

If $isDarkMode = True Then
	$cLabel3 = GUICtrlCreateLabel("", 15, $FolderACLTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel3, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel3, 0x828790)
Else
	$cLabel3 = GUICtrlCreateLabel("", 15, $FolderACLTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel3, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel3, 0x000000)
EndIf

;$FolderACLButton = GUICtrlCreateButton(" Browse ", 510, $FolderACLLabelHeight + $TitleSpaceVert, -1, -1)
GUISetFont(12, $FW_NORMAL, -1, "Segoe MDL2 Assets")
$FolderACLButton = GUICtrlCreateButton("", $FolderACLTextPosH + $ButtonSpaceHor, $FolderACLLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight, $BS_VCENTER + $BS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $FolderACLButton)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$FolderACLButtonPosV = $aPos[1] + $aPos[3]
$FolderACLButtonPosH = $aPos[0] + $aPos[2]
$FolderACLButtonWidth = $aPos[2]

GUISetFont(10, $FW_NORMAL, -1, $MainFont)


Local $aFolderACL[2]
$aFolderACL[0] = "Full"
$aFolderACL[1] = "RX"


Local $FolderACLCombo = GUICtrlCreateCombo("|", $FolderACLButtonPosH + $ButtonSpaceHor, $FolderACLLabelHeight + $TitleSpaceVert, $BigComboWidth, $AutoTextHeight)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetData($FolderACLCombo, "RX")
$hFolderACLCombo = GUICtrlGetHandle($FolderACLCombo)

If $isDarkMode = True Then
	_GUICtrlComboBoxEx_SetColor($FolderACLCombo, 0x282828, 0xffffff)
Else
	_GUICtrlComboBoxEx_SetColor($FolderACLCombo, 0xffffff, 0x000000)
EndIf

$aFolder = ""
For $i = 0 To Ubound($aFolderACL)-1
	$aFolder &= "|" & $aFolderACL[$i]
Next
GUICtrlSetData($FolderACLCombo, $aFolder)

$aPos = ControlGetPos($hGUI, "", $FolderACLCombo)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$FolderACLComboPosV = $aPos[1] + $aPos[3]
$FolderACLComboPosH = $aPos[0] + $aPos[2]


GUISetFont(10, $FW_NORMAL, -1, $MainFont)
$FolderACLButtonSet = GUICtrlCreateButton(" Set ", $FolderACLComboPosH + $ButtonSpaceHor, $FolderACLLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight, $BS_VCENTER + $BS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

; LABEL
$FileACLLabel = GUICtrlCreateLabel("Add File ACL Permissions:", 15, $FolderACLTextPosV + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetFont($FileACLLabel, 10, $FW_BOLD, -1, "Segoe UI")
$aPos = ControlGetPos($hGUI, "", $FileACLLabel)
$hFileACLLabel = GUICtrlGetHandle($FileACLLabel)

$FileACLLabelPosV = $aPos[1] + 4
$FileACLLabelPosH = $aPos[0] + $aPos[2]
$FileACLLabelHeight = $aPos[1] + $aPos[3]
$FileACLLabelHeight2 = $aPos[3]

GUISetFont(10, $FW_NORMAL, -1, "Segoe MDL2 Assets")


$FileACLLabelInfo = GUICtrlCreateLabel("", $FileACLLabelPosH, $FileACLLabelPosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$FileACLLabelInfo = GUICtrlCreateLabel("", $FileACLLabelPosH, $FileACLLabelPosV, -1, -1)
;GUICtrlSetFont($FileACLLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")
$hFileACLLabelInfo = GUICtrlGetHandle($FileACLLabelInfo)
;GUICtrlSetResizing($FileACLLabelInfo, $GUI_DOCKLEFT)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

GUICtrlCreateLabel(" ", $FileACLLabelPosH + 50, $FileACLLabelPosV - 4, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

;_GUIToolTip_AddTool($hToolTip2, 0, " This option will delete the AppContainer profile " & @CRLF & " folder upon exit of the sandboxed program. ", $hDeleteACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" This will add Full Control to the ACL permissions " & @CRLF & _
		" specifically for the SID associated with the AppContainer " & @CRLF & _
		" Name chosen to the file selected. " & @CRLF & @CRLF & _
		" Note: Some areas of the filesystem will require this " & @CRLF & _
		" to be run as Admin. ", $hFileACLLabelInfo)


; Input
GUISetFont(10, $FW_NORMAL, -1, $MainFont)

$FileACLText = GUICtrlCreateInput("", 15, $FileACLLabelHeight + $TitleSpaceVert, $BigInputBox, $AutoTextHeight, -1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hFileACLText = GUICtrlGetHandle($FileACLText)
$aPos = ControlGetPos($hGUI, "", $FileACLText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$FileACLTextPosV = $aPos[1] + $aPos[3]
$FileACLTextPosH = $aPos[0] + $aPos[2]
$FileACLTextHeight = $aPos[3]

If $isDarkMode = True Then
	$cLabel4 = GUICtrlCreateLabel("", 15, $FileACLTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel4, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel4, 0x828790)
Else
	$cLabel4 = GUICtrlCreateLabel("", 15, $FileACLTextPosV, $BigInputBox, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel4, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel4, 0x000000)
EndIf


;$FileACLButton = GUICtrlCreateButton(" Browse ", 510, $FileACLLabelHeight + $TitleSpaceVert, -1, -1)

GUISetFont(12, $FW_NORMAL, -1, "Segoe MDL2 Assets")
$FileACLButton = GUICtrlCreateButton("", $FileACLTextPosH + $ButtonSpaceHor, $FileACLLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight, $BS_VCENTER + $BS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $FileACLButton)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$FileACLButtonPosV = $aPos[1] + $aPos[3]
$FileACLButtonPosH = $aPos[0] + $aPos[2]
$FileACLButtonWidth = $aPos[2]

GUISetFont(10, $FW_NORMAL, -1, $MainFont)


Local $aFileACL[2]
$aFileACL[0] = "Full"
$aFileACL[1] = "RX"


Local $FileACLCombo = GUICtrlCreateCombo("|", $FileACLButtonPosH + $ButtonSpaceHor, $FileACLLabelHeight + $TitleSpaceVert, $BigComboWidth, $AutoTextHeight)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetData($FileACLCombo, "RX")
$hFileACLCombo = GUICtrlGetHandle($FileACLCombo)

If $isDarkMode = True Then
	_GUICtrlComboBoxEx_SetColor($FileACLCombo, 0x282828, 0xffffff)
Else
	_GUICtrlComboBoxEx_SetColor($FileACLCombo, 0xffffff, 0x000000)
EndIf

$aFile = ""
For $i = 0 To Ubound($aFileACL)-1
	$aFile &= "|" & $aFileACL[$i]
Next
GUICtrlSetData($FileACLCombo, $aFile)

$aPos = ControlGetPos($hGUI, "", $FileACLCombo)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$FileACLComboPosV = $aPos[1] + $aPos[3]
$FileACLComboPosH = $aPos[0] + $aPos[2]


GUISetFont(10, $FW_NORMAL, -1, $MainFont)
$FileACLButtonSet = GUICtrlCreateButton(" Set ", $FileACLComboPosH + $ButtonSpaceHor, $FileACLLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight, $BS_VCENTER + $BS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)



; LABEL
$RegistryACLLabel = GUICtrlCreateLabel("Add Registry ACL Permissions:", 15, $FileACLTextPosV + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetFont($FileACLLabel, 10, $FW_BOLD, -1, "Segoe UI")
$aPos = ControlGetPos($hGUI, "", $RegistryACLLabel)
$hRegistryACLLabel = GUICtrlGetHandle($RegistryACLLabel)

$RegistryACLLabelPosV = $aPos[1] + 4
$RegistryACLLabelPosH = $aPos[0] + $aPos[2]
$RegistryACLLabelHeight = $aPos[1] + $aPos[3]
$RegistryACLLabelHeight2 = $aPos[3]

GUISetFont(10, $FW_NORMAL, -1, "Segoe MDL2 Assets")


$RegistryACLLabelInfo = GUICtrlCreateLabel("", $RegistryACLLabelPosH, $RegistryACLLabelPosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$FileACLLabelInfo = GUICtrlCreateLabel("", $FileACLLabelPosH, $FileACLLabelPosV, -1, -1)
;GUICtrlSetFont($FileACLLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")
$hRegistryACLLabelInfo = GUICtrlGetHandle($RegistryACLLabelInfo)
;GUICtrlSetResizing($FileACLLabelInfo, $GUI_DOCKLEFT)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

GUICtrlCreateLabel(" ", $RegistryACLLabelPosH + 50, $RegistryACLLabelPosV - 4, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

;_GUIToolTip_AddTool($hToolTip2, 0, " This option will delete the AppContainer profile " & @CRLF & " folder upon exit of the sandboxed program. ", $hDeleteACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" This will add Full Control to the ACL permissions " & @CRLF & _
		" specifically for the SID associated with the AppContainer " & @CRLF & _
		" Name chosen to the registry key. " & @CRLF & @CRLF & _
		" Note: Some areas of the registry will require this " & @CRLF & _
		" to be run as Admin. ", $hRegistryACLLabelInfo)


; Input
GUISetFont(10, $FW_NORMAL, -1, $MainFont)

$RegistryACLText = GUICtrlCreateInput("", 15, $RegistryACLLabelHeight + $TitleSpaceVert, $BigInputBox + $ButtonSpaceHor + $FileACLButtonWidth - 4, $AutoTextHeight, -1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hRegistryACLText = GUICtrlGetHandle($RegistryACLText)
$aPos = ControlGetPos($hGUI, "", $RegistryACLText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$RegistryACLTextPosV = $aPos[1] + $aPos[3]
$RegistryACLTextPosH = $aPos[0] + $aPos[2]
$RegistryACLTextHeight = $aPos[3]
$RegistryACLTextWidth = $aPos[2]

If $isDarkMode = True Then
	$cLabel4 = GUICtrlCreateLabel("", 15, $RegistryACLTextPosV, $BigInputBox + $ButtonSpaceHor + $FileACLButtonWidth - 4, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel4, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel4, 0x828790)
Else
	$cLabel4 = GUICtrlCreateLabel("", 15, $RegistryACLTextPosV, $BigInputBox + $ButtonSpaceHor + $FileACLButtonWidth - 4, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel4, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel4, 0x000000)
EndIf


Local $aRegistryACL[2]
$aRegistryACL[0] = "Full"
$aRegistryACL[1] = "Read"


Local $RegistryACLCombo = GUICtrlCreateCombo("|", $RegistryACLTextPosH + $ButtonSpaceHor + 4, $RegistryACLLabelHeight + $TitleSpaceVert, $BigComboWidth, $AutoTextHeight)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hRegistryACLCombo = GUICtrlGetHandle($RegistryACLCombo)

If $isDarkMode = True Then
	_GUICtrlComboBoxEx_SetColor($RegistryACLCombo, 0x282828, 0xffffff)
Else
	_GUICtrlComboBoxEx_SetColor($RegistryACLCombo, 0xffffff, 0x000000)
EndIf
;GUICtrlSetData($RegistryACLCombo, "Read")

$aRegistry = ""
For $i = 0 To Ubound($aRegistryACL)-1
	$aRegistry &= "|" & $aRegistryACL[$i]
Next
GUICtrlSetData($RegistryACLCombo, $aRegistry)

$aPos = ControlGetPos($hGUI, "", $RegistryACLCombo)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$RegistryACLComboPosV = $aPos[1] + $aPos[3]
$RegistryACLComboPosH = $aPos[0] + $aPos[2]
$RegistryACLComboWidth = $aPos[2]

$RegistryACLButton = GUICtrlCreateButton(" Set ", $RegistryACLComboPosH + $ButtonSpaceHor, $RegistryACLLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight, $BS_VCENTER + $BS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $RegistryACLButton)
$hRegistryACLButton = GUICtrlGetHandle($RegistryACLButton)
$RegistryACLButtonWidth = $aPos[2]

Local $aDrives = DriveGetDrive($DT_ALL)
If @error Then
        ; An error occurred when retrieving the drives.
        MsgBox($MB_SYSTEMMODAL, "", "It appears an error occurred.")
Else
        For $i = 1 To $aDrives[0]
            ; Show all the drives found and convert the drive letter to uppercase.
            ;MsgBox($MB_SYSTEMMODAL, "", "Drive " & $i & "/" & $aDrives[0] & ":" & @CRLF & StringUpper($aDrives[$i]))
			$stringUpper = StringUpper($aDrives[$i])
			$aDrives[$i] = StringReplace($aDrives[$i], $aDrives[$i], $stringUpper)
        Next
EndIf

_ArrayDelete($aDrives, 0)

;_ArrayDisplay($aDrives, "initial drive list")


Local $sFileSystem = DriveGetFileSystem($aDrives[0] & "\") ; Find the file system type of the home drive, generally this is the C:\ drive.
;MsgBox($MB_SYSTEMMODAL, "", "File System Type: " & $sFileSystem)


For $i = UBound($aDrives) - 1 To 0 Step -1
	Local $sFileSystem = DriveGetFileSystem($aDrives[$i] & "\")
	;If $sFileSystem <> 'NTFS' Or 'ReFS' Then
	If $sFileSystem = 'NTFS' Or 'ReFS' Then
		;_ArrayDelete($aDrives, $i)
		;MsgBox($MB_SYSTEMMODAL, "", "File System Type: " & $sFileSystem)
	Else
		;MsgBox($MB_SYSTEMMODAL, "", "File System Type: " & $sFileSystem)
		_ArrayDelete($aDrives, $i)
	EndIf
	;If $aDrives[$i][1] <> 'Permissive' Then _ArrayDelete($aDrives, $i)
Next


;_ArrayDisplay($aDrives, "after removing non-NTFS or ReFS")


$DriveACLLabel = GUICtrlCreateLabel("Add Volume Root ACL Permissions (minimal):", 15, $RegistryACLTextPosV + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;GUICtrlSetFont($FileACLLabel, 10, $FW_BOLD, -1, "Segoe UI")
$aPos = ControlGetPos($hGUI, "", $DriveACLLabel)
$hDriveACLLabel = GUICtrlGetHandle($DriveACLLabel)

$DriveACLLabelPosV = $aPos[1] + 4
$DriveACLLabelPosH = $aPos[0] + $aPos[2]
$DriveACLLabelHeight = $aPos[1] + $aPos[3]
$DriveACLLabelHeight2 = $aPos[3]

GUISetFont(10, $FW_NORMAL, -1, "Segoe MDL2 Assets")


$DriveACLLabelInfo = GUICtrlCreateLabel("", $DriveACLLabelPosH, $DriveACLLabelPosV, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


;$FileACLLabelInfo = GUICtrlCreateLabel("", $FileACLLabelPosH, $FileACLLabelPosV, -1, -1)
;GUICtrlSetFont($FileACLLabelInfo, 10, -1, -1, "Segoe MDL2 Assets")
$hDriveACLLabelInfo = GUICtrlGetHandle($DriveACLLabelInfo)
;GUICtrlSetResizing($FileACLLabelInfo, $GUI_DOCKLEFT)

GUISetFont(10, $FW_NORMAL, -1, $MainFont)

GUICtrlCreateLabel(" ", $DriveACLLabelPosH + 50, $DriveACLLabelPosV - 4, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

;_GUIToolTip_AddTool($hToolTip2, 0, " This option will delete the AppContainer profile " & @CRLF & " folder upon exit of the sandboxed program. ", $hDeleteACLabel)
_GUIToolTip_AddTool($hToolTip2, 0, _
		" This will add minimal (RX) permissions to the volume " & @CRLF & _
		" root of the selected drive. No other files or folders " & @CRLF & _
		" on the selected drive will inherit these permissions. " & @CRLF & @CRLF & _
		" This is similar to how isolatedWin32-volumeRootMinimal " & @CRLF & _
		" capability works in win32-app-isolation. That will " & @CRLF & _
		" unfortunately not work with regular AppContainers " & @CRLF & _
		" created using this tool, unfortunately. " & @CRLF & @CRLF & _
		" The benefit is being able to traverse directories " & @CRLF & _
		" with command line tools and other win32 apps. " & @CRLF & @CRLF & _
		" Example: You have several directoies deep within your " & @CRLF & _
		" filesystem but you get Access Denied when you try to " & @CRLF & _
		" access them by command line despite already having " & @CRLF & _
		" set per-container permissions to access them. ", $hDriveACLLabelInfo)


; Input
GUISetFont(10, $FW_NORMAL, -1, $MainFont)


Local $DriveACLCombo = GUICtrlCreateCombo("|", 15, $DriveACLLabelHeight + $TitleSpaceVert, $SmallComboWidth, $AutoTextHeight)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hDriveACLCombo = GUICtrlGetHandle($DriveACLCombo)

If $isDarkMode = True Then
	_GUICtrlComboBoxEx_SetColor($DriveACLCombo, 0x282828, 0xffffff)
Else
	_GUICtrlComboBoxEx_SetColor($DriveACLCombo, 0xffffff, 0x000000)
EndIf
;GUICtrlSetData($DriveACLCombo, "Read")

$cData = ""
For $i = 0 To Ubound($aDrives)-1
 $cData &= "|" & $aDrives[$i]
Next
GUICtrlSetData($DriveACLCombo, $cData)


$aPos = ControlGetPos($hGUI, "", $DriveACLCombo)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$DriveACLComboPosV = $aPos[1] + $aPos[3]
$DriveACLComboPosH = $aPos[0] + $aPos[2]
$DriveACLComboHeight = $aPos[3]

$DriveACLButton = GUICtrlCreateButton(" Set ", $DriveACLComboPosH + $ButtonSpaceHor, $DriveACLLabelHeight + $TitleSpaceVert, -1, $AutoTextHeight, $BS_VCENTER + $BS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


$OutputLabel = GUICtrlCreateLabel("Output:", 15, $DriveACLComboPosV + $SectionSpaceVert, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$aPos = ControlGetPos($hGUI, "", $OutputLabel)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$OutputLabelPosV = $aPos[1] + $aPos[3]
$OutputLabelPosH = $aPos[0] + $aPos[2]
$OutputLabelHeight = $aPos[3]
;GUICtrlSetFont($OutputLabel, 10, $FW_BOLD, -1, "Segoe UI")
;$OutputText = GUICtrlCreateInput("", 15, 500, 985, 88, $ES_MULTILINE + $ES_AUTOVSCROLL + $WS_VSCROLL, 0)

;$OutputBoxWidthHelper = $RegistryACLTextWidth + $ButtonSpaceHor + $RegistryACLComboWidth + $ButtonSpaceHor + $RegistryACLButtonWidth
$OutputBoxWidthHelper = $RegistryACLTextWidth + $ButtonSpaceHor + 4 + $RegistryACLComboWidth + $ButtonSpaceHor + $RegistryACLButtonWidth

$OutputText = GUICtrlCreateInput("", 15, $OutputLabelPosV + $TitleSpaceVert, $OutputBoxWidthHelper + 20, 88, $ES_MULTILINE + $ES_AUTOVSCROLL, 0)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


$hOutputText = GUICtrlGetHandle($OutputText)
$aPos = ControlGetPos($hGUI, "", $OutputText)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$OutputTextPosV = $aPos[1] + $aPos[3]
$OutputTextPosH = $aPos[0] + $aPos[2]
$OutputTextHeight = $aPos[3]
$OutputTextWidth = $aPos[2]

If $isDarkMode = True Then
	$cLabel5 = GUICtrlCreateLabel("", 15, $OutputTextPosV, $OutputBoxWidthHelper + 20, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel5, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel5, 0x828790)
Else
	$cLabel5 = GUICtrlCreateLabel("", 15, $OutputTextPosV, $OutputBoxWidthHelper + 20, 1)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetState($cLabel5, $GUI_DISABLE)
	GUICtrlSetBkColor($cLabel5, 0x000000)
EndIf



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

Endfunc

If $isDarkMode = True Then
	GUICtrlSetBkColor($AppContainerNameText, 0x282828)
	GUICtrlSetBkColor($FolderACLText, 0x282828)
	GUICtrlSetBkColor($FileACLText, 0x282828)
	GUICtrlSetBkColor($RegistryACLText, 0x282828)
	GUICtrlSetBkColor($OutputText, 0x282828)
Else
	GUICtrlSetBkColor($AppContainerNameText, 0xffffff)
	GUICtrlSetBkColor($FolderACLText, 0xffffff)
	GUICtrlSetBkColor($FileACLText, 0xffffff)
	GUICtrlSetBkColor($RegistryACLText, 0xffffff)
	GUICtrlSetBkColor($OutputText, 0xffffff)
EndIf

;GUICtrlSetState($ProgramText, $GUI_FOCUS)


$ClientAreaHeight = 20 + $AutoTextHeight + $TitleSpaceVert + $AppContainerNameTextHeight2 + $SectionSpaceVert + $FolderACLLabelHeight2 + $TitleSpaceVert + $FolderACLTextHeight + $SectionSpaceVert + $FileACLLabelHeight2 + $TitleSpaceVert + $FileACLTextHeight + $SectionSpaceVert + $RegistryACLLabelHeight2 + $TitleSpaceVert + $RegistryACLTextHeight + $SectionSpaceVert + $DriveACLLabelHeight2 + $TitleSpaceVert + $DriveACLComboHeight + $SectionSpaceVert + $OutputLabelHeight + $TitleSpaceVert + $OutputTextHeight + 20 + 5
$ClientAreaWidth = 15 + $OutputTextWidth + 15


;GUISetState()

;WinMove($hGUI,'', -1, -1, $ClientAreaWidth, $ClientAreaHeight)
;WinMove($hGUI,'', -1, -1, 500, 500)

;GUISetState()

WinMove($hGUI,'',(@Desktopwidth - WinGetPos($hGUI)[2]) / 2,(@Desktopheight - WinGetPos($hGUI)[3]) / 2, $ClientAreaWidth + 6, $ClientAreaHeight + $ClientAreaTitlebar)
;WinMove($hGUI,'',(@Desktopwidth - WinGetPos($hGUI)[2]) / 2,(@Desktopheight - WinGetPos($hGUI)[3]) / 2, 804, 802)

;Sleep(500)

;GUISetState()

GUISetStyle($GUI_SS_DEFAULT_GUI, -1)

WinMove($hGUI,'', (@Desktopwidth - WinGetPos($hGUI)[2]) / 2,(@Desktopheight - WinGetPos($hGUI)[3]) / 2)

GUISetState(@SW_SHOWMINIMIZED)
GUISetState(@SW_RESTORE)

WinSetOnTop($hGUI, "", $WINDOWS_ONTOP)
WinSetOnTop($hGUI, "", $WINDOWS_NOONTOP)

GUICtrlSetState($FolderACLText, $GUI_FOCUS)



Func BrowseFolders()
Local $mFolder

$mFolder = FileSelectFolder("Select a folder", @ScriptDir)
If @error Then
    ConsoleWrite("error")
Else
	;MsgBox($MB_SYSTEMMODAL, "", $mFile)
	;GUICtrlSetData($FolderACLText, $mFolder)
	Global $ACLFolder = '"' & $mFolder & '"'
	GUICtrlSetData($FolderACLText, $ACLFolder)

EndIf
EndFunc


Func BrowseFoldersSetACL()

	GUICtrlSetData($OutputText, '')
	Local $FolderACLPerm = GUICtrlRead($FolderACLCombo)
	$ACLFolder = GUICtrlRead($FolderACLText)

	If $ACLFolder = '' Then
		_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "Folder ACL box is blank." & @CRLF)
		Return
	Else

		$icacls = @SystemDir & '\icacls.exe'
		$grant = " /grant *"
		$Moniker = GUICtrlRead($AppContainerNameText)
		$MonikerLower = StringLower($Moniker)
		If $FolderACLPerm = 'Full' Then
			$perms = ":(OI)(CI)(F)"
		ElseIf $FolderACLPerm = 'RX' Then
			$perms = ":(OI)(CI)(RX)"
		EndIf

		Local $o_Pid2 = Run(@ComSpec & " /c " & @ScriptDir & "\bin\AppContainerSid.exe" & " " & $Moniker, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

		ProcessWaitClose($o_Pid2)
		$out2 = StdoutRead($o_Pid2)

		$ACSID = StringStripWS($out2, $STR_STRIPSPACES + $STR_STRIPLEADING + $STR_STRIPTRAILING)

		Local $o_Pid = Run(@ComSpec & " /c " & $icacls & " " & $ACLFolder & $grant & $ACSID & $perms, @SystemDir, @SW_HIDE, $STDOUT_CHILD)
		;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $icacls & " " & $ACLFolder & $grant & $ACSID & $perms)

		ProcessWaitClose($o_Pid)
		$out = StdoutRead($o_Pid)
		$icaclsmsg = StringStripWS($out, $STR_STRIPLEADING + $STR_STRIPTRAILING)
		;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $out)
		GUICtrlSetData($OutputText, $icaclsmsg)
	EndIf
EndFunc


Func BrowseFiles()
Local $mFile

$mFile = FileOpenDialog("Select a file", @ScriptDir, "All Files (*.*)", 1)
If @error Then
    ConsoleWrite("error")
Else
	;MsgBox($MB_SYSTEMMODAL, "", $mFile)
	$ACLFile = '"' & $mFile & '"'
	GUICtrlSetData($FileACLText, $ACLFile)
	;GUICtrlSetData($FileACLText, $mFile)

EndIf
EndFunc

Func BrowseFilesSetACL()

	GUICtrlSetData($OutputText, '')
	Local $FileACLPerm = GUICtrlRead($FileACLCombo)
	$ACLFile = GUICtrlRead($FileACLText)

	If $ACLFile = '' Then
		_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "File ACL box is blank." & @CRLF)
		Return
	Else
		$icacls = @SystemDir & '\icacls.exe'
		$grant = " /grant *"
		$Moniker = GUICtrlRead($AppContainerNameText)
		$MonikerLower = StringLower($Moniker)
		If $FileACLPerm = 'Full' Then
			$perms = ":(F)"
		ElseIf $FileACLPerm = 'RX' Then
			$perms = ":(RX)"
		EndIf
		Local $o_Pid2 = Run(@ComSpec & " /c " & @ScriptDir & "\bin\AppContainerSid.exe" & " " & $Moniker, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

		ProcessWaitClose($o_Pid2)
		$out2 = StdoutRead($o_Pid2)

		$ACSID = StringStripWS($out2, $STR_STRIPSPACES + $STR_STRIPLEADING + $STR_STRIPTRAILING)

		Local $o_Pid = Run(@ComSpec & " /c " & $icacls & " " & $ACLFile & $grant & $ACSID & $perms, @SystemDir, @SW_HIDE, $STDOUT_CHILD)
		;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $icacls & " " & $ACLFile & $grant & $ACSID & $perms)

		ProcessWaitClose($o_Pid)
		$out = StdoutRead($o_Pid)
		$icaclsmsg = StringStripWS($out, $STR_STRIPLEADING + $STR_STRIPTRAILING)
		;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $out)
		GUICtrlSetData($OutputText, $icaclsmsg)
	EndIf
EndFunc


Func RegistrySetACL()

	GUICtrlSetData($OutputText, '')
	Local $RegistryACLPerm = GUICtrlRead($RegistryACLCombo)
	Local $RegistryACL = GUICtrlRead($RegistryACLText)
	Local $CheckQuotes = StringInStr($RegistryACL, '"')

	If $CheckQuotes = 0 Then
		$ContainsQuotes = False
	Else
		$ContainsQuotes = True
	EndIf

	If $RegistryACL = '' Then
		_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "Registry ACL box is blank." & @CRLF)
		Return
	Else
	EndIf

	If $ContainsQuotes = True Then
		$RegistryACL = $RegistryACL
	Else
		$RegistryACL = '"' & $RegistryACL & '"'
	EndIf


	$Moniker = GUICtrlRead($AppContainerNameText)
	$MonikerLower = StringLower($Moniker)

	Local $o_Pid1 = Run(@ComSpec & " /c " & @ScriptDir & "\bin\AppContainerSid.exe" & " " & $Moniker, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

	ProcessWaitClose($o_Pid1)
	$out2 = StdoutRead($o_Pid1)

	$ACSID = StringStripWS($out2, $STR_STRIPSPACES + $STR_STRIPLEADING + $STR_STRIPTRAILING)

	If $RegistryACLPerm = 'Full' Then
		$cmd1 = @ScriptDir & "\bin\SetACL.exe" & " -on " & $RegistryACL & ' -ot reg -actn ace -ace "n:' & $ACSID & ';p:full"'
	ElseIf $RegistryACLPerm = 'Read' Then
		$cmd1 = @ScriptDir & "\bin\SetACL.exe" & " -on " & $RegistryACL & ' -ot reg -actn ace -ace "n:' & $ACSID & ';p:read"'
	EndIf
	; setacl -on "hkcu\Console" -ot reg -actn ace -ace "n:S-1-15-2-2;p:full"
	;$cmd1 = @ScriptDir & "\bin\SetACL.exe" & " -on " & $RegistryACL & ' -ot reg -actn ace -ace "n:' & $ACSID & ';p:full"'
	Local $o_Pid2 = Run($cmd1, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $cmd1 & @CRLF)

	ProcessWaitClose($o_Pid2)
	$out2 = StdoutRead($o_Pid2)
	$setaclmsg = StringStripWS($out2, $STR_STRIPLEADING + $STR_STRIPTRAILING)
	;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $out)
	GUICtrlSetData($OutputText, $setaclmsg)

EndFunc




Func ACNameCheck()

Global $Moniker = GUICtrlRead($AppContainerNameText)
Global $MonikerLower = StringLower($Moniker)

If $Moniker = '' Then
_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "Please enter an AppContainer Name." & @CRLF)
Else
Global $MonikerCLI = ' -m ' & $Moniker

EndIf

Endfunc


Func VolumeRootSetACL()

	If Not IsAdmin() Then
		_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "This command requires running SetAppContainerACL as Admin." & @CRLF)
		Return
	EndIf

	GUICtrlSetData($OutputText, '')


	;$testmsg = "icacls.exe D: /grant *S-1-15-2-148355267-3854800384-2897749412-1371228441-296597757-3768963130-780219625:(RX)"

	$Moniker = GUICtrlRead($AppContainerNameText)
	$MonikerLower = StringLower($Moniker)

	Local $o_Pid1 = Run(@ComSpec & " /c " & @ScriptDir & "\bin\AppContainerSid.exe" & " " & $Moniker, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

	ProcessWaitClose($o_Pid1)
	$out2 = StdoutRead($o_Pid1)

	$ACSID = StringStripWS($out2, $STR_STRIPSPACES + $STR_STRIPLEADING + $STR_STRIPTRAILING)

	;Local $FileACLPerm = GUICtrlRead($FileACLCombo)
	$VolumeRootACL = GUICtrlRead($DriveACLCombo)

	If $VolumeRootACL = '' Then
		_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "No drive has been selected." & @CRLF)
		Return
	Else
	EndIf

	If $Moniker = '' Then
		_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", "No AppContainer name has been given." & @CRLF)
		Return
	Else
	EndIf

	; setacl -on "C:\\" -ot file -actn ace -ace "n:S-1-15-2-148355267-3854800384-2897749412-1371228441-296597757-3768963130-780219625;i:np;p:read_ex"

	$cmd1 = @ScriptDir & "\bin\SetACL.exe"
	$cmd2 = ' -on '
	$cmd3 = '"'
	$cmd4 = $VolumeRootACL
	$cmd5 = '\\"'
	$cmd6 = ' -ot file -actn ace -ace "n:'
	$cmd7 = $ACSID
	$cmd8 = ';i:np;p:read_ex"'
	$quote = '"'
	$cmd_all = $quote & $cmd1 & $quote & $cmd2 & $cmd3 & $cmd4 & $cmd5 & $cmd6 & $cmd7 & $cmd8

	;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $cmd1 & $cmd2 & $cmd3 & $cmd4 & $cmd5)
	;_ExtMsgBox (0 & ";" & @ScriptDir & "\SetAppContainerACL.exe", 0, "Set AppContainer ACL", $cmd_all)

	GUICtrlSetData($OutputText, "This can potentially take several minutes...")
	;Local $o_Pid3 = Run(@ComSpec & " /k " & '"' & $cmd1 & '"', @SystemDir)
	Local $o_Pid3 = Run($cmd_all, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)
	;Local $o_Pid3 = Run(@ComSpec & " /c " & @ScriptDir & "\bin\sysrun.exe" & " " & $cmd1 & $cmd2 & $cmd3 & $cmd4 & $cmd5, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)

	ProcessWaitClose($o_Pid3)
	$out3 = StdoutRead($o_Pid3)

	$VolumeRootOutput = StringStripWS($out3, $STR_STRIPLEADING + $STR_STRIPTRAILING)
	GUICtrlSetData($OutputText, $VolumeRootOutput)

EndFunc



While 1
    $MSG = GUIGetMsg()
    Select
        Case $MSG = $GUI_EVENT_CLOSE
            Exit
		Case $MSG = $FolderACLButton
			BrowseFolders()
		Case $MSG = $FileACLButton
			BrowseFiles()
		Case $MSG = $FolderACLButtonSet
			BrowseFoldersSetACL()
		Case $MSG = $FileACLButtonSet
			BrowseFilesSetACL()
		Case $MSG = $RegistryACLButton
			RegistrySetACL()
		Case $MSG = $DriveACLButton
			VolumeRootSetACL()
	EndSelect

WEnd

