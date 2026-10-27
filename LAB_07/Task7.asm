INCLUDE Irvine32.inc

.data
msgCase1    BYTE "===== Case 1: CMP 7,7 (ZF=1) then AnalyzeValues(20, 30) =====", 0
msgCase2    BYTE "===== Case 2: CMP 1,2 (ZF=0, CF=1) then AnalyzeValues(45, -45) =====", 0
msgBefore   BYTE "Main, before CALL:", 0
msgInside   BYTE "Inside AnalyzeValues, after arithmetic (flags changed):", 0
msgAfter    BYTE "Main, after RET (caller flags restored, EAX = sum):", 0

.code
main PROC
    xor     ecx, ecx                    ; clear registers so DumpRegs is easy to read
    xor     esi, esi
    xor     edi, edi

    ; ======================= Case 1 =======================
    mov     edx, OFFSET msgCase1
    call    WriteString
    call    Crlf
    mov     edx, OFFSET msgBefore
    call    WriteString

    mov     eax, 7
    cmp     eax, 7                      ; recognizable state: ZF=1, CF=0, SF=0
    mov     eax, 20                     ; MOV does not change flags
    mov     ebx, 30
    call    DumpRegs

    call    AnalyzeValues               ; EAX = 50

    pushfd                              ; keep the restored flags while printing
    mov     edx, OFFSET msgAfter
    call    WriteString
    popfd
    call    DumpRegs                    ; EAX = 00000032h, ZF=1 (caller's flag)
    call    Crlf

    ; ======================= Case 2 =======================
    mov     edx, OFFSET msgCase2
    call    WriteString
    call    Crlf
    mov     edx, OFFSET msgBefore
    call    WriteString

    mov     eax, 1
    cmp     eax, 2                      ; recognizable state: ZF=0, CF=1, SF=1
    mov     eax, 45
    mov     ebx, -45
    call    DumpRegs

    call    AnalyzeValues               ; EAX = 0

    pushfd
    mov     edx, OFFSET msgAfter
    call    WriteString
    popfd
    call    DumpRegs                    ; EAX = 0 but ZF=0 (caller's flag)

    exit
main ENDP

;------------------------------------------------------------
; AnalyzeValues
; Adds two values and also computes their difference, which
; changes the status flags. The caller's EFLAGS are preserved.
; Receives: EAX = first value, EBX = second value
; Returns:  EAX = EAX + EBX
; Preserves: EFLAGS, EBX, ECX, EDX
;------------------------------------------------------------
AnalyzeValues PROC
    pushfd                              ; save the caller's flags first
    push    ecx
    push    edx

    mov     edx, OFFSET msgInside
    call    WriteString

    mov     ecx, eax
    sub     ecx, ebx                    ; ECX = first - second (changes flags)
    add     eax, ebx                    ; EAX = sum (changes flags again)
    call    DumpRegs                    ; shows the procedure's own flags

    pop     edx
    pop     ecx
    popfd                               ; restore caller's flags just before RET
    ret                                 ; EAX keeps the sum: POPFD restores flags only
AnalyzeValues ENDP
END main
