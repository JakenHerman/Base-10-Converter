org	100h

section .data
   prompt1: db	"Please enter a decimal number: $"
   prompt2: db	0Dh,0Ah, "In binary, the number you entered is:    $"
   prompt4: db	0Dh,0Ah, "In octal, the number you entered is:    $"
   prompt3: db	0Dh,0Ah, "In hexadecimal, the number you entered is:    $"

section .text
start:
	mov	    ah,9		    ; print prompt
	mov	    dx,prompt1
	int 	    21h

; input base 10 value
	mov   	    bx,0	      ; bx holds input value
	mov	    ah,1	      ; input char function
	int	    21h		      ; read char into al
top1:				          ; while (char != CR)
	cmp	    al,13		    ; is char = CR?
	je	    out1		    ; yes?  finished with input
	and	    ax,000Fh	  ; convert from ASCII to base 10 value
	push	    ax		      ; and save it on stack
	mov	    ax,10		    ; set up to multiply bx by 10
	mul	    bx		      ; dx:ax = bx*10
	pop   	    bx		      ; saved value in bx
	add	    bx,ax		    ; bx = old bx*10 + new digit

        mov	    ah,1		    ; input char function
	int	    21h		      ; read next character
	jmp	    top1		    ; loop until done

; now, output it in binary
out1:
	mov	    ah,9		    ; print binary output label
	mov	    dx,prompt2
	int         21h

; for 16 times do this:
	mov	    cx, 16		  ; loop counter

top2:
        rol    	    bx,1              ; rotate most significant bit into carry flag
	jc    	    one		      ; carry flag = 1?
	mov    	    dl,'0'	      ; if no, set up to print a 0
	jmp	    print             ; now print
one:
        mov    	    dl,'1'		  ; printing a 1
print:
        mov   	    ah,2		  ; print char fcn
	int	    21h		          ; print it
	loop	    top2		  ; loop until done


;output in octal

out2:
   mov    ah, 9       ;print octal output label
   mov    dx,prompt4
   int    21h

; for 7 times do this:
	mov	    cx, 3		  ; loop counter

top3:
        rol	    bx,3		    ; rotate top nybble into the bottom
	mov	    dl,bl		    ; put a copy in dl
	and	    dl,0Fh		  ; we only want the lower 4 bits
	or	    dl,30h		  ; convert 0-9 to '0'-'9'
	jmp	    print_oc		  ; now print
print_oc:
        mov   	ah,2		    ; print char fcn
	int	21h		      ; print it
	loop	top3		    ; loop until done


;end octal



; output it again, only this time in hexadecimal
out3:
	mov	    ah,9		    ; print hex output label
	mov	    dx,prompt3
	int 	  21h

; for 4 times do this:
	mov    	cx, 4		    ; loop counter

top4:
        rol	    bx,4		    ; rotate top nybble into the bottom
	mov	    dl,bl		    ; put a copy in dl
	and	    dl,0Fh		  ; we only want the lower 4 bits
	cmp	    dl,9		    ; is it in [0-9]?
	ja	    AF	    	  ; if not, process [A-F]
	or	    dl,30h		  ; convert 0-9 to '0'-'9'
	jmp	    print2		  ; now print

AF:
  add   	dl,55		    ; convert 10-15 to 'A'-'F'

print2:
        mov	    ah,2	    	; print char
	int	    21h
	loop	  top4	     	; loop until done

Exit:
	mov     ah,04Ch     ;DOS function: Exit program
	mov     al,0        ;Return exit code value
	int     21h         ;Call DOS.  Terminate program
