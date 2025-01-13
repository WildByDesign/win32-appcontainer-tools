#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.16.1
 Author:         SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
 Remarks:        Used to perform on exit garbage cleanup
#ce ----------------------------------------------------------------------------

#include-once

; Use this add new garbage cleanups funcs
; [n][0] = function to call/cleanup
; [n][1-8] = argument (could be hwnd or some other val, only allows 8 arguments
Global $AUTONEXIT_MAXPARAMS = 8
Global $AUTONEXIT_ARGS[1][$AUTONEXIT_MAXPARAMS + 1] = [[Null,Null,Null,Null,Null,Null,Null,Null,Null]]
Global $AUTONEXIT_ARGSCOUNT = -1

OnAutoItExitRegister(__AutOnExit_Cleanup);

; #CURRENT# =====================================================================================================================
; _AutOnExit_AddFunc
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _AutOnExit_AddFunc
; Description ...: Add a single or multiple exit functions with up to 8 parameters each
; Syntax ........: _AutOnExit_AddFunc($vFunc[, $vParam1 = "@APPEXITPARAM@"[, $vParam2 = "@APPEXITPARAM@"[, $vParam3 = "@APPEXITPARAM@"[,
;                  $vParam4 = "@APPEXITPARAM@"[, $vParam5 = "@APPEXITPARAM@"[, $vParam6 = "@APPEXITPARAM@"[, $vParam7 = "@APPEXITPARAM@"[,
;                  $vParam8 = "@APPEXITPARAM@"]]]]]]]])
; Parameters ....: $vFunc               - a variant value.
;                  $vParam1-$vParam8    - optional parameters
; Author ........: SmOke_N (Ron Nielsen.. Ron.SMACKThatApp@GMail.com)
; Modified ......:
; ===============================================================================================================================
Func _AutOnExit_AddFunc($vFunc, _
		$vParam1 = "@APPEXITPARAM@", $vParam2 = "@APPEXITPARAM@", _
		$vParam3 = "@APPEXITPARAM@", $vParam4 = "@APPEXITPARAM@", _
		$vParam5 = "@APPEXITPARAM@", $vParam6 = "@APPEXITPARAM@", _
		$vParam7 = "@APPEXITPARAM@", $vParam8 = "@APPEXITPARAM@")

	If IsString($vFunc) Then $vFunc = Execute($vFunc)

	Local $aParams[$AUTONEXIT_MAXPARAMS + 2] = [$vParam1, $vParam2, $vParam3, _
							$vParam4, $vParam5, $vParam6, $vParam7, $vParam8]

	$AUTONEXIT_ARGSCOUNT += 1
	ReDim $AUTONEXIT_ARGS[$AUTONEXIT_ARGSCOUNT + 1][$AUTONEXIT_MAXPARAMS + 1]
	; fill arguments
	For $i = 1 To $AUTONEXIT_MAXPARAMS
		$AUTONEXIT_ARGS[$AUTONEXIT_ARGSCOUNT][$i] = "@APPEXITPARAM@"
	Next

	; first param is function
	$AUTONEXIT_ARGS[$AUTONEXIT_ARGSCOUNT][0] = $vFunc

	; now for rest of parameters/arguments
	For $i = 1 To @NumParams - 1
		$AUTONEXIT_ARGS[$AUTONEXIT_ARGSCOUNT][$i] = $aParams[$i]
	Next

EndFunc

Func __AutOnExit_Cleanup()

	Local $vCall, $iArgs = 0

	If IsDeclared("$AUTONEXIT_ARGSCOUNT") Then
		For $i = 0 To $AUTONEXIT_ARGSCOUNT

			; get filled argument counts
			$iArgs = 0
			For $n = 1 To UBound($AUTONEXIT_ARGS, 2) - 1
				If $AUTONEXIT_ARGS[$i][$n] = "@APPEXITPARAM@" Then ExitLoop
				$iArgs += 1
			Next

			$vCall = $AUTONEXIT_ARGS[$i][0]
			Switch $iArgs
				Case 0
					$vCall()
				Case 1
					$vCall($AUTONEXIT_ARGS[$i][1])
				Case 2
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2])
				Case 3
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2], _
						$AUTONEXIT_ARGS[$i][3])
				Case 4
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2], _
						$AUTONEXIT_ARGS[$i][3], _
						$AUTONEXIT_ARGS[$i][4])
				Case 5
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2], _
						$AUTONEXIT_ARGS[$i][3], _
						$AUTONEXIT_ARGS[$i][4], _
						$AUTONEXIT_ARGS[$i][5])
				Case 6
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2], _
						$AUTONEXIT_ARGS[$i][3], _
						$AUTONEXIT_ARGS[$i][4], _
						$AUTONEXIT_ARGS[$i][5], _
						$AUTONEXIT_ARGS[$i][6])
				Case 7
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2], _
						$AUTONEXIT_ARGS[$i][3], _
						$AUTONEXIT_ARGS[$i][4], _
						$AUTONEXIT_ARGS[$i][5], _
						$AUTONEXIT_ARGS[$i][6], _
						$AUTONEXIT_ARGS[$i][7])
				Case 8
					$vCall($AUTONEXIT_ARGS[$i][1], _
						$AUTONEXIT_ARGS[$i][2], _
						$AUTONEXIT_ARGS[$i][3], _
						$AUTONEXIT_ARGS[$i][4], _
						$AUTONEXIT_ARGS[$i][5], _
						$AUTONEXIT_ARGS[$i][6], _
						$AUTONEXIT_ARGS[$i][7], _
						$AUTONEXIT_ARGS[$i][8])
			EndSwitch
		Next
	EndIf
EndFunc