.model small
.stack 100h
.data
	message db "Irasykite simboliu eilute", 0dh, 0ah, '$'
	dec1 db 255*4 dup('$')
.code
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset message
	mov ah, 09h
	int 21h
	
reading:
	mov ah, 1
	int 21h
	
	cmp al, 13
	je endreading

	mov ah, 0
	mov cl, 100
	div cl
	add al, 30h
	
	cmp al, '0'
	je sokti
	
	mov [dec1+si], al
	inc si
	
sokti:
	mov al, ah
	mov ah, 0
	mov cl, 10
	div cl
	add al, 30h
	add ah, 30h
	
	mov [dec1+si], al
	inc si
	mov [dec1+si], ah
	inc si
	mov [dec1+si], ' '
	inc si
	
	jmp reading
	
endreading:
	
	mov dx, offset dec1
	mov ah, 09h
	int 21h
	
	mov ax, 4c00h
	int 21h
	
end start