INCLUDE Irvine32.inc

.data
arrayB      BYTE 12h, 24h, 36h, 48h, 5Ah
arrayW      WORD 1111h, 2222h, 3333h, 4444h

msgTitle    BYTE "Task 1 - Direct-Offset Operands", 0
msgB1       BYTE "arrayB first  [arrayB + 0] = ", 0
msgB3       BYTE "arrayB third  [arrayB + 2] = ", 0
msgB5       BYTE "arrayB last   [arrayB + 4] = ", 0
msgW2       BYTE "arrayW second [arrayW + 2] = ", 0
msgW4       BYTE "arrayW fourth [arrayW + 6] = ", 0
msgHex      BYTE "h", 0

.code
main PROC
    mov     edx, OFFSET msgTitle
    call    WriteString
    call    Crlf
    call    Crlf

    ; ---------- arrayB : 1 byte per element ----------
    mov     edx, OFFSET msgB1
    call    WriteString
    movzx   eax, [arrayB + 0]           ; first element, zero-extended to 32 bits
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgB3
    call    WriteString
    movzx   eax, [arrayB + 2]           ; third element (index 2 * 1 byte)
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgB5
    call    WriteString
    movzx   eax, [arrayB + 4]           ; last element (index 4 * 1 byte)
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    ; ---------- arrayW : 2 bytes per element ----------
    mov     edx, OFFSET msgW2
    call    WriteString
    movzx   eax, [arrayW + 2]           ; second element (index 1 * 2 bytes)
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgW4
    call    WriteString
    movzx   eax, [arrayW + 6]           ; fourth element (index 3 * 2 bytes)
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    exit
main ENDP
END main
