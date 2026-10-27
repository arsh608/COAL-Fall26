INCLUDE Irvine32.inc

.data
argA        SDWORD 150, -40, 1000       ; first argument of each test
argB        SDWORD 275, 90, -2500       ; second argument of each test
retAddr     DWORD ?                     ; return address saved by the procedure
argTemp     DWORD ?                     ; first argument removed from the stack
espBefore   DWORD ?
espAfter    DWORD ?

msgPlus     BYTE " + ", 0
msgEq       BYTE " = ", 0
msgBefore   BYTE "   ESP before PUSH = ", 0
msgAfter    BYTE "h   ESP after return = ", 0
msgBal      BYTE "h   (balanced)", 0
msgUnbal    BYTE "h   (NOT balanced)", 0

.code
main PROC
    mov     esi, 0                      ; test index
    mov     ecx, LENGTHOF argA          ; 3 tests
NextTest:
    mov     espBefore, esp

    push    argA[esi * TYPE argA]       ; first argument
    push    argB[esi * TYPE argB]       ; second argument
    call    AddStackNumbers             ; pushes the return address
    mov     espAfter, esp               ; EAX = sum
    call    ShowTest

    inc     esi
    loop    NextTest

    exit
main ENDP

;------------------------------------------------------------
; ShowTest
; Displays "a + b = sum" and the ESP values for one test.
; Receives: EAX = sum, ESI = test index
;------------------------------------------------------------
ShowTest PROC
    ; ---- display "a + b = sum" ----
    mov     ebx, eax                    ; keep the sum
    mov     eax, argA[esi * TYPE argA]
    call    WriteInt
    mov     edx, OFFSET msgPlus
    call    WriteString
    mov     eax, argB[esi * TYPE argB]
    call    WriteInt
    mov     edx, OFFSET msgEq
    call    WriteString
    mov     eax, ebx
    call    WriteInt
    call    Crlf

    ; ---- display stack balance ----
    mov     edx, OFFSET msgBefore
    call    WriteString
    mov     eax, espBefore
    call    WriteHex
    mov     edx, OFFSET msgAfter
    call    WriteString
    mov     eax, espAfter
    call    WriteHex
    mov     edx, OFFSET msgBal
    cmp     eax, espBefore
    je      ShowBal
    mov     edx, OFFSET msgUnbal
ShowBal:
    call    WriteString
    call    Crlf
    call    Crlf
    ret
ShowTest ENDP

;------------------------------------------------------------
; AddStackNumbers
; Adds two 32-bit integers that the caller pushed on the stack.
; Stack on entry:  [ESP]   = return address
;                  [ESP+4] = second argument
;                  [ESP+8] = first argument
; Returns: EAX = first + second. Both arguments are removed,
;          so the stack is balanced when control returns.
;------------------------------------------------------------
AddStackNumbers PROC
    pop     retAddr                     ; save the return address
    pop     eax                         ; EAX = second argument
    pop     argTemp                     ; first argument
    add     eax, argTemp                ; EAX = sum
    push    retAddr                     ; put the return address back on top
    ret                                 ; RET pops the correct return address
AddStackNumbers ENDP
END main
