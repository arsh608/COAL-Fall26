; Lab 4 - Task 4 : symbolic constants, LENGTHOF / SIZEOF, offsets and XCHG on arrays
INCLUDE Irvine32.inc

ROWS = 3
COLS = 4
TOTAL EQU ROWS * COLS

.data
    values  WORD TOTAL DUP(5)
    result  DWORD ?
    buffer  BYTE 16 DUP(?)

msgTotal    BYTE "TOTAL (ROWS*COLS)       = ", 0
msgLen      BYTE "LENGTHOF values         = ", 0
msgSize     BYTE "SIZEOF values (bytes)   = ", 0
msgType     BYTE "TYPE values (bytes)     = ", 0
msgBefore   BYTE "--- Before XCHG ---", 0
msgAfter    BYTE "--- After XCHG (first <-> last) ---", 0
msgFirst    BYTE "values[0]  (offset  0) = ", 0
msgFourth   BYTE "values[3]  (offset  6) = ", 0
msgFifth    BYTE "values[4]  (offset  8) = ", 0
msgLast     BYTE "values[11] (offset 22) = ", 0
msgSum      BYTE "Sum of first four elements (result) = ", 0

.code
main PROC
    ; ---- array dimensions ----
    mov     edx, OFFSET msgTotal
    call    WriteString
    mov     eax, TOTAL                  ; 12
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgLen
    call    WriteString
    mov     eax, LENGTHOF values        ; 12 elements
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgSize
    call    WriteString
    mov     eax, SIZEOF values          ; 12 * 2 = 24 bytes
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgType
    call    WriteString
    mov     eax, TYPE values            ; 2 bytes per element
    call    WriteDec
    call    Crlf
    call    Crlf

    ; ---- selected elements before the exchange ----
    mov     edx, OFFSET msgBefore
    call    WriteString
    call    Crlf
    call    ShowElements

    ; ---- exchange first and last element ----
    mov     ax, values                              ; AX = first element
    xchg    ax, [values + SIZEOF values - TYPE values]  ; AX <-> last element
    mov     values, ax                              ; old last -> first

    mov     edx, OFFSET msgAfter
    call    WriteString
    call    Crlf
    call    ShowElements

    ; ---- sum of the first four elements ----
    movzx   eax, values                 ; values[0]
    movzx   ebx, [values + 2]           ; values[1]
    add     eax, ebx
    movzx   ebx, [values + 4]           ; values[2]
    add     eax, ebx
    movzx   ebx, [values + 6]           ; values[3]
    add     eax, ebx
    mov     result, eax                 ; result = 20

    mov     edx, OFFSET msgSum
    call    WriteString
    mov     eax, result
    call    WriteDec
    call    Crlf

    exit
main ENDP

;------------------------------------------------------------
; ShowElements
; Displays the first, fourth, fifth and last elements of values.
;------------------------------------------------------------
ShowElements PROC
    mov     edx, OFFSET msgFirst
    call    WriteString
    movzx   eax, values                 ; offset 0
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgFourth
    call    WriteString
    movzx   eax, [values + 3 * TYPE values]   ; offset 6
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgFifth
    call    WriteString
    movzx   eax, [values + 4 * TYPE values]   ; offset 8
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgLast
    call    WriteString
    movzx   eax, [values + SIZEOF values - TYPE values]   ; offset 22
    call    WriteDec
    call    Crlf
    call    Crlf
    ret
ShowElements ENDP
END main
