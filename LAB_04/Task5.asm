; Lab 4 - Task 5 : evaluate R = -(2X - Y) + (Z - 3W) with signed 32-bit values
INCLUDE Irvine32.inc

.data
X           SDWORD 120
Y           SDWORD 75
Z           SDWORD 40
W           SDWORD 30
R           SDWORD ?

msgT1       BYTE "Term 1 : EAX = -(2X - Y)", 0
msgT2       BYTE "Term 2 : ECX = (Z - 3W)", 0
msgFinal    BYTE "Final  : EAX = EAX + ECX  (flags after final ADD)", 0
msgRHex     BYTE "R (hexadecimal)          = ", 0
msgRDec     BYTE "R (signed decimal)       = ", 0
msgVerify   BYTE "Verify: ESI = R          = ", 0
msgUns      BYTE "Same bits read unsigned  = ", 0
msgHex      BYTE "h", 0

.code
main PROC
    xor     ebx, ebx                ; clear registers so DumpRegs is easy to read
    xor     ecx, ecx
    xor     esi, esi

    ; ---------- Term 1 : -(2X - Y) ----------
    mov     edx, OFFSET msgT1
    call    WriteString
    mov     eax, X                  ; EAX = 120
    add     eax, X                  ; EAX = 2X = 240
    sub     eax, Y                  ; EAX = 2X - Y = 165
    neg     eax                     ; EAX = -165 (FFFFFF5Bh)
    call    DumpRegs                ; flags after NEG

    ; ---------- Term 2 : (Z - 3W) ----------
    mov     edx, OFFSET msgT2
    call    WriteString
    mov     ebx, W                  ; EBX = 30
    add     ebx, W                  ; EBX = 60
    add     ebx, W                  ; EBX = 3W = 90
    mov     ecx, Z                  ; ECX = 40
    sub     ecx, ebx                ; ECX = Z - 3W = -50 (FFFFFFCEh)
    call    DumpRegs                ; flags after SUB

    ; ---------- Combine ----------
    mov     edx, OFFSET msgFinal
    call    WriteString
    add     eax, ecx                ; EAX = -165 + (-50) = -215 (FFFFFF29h)
    call    DumpRegs                ; flags immediately after the final ADD
    mov     R, eax                  ; store final answer

    ; ---------- Display R ----------
    mov     edx, OFFSET msgRHex
    call    WriteString
    mov     eax, R
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgRDec
    call    WriteString
    mov     eax, R
    call    WriteInt
    call    Crlf

    ; ---------- Verify by loading R into another register ----------
    mov     esi, R                  ; ESI = FFFFFF29h
    mov     edx, OFFSET msgVerify
    call    WriteString
    mov     eax, esi
    call    WriteInt                ; signed view   : -215
    call    Crlf

    mov     edx, OFFSET msgUns
    call    WriteString
    mov     eax, esi
    call    WriteDec                ; unsigned view : 4294967081
    call    Crlf

    exit
main ENDP
END main
