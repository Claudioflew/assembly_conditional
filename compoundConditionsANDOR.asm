;--------------------------------------------------------------------------------------
; Description: Implements compound conditions And and OR, using conditional jmp
;			   ((ebx > ecx && ebx > edx) || edx > eax) ? X = 1 : X = 2
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
X dword ?
msg byte "X: ", 0


.code
main PROC
	mov  eax, 11111111h
	mov  ebx, 22222222h
	mov  ecx, 10000000h
	mov  edx, 10000000h

	cmp  ebx, ecx		; Evaluates 1st condition
	jbe	 L1				; Jump to L1 if False
	cmp  ebx, edx		; Evaluates 2nd condition
	jbe  L1				; Jump to L1 if False
	jmp  L2				; No need to evaluate 3rd condition if 1st and 2nd are True
	jmp	 next

L1:						; Still have a chance to be True
	cmp  edx, eax		; Evaluates 3rd condition
	ja	 L2				; Jump to L2 if True
	mov  X, 2			; Comes to this line if False
	jmp  next

L2: mov  X, 1			; Comes to this block if True
	jmp  next

next:
    call DumpRegs
	mov  edx, offset msg
	call WriteString
	mov	 eax, X
	call WriteDec
	INVOKE ExitProcess, 0
main ENDP
END main