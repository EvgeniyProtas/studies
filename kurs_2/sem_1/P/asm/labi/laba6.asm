.model tiny
.stack 100h
include macro.inc
.data
Old_09h dd 0
NumberLen db 0
int_ dw 0
base dw 10
.code
org 100h

write_int proc 		;������� ����� �����
	save_registers
	init_registers
	mov NumberLen, 0
	mov ax, int_
	test ax, 8000h	;�������� �� ���������������
	jz positive_part
	neg ax
	writech '-'
positive_part:    		;��������� ������ ����� �� �����
	clear_register dx	
	div base
	push dx
	inc NumberLen
	test ax, ax
jnz positive_part
	clear_register cx
	mov cl, NumberLen
for1:	
	pop bx			
	add bl, '0'		;�������������� ���� � �� ���������� ���������
	writech bl
loop for1
	load_registers
	ret  
write_int endp




new_09h proc far
	push es ds si di cx bx dx ax

	push cs
	pop ds		;��� ds ����� ��� ���������� ������ ��������� ������ �����
	
	clear_register ax

	in al, 60h
	cmp al, 10h
	jnz standart
	mov int_, ax
	call write_int
	next_line

	mov al,20h
	out 20h,al
		

	pop ax dx bx cx di si ds es
	iret
standart:
	pop ax dx bx cx di si ds es
	jmp dword ptr cs:[Old_09h]		;��� ���� ��������� �������, ������������ �������� ����� ���������
new_09h endp



last_byte:
start:
	init_ds
	init_registers

	cli
	
	push es
	clear_register ax
	mov es, ax
	
	mov ax, word ptr es:[09h*4]	;��������
	mov word ptr Old_09h, ax
	mov ax, word ptr es:[09h*4+2]	;������� 
	mov word ptr Old_09h+2, ax

	mov ax, cs
	mov word ptr eS:[09h*4+2], ax	;������� 
	mov ax, offset new_09h
	mov word ptr es:[09h*4], ax	;��������

	pop es

	sti

	mov bx, (last_byte - write_int + 10fh)/16
	keep_resident bx, 0
end start
