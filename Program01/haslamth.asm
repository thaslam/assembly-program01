TITLE Math Assistant     (haslamth.asm)            
;EC: Program verifies second number less than first.

; Author: Tom Haslam
; CS271 / Project #1                 Date: 10/1/2017
; Description: Project instruction user to enter two numbers and displays sum, diff, product, and quotient with remainder

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
    intro       BYTE    "My programmer's name is Tom.", 13, 10, \
                        "My title is 'Your Math Assistant'", 10, 0     ;store author and title
    instructs   BYTE    "Enter 2 numbers, and I'll show you the sum ", \
                        "difference", 13, 10, "product, quotient, and ", \
                        "remainder.", 13, 10, 0                         ;store instructions

    prompt_1    BYTE    "First Number:", 0                              ;store first number
    prompt_2    BYTE    "Second Number:", 0                             ;store second number
    terminate_1 BYTE    "All Done!, press any key to exit.", 0          ;store exit message
    invalid_msg BYTE    "Second number must be less than the first!",0  ;store message if invalid second number entered
    plus_op     BYTE    " + ", 0                                        ;store plus operator
    minus_op    BYTE    " - ", 0                                        ;store minus operator
    multiply_op BYTE    " * ", 0                                        ;store multiplication operator
    divide_op   BYTE    " / ", 0                                        ;store division operator
    equals_op   BYTE    " = ", 0                                        ;store equals operator
    mod_label   BYTE    " remainder ", 0                                ;store remainder label text
    
    operand_1	DWORD	?	;first int operand entered by user
    operand_2   DWORD   ?   ;second int operan entered by user

    sum         DWORD   ?   ;store sum of first and second number
    diff        DWORD   ?   ;store difference of first and second number
    product     DWORD   ?   ;store product of first and second number
    quotient    DWORD   ?   ;store quotient of first and second number
    remainder   DWORD   ?   ;store remainder of first and second number
.code
main PROC

; introduce programmer
    mov     edx, OFFSET intro
    call    WriteString
    call    CrLf

    mov     edx, OFFSET instructs
    call    WriteString
    call    CrLf

; get first and second operands
    mov     edx, OFFSET prompt_1
    call    WriteString
	call	ReadInt
	mov		operand_1, eax

    mov     edx, OFFSET prompt_2
    call    WriteString
	call	ReadInt
	mov		operand_2, eax
    call    CrLf

; validate input
    mov     eax, operand_1
    cmp     eax, operand_2
    js      InvalidInput

; calculate values
    ; calculate sum of first and second number
    mov     eax, operand_1
    add     eax, operand_2
    mov     sum, eax                ;result applied to eax, move to memory story
; calculate difference of first and second number
    mov     eax, operand_1
    sub     eax, operand_2
    mov     diff, eax               ;results applied to eax register, move to memory store
; calculate product of first and second number
    mov     eax, operand_1
    mov     ebx, operand_2
    mul     ebx
    mov     product, eax            ;result stored in eax, move to memory story for product
;calculate quotient and remainder of first and second number
    mov     edx, 0
    mov     eax, operand_1
    div     operand_2
    mov     quotient, eax           ;result stored in eax, we only care about eax because 32bit numbers
    mov     remainder, edx          ;remainder stored in edx reg, move to memory

; display results
    ;display addition results
    mov     eax, operand_1
    call    WriteDec
    mov     edx, OFFSET plus_op
    call    WriteString
    mov     eax, operand_2
    call    WriteDec
    mov     edx, OFFSET equals_op
    call    WriteString
    mov     eax, sum
    call    WriteDec
    call    CrLf
    
;display substraction results
    mov     eax, operand_1
    call    WriteDec
    mov     edx, OFFSET minus_op
    call    WriteString
    mov     eax, operand_2
    call    WriteDec
    mov     edx, OFFSET equals_op
    call    WriteString
    mov     eax, diff
    call    WriteDec
    call    CrLf

;display multiplication results
    mov     eax, operand_1
    call    WriteDec
    mov     edx, OFFSET multiply_op
    call    WriteString
    mov     eax, operand_2
    call    WriteDec
    mov     edx, OFFSET equals_op
    call    WriteString
    mov     eax, product
    call    WriteDec
    call    CrLf
    
;display division results
    mov     eax, operand_1
    call    WriteDec
    mov     edx, OFFSET divide_op
    call    WriteString
    mov     eax, operand_2
    call    WriteDec
    mov     edx, OFFSET equals_op
    call    WriteString
    mov     eax, quotient
    call    WriteDec
    mov     edx, OFFSET mod_label
    call    WriteString
    mov     eax, remainder
    call    WriteDec
    call    CrLf

; exit program but wait for user to press any key
    call    CrLf
    mov     edx, OFFSET terminate_1
    call    WriteString
	call	ReadChar
	exit	; exit to operating system

; here we jump to this label if input is invalid, then exit
InvalidInput: 
    mov     edx, OFFSET invalid_msg
    call    WriteString
    call    CrLf
    call    CrLf
    mov     edx, OFFSET terminate_1
    call    WriteString
    call	ReadChar
	exit	; exit to operating system

main ENDP

; (insert additional procedures here)

END main
