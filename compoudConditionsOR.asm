;--------------------------------------------------------------------------------------
; Description: Implements compound conditions OR, using conditional jmp
;			   (ebx > ecx || ebx > val1) ? X = 1 : X = 2
; Author name: Koichi Nakata
; Author email: kanakta595@insite.4cd.edu
; Last modified date: March 28, 2024
; Creation date: March 28, 2024
;--------------------------------------------------------------------------------------

INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: dword

.data
val1  dword 19191919
X.    dword ?
msg1  byte  "X: ", 0
msg2  byte  "val1: ", 0
msg3  byte  "EBX: ", 0
msg4  byte  "ECX: ", 0

.code
main PROC
	mov  ebx, 19191920
	mov  ecx, 19191921

	cmp  ebx, ecx		; Evaluates ebx - ecx
	ja   L1			; Jump to L1 if the result is above 0
	cmp  ebx, val1		; Evaluates ebx - val1
	ja   L1			; Jump to L1 if the result is above 0
	mov  X, 2		; Both conditions are false
	jmp  next		; Want to skip L1

L1: mov	 X, 1

next:
    	call displayX
	INVOKE ExitProcess, 0
main ENDP

;--------------------------------------------------------------------------------------
displayX PROC
; Displays the contents in X, val1, ebx and ecx
; Receives: void
; Returns: void
; Remarks: Save the value edx to the stack
;--------------------------------------------------------------------------------------
	mov  edx, offset msg1
	call WriteString
	mov  eax, X
	call WriteDec
	call Crlf

	mov  edx, offset msg2
	call WriteString
	mov  eax, val1
	call WriteDec
	call Crlf

	mov  edx, offset msg3
	call WriteString
	mov  eax, ebx
	call WriteDec
	call Crlf

	mov  edx, offset msg4
	call WriteString
	mov  eax, ecx
	call WriteDec
	ret
displayX ENDP

END main