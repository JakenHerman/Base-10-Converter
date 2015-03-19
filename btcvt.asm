org 0x100

start:
push cs
pop ax
mov ds, ax
mov es, ax; make sure ds = es = cs

mov di, string ; es:di points to string
cld ; clear direction flag (so stosb incremements rather than decrements)
read_loop:
mov ah, 0x01 ; Function 01h Read character from stdin with echo
int 0x21
cmp al, 0x0D ; character is carriage return?
je read_done ; yes? exit the loop
stosb ; store the character at es:di and increment di
jmp read_loop ; loop again
read_done:
mov al, '$'
stosb ; 'Make sure the string is '$' terminated

mov dx, string ; ds:dx points to string
mov ah, 0x09 ; Function 09h Print character string
int 0x21

; Exit
mov ax, 0x4c00
int 0x21

string:
times 255 db 0 ; reserve room for 255 characters
