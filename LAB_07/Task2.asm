INCLUDE Irvine32.inc

.data
espBefore   DWORD ?
espAfter    DWORD ?

msgOrig     BYTE "1) Original values (before PUSH):", 0
msgOver     BYTE "2) After PUSH and overwriting EAX/EBX:", 0
msgRest     BYTE "3) After POP EBX, POP EAX (restored):", 0
msgB        BYTE "ESP before the two PUSHes = ", 0
msgA        BYTE "ESP after the two POPs    = ", 0
msgOK       BYTE "Stack pointer is back to its original value.", 0
msgHex      BYTE "h", 0

.code
main PROC
    mov     edx, OFFSET msgOrig
    call    WriteString
    mov     eax, 12345678h
    mov     ebx, 0ABCDEF0h
    call    DumpRegs

    mov     edx, OFFSET msgOver
    call    WriteString

    mov     espBefore, esp
    push    eax                         ; save EAX
    push    ebx                         ; save EBX (now on top)

    mov     eax, 11111111h              ; overwrite both registers
    mov     ebx, 22222222h
    call    DumpRegs                    ; ESP is 8 bytes lower here

    mov     edx, OFFSET msgRest
    call    WriteString
    pop     ebx                         ; reverse order: last pushed, first popped
    pop     eax
    mov     espAfter, esp
    call    DumpRegs                    ; EAX = 12345678h, EBX = 0ABCDEF0h

    ; ---------- show stack balance ----------
    mov     edx, OFFSET msgB
    call    WriteString
    mov     eax, espBefore
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgA
    call    WriteString
    mov     eax, espAfter
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     eax, espAfter
    cmp     eax, espBefore
    jne     Done
    mov     edx, OFFSET msgOK
    call    WriteString
    call    Crlf
Done:
    exit
main ENDP
END main
