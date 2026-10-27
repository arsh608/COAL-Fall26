INCLUDE Irvine32.inc

ROWS = 5

.data
outerCount  DWORD ?                     ; saved outer-loop counter
rowNum      DWORD 1                     ; numbers to print in current row
msgSpace    BYTE " ", 0

.code
main PROC
    mov     ecx, ROWS                   ; outer loop: 5 rows
Outer:
    mov     outerCount, ecx             ; save outer ECX
    mov     ecx, rowNum                 ; inner loop runs rowNum times
    mov     eax, 1                      ; first number of every row
Inner:
    call    WriteDec
    mov     edx, OFFSET msgSpace
    call    WriteString
    inc     eax                         ; next number
    loop    Inner

    call    Crlf                        ; end of row
    inc     rowNum                      ; next row prints one more number
    mov     ecx, outerCount             ; restore outer ECX
    loop    Outer

    exit
main ENDP
END main
