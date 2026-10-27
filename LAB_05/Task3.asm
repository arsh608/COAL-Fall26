INCLUDE Irvine32.inc

.data
dataVal     DWORD 89ABCDEFh
wordList    WORD  1357h, 2468h

; Little-endian: the LOWEST byte is stored at the LOWEST address.
;   dataVal  in memory : EF CD AB 89        (dataVal+0 .. dataVal+3)
;   wordList in memory : 57 13 68 24        (1357h then 2468h)

msgTitle    BYTE "Task 3 - PTR and Little-Endian", 0
msgLow      BYTE "Low word  : AX  = WORD PTR dataVal       = ", 0
msgHigh     BYTE "High word : BX  = WORD PTR [dataVal + 2] = ", 0
msgByte     BYTE "Low byte  : CL  = BYTE PTR dataVal       = ", 0
msgDword    BYTE "DWORD     : ESI = DWORD PTR wordList     = ", 0
msgHex      BYTE "h", 0

.code
main PROC
    mov     edx, OFFSET msgTitle
    call    WriteString
    call    Crlf

    xor     eax, eax                    ; clear registers so DumpRegs is easy to read
    xor     ebx, ebx
    xor     ecx, ecx

    ; bytes at dataVal+0, +1 are EF CD -> read as a word = CDEFh
    mov     ax, WORD PTR dataVal

    ; bytes at dataVal+2, +3 are AB 89 -> read as a word = 89ABh
    mov     bx, WORD PTR [dataVal + 2]

    ; byte at dataVal+0 is EF -> lowest byte = EFh
    mov     cl, BYTE PTR dataVal

    ; bytes 57 13 68 24 read as one DWORD -> 24681357h
    ; (the second word 2468h becomes the HIGH half because it is at the higher address)
    mov     esi, DWORD PTR wordList

    call    DumpRegs

    ; ---------- display the four values ----------
    mov     edx, OFFSET msgLow
    call    WriteString
    movzx   eax, ax                     ; AX = CDEFh
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgHigh
    call    WriteString
    movzx   eax, bx                     ; BX = 89ABh
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgByte
    call    WriteString
    movzx   eax, cl                     ; CL = EFh
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgDword
    call    WriteString
    mov     eax, esi                    ; ESI = 24681357h
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    exit
main ENDP
END main
