INCLUDE Irvine32.inc

.data
scores      DWORD 12, 25, 18, 30, 15, 20

msgScores   BYTE "Scores  : ", 0
msgTotal    BYTE "Total   = ", 0
msgAvg      BYTE "Average = ", 0
msgSpace    BYTE "  ", 0

.code
main PROC
    mov     edx, OFFSET msgScores
    call    WriteString

    mov     ecx, LENGTHOF scores        ; loop counter = 6
    mov     esi, 0                      ; index register
    mov     ebx, 0                      ; running total (not the loop counter)
L1:
    mov     eax, scores[esi * TYPE scores]  ; byte offset = index * 4
    call    WriteDec
    mov     edx, OFFSET msgSpace
    call    WriteString
    add     ebx, eax                    ; total += element
    inc     esi                         ; next index
    loop    L1
    call    Crlf

    ; ---------- display total ----------
    mov     edx, OFFSET msgTotal
    call    WriteString
    mov     eax, ebx                    ; 120
    call    WriteDec
    call    Crlf

    ; ---------- integer average = total / count ----------
    mov     eax, ebx                    ; dividend = total
    mov     edx, 0                      ; clear upper half of EDX:EAX
    mov     ecx, LENGTHOF scores        ; divisor = 6
    div     ecx                         ; EAX = quotient (20), EDX = remainder

    mov     edx, OFFSET msgAvg
    call    WriteString
    call    WriteDec
    call    Crlf

    exit
main ENDP
END main
