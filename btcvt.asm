org 100h


section .data

prompt   db   "Enter a Base 10 Number",13,10,'$'
len      equ $ -prompt



section .text
start:

    ;display prompt
    mov   ah, 09
    mov   dx, prompt
    int   21h


    mov   bx, 0        ;initialize bx to 0
    mov   ax, 0100h

    ;get user input
    mov   ah, 0Ah
    int   21h


while:
    cmp   ax, 13        ;is char = carriage return?
    jmp   endwhile      ;if so, we're done
    mov   bx, ax        ;save char to bx
    int   21h           ;get another char
    loop  while
endwhile:
    ret                 ;end subroutine
