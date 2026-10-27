INCLUDE Irvine32.inc

.data
firstVals   DWORD 25, 120, 8            ; test inputs (first number)
secondVals  DWORD 7, 45, 20             ; test inputs (second number)
sumR        DWORD ?
diffR       DWORD ?
prodR       DWORD ?

msgCase     BYTE "Test ", 0
msgA        BYTE ":  A = ", 0
msgB        BYTE ",  B = ", 0
msgSum      BYTE "   Sum        (A + B) = ", 0
msgDiff     BYTE "   Difference (A - B) = ", 0
msgSigned   BYTE "   (signed view: ", 0
msgClose    BYTE ")", 0
msgProd     BYTE "   Product    (A * B) = ", 0

.code
main PROC
    mov     esi, 0                      ; test index
    mov     ecx, LENGTHOF firstVals     ; number of tests
NextTest:
    ; ---- show the inputs ----
    mov     edx, OFFSET msgCase
    call    WriteString
    mov     eax, esi
    inc     eax
    call    WriteDec
    mov     edx, OFFSET msgA
    call    WriteString
    mov     eax, firstVals[esi * TYPE firstVals]
    call    WriteDec
    mov     edx, OFFSET msgB
    call    WriteString
    mov     eax, secondVals[esi * TYPE secondVals]
    call    WriteDec
    call    Crlf

    ; ---- call the procedure ----
    mov     eax, firstVals[esi * TYPE firstVals]    ; input 1
    mov     ebx, secondVals[esi * TYPE secondVals]  ; input 2
    call    CalculateResult
    call    ShowResults

    inc     esi                         ; ECX and ESI were preserved by the procedures
    loop    NextTest

    exit
main ENDP

;------------------------------------------------------------
; ShowResults
; Displays the three results returned by CalculateResult.
; Receives: EDI = sum, EDX = difference, EAX = product
;------------------------------------------------------------
ShowResults PROC
    mov     sumR, edi
    mov     diffR, edx
    mov     prodR, eax

    mov     edx, OFFSET msgSum
    call    WriteString
    mov     eax, sumR
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgDiff
    call    WriteString
    mov     eax, diffR
    call    WriteDec                    ; unsigned result
    mov     edx, OFFSET msgSigned
    call    WriteString
    call    WriteInt                    ; same bits as signed
    mov     edx, OFFSET msgClose
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgProd
    call    WriteString
    mov     eax, prodR
    call    WriteDec
    call    Crlf
    call    Crlf
    ret
ShowResults ENDP

;------------------------------------------------------------
; CalculateResult
; Calculates the sum, difference and product of two
; unsigned integers.
; Receives: EAX = first number (A), EBX = second number (B)
; Returns:  EDI = A + B
;           EDX = A - B
;           EAX = A * B (low 32 bits)
; Preserves: EBX, ECX, ESI
;------------------------------------------------------------
CalculateResult PROC
    mov     edi, eax
    add     edi, ebx                    ; EDI = sum

    push    eax                         ; save A (MUL overwrites EAX and EDX)
    mul     ebx                         ; EDX:EAX = A * B
    pop     edx                         ; EDX = A
    sub     edx, ebx                    ; EDX = A - B
    ret
CalculateResult ENDP
END main
