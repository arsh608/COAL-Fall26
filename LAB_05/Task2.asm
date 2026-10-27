INCLUDE Irvine32.inc

.data
numbers     BYTE  10, 20, 30, 40, 50, 60
marks       WORD  1000h, 2000h, 3000h
values      DWORD 11111111h, 22222222h

msgAddr     BYTE "--- Array addresses (OFFSET) ---", 0
msgAddrN    BYTE "OFFSET numbers (ESI) = ", 0
msgAddrM    BYTE "OFFSET marks   (EDI) = ", 0
msgAddrV    BYTE "OFFSET values  (EBX) = ", 0
msgNum      BYTE "numbers : ", 0
msgMarks    BYTE "marks   : ", 0
msgVals     BYTE "values  : ", 0
msgType     BYTE "TYPE = ", 0
msgLen      BYTE "   LENGTHOF = ", 0
msgSize     BYTE "   SIZEOF = ", 0
msgCheck    BYTE "          TYPE x LENGTHOF = ", 0
msgOK       BYTE "  = SIZEOF  (verified)", 0
msgBad      BYTE "  <> SIZEOF (mismatch)", 0
msgHex      BYTE "h", 0

.code
main PROC
    ; ---------- load the three addresses ----------
    mov     esi, OFFSET numbers
    mov     edi, OFFSET marks
    mov     ebx, OFFSET values

    mov     edx, OFFSET msgAddr
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgAddrN
    call    WriteString
    mov     eax, esi
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgAddrM
    call    WriteString
    mov     eax, edi
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgAddrV
    call    WriteString
    mov     eax, ebx
    call    WriteHex
    mov     edx, OFFSET msgHex
    call    WriteString
    call    Crlf
    call    Crlf

    ; ---------- operators for each array ----------
    mov     edx, OFFSET msgNum
    call    WriteString
    mov     eax, TYPE numbers           ; 1
    mov     ebx, LENGTHOF numbers       ; 6
    mov     ecx, SIZEOF numbers         ; 6
    call    ShowSizes

    mov     edx, OFFSET msgMarks
    call    WriteString
    mov     eax, TYPE marks             ; 2
    mov     ebx, LENGTHOF marks         ; 3
    mov     ecx, SIZEOF marks           ; 6
    call    ShowSizes

    mov     edx, OFFSET msgVals
    call    WriteString
    mov     eax, TYPE values            ; 4
    mov     ebx, LENGTHOF values        ; 2
    mov     ecx, SIZEOF values          ; 8
    call    ShowSizes

    exit
main ENDP

;------------------------------------------------------------
; ShowSizes
; Displays TYPE, LENGTHOF and SIZEOF and checks SIZEOF = TYPE x LENGTHOF.
; Receives: EAX = TYPE, EBX = LENGTHOF, ECX = SIZEOF
;------------------------------------------------------------
ShowSizes PROC
    push    eax                         ; keep TYPE for the multiplication

    mov     edx, OFFSET msgType
    call    WriteString
    call    WriteDec                    ; TYPE

    mov     edx, OFFSET msgLen
    call    WriteString
    mov     eax, ebx
    call    WriteDec                    ; LENGTHOF

    mov     edx, OFFSET msgSize
    call    WriteString
    mov     eax, ecx
    call    WriteDec                    ; SIZEOF
    call    Crlf

    pop     eax
    imul    eax, ebx                    ; EAX = TYPE x LENGTHOF
    mov     edx, OFFSET msgCheck
    call    WriteString
    call    WriteDec

    cmp     eax, ecx                    ; compare with SIZEOF
    mov     edx, OFFSET msgOK
    je      L1
    mov     edx, OFFSET msgBad
L1:
    call    WriteString
    call    Crlf
    ret
ShowSizes ENDP
END main
