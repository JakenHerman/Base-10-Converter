org   0x100                            ;.com files always start 256 bytes into segment

mov   bx, 1                            ;init bx to 1
mov   ax, 0100h

mov   dx, msg                          ;message's address in dx
mov   cx, len
mov   ah, 0x40
int   0x21

msg db 'Enter a Base Ten Number: '
len equ $ -msg

mov   ah, 9
int   21h

while:
        cmp   ax, 13        ;is char = carriage return?
        je    endwhile      ;if so, we're done
        shl   bx, 1         ;multiplies bx by 2
        and   al, 01h       ;convert character to binary
        or    bl, al         ;"add" the low bit
        int   21h
        jmp   while
endwhile
