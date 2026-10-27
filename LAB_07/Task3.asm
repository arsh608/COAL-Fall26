INCLUDE Irvine32.inc

.data
msgKnown    BYTE "1) Known state: MOV EAX,5 / CMP EAX,5  (ZF should be 1)", 0
msgChanged  BYTE "2) After PUSHFD and flag-changing instructions", 0
msgRestored BYTE "3) After POPFD (flags restored, registers NOT restored)", 0

.code
main PROC
    xor     ebx, ebx                    ; clear registers so DumpRegs is easy to read
    xor     ecx, ecx

    mov     edx, OFFSET msgKnown
    call    WriteString

    mov     eax, 5
    cmp     eax, 5                      ; 5 - 5 = 0  -> ZF=1, CF=0, SF=0
    call    DumpRegs

    pushfd                              ; save EFLAGS (ZF=1) on the stack

    mov     edx, OFFSET msgChanged
    call    WriteString

    mov     ebx, 10
    add     ebx, 1                      ; EBX = 11, result non-zero -> ZF=0
    sub     eax, 3                      ; EAX = 2
    mov     ecx, 1
    sub     ecx, 2                      ; ECX = FFFFFFFFh -> CF=1, SF=1, ZF=0
    call    DumpRegs

    mov     edx, OFFSET msgRestored
    call    WriteString

    popfd                               ; restore EFLAGS saved by PUSHFD
    call    DumpRegs                    ; ZF=1 again, but EAX/EBX/ECX keep new values

    exit
main ENDP
END main
