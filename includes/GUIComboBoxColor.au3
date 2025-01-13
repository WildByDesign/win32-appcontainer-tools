;~ #AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
; #INDEX# =======================================================================================================================
; Title .........: GUIComboBoxFont
; AutoIt Version : 3.3.16.1
; Version .......: 0.0.2
; ===============================================================================================================================
#include-once
#include <WindowsConstants.au3>
#include <WinAPIShellEx.au3>
#include <WinAPIGdiDC.au3>
#include <GUIComboBox.au3>
#include <GUIConstantsEx.au3>
#include <SendMessage.au3>
#include "AutOnExit.au3"
#include "GUIRegisterMsg20.au3"

Global Enum _
	$CBOX_CTRL_COLORHWND, _
	$CBOX_CTRL_COLOREDITHWND, _
	$CBOX_CTRL_COLORLBHWND, _
	$CBOX_CTRL_COLORLBHWNDHBRUSH, _
	$CBOX_CTRL_COLOREDITHWNDHBRUSH, _
	$CBOX_CTRL_COLORLBTXTCOLOR, _
	$CBOX_CTRL_COLORLBBKCOLOR, _
	$CBOX_CTRL_COLOREDITTXTCOLOR, _
	$CBOX_CTRL_COLOREDITBKCOLOR, _
	$CBOX_CTRL_COLORENDENUM

Global $CBOX_CTRL_COLORMAXDIM = 5
Global $CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORMAXDIM][$CBOX_CTRL_COLORENDENUM]
Global $CBOX_CTRL_COLORENUM = 0

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBoxEx_SetColor
; Description ...: Set the background color/colour to the combobox
; Syntax ........: _GUICtrlComboBoxEx_SetColor($hWnd[, $iLBBkGrColor = Default[, $iLBTextColor = Default[,
;                  $iEditBkGrColor = Default[, $iEditTextColor = Default]]]])
; Parameters ....: $hWnd                - The handle to the combobox control
;                  $iLBBkGrColor        - Background color to the drop down listbox, default is system window color
;                  $iLBTextColor        - Foreground/Font color to the drop down text, default is system window text color
;                  $iEditBkGrColor      - Background color to the edit box (by the button), default is listbox back ground color
;                  $iEditTextColor      - Foreground/Font color to the edit box (by the button), default is listbox text color
; Return values .: Success              - Array:
;                                               [0] = Hwnd to control/combobox
;                                               [1] = Edit hwnd to control/combobox
;                                               [2] = Listbox hwnd to control/combobox
;                  Failure              - @error: 1 = Could not get combo info
; Author ........: SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
; Modified ......:
; Links .........: GUIRegisterMsg20 subclassing by LarsJ
;                   https://www.autoitscript.com/forum/topic/195151-guiregistermsg20-subclassing-made-easy
;                  ComboBox Set DROPDOWNLIST Colors/size UDF by argumentum (has more options than just background coloring)
;                   with a different approach
;                   https://www.autoitscript.com/forum/topic/191035-combobox-set-dropdownlist-colorssize-udf/
; ===============================================================================================================================
Func _GUICtrlComboBoxEx_SetColor($hWnd, $iLBBkGrColor = Default, $iLBTextColor = Default, $iEditBkGrColor = Default, $iEditTextColor = Default)

	If Not IsHWnd($hWnd) Then
		$hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)
		$hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)
	EndIf

	$iLBBkGrColor = ($iLBBkGrColor = Default Or $iLBBkGrColor == -1) ? _
		_WinAPI_GetSysColor($COLOR_WINDOW) : __GUICtrlComboBoxEx_ColorShiftBits($iLBBkGrColor)
	$iLBTextColor = ($iLBTextColor = Default Or $iLBTextColor == -1) ? _
		_WinAPI_GetSysColor($COLOR_WINDOWTEXT) : __GUICtrlComboBoxEx_ColorShiftBits($iLBTextColor)
	$iEditBkGrColor = ($iEditBkGrColor = Default Or $iEditBkGrColor == -1) ? _
		$iLBBkGrColor : __GUICtrlComboBoxEx_ColorShiftBits($iEditBkGrColor)
	$iEditTextColor = ($iEditTextColor = Default Or $iEditTextColor == -1) ? _
		$iLBTextColor : __GUICtrlComboBoxEx_ColorShiftBits($iEditTextColor)


	Local $tInfo
	If Not _GUICtrlComboBox_GetComboBoxInfo($hWnd, $tInfo) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hEdit = HWnd(DllStructGetData($tInfo, "hEdit"))
	Local $hLBox = HWnd(DllStructGetData($tInfo, "hList"))
	Local $hLBBrush = _WinAPI_CreateSolidBrush($iLBBkGrColor)
	Local $hEditBrush = _WinAPI_CreateSolidBrush($iEditBkGrColor)

	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLORHWND] = $hWnd
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLOREDITHWND] = $hEdit
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLORLBHWND] = $hLBox
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLORLBHWNDHBRUSH] = $hLBBrush
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLOREDITHWNDHBRUSH] = $hEditBrush
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLORLBTXTCOLOR] = $iLBTextColor
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLORLBBKCOLOR] = $iLBBkGrColor
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLOREDITTXTCOLOR] = $iEditTextColor
	$CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLOREDITBKCOLOR] = $iEditBkGrColor

	; clean up func when script exits
	_AutOnExit_AddFunc(_WinAPI_DeleteObject, $hLBBrush)
	_AutOnExit_AddFunc(_WinAPI_DeleteObject, $hEditBrush)

	$CBOX_CTRL_COLORENUM += 1
	If Mod($CBOX_CTRL_COLORENUM, $CBOX_CTRL_COLORMAXDIM) = 0 Then
		ReDim $CBOX_CTRL_COLORARRAY[$CBOX_CTRL_COLORMAXDIM + $CBOX_CTRL_COLORENUM][$CBOX_CTRL_COLORENDENUM]
	EndIf

	GUIRegisterMsg20($hWnd, $WM_CTLCOLORLISTBOX, __GUICtrlComboBoxEx_SubClass_CtrlColor)
	GUIRegisterMsg20($hWnd, $WM_CTLCOLOREDIT, __GUICtrlComboBoxEx_SubClass_CtrlColor)

	_SendMessage($hWnd, $WM_CTLCOLORLISTBOX, _WinAPI_GetDC($hLBox), $hLBox)
	_SendMessage($hWnd, $WM_CTLCOLOREDIT, _WinAPI_GetDC($hEdit), $hEdit)

	Local $aRet[3] = [$hWnd,$hEdit,$hLBox]
	Return SetExtended(1, $aRet)
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlComboBoxEx_SubClass_CtrlColor
; Description ...: Internal function used to paint the combobox, cannot (should not) be called
; ===============================================================================================================================
Func __GUICtrlComboBoxEx_SubClass_CtrlColor($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam

	Local $iIndex = $CBOX_CTRL_COLORENUM
	Local $aCombo = $CBOX_CTRL_COLORARRAY

	Switch ($iMsg)
		Case $WM_CTLCOLORLISTBOX
			For $i = 0 To $iIndex - 1
				If ($aCombo[$i][$CBOX_CTRL_COLORLBHWND] == HWnd($lParam)) Then
					_WinAPI_SetTextColor($wParam, $aCombo[$i][$CBOX_CTRL_COLORLBTXTCOLOR])
					_WinAPI_SetBkColor($wParam, $aCombo[$i][$CBOX_CTRL_COLORLBBKCOLOR])
					Return $aCombo[$i][$CBOX_CTRL_COLORLBHWNDHBRUSH]
				EndIf
			Next
		Case $WM_CTLCOLOREDIT
			For $i = 0 To $iIndex - 1
				If ($aCombo[$i][$CBOX_CTRL_COLOREDITHWND] == HWnd($lParam)) Then
					_WinAPI_SetTextColor($wParam, $aCombo[$i][$CBOX_CTRL_COLOREDITTXTCOLOR])
					_WinAPI_SetBkColor($wParam, $aCombo[$i][$CBOX_CTRL_COLOREDITBKCOLOR])
					Return $aCombo[$i][$CBOX_CTRL_COLOREDITHWNDHBRUSH]
				EndIf
			Next
	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlComboBoxEx_ColorShiftBits
; Description ...: Internal function used swap the color bits
; ===============================================================================================================================
Func __GUICtrlComboBoxEx_ColorShiftBits($iColor)
	Return BitOR(BitAND($iColor, 0x00FF00), _
		BitShift(BitAND($iColor, 0x0000FF), -16), _
		BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc