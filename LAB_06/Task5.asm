INCLUDE Irvine32.inc

.data
rolls       DWORD 12 DUP(?)
highCount   DWORD ?                     ; rolls that are 4 or greater
rollSum     DWORD ?                     ; sum of all rolls

msgRolls    BYTE "Dice rolls : ", 0
msgCount    BYTE "Rolls of 4 or greater = ", 0
msgSum      BYTE "Sum of all rolls      = ", 0
msgCancel   BYTE "Results cancelled by the user.", 0
msgSpace    BYTE "  ", 0
caption     BYTE "Dice Analysis", 0
question    BYTE "Do you want to view the results?", 0

.code
main PROC
    call    Randomize                   ; seed the generator once

    ; ---------- fill the array with 1..6 ----------
    mov     esi, OFFSET rolls
    mov     ecx, LENGTHOF rolls         ; 12 rolls
Fill:
    mov     eax, 6
    call    RandomRange                 ; EAX = 0..5
    inc     eax                         ; EAX = 1..6
    mov     [esi], eax
    add     esi, TYPE rolls
    loop    Fill

    ; ---------- display rolls, count >= 4 and sum ----------
    mov     edx, OFFSET msgRolls
    call    WriteString
    mov     esi, OFFSET rolls
    mov     ecx, LENGTHOF rolls
    mov     ebx, 0                      ; count of rolls >= 4
    mov     edi, 0                      ; sum
Scan:
    mov     eax, [esi]
    call    WriteDec
    mov     edx, OFFSET msgSpace
    call    WriteString
    add     edi, eax                    ; sum += roll
    cmp     eax, 4
    jb      NotHigh                     ; skip if roll < 4
    inc     ebx                         ; roll >= 4
NotHigh:
    add     esi, TYPE rolls
    loop    Scan
    call    Crlf

    mov     highCount, ebx              ; save results (EBX is needed for MsgBoxAsk)
    mov     rollSum, edi

    ; ---------- ask the user ----------
    mov     edx, OFFSET question
    mov     ebx, OFFSET caption
    call    MsgBoxAsk                   ; EAX = IDYES (6) or IDNO (7)
    cmp     eax, IDYES
    je      ShowResults
    jmp     Cancelled

ShowResults:
    mov     edx, OFFSET msgCount
    call    WriteString
    mov     eax, highCount
    call    WriteDec
    call    Crlf
    mov     edx, OFFSET msgSum
    call    WriteString
    mov     eax, rollSum
    call    WriteDec
    call    Crlf
    jmp     Done

Cancelled:
    mov     edx, OFFSET msgCancel
    call    WriteString
    call    Crlf

Done:
    exit
main ENDP
END main
