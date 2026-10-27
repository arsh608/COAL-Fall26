INCLUDE Irvine32.inc

.data
arrayB      BYTE  11, 22, 33, 44, 55, 66
arrayW      WORD  1000h, 2000h, 3000h, 4000h, 5000h, 6000h
arrayD      DWORD 11111111h, 22222222h, 33333333h, 44444444h

msgB        BYTE "--- arrayB (TYPE 1) ---", 0
msgW        BYTE "--- arrayW (TYPE 2) : elements 1, 3, 5 ---", 0
msgD        BYTE "--- arrayD (TYPE 4) : second and fourth ---", 0
msgIdx      BYTE "  index ", 0
msgDisp     BYTE "  displacement = ", 0
msgVal      BYTE "  value = ", 0
msgDec      BYTE "h  (", 0
msgClose    BYTE ")", 0
msgHex      BYTE "h", 0
msgRange    BYTE "  valid displacements: 0 to ", 0
msgOut      BYTE "--- Out-of-range access ---", 0
msgOutB     BYTE "  arrayB[6] (displacement 6) assembled and read = ", 0
msgOutNote  BYTE "  -> this is NOT part of arrayB; it is the low byte of arrayW[0] (1000h)", 0

.code
main PROC
    ; ================= arrayB =================
    mov     edx, OFFSET msgB
    call    WriteString
    call    Crlf

    mov     esi, 0 * TYPE arrayB        ; index 0
    movzx   eax, arrayB[esi]
    mov     ebx, 0
    mov     ecx, TYPE arrayB
    call    PrintEntry

    mov     esi, 2 * TYPE arrayB        ; index 2
    movzx   eax, arrayB[esi]
    mov     ebx, 2
    mov     ecx, TYPE arrayB
    call    PrintEntry

    mov     esi, (LENGTHOF arrayB - 1) * TYPE arrayB   ; last index 5
    movzx   eax, [arrayB + esi]         ; same as arrayB[esi]
    mov     ebx, LENGTHOF arrayB - 1
    mov     ecx, TYPE arrayB
    call    PrintEntry

    mov     eax, (LENGTHOF arrayB - 1) * TYPE arrayB
    call    PrintRange

    ; ================= arrayW =================
    mov     edx, OFFSET msgW
    call    WriteString
    call    Crlf

    mov     esi, 1 * TYPE arrayW        ; displacement 2
    movzx   eax, arrayW[esi]
    mov     ebx, 1
    mov     ecx, TYPE arrayW
    call    PrintEntry

    mov     esi, 3 * TYPE arrayW        ; displacement 6
    movzx   eax, arrayW[esi]
    mov     ebx, 3
    mov     ecx, TYPE arrayW
    call    PrintEntry

    mov     esi, 5 * TYPE arrayW        ; displacement 10
    movzx   eax, arrayW[esi]
    mov     ebx, 5
    mov     ecx, TYPE arrayW
    call    PrintEntry

    mov     eax, (LENGTHOF arrayW - 1) * TYPE arrayW
    call    PrintRange

    ; ================= arrayD =================
    mov     edx, OFFSET msgD
    call    WriteString
    call    Crlf

    mov     esi, 1 * TYPE arrayD        ; second element, displacement 4
    mov     eax, arrayD[esi]
    mov     ebx, 1
    mov     ecx, TYPE arrayD
    call    PrintEntry

    mov     esi, 3 * TYPE arrayD        ; fourth element, displacement 12
    mov     eax, arrayD[esi]
    mov     ebx, 3
    mov     ecx, TYPE arrayD
    call    PrintEntry

    mov     eax, (LENGTHOF arrayD - 1) * TYPE arrayD
    call    PrintRange

    ; ================= out of range =================
    mov     edx, OFFSET msgOut
    call    WriteString
    call    Crlf
    mov     esi, LENGTHOF arrayB * TYPE arrayB  ; displacement 6 = one past the end
    movzx   eax, arrayB[esi]            ; assembles fine, no range check
    mov     edx, OFFSET msgOutB
    call    WriteString
    mov     ebx, TYPE arrayB
    call    WriteHexB
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf
    mov     edx, OFFSET msgOutNote
    call    WriteString
    call    Crlf

    exit
main ENDP

;------------------------------------------------------------
; PrintEntry
; Displays one element as: index, displacement, value (hex and decimal).
; Receives: EAX = value, EBX = index, ECX = TYPE of the array,
;           ESI = byte displacement
;------------------------------------------------------------
PrintEntry PROC
    push    eax

    mov     edx, OFFSET msgIdx
    call    WriteString
    mov     eax, ebx
    call    WriteDec                    ; index

    mov     edx, OFFSET msgDisp
    call    WriteString
    mov     eax, esi
    call    WriteDec                    ; displacement

    mov     edx, OFFSET msgVal
    call    WriteString
    pop     eax
    mov     ebx, ecx                    ; WriteHexB size = TYPE
    call    WriteHexB                   ; value in hex
    mov     edx, OFFSET msgDec
    call    WriteString
    call    WriteDec                    ; value in decimal
    mov     edx, OFFSET msgClose
    call    WriteString
    call    Crlf
    ret
PrintEntry ENDP

;------------------------------------------------------------
; PrintRange
; Displays the valid displacement range 0 .. EAX.
; Receives: EAX = largest valid displacement
;------------------------------------------------------------
PrintRange PROC
    mov     edx, OFFSET msgRange
    call    WriteString
    call    WriteDec
    call    Crlf
    call    Crlf
    ret
PrintRange ENDP
END main
