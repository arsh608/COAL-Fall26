INCLUDE Irvine32.inc

.data
marks       BYTE 67, 84, 92, 75, 88

msgFirst    BYTE "First element  [marks + 0]  = ", 0
msgLast     BYTE "Last element   marks[ESI=4] = ", 0
msgIdx2     BYTE "Index 2        [marks + 2]  = ", 0
msgLen      BYTE "LENGTHOF marks = ", 0
msgSize     BYTE "SIZEOF marks   = ", 0
msgBytes    BYTE " bytes", 0
msgOrig     BYTE "Original array : ", 0
msgUpd      BYTE "Updated array  : ", 0
msgSpace    BYTE "  ", 0

.code
main PROC
    mov     edx, OFFSET msgOrig
    call    WriteString
    call    ShowMarks
    call    Crlf

    ; ---------- first element (direct-offset) ----------
    mov     edx, OFFSET msgFirst
    call    WriteString
    movzx   eax, [marks + 0]            ; 67
    call    WriteDec
    call    Crlf

    ; ---------- last element (indexed, using LENGTHOF) ----------
    mov     edx, OFFSET msgLast
    call    WriteString
    mov     esi, LENGTHOF marks - 1     ; last index = 4
    movzx   eax, marks[esi]             ; 88
    call    WriteDec
    call    Crlf

    ; ---------- element at index 2 ----------
    mov     edx, OFFSET msgIdx2
    call    WriteString
    movzx   eax, [marks + 2]            ; 92
    call    WriteDec
    call    Crlf
    call    Crlf

    ; ---------- number of elements and size ----------
    mov     edx, OFFSET msgLen
    call    WriteString
    mov     eax, LENGTHOF marks         ; 5
    call    WriteDec
    call    Crlf

    mov     edx, OFFSET msgSize
    call    WriteString
    mov     eax, SIZEOF marks           ; 5
    call    WriteDec
    mov     edx, OFFSET msgBytes
    call    WriteString
    call    Crlf
    call    Crlf

    ; ---------- change index 1 to 90 ----------
    mov     [marks + 1], 90             ; size known from marks (BYTE)

    mov     edx, OFFSET msgUpd
    call    WriteString
    call    ShowMarks

    exit
main ENDP

;------------------------------------------------------------
; ShowMarks
; Displays every element of marks on one line.
;------------------------------------------------------------
ShowMarks PROC
    mov     esi, 0                      ; index
    mov     ecx, LENGTHOF marks
L1:
    movzx   eax, marks[esi]
    call    WriteDec
    mov     edx, OFFSET msgSpace
    call    WriteString
    inc     esi                         ; TYPE marks = 1
    loop    L1
    call    Crlf
    ret
ShowMarks ENDP
END main
