; Lab 4 - Task 1 : MOV, XCHG and storing registers to memory
INCLUDE Irvine32.inc

.data
num1        DWORD 1500h
num2        DWORD 2500h
finalEBX    DWORD ?
finalECX    DWORD ?

msgTitle    BYTE "Task 1 - MOV and XCHG", 0
msgEBX      BYTE "finalEBX (memory) = ", 0
msgECX      BYTE "finalECX (memory) = ", 0
msgHex      BYTE "h", 0

.code
main PROC
    mov     edx, OFFSET msgTitle
    call    WriteString
    call    Crlf

    mov     eax, num1           ; EAX = 00001500h
    mov     ebx, eax            ; EBX = 00001500h
    mov     ecx, num2           ; ECX = 00002500h

    xchg    ebx, ecx            ; EBX = 00002500h, ECX = 00001500h

    mov     finalEBX, ebx       ; store final EBX in memory
    mov     finalECX, ecx       ; store final ECX in memory

    call    DumpRegs            ; show EAX, EBX, ECX

    ; display both memory variables
    mov     edx, OFFSET msgEBX
    call    WriteString
    mov     eax, finalEBX
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgECX
    call    WriteString
    mov     eax, finalECX
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    exit
main ENDP
END main
