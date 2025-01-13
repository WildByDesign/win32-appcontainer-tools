
; GUIRegisterMsg20 - Subclassing Made Easy

#include-once

Global $aGUIRegisterMsg20[51][5]

; Register a message handler function for a window or control message
; GUIRegisterMsg20( $vWinOrCtrl, _ ; Window handle or control ID/handle
;                   $WM_MESSAGE, _ ; Window message or control message
;                   $hFunction )   ; User supplied message handler func
;
; $vWinOrCtrl  GUI handle as returned by GUICreate, controlID as returned by GUICtrlCreate<Control> functions
;              or control handle as returned by _GUICtrl<Control>_Create UDF functions or GUICtrlGetHandle.
;
; $WM_MESSAGE  A Windows message code as listed in Appendix section in help file. Or a control message code
;              eg. a LVM_MESSAGE or TVM_MESSAGE as listed in ListViewConstants.au3 or TreeViewConstants.au3.
;              This parameter is only checked to be within the valid range of Windows and control messages:
;              0x0000 - 0x7FFF.
;
; $hFunction   The user supplied function (not the name but the FUNCTION) to call when the message appears.
;              The function is defined in exactly the same way as the function for the official GUIRegisterMsg:
;              Takes four input parameters ($hWnd, $iMsg, $wParam, $lParam) and returns $GUI_RUNDEFMSG to conti-
;              nue with default message handling, or a specific value if the message is handled by the function.
;
; Error code in @error                                               Return value
;     1 => Invalid window handle or control ID/handle                    Success => 1
;     2 => Invalid Window or control message                             Failure => 0
;     3 => Invalid function handle
;     4 => Too many subclasses
;
Func GUIRegisterMsg20( $vWinOrCtrl, $WM_MESSAGE, $hFunction )
	; Check $vWinOrCtrl
	Local $hWndHandle = $vWinOrCtrl
	If Not IsHWnd( $hWndHandle ) Then $hWndHandle = GUICtrlGetHandle( $hWndHandle )
	If Not IsHWnd( $hWndHandle ) Then Return SetError( 1, 0, 0 )

	; Check $WM_MESSAGE
	If Not ( $WM_MESSAGE >= 0 And $WM_MESSAGE <= 32767 ) Then Return SetError( 2, 0, 0 )

	; Check $hFunction
	If Not IsFunc( $hFunction ) Then Return SetError( 3, 0, 0 )

	; Check existing subclass
	If $aGUIRegisterMsg20[0][0] Then
		For $i = 1 To $aGUIRegisterMsg20[0][1]
			If Not $aGUIRegisterMsg20[$i][0] Then ContinueLoop
			If ( $aGUIRegisterMsg20[$i][1] = $vWinOrCtrl Or $aGUIRegisterMsg20[$i][2] = $vWinOrCtrl ) And _
				$aGUIRegisterMsg20[$i][3] = $WM_MESSAGE And $aGUIRegisterMsg20[$i][4] = $hFunction Then Return 1 ; Existing subclass, return without error
		Next
	EndIf

	; Too many subclasses?
	If $aGUIRegisterMsg20[0][0] = $aGUIRegisterMsg20[0][1] Then Return SetError( 4, 0, 0 )

	; Register new subclass
	For $i = 1 To $aGUIRegisterMsg20[0][1]
		If Not $aGUIRegisterMsg20[$i][0] Then ExitLoop
	Next
	$aGUIRegisterMsg20[0][0] += 1
	$aGUIRegisterMsg20[$i][0] = $i
	$aGUIRegisterMsg20[$i][1] = $vWinOrCtrl
	$aGUIRegisterMsg20[$i][2] = $hWndHandle
	$aGUIRegisterMsg20[$i][3] = $WM_MESSAGE
	$aGUIRegisterMsg20[$i][4] = $hFunction
	If Not $aGUIRegisterMsg20[0][2] Then $aGUIRegisterMsg20[0][2] = DllCallbackGetPtr( DllCallbackRegister( "GUIRegisterMsg20_Handler", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr" ) )
	DllCall( "comctl32.dll", "bool", "SetWindowSubclass", "hwnd", $hWndHandle, "ptr", $aGUIRegisterMsg20[0][2], "uint_ptr", $i, "dword_ptr", 0 ) ; $iSubclassId = $i, $pData = 0

	Return 1
EndFunc

; Unregister a message handler function for a window or control message
; GUIUnRegisterMsg20( $vWinOrCtrl, _ ; Window handle or control ID/handle
;                     $WM_MESSAGE, _ ; Window message or control message
;                     $hFunction )   ; User supplied message handler func
;
; Error code in @error                                               Return value
;     1 => Invalid window handle or control ID/handle                    Success => 1
;     2 => Invalid Window or control message                             Failure => 0
;     3 => Invalid function handle
;     5 => Subclass not found
;
Func GUIUnRegisterMsg20( $vWinOrCtrl, $WM_MESSAGE, $hFunction )
	; Check $vWinOrCtrl
	Local $hWndHandle = $vWinOrCtrl
	If Not IsHWnd( $hWndHandle ) Then $hWndHandle = GUICtrlGetHandle( $hWndHandle )
	If Not IsHWnd( $hWndHandle ) Then Return SetError( 1, 0, 0 )

	; Check $WM_MESSAGE
	If Not ( $WM_MESSAGE >= 0 And $WM_MESSAGE <= 32767 ) Then Return SetError( 2, 0, 0 )

	; Check $hFunction
	If Not IsFunc( $hFunction ) Then Return SetError( 3, 0, 0 )

	; Find existing subclass
	If Not $aGUIRegisterMsg20[0][0] Then Return 1
	For $i = 1 To $aGUIRegisterMsg20[0][1]
		If Not $aGUIRegisterMsg20[$i][0] Then ContinueLoop
		If ( $aGUIRegisterMsg20[$i][1] = $vWinOrCtrl Or $aGUIRegisterMsg20[$i][2] = $vWinOrCtrl ) And _
			$aGUIRegisterMsg20[$i][3] = $WM_MESSAGE And $aGUIRegisterMsg20[$i][4] = $hFunction Then ExitLoop
	Next
	If $i = $aGUIRegisterMsg20[0][1] + 1 Then Return SetError( 5, 0, 0 )

	; Remove subclass
	$aGUIRegisterMsg20[0][0] -= 1
	$aGUIRegisterMsg20[$i][0] = 0
	DllCall( "comctl32.dll", "bool", "RemoveWindowSubclass", "hwnd", $vWinOrCtrl, "ptr", $aGUIRegisterMsg20[0][2], "uint_ptr", $i ) ; $iSubclassId = $i

	Return 1
EndFunc


; ##############################################################################
; #                                                                            #
; #            --- Internal global array and internal functions ---            #
; #                                                                            #
; ##############################################################################

; Global $aGUIRegisterMsg20[51][5] ; Internal global array

; Column information for row 0
; --------------------------------------------------------------------
  $aGUIRegisterMsg20[0][0] = 0  ; Number of registered subclasses
  $aGUIRegisterMsg20[0][1] = 50 ; Max. number of registered subclasses
; $aGUIRegisterMsg20[0][2]      ; Subclass callback function

; Room for 50 registered subclasses in rows 1 - 50

; Column information for other rows
; ------------------------------------------------------
;  0  Row index       Index in $aGUIRegisterMsg20 array
;  1  $vWinOrCtrl     Window handle or control ID/handle
;  2  $hWndHandle     Control ID converted into a HWND
;  3  $WM_MESSAGE     Window message or control message
;  4  $hFunction      User supplied message handler func

; Remove all subclasses on exit
OnAutoItExitRegister( "GUIRegisterMsg20_Exit" )

Func GUIRegisterMsg20_Handler( $hWnd, $iMsg, $wParam, $lParam, $idx, $pData )
	If $iMsg <> $aGUIRegisterMsg20[$idx][3] Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Local $vRetVal = $aGUIRegisterMsg20[$idx][4]( $hWnd, $iMsg, $wParam, $lParam ) ; Execute user supplied message handler function
	If $vRetVal == "GUI_RUNDEFMSG" Then Return DllCall( "comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $iMsg, "wparam", $wParam, "lparam", $lParam )[0]
	Return $vRetVal
	#forceref $pData
EndFunc

; Remove subclasses on exit
Func GUIRegisterMsg20_Exit()
	If Not $aGUIRegisterMsg20[0][0] Then Return
	For $i = 1 To $aGUIRegisterMsg20[0][1]
		If Not $aGUIRegisterMsg20[$i][0] Then ContinueLoop
		DllCall( "comctl32.dll", "bool", "RemoveWindowSubclass", "hwnd", $aGUIRegisterMsg20[$i][2], "ptr", $aGUIRegisterMsg20[0][2], "uint_ptr", $i ) ; $iSubclassId = $i
	Next
EndFunc
