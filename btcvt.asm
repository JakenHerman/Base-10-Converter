org 100h


section .DATA
prompt   db   "Enter a Base 10 Number",13,10,'$'
len      equ $ -prompt


section .TEXT
start:

;display prompt
mov   ah, 09
mov   dx, prompt
int   21h


mov   bx, 1                            ;init bx to 1
mov   ax, 0100h


mov   ah, 0Ah
int   21h


while:
    cmp   ax, 13        ;is char = carriage return?
    je    endwhile      ;if so, we're done
    shl   bx, 1         ;multiplies bx by 2
    and   al, 01h       ;convert character to binary
    or    bl, al        ;"add" the low bit
    int   21h
    jmp   while
endwhile
