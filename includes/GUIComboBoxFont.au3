;~ #AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
; #INDEX# =======================================================================================================================
; Title .........: GUIComboBoxFont
; AutoIt Version : 3.3.16.1
; Version .......: 0.0.1
; ===============================================================================================================================
#include-once
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIGdi.au3>
#include <WinAPIGdiDC.au3>
#include <WinAPIHObj.au3>
#include <WinAPISysWin.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include "AutOnExit.au3"

; #CURRENT# =====================================================================================================================
; _GUICtrlComboBoxEx_SetFont
; _GUICtrlComboBoxEx_SetControlFont
; _GUICtrlComboBoxEx_SetEditFont
; _GUICtrlComboBoxEx_SetLBFont
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBoxEx_SetFont
; Description ...: Set font data for all 3 hwnds (control/edit/listbox)
; Syntax ........: _GUICtrlComboBoxEx_SetFont($hWnd[, $iSize = Default[, $iWeight = Default[, $iAttribute = Default[,
;                  $sFont = Default[, $iQuality = Default[, $iCharSet = Default[, $iOutputPrec = Default[, $iClipPrec = Default[,
;                  $iPitch = Default]]]]]]]]])
; Parameters ....: $hWnd                - The combobox's hwnd (or ctrlid if using standard functions (not really tested)
;                             The below values can all be found in either GUICtrlSetFont or _WinAPI_CreateFont
;                  $iSize               - Size/Height of font. Default is 8.5.
;                  $iWeight             - The weight of the font in the range 0 through 1000. Default is $FW_DONTCARE.
;                  $iAttribute          - Font attributes, which can be a combination. Default is D$GUI_FONTNORMAL.
;                  $sFont               - Name of the font to use. (OS default GUI font is used if the font is "" or is not found)
;                  $iQuality            - Font quality to select. Default is $DEFAULT_QUALITY.
;                  $iCharSet            - Specifies the character set. Default is $DEFAULT_CHARSET.
;                  $iOutputPrec         - Specifies the output precision. Default is $OUT_DEFAULT_PRECIS.
;                  $iClipPrec           - Specifies the clipping precision. Default is $CLIP_DEFAULT_PRECIS.
;                  $iPitch              - Specifies the pitch and family of the font. Default is $FF_DONTCARE.
; Return values .: Success              - Font Array [0] = ComboBox font handle
;                                                    [1] = Edit font handle
;                                                    [2] = ListBox font handle
; Author ........: SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
; Modified ......:
; ===============================================================================================================================
Func _GUICtrlComboBoxEx_SetFont($hWnd, $iSize = Default, $iWeight = Default, $iAttribute = Default, $sFont = Default, _
		$iQuality = Default, $iCharSet = Default, $iOutputPrec = Default, $iClipPrec = Default, $iPitch = Default)

	If Not IsHWnd($hWnd) Then $hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)

	Local $tInfo
	If Not _GUICtrlComboBox_GetComboBoxInfo($hWnd, $tInfo) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $hEdit = HWnd(DllStructGetData($tInfo, "hEdit"))
	Local $hLBox = HWnd(DllStructGetData($tInfo, "hList"))

	Local $aFont[3]
	$aFont[0] = __GUICtrlComboBoxEx_SetFontDefault($hWnd, $iSize, $iWeight, $iAttribute, $sFont, $iQuality, $iCharSet, $iOutputPrec, $iClipPrec, $iPitch)
	$aFont[1] = __GUICtrlComboBoxEx_SetFontDefault($hEdit, $iSize, $iWeight, $iAttribute, $sFont, $iQuality, $iCharSet, $iOutputPrec, $iClipPrec, $iPitch)
	$aFont[2] = __GUICtrlComboBoxEx_SetFontDefault($hLBox, $iSize, $iWeight, $iAttribute, $sFont, $iQuality, $iCharSet, $iOutputPrec, $iClipPrec, $iPitch)

	Return $aFont
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBoxEx_SetControlFont
; Description ...:
; Syntax ........: _GUICtrlComboBoxEx_SetControlFont($hWnd[, $iSize = Default[, $iWeight = Default[, $iAttribute = Default[,
;                  $sFont = Default[, $iQuality = Default[, $iCharSet = Default[, $iOutputPrec = Default[, $iClipPrec = Default[,
;                  $iPitch = Default]]]]]]]]])
; Parameters ....: $hWnd                - The combobox's hwnd (or ctrlid if using standard functions (not really tested)
;                             The below values can all be found in either GUICtrlSetFont or _WinAPI_CreateFont
;                  $iSize               - Size/Height of font. Default is 8.5.
;                  $iWeight             - The weight of the font in the range 0 through 1000. Default is $FW_DONTCARE.
;                  $iAttribute          - Font attributes, which can be a combination. Default is D$GUI_FONTNORMAL.
;                  $sFont               - Name of the font to use. (OS default GUI font is used if the font is "" or is not found)
;                  $iQuality            - Font quality to select. Default is $DEFAULT_QUALITY.
;                  $iCharSet            - Specifies the character set. Default is $DEFAULT_CHARSET.
;                  $iOutputPrec         - Specifies the output precision. Default is $OUT_DEFAULT_PRECIS.
;                  $iClipPrec           - Specifies the clipping precision. Default is $CLIP_DEFAULT_PRECIS.
;                  $iPitch              - Specifies the pitch and family of the font. Default is $FF_DONTCARE.
; Return values .: Success              - ComboBox font handle
; Author ........: SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
; Modified ......:
; ===============================================================================================================================
Func _GUICtrlComboBoxEx_SetControlFont($hWnd, $iSize = Default, $iWeight = Default, $iAttribute = Default, $sFont = Default, _
		$iQuality = Default, $iCharSet = Default, $iOutputPrec = Default, $iClipPrec = Default, $iPitch = Default)

	If Not IsHWnd($hWnd) Then $hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)

	Local $sHWNDType = _WinAPI_GetClassName($hWnd)

	If $sHWNDType <> "ComboBox" Then
		Return SetError(1, 0, $sHWNDType)
	EndIf

	Return __GUICtrlComboBoxEx_SetFontDefault($hWnd, $iSize, $iWeight, $iAttribute, $sFont, $iQuality, $iCharSet, $iOutputPrec, $iClipPrec, $iPitch)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBoxEx_SetEditFont
; Description ...:
; Syntax ........: _GUICtrlComboBoxEx_SetEditFont($hWnd[, $iSize = Default[, $iWeight = Default[, $iAttribute = Default[,
;                  $sFont = Default[, $iQuality = Default[, $iCharSet = Default[, $iOutputPrec = Default[, $iClipPrec = Default[,
;                  $iPitch = Default]]]]]]]]])
; Parameters ....: $hWnd                - The combobox's hwnd (or ctrlid if using standard functions (not really tested)
;                             The below values can all be found in either GUICtrlSetFont or _WinAPI_CreateFont
;                  $iSize               - Size/Height of font. Default is 8.5.
;                  $iWeight             - The weight of the font in the range 0 through 1000. Default is $FW_DONTCARE.
;                  $iAttribute          - Font attributes, which can be a combination. Default is D$GUI_FONTNORMAL.
;                  $sFont               - Name of the font to use. (OS default GUI font is used if the font is "" or is not found)
;                  $iQuality            - Font quality to select. Default is $DEFAULT_QUALITY.
;                  $iCharSet            - Specifies the character set. Default is $DEFAULT_CHARSET.
;                  $iOutputPrec         - Specifies the output precision. Default is $OUT_DEFAULT_PRECIS.
;                  $iClipPrec           - Specifies the clipping precision. Default is $CLIP_DEFAULT_PRECIS.
;                  $iPitch              - Specifies the pitch and family of the font. Default is $FF_DONTCARE.
; Return values .: Success              - Combobox Edit font handle
; Author ........: SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
; Modified ......:
; ===============================================================================================================================
Func _GUICtrlComboBoxEx_SetEditFont($hWnd, $iSize = Default, $iWeight = Default, $iAttribute = Default, $sFont = Default, _
		$iQuality = Default, $iCharSet = Default, $iOutputPrec = Default, $iClipPrec = Default, $iPitch = Default)

	If Not IsHWnd($hWnd) Then $hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)

	Local $sHWNDType = _WinAPI_GetClassName($hWnd)

	If $sHWNDType <> "Edit" Then
		Return SetError(1, 0, $sHWNDType)
	EndIf

	Return __GUICtrlComboBoxEx_SetFontDefault($hWnd, $iSize, $iWeight, $iAttribute, $sFont, $iQuality, $iCharSet, $iOutputPrec, $iClipPrec, $iPitch)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBoxEx_SetLBFont
; Description ...:
; Syntax ........: _GUICtrlComboBoxEx_SetLBFont($hWnd[, $iSize = Default[, $iWeight = Default[, $iAttribute = Default[,
;                  $sFont = Default[, $iQuality = Default[, $iCharSet = Default[, $iOutputPrec = Default[, $iClipPrec = Default[,
;                  $iPitch = Default]]]]]]]]])
; Parameters ....: $hWnd                - The combobox's hwnd (or ctrlid if using standard functions (not really tested)
;                             The below values can all be found in either GUICtrlSetFont or _WinAPI_CreateFont
;                  $iSize               - Size/Height of font. Default is 8.5.
;                  $iWeight             - The weight of the font in the range 0 through 1000. Default is $FW_DONTCARE.
;                  $iAttribute          - Font attributes, which can be a combination. Default is D$GUI_FONTNORMAL.
;                  $sFont               - Name of the font to use. (OS default GUI font is used if the font is "" or is not found)
;                  $iQuality            - Font quality to select. Default is $DEFAULT_QUALITY.
;                  $iCharSet            - Specifies the character set. Default is $DEFAULT_CHARSET.
;                  $iOutputPrec         - Specifies the output precision. Default is $OUT_DEFAULT_PRECIS.
;                  $iClipPrec           - Specifies the clipping precision. Default is $CLIP_DEFAULT_PRECIS.
;                  $iPitch              - Specifies the pitch and family of the font. Default is $FF_DONTCARE.
; Return values .: Success              - ComboBox Listbox font handle
; Author ........: SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
; Modified ......:
; ===============================================================================================================================
Func _GUICtrlComboBoxEx_SetLBFont($hWnd, $iSize = Default, $iWeight = Default, $iAttribute = Default, $sFont = Default, _
		$iQuality = Default, $iCharSet = Default, $iOutputPrec = Default, $iClipPrec = Default, $iPitch = Default)

	If Not IsHWnd($hWnd) Then $hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)

	Local $sHWNDType = _WinAPI_GetClassName($hWnd)

	If $sHWNDType <> "ComboLBox" Then
		Return SetError(1, 0, $sHWNDType)
	EndIf

	Return __GUICtrlComboBoxEx_SetFontDefault($hWnd, $iSize, $iWeight, $iAttribute, $sFont, $iQuality, $iCharSet, $iOutputPrec, $iClipPrec, $iPitch)

EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlComboBoxEx_SubClass_CtrlColor
; Description ...: Internal function used to paint the combobox, cannot (should not) be called
; Remarks .......: This really is the bread and butter function, it's actually a stand-alone that should
;                   be able to work on most standard or non-standard gui funcs, I just found it easier to implement
;                   this way with the combobox because the 3 different hwnds
; ===============================================================================================================================
Func __GUICtrlComboBoxEx_SetFontDefault($hWnd, $iSize = Default, $iWeight = Default, $iAttribute = Default, $sFont = Default, _
		$iQuality = Default, $iCharSet = Default, $iOutputPrec = Default, $iClipPrec = Default, $iPitch = Default)

	If Not IsHWnd($hWnd) Then $hWnd = IsInt($hWnd) ? GUICtrlGetHandle($hWnd) : HWnd($hWnd)

	$iSize = ($iSize = Default Or $iSize == -1) ? 8.5 : $iSize
	$iWeight = ($iWeight = Default Or $iWeight == -1) ? $FW_DONTCARE : $iWeight
	$iAttribute = ($iAttribute = Default Or $iWeight == -1) ? $GUI_FONTNORMAL : $iAttribute
	$sFont = ($sFont = Default Or $sFont == -1) ? $DEFAULT_GUI_FONT : $sFont
	$iQuality = ($iQuality = Default Or $iQuality == -1) ? $DEFAULT_QUALITY : $iQuality
	$iCharSet  = ($iCharSet = Default Or $iCharSet == -1) ? $DEFAULT_CHARSET : $iCharSet
	$iOutputPrec = ($iOutputPrec = Default Or $iOutputPrec == -1) ? $OUT_DEFAULT_PRECIS : $iOutputPrec
	$iClipPrec = ($iClipPrec = Default Or $iClipPrec == -1) ? $CLIP_DEFAULT_PRECIS : $iClipPrec
	$iPitch = ($iPitch = Default Or $iPitch == -1) ? $FF_DONTCARE : $iPitch

	Local $bItalic = (BitAND($iAttribute, $GUI_FONTITALIC) <> 0)
	Local $bUnderlined = (BitAND($iAttribute, $GUI_FONTUNDER) <> 0)
	Local $bStrike = (BitAND($iAttribute, $GUI_FONTSTRIKE) <> 0)

	Local $hDC = _WinAPI_GetDC($hWnd)
	Local $iGDC = _WinAPI_GetDeviceCaps($hDC, $LOGPIXELSY)
	$iSize = -1 * _WinAPI_MulDiv($iSize, $iGDC, 72)
	_WinAPI_ReleaseDC($hWnd, $hDC)

	Local $hFont = _WinAPI_CreateFont($iSize, 0, 0, 0, $iWeight, $bItalic, $bUnderlined, $bStrike, $iCharSet, _
		$iOutputPrec, $iClipPrec, $iQuality, $iPitch, $sFont)

	_WinAPI_SetFont($hWnd, $hFont, True)

	_AutOnExit_AddFunc(_WinAPI_DeleteObject, $hFont)

	Return $hFont
EndFunc