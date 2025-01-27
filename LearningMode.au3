#RequireAdmin
#NoTrayIcon

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=app.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=AppContainer Learning Mode
#AutoIt3Wrapper_res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Res_Fileversion=1.0.2
#AutoIt3Wrapper_Res_ProductVersion=1.0.2
#AutoIt3Wrapper_Res_ProductName=AppContainerLearningMode
#AutoIt3Wrapper_Res_LegalCopyright=@ 2025 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#AutoIt3Wrapper_Res_Icon_Add=app.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region ; *** Dynamically added Include files ***
#include <Array.au3>                                         ; added:01/24/25 06:43:50
#include <AutoItConstants.au3>                               ; added:01/24/25 06:43:50
#include <File.au3>                                          ; added:01/24/25 06:43:50
#include <FileConstants.au3>                                 ; added:01/24/25 06:43:50
#include <FontConstants.au3>                                 ; added:01/24/25 06:43:50
#include <GUIConstantsEx.au3>                                ; added:01/24/25 06:43:50
#include <GuiListView.au3>                                   ; added:01/24/25 06:43:50
#include <GuiToolTip.au3>                                    ; added:01/24/25 06:43:50
#include <HeaderConstants.au3>                               ; added:01/24/25 06:43:50
#include <ListViewConstants.au3>                             ; added:01/24/25 06:43:50
#include <Misc.au3>                                          ; added:01/24/25 06:43:50
#include <MsgBoxConstants.au3>                               ; added:01/24/25 06:43:50
#include <StaticConstants.au3>                               ; added:01/24/25 06:43:50
#include <String.au3>                                        ; added:01/24/25 06:43:50
#include <StringConstants.au3>                               ; added:01/24/25 06:43:50
#include <StructureConstants.au3>                            ; added:01/24/25 06:43:50
#include <WinAPIFiles.au3>                                   ; added:01/24/25 06:43:50
#include <WinAPISysInternals.au3>                            ; added:01/24/25 06:43:50
#include <WinAPISysWin.au3>                                  ; added:01/24/25 06:43:50
#include <WinAPITheme.au3>                                   ; added:01/24/25 06:43:50
#include <WindowsConstants.au3>                              ; added:01/24/25 06:43:50
#EndRegion ; *** Dynamically added Include files ***

#include "includes\ExtMsgBox.au3"
#include "includes\GUIDarkMode_v0.02mod.au3"
#include "includes\GUIListViewEx.au3"


If @Compiled = 0 Then
	; System aware DPI awareness
	;DllCall("User32.dll", "bool", "SetProcessDPIAware")
	; Per-monitor V2 DPI awareness
	DllCall("User32.dll", "bool", "SetProcessDpiAwarenessContext" , "HWND", "DPI_AWARENESS_CONTEXT" -4)
EndIf


Global $tracepath = '"' & @LocalAppDataDir & '\Temp\AppContainerTrace.etl' & '"'
Global $xmlpath = '"' & @LocalAppDataDir & '\Temp\AppContainerTrace.xml' & '"'
Global $xmlpath2 = @LocalAppDataDir & '\Temp\AppContainerTrace.xml'
Global $aArray1, $aTemp, $aRetArray, $PermissiveCount, $aUniques
Global $cListView, $hListView, $aContent
Global $oComError = ObjEvent('AutoIt.Error', ErrorHandler)


If _Singleton("LearningMode", 1) = 0 Then
        $sMsg = " An instance of AppContainer Learning Mode is already running. " & @CRLF
		MsgBox($MB_SYSTEMMODAL, "AppContainer Learning Mode", $sMsg)
        Exit
EndIf


$GetDPI = _GetDPI()

; 96 DPI = 100% scaling
; 120 DPI = 125% scaling
; 144 DPI = 150% scaling
; 192 DPI = 200% scaling

If $GetDPI = 96 Then
	$DPIScale = 100
	$ListViewWidth = 1000
	$ListViewHeight = 340
	$hGUIWidth = 1020
	$hGUIHeight = 580
	$HorizontalSpace = 25
	$HorizontalSpaceSml = 15
	$VerticalSpaceSml = 8
	$VerticalSpace = 48
	$ClientAreaTitlebar = 24
ElseIf $GetDPI = 120 Then
	$DPIScale = 125
	$ListViewWidth = 1200
	$ListViewHeight = 340
	$hGUIWidth = 1220
	$hGUIHeight = 634
	$HorizontalSpace = 34
	$HorizontalSpaceSml = 10
	$VerticalSpaceSml = 14
	$VerticalSpace = 48
	$ClientAreaTitlebar = 30
ElseIf $GetDPI = 144 Then
	$DPIScale = 150
	$ListViewWidth = 1400
	$ListViewHeight = 380
	$hGUIWidth = 1420
	$hGUIHeight = 750
	$HorizontalSpace = 25
	$HorizontalSpaceSml = 20
	$VerticalSpaceSml = 14
	$VerticalSpace = 68
	$ClientAreaTitlebar = 34
ElseIf $GetDPI = 168 Then
	$DPIScale = 175
	$ListViewWidth = 1520
	$ListViewHeight = 380
	$hGUIWidth = 1540
	$hGUIHeight = 770
	$HorizontalSpace = 25
	$HorizontalSpaceSml = 20
	$VerticalSpaceSml = 14
	$VerticalSpace = 68
	$ClientAreaTitlebar = 40
ElseIf $GetDPI = 192 Then
	$DPIScale = 200
	$ListViewWidth = 1640
	$ListViewHeight = 380
	$hGUIWidth = 1660
	$hGUIHeight = 800
	$HorizontalSpace = 25
	$HorizontalSpaceSml = 20
	$VerticalSpaceSml = 14
	$VerticalSpace = 68
	$ClientAreaTitlebar = 48
Else
	$ListViewWidth = 1200
	$ListViewHeight = 340
	$hGUIWidth = 1220
	$hGUIHeight = 634
	$HorizontalSpace = 25
	$HorizontalSpaceSml = 15
	$VerticalSpaceSml = 8
	$VerticalSpace = 48
	$ClientAreaTitlebar = 48
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

Global $ifPS7Exists = FileExists(@ProgramFilesDir & '\PowerShell\7\pwsh.exe')
;If $ifPS7Exists Then
;	Global $o_powershell = @ProgramFilesDir & '\PowerShell\7\pwsh.exe -NoProfile -Command'
;Else
	Global $o_powershell = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -Command"
;EndIf

If $isDarkMode = True Then
Global $iDllGDI = DllOpen("gdi32.dll")
Global $iDllUSER32 = DllOpen("user32.dll")

;Three column colours
Global $aCol[11][2] = [[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff],[0xffffff, 0xffffff]]

;Convert RBG to BGR for SetText/BkColor()
For $i = 0 To UBound($aCol)-1
    $aCol[$i][0] = _BGR2RGB($aCol[$i][0])
    $aCol[$i][1] = _BGR2RGB($aCol[$i][1])
Next
EndIf


$hGUI = GUICreate("AppContainer Learning Mode", @DesktopWidth - 200, $hGUIHeight, -1, -1, $WS_SIZEBOX + $WS_SYSMENU + $WS_MINIMIZEBOX + $WS_MAXIMIZEBOX)

GUISetIcon(@ScriptFullPath, 201)

Local Const $sCascadiaPath = @WindowsDir & "\fonts\CascadiaCode.ttf"
Local $iCascadiaExists = FileExists($sCascadiaPath)

If $iCascadiaExists Then
	GUISetFont(10, $FW_THIN, -1, "Cascadia Code")
Else
	GUISetFont(10, $FW_NORMAL, -1, "Consolas")
EndIf


Local $hToolTip2 = _GUIToolTip_Create(0)
;_GUIToolTip_SetMaxTipWidth($hToolTip2, 400)

If $isDarkMode = True Then
	_WinAPI_SetWindowTheme($hToolTip2, "", "")
	_GUIToolTip_SetTipBkColor($hToolTip2, 0x202020)
	_GUIToolTip_SetTipTextColor($hToolTip2, 0xe0e0e0)
Else
	_WinAPI_SetWindowTheme($hToolTip2, "", "")
	_GUIToolTip_SetTipBkColor($hToolTip2, 0xffffff)
	_GUIToolTip_SetTipTextColor($hToolTip2, 0x000000)
EndIf

_GUIToolTip_SetMaxTipWidth($hToolTip2, 260)

GUISetFont(10, $FW_NORMAL, -1, "Segoe UI")


$StartTrace = GUICtrlCreateButton(" Start Learning ", $HorizontalSpace, $VerticalSpaceSml, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hStartTrace = GUICtrlGetHandle($StartTrace)
$aPos = ControlGetPos($hGUI, "", $StartTrace)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])

$StartTracePosV = $aPos[1] + 34
$StartTracePosH = $aPos[0] + $aPos[2]


$StopTrace = GUICtrlCreateButton(" Stop Learning ", $StartTracePosH + $HorizontalSpace, $VerticalSpaceSml, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hStopTrace = GUICtrlGetHandle($StopTrace)
GUICtrlSetState($StopTrace, $GUI_DISABLE)

$aPos = ControlGetPos($hGUI, "", $StopTrace)

$StopTracePosV = $aPos[1]
$StopTracePosH = $aPos[0] + $aPos[2]
$StopTraceHeight = $aPos[3]


$SaveParsedData = GUICtrlCreateButton(" Save to CSV ", $StopTracePosH + $HorizontalSpace, $VerticalSpaceSml, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hSaveParsedData = GUICtrlGetHandle($SaveParsedData)
GUICtrlSetState($SaveParsedData, $GUI_DISABLE)

$aPos = ControlGetPos($hGUI, "", $SaveParsedData)

$SaveParsedDataPosV = $aPos[1]
$SaveParsedDataPosH = $aPos[0] + $aPos[2]
$SaveParsedDataHeight = $aPos[3]
$SaveParsedDataHeight2 = $aPos[1] / 2

GUISetFont(9, $FW_THIN, -1, "Cascadia Code")

;$InfoBox = GUICtrlCreateLabel(" AppContainer Learning Mode has started. Data will appear after clicking Stop Learning. ", $StopTracePosH + $HorizontalSpace, $VerticalSpaceSml, -1, -1, $WS_BORDER + $SS_LEFTNOWORDWRAP)
$InfoBox = GUICtrlCreateLabel("                                                                                        ", $SaveParsedDataPosH + $HorizontalSpace, $SaveParsedDataHeight2 + $VerticalSpaceSml, -1, -1, $SS_LEFTNOWORDWRAP)
$hInfoBox = GUICtrlGetHandle($InfoBox)

$aPos = ControlGetPos($hGUI, "", $InfoBox)

$InfoBoxPosV = $aPos[1]
$InfoBoxPosH = $aPos[0] + $aPos[2]
$InfoBoxHeight = $aPos[3]


If $iCascadiaExists Then
	GUISetFont(9, $FW_THIN, -1, "Cascadia Code")
Else
	GUISetFont(10, $FW_NORMAL, -1, "Consolas")
EndIf


Local $exStyles = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_DOUBLEBUFFER), $cListView
$cListView = GUICtrlCreateListView("Time Created|Process|Type|Object|Requested Access", 15, $StopTracePosV + $StopTraceHeight + $VerticalSpaceSml, @DesktopWidth - 220, $hGUIHeight - $StopTraceHeight - $VerticalSpaceSml - $VerticalSpaceSml - $VerticalSpaceSml)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
$hListView = GUICtrlGetHandle($cListView)

$aPos = ControlGetPos($hGUI, "", $cListView)
;MsgBox($MB_SYSTEMMODAL, "", "Position: " & $aPos[0] & ", " & $aPos[1] & @CRLF & "Size: " & $aPos[2] & ", " & $aPos[3])
$cListViewPosV = $aPos[1]
$cListViewPosH = $aPos[0] + $aPos[2] + $HorizontalSpace
$cListViewLength = $aPos[2]
$cListViewHeight = $aPos[3]

_GUICtrlListView_SetExtendedListViewStyle($hListView, $exStyles)

_GUICtrlListView_SetColumnWidth($hListView, 0, $LVSCW_AUTOSIZE_USEHEADER)
_GUICtrlListView_SetColumnWidth($hListView, 1, $LVSCW_AUTOSIZE_USEHEADER)
_GUICtrlListView_SetColumnWidth($hListView, 2, $LVSCW_AUTOSIZE_USEHEADER)
_GUICtrlListView_SetColumnWidth($hListView, 3, @DesktopWidth / 2)
_GUICtrlListView_SetColumnWidth($hListView, 4, $LVSCW_AUTOSIZE_USEHEADER)

HeaderFix()

Func HeaderFix()
If $isDarkMode = True Then
;get handle to child SysHeader32 control of ListView
Global $hHeader = HWnd(GUICtrlSendMsg($cListView, $LVM_GETHEADER, 0, 0))
;Turn off theme for header
DllCall("uxtheme.dll", "int", "SetWindowTheme", "hwnd", $hHeader, "wstr", "", "wstr", "")
;subclass ListView to get at NM_CUSTOMDRAW notification sent to ListView
Global $wProcNew = DllCallbackRegister("_LVWndProc", "ptr", "hwnd;uint;wparam;lparam")
Global $wProcOld = _WinAPI_SetWindowLong($hListView, $GWL_WNDPROC, DllCallbackGetPtr($wProcNew))

;Optional: Flat Header - remove header 3D button effect
Global $iStyle = _WinAPI_GetWindowLong($hHeader, $GWL_STYLE)
_WinAPI_SetWindowLong($hHeader, $GWL_STYLE, BitOR($iStyle, $HDS_FLAT))
EndIf
Endfunc


; apply theme color after listview

ApplyThemeColor()
Func ApplyThemeColor()

If $isDarkMode = True Then
	GuiDarkmodeApply($hGUI)
Else
	Local $bEnableDarkTheme = False
    GuiLightmodeApply($hGUI)
EndIf

Endfunc



$ClientAreaWidth = 15 + $cListViewLength + 15
$ClientAreaHeight = $VerticalSpaceSml + $StopTraceHeight + $VerticalSpaceSml + $cListViewHeight + 20



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



Func _LVWndProc($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam
    If $iMsg = $WM_NOTIFY Then
        Local $tNMHDR, $hWndFrom, $iCode, $iItem, $hDC
        $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
        $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
        $iCode = DllStructGetData($tNMHDR, "Code")
        ;Local $IDFrom = DllStructGetData($tNMHDR, "IDFrom")

        Switch $hWndFrom
            Case $hHeader
                Switch $iCode
                    Case $NM_CUSTOMDRAW
                        Local $tCustDraw = DllStructCreate($tagNMLVCUSTOMDRAW, $lParam)
                        Switch DllStructGetData($tCustDraw, "dwDrawStage")
                            Case $CDDS_PREPAINT
                                Return $CDRF_NOTIFYITEMDRAW
                            Case $CDDS_ITEMPREPAINT
                                $hDC = DllStructGetData($tCustDraw, "hDC")
                                $iItem = DllStructGetData($tCustDraw, "dwItemSpec")
                                DllCall($iDllGDI, "int", "SetTextColor", "handle", $hDC, "dword", $aCol[$iItem][0])
                                DllCall($iDllGDI, "int", "SetBkColor", "handle", $hDC, "dword", $aCol[$iItem][1])
                                Return $CDRF_NEWFONT
                                Return $CDRF_SKIPDEFAULT
                        EndSwitch
                EndSwitch
        EndSwitch
    EndIf
    ;pass the unhandled messages to default WindowProc
    Local $aResult = DllCall($iDllUSER32, "lresult", "CallWindowProcW", "ptr", $wProcOld, _
            "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam)
    If @error Then Return -1
    Return $aResult[0]
EndFunc   ;==>_LVWndProc

Func _BGR2RGB($iColor)
    ;Author: Wraithdu
    Return BitOR(BitShift(BitAND($iColor, 0x0000FF), -16), BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc   ;==>_BGR2RGB


Func StartTrace()
	;Local $o_CmdString1 = " $name = 'AppContainerTrace'; New-NetEventSession -Name $name -LocalFilePath $env:LOCALAPPDATA+'\Temp\AppContainerTrace.etl' | Out-Null; Add-NetEventProvider -SessionName $name -Name 'Microsoft-Windows-Kernel-General' -MatchAllKeyword 0x20 | Out-Null; Start-NetEventSession -Name $name"

	Local $tracepath = @LocalAppDataDir & "\Temp\AppContainerTrace.etl"
	Local $o_Cmd1 = " $name = 'AppContainerTrace';"
	Local $o_Cmd2 = " New-NetEventSession -Name $name -LocalFilePath " & $tracepath & " | Out-Null;"
	Local $o_Cmd3 = " Add-NetEventProvider -SessionName $name -Name 'Microsoft-Windows-Kernel-General' -MatchAllKeyword 0x20 | Out-Null; Start-NetEventSession -Name $name"

	Local $o_Pid = Run($o_powershell & $o_Cmd1 & $o_Cmd2 & $o_Cmd3 , "", @SW_Hide)
	;ProcessWaitClose($o_Pid)
	;$out = StdoutRead($o_Pid)
	;CreatePolicyTable($out)
EndFunc


Func StopTrace()
	;Local $o_CmdString1 = " $name = 'AppContainerTrace'; New-NetEventSession -Name $name -LocalFilePath $env:LOCALAPPDATA+'\Temp\AppContainerTrace.etl' | Out-Null; Add-NetEventProvider -SessionName $name -Name 'Microsoft-Windows-Kernel-General' -MatchAllKeyword 0x20 | Out-Null; Start-NetEventSession -Name $name"

	;Local $tracepath = @LocalAppDataDir & "\Temp\AppContainerTrace.etl"
	Local $o_Cmd1 = " $name = 'AppContainerTrace';"
	Local $o_Cmd2 = " Stop-NetEventSession -Name $name;"
	Local $o_Cmd3 = " Remove-NetEventSession -Name $name"

	Local $o_Pid = Run($o_powershell & $o_Cmd1 & $o_Cmd2 & $o_Cmd3 , "", @SW_Hide)
	ProcessWaitClose($o_Pid)
	;$out = StdoutRead($o_Pid)
	;CreatePolicyTable($out)
	ParseTrace()
EndFunc


Func ParseTrace()
	; tracerpt.exe access_trace2.etl -of XML -o etw.xml -y -lr
	Local $iPID = Run('tracerpt.exe ' & $tracepath & ' -of XML -o ' & $xmlpath & ' -y -lr', @SystemDir, @SW_HIDE)
	ProcessWaitClose($iPID)
	ParseXMLData()
EndFunc


Func ParseXMLData()

Local $oXML = ObjCreate("Microsoft.XMLDOM")
$oXML.async = False
$oXML.load($xmlpath2)
If $oXML.parseError.errorCode Then Exit MsgBox($MB_SYSTEMMODAL, "You have an error", $oXML.parseError.reason)

Local $oNodes = $oXML.SelectNodes("//ComplexData")
$oNodes.removeAll()

$oNodes = $oXML.SelectNodes("//Event")
For $oNode In $oNodes
  $oData = $oNode.selectSingleNode("EventData")
  If Not IsObj($oData) Then
    $oXML.documentElement.removeChild($oNode)
  EndIf

Next

$oNodes = $oXML.SelectNodes("//Event")
For $oNode In $oNodes
  $oData = $oNode.selectSingleNode("ExtendedTracingInfo")
  If IsObj($oData) Then
    $oXML.documentElement.removeChild($oNode)
  EndIf

Next

$oXML.save($xmlpath2)

CountPermissive()
EndFunc


Func ErrorHandler($oError)
EndFunc


Func CountPermissive()

Local $hFileOpen = FileOpen($xmlpath2, $FO_READ)
Local $ReadFile = FileRead($hFileOpen)
StringReplace($ReadFile, '<Data Name="Mode">Permissive</Data>', '<Data Name="Mode">Permissive</Data>')
Global $PermissiveCount = @extended
;MsgBox($MB_SYSTEMMODAL, "Permissive Count", $PermissiveCount)
FileClose($hFileOpen)
If $PermissiveCount = 0 Then
	Return
Else
	CreateArrayFromXML()
EndIf
EndFunc



Func CreateArrayFromXML()
	Local $hFileOpen = FileOpen($xmlpath2, $FO_READ)
	Local $sFileRead = FileRead($hFileOpen)
	;$aArray1 = _StringBetween($sFileRead, '<Data Name="Mode">', '</Data>')
	;_ArrayTranspose($aArray1)
	;_ArrayDisplay($aArray1, "Mode")
	;_ArrayTranspose($aArray1, Default)
	;_ArrayDisplay($aArray1, "Mode")
	$aArray1 = _StringBetween($sFileRead, '<TimeCreated SystemTime="', '"/>')
	_ArrayTranspose($aArray1)
	$aArray2 = _StringBetween($sFileRead, '<Data Name="Mode">', '</Data>')
	_ArrayTranspose($aArray2)
	;_ArrayDisplay($aArray1, "SystemTime")
	$aArray3 = _StringBetween($sFileRead, '<Data Name="ProcessName">', '</Data>')
	_ArrayTranspose($aArray3)
	;_ArrayDisplay($aArray3, "ProcessName")
	$aArray4 = _StringBetween($sFileRead, '<Data Name="ObjectType">', '</Data>')
	_ArrayTranspose($aArray4)
	;_ArrayDisplay($aArray4, "ObjectType")
	$aArray5 = _StringBetween($sFileRead, '<Data Name="ObjectName">', '</Data>')
	_ArrayTranspose($aArray5)
	;_ArrayDisplay($aArray5, "ObjectName")
	$aArray6 = _StringBetween($sFileRead, '<Data Name="AccessMask">', '</Data>')
	_ArrayTranspose($aArray6)
	;_ArrayDisplay($aArray6, "AccessMask")

	_ArrayAdd($aArray1, $aArray2)
	_ArrayAdd($aArray1, $aArray3)
	;_ArrayTranspose($aArray1, Default)
	;_ArrayDisplay($aArray1, "Mode")

	_ArrayAdd($aArray1, $aArray4)
	_ArrayAdd($aArray1, $aArray5)
	_ArrayAdd($aArray1, $aArray6)
	_ArrayTranspose($aArray1, Default)
	;_ArrayDisplay($aArray1, "Mode")

	FileClose($hFileOpen)
	RemoveNonPermissive()
EndFunc


Func RemoveNonPermissive()

	For $i = UBound($aArray1) - 1 To 0 Step -1
		If $aArray1[$i][1] <> 'Permissive' Then _ArrayDelete($aArray1, $i)
	Next
	_ArrayColDelete($aArray1, 1)
	;_ArrayDisplay($aArray1, "Non-Permissive Removed")
	ComparePermissiveCount()

EndFunc


Func ComparePermissiveCount()

	$ArrayRowCount = UBound ($aArray1, $UBOUND_ROWS)
	If $ArrayRowCount <> $PermissiveCount Then
		MsgBox($MB_SYSTEMMODAL, "Permissive Count", 'There is a mismatch between Permissive Count and Array Row Count.')
	EndIf

	RemoveBlankEntries()
EndFunc

; Remove Object entries that have no values
Func RemoveBlankEntries()
	For $i = UBound($aArray1) - 1 To 0 Step -1
		If $aArray1[$i][3] = '' Or $aArray1[$i][1] = '' Then _ArrayDelete($aArray1, $i)
	Next

	ParseLearningData()

EndFunc


Func ParseLearningData()

	For $i = 0 To UBound($aArray1) - 1

	; Fix TimeStamp
	$DateTime = StringLeft($aArray1[$i][0], 19)
	$aArray1[$i][0] = $DateTime
	$aArray1[$i][0] = StringReplace($aArray1[$i][0], "T", " ")

	$test = $aArray1[$i][2]
	;Global $dosname = _DosPathNameToPathName($aArray1[$i][0])
	Global $dosname = $aArray1[$i][1]
	Global $dosname2 = $aArray1[$i][3]
	Global $drivename = _DosPathNameToPathName($dosname)
	Global $drivename2 = _DosPathNameToPathName($dosname2)
	$aArray1[$i][1] = StringReplace($aArray1[$i][1], $aArray1[$i][1], $drivename)
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], $aArray1[$i][3], $drivename2)

	$aArray1[$i][3] = StringReplace($aArray1[$i][3], '\??\', '')
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], '\REGISTRY\MACHINE', 'HKEY_LOCAL_MACHINE')
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], 'HKEY_LOCAL_MACHINE\Software', 'HKEY_LOCAL_MACHINE\SOFTWARE', 0, $STR_CASESENSE)
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], 'HKEY_LOCAL_MACHINE\System', 'HKEY_LOCAL_MACHINE\SYSTEM', 0, $STR_CASESENSE)
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], '\REGISTRY\USER', 'HKEY_USERS')

	If $test = 'ALPC Port' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1', 'Connect')

	ElseIf $test = 'Directory' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x4', 'CreateObject')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1', 'Query')

	ElseIf $test = 'File' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x113008A', 'WriteData, ReadEa, ReadAttributes, Delete, ReadControl, Synchronize, AccessSystemSecurity')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x17019F', 'ReadData, WriteData, AppendData, ReadEa, WriteEa, ReadAttributes, WriteAttributes, Delete, ReadControl, WriteDac, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x120196', 'WriteData, AppendData, WriteEa, ReadAttributes, WriteAttributes, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100001', 'ReadData, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x13019F', 'ReadData, WriteData, AppendData, ReadEa, WriteEa, ReadAttributes, WriteAttributes, Delete, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100180', 'ReadAttributes, WriteAttributes, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x110080', 'ReadAttributes, Delete, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100002', 'WriteData, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100000', 'Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100020', 'Execute, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100084', 'AppendData, ReadAttributes, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100081', 'ReadData, ReadAttributes, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100080', 'ReadAttributes, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1F019F', 'ReadData, WriteData, AppendData, ReadEa, WriteEa, ReadAttributes, WriteAttributes, Delete, ReadControl, WriteDac, WriteOwner, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x13008A', 'WriteData, ReadEa, ReadAttributes, Delete, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x120116', 'WriteData, AppendData, WriteEa, WriteAttributes, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x120089', 'ReadData, ReadEa, ReadAttributes, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x12019b', 'ReadData, WriteData, ReadEa, WriteEa, ReadAttributes, WriteAttributes, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x12019f', 'ReadData, WriteData, AppendData, ReadEa, WriteEa, ReadAttributes, WriteAttributes, ReadControl, Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x10001', 'ReadData, Delete')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x20080', 'ReadAttributes, ReadControl')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x20000', 'ReadControl')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x60080', 'ReadAttributes, ReadControl, WriteDac')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x10080', 'ReadAttributes, Delete')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x80', 'ReadAttributes')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x40', 'DeleteChild')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x4', 'AppendData')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x2', 'WriteData')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1', 'ReadData')

	ElseIf $test = 'Key' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x2000000', 'MaximumAllowed')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x2020019', 'QueryValue, EnumerateSubKeys, Notify, ReadControl, MaximumAllowed')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x20019', 'QueryValue, EnumerateSubKeys, Notify, ReadControl')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x20006', 'SetValue, CreateSubKey, ReadControl')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x2001f', 'QueryValue, SetValue, CreateSubKey, EnumerateSubKeys, Notify, ReadControl')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x3001f', 'QueryValue, SetValue, CreateSubKey, EnumerateSubKeys, Notify, Delete, ReadControl')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0xf003f', 'QueryValue, SetValue, CreateSubKey, EnumerateSubKeys, Notify, CreateLink, Delete, ReadControl, WriteDac, WriteOwner')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x8', 'EnumerateSubKeys')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x4', 'CreateSubKey')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x11', 'QueryValue, Notify')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x10', 'Notify')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1', 'QueryValue')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x2', 'SetValue')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x3', 'QueryValue, SetValue')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x9', 'QueryValue, EnumerateSubKeys')
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], "windows nt", "Windows NT", 0, $STR_CASESENSE)
	$aArray1[$i][3] = StringReplace($aArray1[$i][3], "\\", "\")

	ElseIf $test = 'Mutant' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100000', 'Synchronize')

	ElseIf $test = 'Desktop' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x8', 'HookControl')

	ElseIf $test = 'SymbolicLink' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1', 'Query')

	ElseIf $test = 'Event' Then
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x100000', 'Synchronize')
	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x1', 'QueryState')

	;ElseIf $test = 'RPC Interface' Then
	;	$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x4', '')

	ElseIf $test = 'Section' Then
		$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x4', 'MapRead')
		$aArray1[$i][4] = StringReplace($aArray1[$i][4], '0x6', 'MapWrite, MapRead')

	EndIf

	Next

	; Remove duplicates
	Global $aUniques = _ArrayUnique2D_Ex($aArray1, "1,2,3,4", True)


	_GUICtrlListView_AddArray($hListView,$aUniques)

	; Read ListView content into an array
	$aContent = _GUIListViewEx_ReadToArray($cListView)

	; Initiate ListView
	$iLV_Index = _GUIListViewEx_Init($cListView, $aContent, 0, Default, False, 1)

	; Register required messages
	_GUIListViewEx_MsgRegister()

	_GUICtrlListView_SetColumnWidth($hListView, 0, $LVSCW_AUTOSIZE)
	_GUICtrlListView_SetColumnWidth($hListView, 1, $LVSCW_AUTOSIZE)
	_GUICtrlListView_SetColumnWidth($hListView, 2, $LVSCW_AUTOSIZE)
	_GUICtrlListView_SetColumnWidth($hListView, 3, @DesktopWidth / 2)
	_GUICtrlListView_SetColumnWidth($hListView, 4, $LVSCW_AUTOSIZE_USEHEADER)

EndFunc


; Remove duplicates
;Global $aUniques = _ArrayUnique2D_Ex($aArray1, "1,2,3,4", True)
;_ArrayDisplay($aUniques, "Output array")


Func _ArrayUnique2D_Ex(ByRef $aSource, $sColumns = "*", $iReturnAllCols = True)
    ; check wanted columns
    If $sColumns = "*" Then
        Local $aColumns[UBound($aSource, 2)]
        For $i = 0 To UBound($aColumns) - 1
            $aColumns[$i] = $i
        Next
    Else
        Local $aColumns = StringSplit($sColumns, ",", 2) ; NO count in element 0
    EndIf

    ; chain fields to check
    Local $aChainFileds[UBound($aSource, 1)][2]
    For $iRow = 0 To UBound($aSource, 1) - 1
        $aChainFileds[$iRow][1] = 0
        For $iField = 0 To UBound($aColumns) - 1
            $aChainFileds[$iRow][0] &= $aSource[$iRow][$aColumns[$iField]]
        Next
    Next
    ; uniqe from chain
    $aTemp = _ArrayUnique($aChainFileds, 0, 0, 0, 1) ; remove duplicate records (if any)
    If $iReturnAllCols Then
        Local $aUniques[UBound($aTemp)][UBound($aSource, 2)] ; Return all columns
    Else
        Local $aUniques[UBound($aTemp)][UBound($aColumns)] ; Return only checked columns
    EndIf
    $aUniques[0][0] = 0 ; pointer to next free row to fill
    If UBound($aChainFileds) <> $aTemp[0] Then ; there are some duplicate
        Local $aDuplicates[UBound($aChainFileds, 1) - $aTemp[0] + 1][UBound($aSource, 2)] ; will hold only duplicate
        $aDuplicates[0][0] = 0 ; pointer to next free row to fill

        For $iRow = 0 To UBound($aChainFileds, 1) - 1
            If Not $aChainFileds[$iRow][1] Then ; this record still not checked
                $aTemp = _ArrayFindAll($aChainFileds, $aChainFileds[$iRow][0]) ; find duplicates (if any)
                For $i = 0 To UBound($aTemp) - 1
                    $aChainFileds[$aTemp[$i]][1] = UBound($aTemp) ; mark this record as a duplicate
                Next
                $aUniques[0][0] += 1
                If $iReturnAllCols Then
                    For $iField = 0 To UBound($aSource, 2) - 1
                        $aUniques[$aUniques[0][0]][$iField] = $aSource[$aTemp[0]][$iField]
                    Next
                Else
                    For $iField = 0 To UBound($aColumns) - 1
                        $aUniques[$aUniques[0][0]][$iField] = $aSource[$aTemp[0]][$aColumns[$iField]]
                    Next
                EndIf
                If UBound($aTemp) > 1 Then ; there are duplicates of this record
                    For $i = 1 To UBound($aTemp) - 1
                        $aDuplicates[0][0] += 1
                        For $iField = 0 To UBound($aSource, 2) - 1
                            $aDuplicates[$aDuplicates[0][0]][$iField] = $aSource[$aTemp[$i]][$iField]
                        Next
                    Next
                EndIf
            EndIf
        Next
        ; _ArrayDisplay($aUniques, "Those are unique elements")
        ; _ArrayDisplay($aDuplicates, "These are duplicates discarded")
    Else
        ; there are not duplicates in source array
        ; return passed array unchanged
        Return $aSource
    EndIf
    _ArrayDelete($aUniques, 0) ; remove the count row
    Return $aUniques

EndFunc   ;==>_ArrayUnique2D_Ex


Func _DosPathNameToPathName($sPath)

    Local $sName, $aDrive = DriveGetDrive('ALL')

    If Not IsArray($aDrive) Then
        Return SetError(1, 0, $sPath)
    EndIf

    For $i = 1 To $aDrive[0]
        $sName = _WinAPI_QueryDosDevice($aDrive[$i])
        If StringInStr($sPath, $sName) = 1 Then
            Return StringReplace($sPath, $sName, StringUpper($aDrive[$i]), 1)
        EndIf
    Next
    Return SetError(2, 0, $sPath)
EndFunc


Func SaveParsedData()
    Local Const $sMessage = "Choose a filename."

    Local $sFileSaveDialog = FileSaveDialog($sMessage, @DesktopDir, "Comma-separated values (*.csv)", $FD_PATHMUSTEXIST + $FD_PROMPTOVERWRITE, "AppContainerLearning")
	If @error Then
		;MsgBox($MB_SYSTEMMODAL, "", "No file was saved.")
	Else
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSEBASIC, -1))

		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSEBASIC)

		If $iExtension Then
			If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".csv") Then $sFileSaveDialog &= ".csv"
		Else
			$sFileSaveDialog &= ".csv"
		EndIf

		_FileWriteFromArray($sFileSaveDialog, $aContent, 0, Default, ",")
		;MsgBox($MB_SYSTEMMODAL, "", "You saved the following file:" & @CRLF & $sFileSaveDialog)
	EndIf
EndFunc


While 1
    $MSG = GUIGetMsg()
    Select
        Case $MSG = $GUI_EVENT_CLOSE
            Exit
		Case $MSG = $SaveParsedData
			SaveParsedData()
		Case $MSG = $StartTrace
			_GUICtrlListView_DeleteAllItems($cListView)
			GUICtrlSetState($StopTrace, $GUI_ENABLE)
			GUICtrlSetState($StartTrace, $GUI_DISABLE)
			GUICtrlSetState($SaveParsedData, $GUI_DISABLE)
			GUICtrlSetData($InfoBox, " AppContainer Learning Mode has started. Data will appear after clicking Stop Learning. ")
			StartTrace()
		Case $MSG = $StopTrace
			GUICtrlSetState($StartTrace, $GUI_ENABLE)
			GUICtrlSetState($StopTrace, $GUI_DISABLE)
			;GUICtrlSetData($InfoBox, "                                                                                        ")
			GUICtrlSetData($InfoBox, " Parsing Learning Data... (time to parse depends on size of dataset)                    ")
			StopTrace()
			GUICtrlSetData($InfoBox, "                                                                                        ")
			GUICtrlSetState($SaveParsedData, $GUI_ENABLE)
	EndSelect

WEnd
