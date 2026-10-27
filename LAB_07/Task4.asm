INCLUDE Irvine32.inc

.data
; ----- student 1 -----
name1       BYTE "Ali Ahmed", 0
reg1        BYTE "24K-0512", 0
course1     BYTE "Computer Organization and Assembly Language", 0
; ----- student 2 -----
name2       BYTE "Sara Khan", 0
reg2        BYTE "24K-0738", 0
course2     BYTE "Data Structures", 0
; ----- student 3 -----
name3       BYTE "Usman Raza", 0
reg3        BYTE "24K-0941", 0
course3     BYTE "Digital Logic Design", 0

msgName     BYTE "Student Name    : ", 0
msgReg      BYTE "Registration No : ", 0
msgCourse   BYTE "Course Title    : ", 0

.code
main PROC
    mov     esi, OFFSET name1           ; pass the three strings in registers
    mov     edi, OFFSET reg1
    mov     ebx, OFFSET course1
    call    DisplayStudentInfo          ; returns to the next instruction

    mov     esi, OFFSET name2
    mov     edi, OFFSET reg2
    mov     ebx, OFFSET course2
    call    DisplayStudentInfo

    mov     esi, OFFSET name3
    mov     edi, OFFSET reg3
    mov     ebx, OFFSET course3
    call    DisplayStudentInfo

    exit
main ENDP

;------------------------------------------------------------
; DisplayStudentInfo
; Prints a student's name, registration number and course
; title on separate lines, followed by a blank line.
; Receives: ESI = OFFSET name, EDI = OFFSET reg. no,
;           EBX = OFFSET course title
; Returns:  nothing (EDX is preserved)
;------------------------------------------------------------
DisplayStudentInfo PROC
    push    edx                         ; WriteString needs EDX

    mov     edx, OFFSET msgName
    call    WriteString
    mov     edx, esi
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgReg
    call    WriteString
    mov     edx, edi
    call    WriteString
    call    Crlf

    mov     edx, OFFSET msgCourse
    call    WriteString
    mov     edx, ebx
    call    WriteString
    call    Crlf
    call    Crlf

    pop     edx
    ret                                 ; return address is on top of the stack
DisplayStudentInfo ENDP
END main
