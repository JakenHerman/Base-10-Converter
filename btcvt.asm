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

    ;initialize registers to 0

       mov   bx, 0
       mov   ax, 0

    ;get user input
       mov   ds, ax
       mov   ah, 0Ah
       int   21h

    ;output user input code
       mov   ah, 09
       mov   dx, ds
       int   21h

    ;end program
       mov   ah, 4Ch
       int   21h
