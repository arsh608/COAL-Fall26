INCLUDE Irvine32.inc

.data
multiples   DWORD 10 DUP(?)

msgArr      BYTE "Multiples of 7 : ", 0
msgDump     BYTE "DumpMem of multiples:", 0
msgSpace    BYTE "  ", 0

.code
main PROC
    ; ---------- loop 1 : fill the array through ESI ----------
    mov     esi, OFFSET multiples       ; pointer to first element
    mov     ecx, LENGTHOF multiples     ; 10 iterations
    mov     eax, 7                      ; first multiple
Fill:
    mov     [esi], eax                  ; store current multiple
    add     eax, 7                      ; next multiple of 7
    add     esi, TYPE multiples         ; next element (+4 bytes)
    loop    Fill

    ; ---------- loop 2 : display the array ----------
    mov     edx, OFFSET msgArr
    call    WriteString
    mov     esi, OFFSET multiples
    mov     ecx, LENGTHOF multiples
Show:
    mov     eax, [esi]
    call    WriteDec
    mov     edx, OFFSET msgSpace
    call    WriteString
    add     esi, TYPE multiples
    loop    Show
    call    Crlf
    call    Crlf

    ; ---------- memory dump ----------
    mov     edx, OFFSET msgDump
    call    WriteString
    mov     esi, OFFSET multiples       ; starting address
    mov     ecx, LENGTHOF multiples     ; number of units
    mov     ebx, TYPE multiples         ; unit size (4 = doubleword)
    call    DumpMem

    exit
main ENDP
END main
