INCLUDE Irvine32.inc

.data
arrayB      BYTE  5, 10, 15, 20, 25
arrayW      WORD  100h, 200h, 300h, 400h, 500h
arrayD      DWORD 1000h, 2000h, 3000h, 4000h, 5000h

msgB        BYTE "arrayB (decimal) : ", 0
msgW        BYTE "arrayW (hex)     : ", 0
msgD        BYTE "arrayD (hex)     : ", 0
msgWrong    BYTE "arrayW if ESI += 1 (wrong) : ", 0
msgSep      BYTE "  ", 0
msgSepH     BYTE "h  ", 0

.code
main PROC
    ; ---------- arrayB ----------
    mov     edx, OFFSET msgB
    call    WriteString
    mov     esi, OFFSET arrayB          ; ESI -> first element
    mov     ecx, LENGTHOF arrayB        ; 5 iterations
L1:
    movzx   eax, BYTE PTR [esi]
    call    WriteDec
    mov     edx, OFFSET msgSep
    call    WriteString
    add     esi, TYPE arrayB            ; next element (+1)
    loop    L1
    call    Crlf

    ; ---------- arrayW ----------
    mov     edx, OFFSET msgW
    call    WriteString
    mov     esi, OFFSET arrayW
    mov     ecx, LENGTHOF arrayW
    mov     ebx, TYPE arrayW            ; WriteHexB: display 2 bytes
L2:
    movzx   eax, WORD PTR [esi]
    call    WriteHexB
    mov     edx, OFFSET msgSepH
    call    WriteString
    add     esi, TYPE arrayW            ; next element (+2)
    loop    L2
    call    Crlf

    ; ---------- arrayD ----------
    mov     edx, OFFSET msgD
    call    WriteString
    mov     esi, OFFSET arrayD
    mov     ecx, LENGTHOF arrayD
L3:
    mov     eax, [esi]                  ; size known from EAX
    call    WriteHex
    mov     edx, OFFSET msgSepH
    call    WriteString
    add     esi, TYPE arrayD            ; next element (+4)
    loop    L3
    call    Crlf
    call    Crlf

    ; ---------- demonstration: wrong increment for a WORD array ----------
    mov     edx, OFFSET msgWrong
    call    WriteString
    mov     esi, OFFSET arrayW
    mov     ecx, LENGTHOF arrayW
    mov     ebx, TYPE arrayW
L4:
    movzx   eax, WORD PTR [esi]
    call    WriteHexB
    mov     edx, OFFSET msgSepH
    call    WriteString
    inc     esi                         ; WRONG: only 1 byte instead of TYPE arrayW
    loop    L4
    call    Crlf

    exit
main ENDP
END main
