INCLUDE Irvine32.inc

.data
esp0        DWORD ?                     ; ESP before any PUSH
esp1        DWORD ?                     ; after PUSH EAX
esp2        DWORD ?                     ; after PUSH EBX
esp3        DWORD ?                     ; after PUSH ECX
esp4        DWORD ?                     ; after POP EDX
esp5        DWORD ?                     ; after POP ESI
esp6        DWORD ?                     ; after POP EDI

msgRegs     BYTE "Registers after the three POPs:", 0
msgTitle    BYTE "ESP trace (change is relative to the starting ESP):", 0
msgS0       BYTE "Start          ESP = ", 0
msgS1       BYTE "After PUSH EAX ESP = ", 0
msgS2       BYTE "After PUSH EBX ESP = ", 0
msgS3       BYTE "After PUSH ECX ESP = ", 0
msgS4       BYTE "After POP  EDX ESP = ", 0
msgS5       BYTE "After POP  ESI ESP = ", 0
msgS6       BYTE "After POP  EDI ESP = ", 0
msgChange   BYTE "h   change = ", 0

.code
main PROC
    mov     edx, OFFSET msgRegs         ; label printed first so EDX is free later
    call    WriteString

    mov     eax, 11
    mov     ebx, 22
    mov     ecx, 33
    xor     edx, edx                    ; clear destination registers
    xor     esi, esi
    xor     edi, edi

    mov     esp0, esp
    push    eax                         ; stack: 11
    mov     esp1, esp
    push    ebx                         ; stack: 22, 11
    mov     esp2, esp
    push    ecx                         ; stack: 33, 22, 11   (33 on top)
    mov     esp3, esp

    pop     edx                         ; EDX = 33 (top of stack)
    mov     esp4, esp
    pop     esi                         ; ESI = 22
    mov     esp5, esp
    pop     edi                         ; EDI = 11
    mov     esp6, esp

    call    DumpRegs                    ; EDX = 33, ESI = 22, EDI = 11

    ; ---------- ESP trace ----------
    mov     edx, OFFSET msgTitle
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgS0
    mov     eax, esp0
    call    ShowStep
    mov     edx, OFFSET msgS1
    mov     eax, esp1
    call    ShowStep
    mov     edx, OFFSET msgS2
    mov     eax, esp2
    call    ShowStep
    mov     edx, OFFSET msgS3
    mov     eax, esp3
    call    ShowStep
    mov     edx, OFFSET msgS4
    mov     eax, esp4
    call    ShowStep
    mov     edx, OFFSET msgS5
    mov     eax, esp5
    call    ShowStep
    mov     edx, OFFSET msgS6
    mov     eax, esp6
    call    ShowStep

    exit
main ENDP

;------------------------------------------------------------
; ShowStep
; Prints a label, an ESP value and its change from the start.
; Receives: EDX = OFFSET label, EAX = recorded ESP value
;------------------------------------------------------------
ShowStep PROC
    call    WriteString
    call    WriteHex
    mov     edx, OFFSET msgChange
    call    WriteString
    sub     eax, esp0                   ; change in bytes
    call    WriteInt
    call    Crlf
    ret
ShowStep ENDP
END main
