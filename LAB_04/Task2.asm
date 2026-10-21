; Lab 4 - Task 2 : ADD, DEC and NEG on 8-bit registers and their effect on flags
INCLUDE Irvine32.inc

.data
resAL       BYTE ?
resBL       BYTE ?
resCL       BYTE ?

msgAdd      BYTE "1) MOV AL,7Fh   ADD AL,01h", 0
msgDec      BYTE "2) MOV BL,00h   DEC BL", 0
msgNeg      BYTE "3) MOV CL,05h   NEG CL", 0
msgFinal    BYTE "Final 8-bit register values:", 0
msgAL       BYTE "AL = ", 0
msgBL       BYTE "BL = ", 0
msgCL       BYTE "CL = ", 0
msgHex      BYTE "h", 0

.code
main PROC
    xor     eax, eax            ; clear registers so DumpRegs is easy to read
    xor     ebx, ebx
    xor     ecx, ecx

    ; ---------- Operation 1 : ADD ----------
    mov     edx, OFFSET msgAdd
    call    WriteString
    mov     al, 7Fh             ; AL = 7Fh (+127)
    add     al, 01h             ; AL = 80h  -> CF=0 ZF=0 SF=1 OF=1
    call    DumpRegs            ; flags recorded immediately after ADD
    mov     resAL, al

    ; ---------- Operation 2 : DEC ----------
    mov     edx, OFFSET msgDec
    call    WriteString
    mov     bl, 00h             ; BL = 00h
    clc                         ; DEC does not touch CF, so start it from a known 0
    dec     bl                  ; BL = FFh  -> CF=0 (unchanged) ZF=0 SF=1
    call    DumpRegs            ; flags recorded immediately after DEC
    mov     resBL, bl

    ; ---------- Operation 3 : NEG ----------
    mov     edx, OFFSET msgNeg
    call    WriteString
    mov     cl, 05h             ; CL = 05h
    neg     cl                  ; CL = FBh (-5) -> CF=1 ZF=0 SF=1 OF=0
    call    DumpRegs            ; flags recorded immediately after NEG
    mov     resCL, cl

    ; ---------- Final register values ----------
    mov     edx, OFFSET msgFinal
    call    WriteString
    call    Crlf

    mov     ebx, 1              ; WriteHexB: display 1 byte

    mov     edx, OFFSET msgAL
    call    WriteString
    movzx   eax, resAL
    call    WriteHexB
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgBL
    call    WriteString
    movzx   eax, resBL
    call    WriteHexB
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgCL
    call    WriteString
    movzx   eax, resCL
    call    WriteHexB
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    exit
main ENDP
END main
