INCLUDE Irvine32.inc

.data
buffer      BYTE 15h, 25h, 35h, 45h, 55h

msgBefore   BYTE "Original buffer : ", 0
msgFirst    BYTE "First element read with [ESI] = ", 0
msgAfter    BYTE "Modified buffer : ", 0
msgHex      BYTE "h", 0
msgSpace    BYTE "h  ", 0

.code
main PROC
    mov     edx, OFFSET msgBefore
    call    WriteString
    call    ShowBuffer

    mov     esi, OFFSET buffer          ; ESI points to buffer[0]

    ; ---- read the first element ----
    mov     al, [esi]                   ; AL = 15h (size known from AL)
    mov     edx, OFFSET msgFirst
    call    WriteString
    movzx   eax, al
    mov     ebx, 1
    call    WriteHexB
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    ; ---- replace the second element with 66h ----
    mov     BYTE PTR [esi + 1], 66h     ; PTR needed: an immediate has no size

    ; ---- increment the fifth element ----
    inc     BYTE PTR [esi + 4]          ; PTR needed: INC has only one operand (55h -> 56h)

    mov     edx, OFFSET msgAfter
    call    WriteString
    call    ShowBuffer

    exit
main ENDP

;------------------------------------------------------------
; ShowBuffer
; Displays every byte of buffer in hexadecimal on one line.
;------------------------------------------------------------
ShowBuffer PROC
    push    esi
    mov     esi, OFFSET buffer
    mov     ecx, LENGTHOF buffer
    mov     ebx, TYPE buffer            ; WriteHexB: display 1 byte
L1:
    movzx   eax, BYTE PTR [esi]
    call    WriteHexB
    mov     edx, OFFSET msgSpace
    call    WriteString
    add     esi, TYPE buffer
    loop    L1
    call    Crlf
    pop     esi
    ret
ShowBuffer ENDP
END main
