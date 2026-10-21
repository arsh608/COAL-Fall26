; Lab 4 - Task 3 : MOVZX and MOVSX (zero extension vs sign extension)
INCLUDE Irvine32.inc

.data
uVal        BYTE  9Bh           ; unsigned byte
sVal        SBYTE -101          ; signed byte (stored as 9Bh)
zxResult    DWORD ?             ; zero-extended CL
sxResult    DWORD ?             ; sign-extended CL

msgTitle    BYTE "Task 3 - MOVZX / MOVSX", 0
msgEAX      BYTE "EAX = MOVZX uVal  : ", 0
msgEBX      BYTE "EBX = MOVSX sVal  : ", 0
msgZX       BYTE "zxResult (MOVZX CL): ", 0
msgSX       BYTE "sxResult (MOVSX CL): ", 0
msgHex      BYTE "h   decimal = ", 0

.code
main PROC
    mov     edx, OFFSET msgTitle
    call    WriteString
    call    Crlf

    movzx   eax, uVal           ; EAX = 0000009Bh = 155
    movsx   ebx, sVal           ; EBX = FFFFFF9Bh = -101

    xor     ecx, ecx            ; clear ECX so CL is easy to see
    mov     cl, 9Bh             ; same bit pattern 1001 1011
    movzx   edx, cl             ; EDX = 0000009Bh (zero extension)
    movsx   esi, cl             ; ESI = FFFFFF9Bh (sign extension)

    mov     zxResult, edx
    mov     sxResult, esi

    call    DumpRegs

    ; ---- display every converted value in hex and decimal ----
    mov     edx, OFFSET msgEAX
    call    WriteString
    call    WriteHex            ; EAX already holds MOVZX uVal
    mov     edx, OFFSET msgHex
    call    WriteString
    call    WriteDec            ; unsigned decimal
    call    Crlf

    mov     edx, OFFSET msgEBX
    call    WriteString
    mov     eax, ebx
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    WriteInt            ; signed decimal
    call    Crlf

    mov     edx, OFFSET msgZX
    call    WriteString
    mov     eax, zxResult
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgSX
    call    WriteString
    mov     eax, sxResult
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    WriteInt
    call    Crlf

    exit
main ENDP
END main
