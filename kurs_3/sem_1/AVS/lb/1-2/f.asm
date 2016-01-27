[org 0x7c00]
	[bits 16]
		;Сохраняем сегментные регистры, используемые в R-Mode:
		mov [R_MODE_DS], ds
		mov [R_MODE_EXTRA_S], es
		mov [R_MODE_FS], fs
		mov [R_MODE_GS], gs
		mov [R_MODE_STACK_S], ss
		
		;Подготавливаем адрес возврата в R-Mode:
		mov [R_MODE_CS], cs
		mov ax, SET_REAL_MODE
		mov [R_MODE_OFFSET], ax

		cli
		lgdt [gdt_descriptor] 
		mov [R_MODE_SP], sp 
		
		
		mov eax, cr0
		or eax, 1
		mov cr0, eax
				
		db 0eah
		dw P_MODE_FISRT_STEP
		dw CODE_SEGMENT
		
		SET_REAL_MODE:
		mov ss, [R_MODE_STACK_S]
		mov ds, [R_MODE_DS]
		mov es, [R_MODE_EXTRA_S]
		mov fs, [R_MODE_FS]
		mov gs, [R_MODE_GS]
		mov sp, [R_MODE_SP]

		sti 
		
		jmp $
		
		INIT_REAL_MODE:

		mov ax, RM_DATA_SELECTOR
		mov ss, ax
		mov ds, ax
		mov es, ax
		mov fs, ax
		mov gs, ax
	
		mov eax, cr0 
		;reset Protection Enable bit (PE bit)
		and al, 11111110b
		;set processor to real mode
		mov cr0, eax
	
		jmp 0:SET_REAL_MODE	
			
	[bits 32]
		P_MODE_FISRT_STEP:
		;we need the data to write the string 
		mov ax, DATA_SEGMENT
		mov ds, ax
		mov ss, ax
		mov es, ax
		mov fs, ax
		mov gs, ax
		
		;need the stack
		
		mov ebp, 0x90000
		mov esp, ebp
		
		mov ebx, P_MODE_ENABLED_MESSAGE
		call PM_ENABLED_MESSAGE
		
		jmp RM_CODE_SELECTOR:INIT_REAL_MODE		
		
		; print string into video memory(VGA)
		VIDEO_MEMORY   equ 0xb8000
		WHITE_ON_BLACK equ 0x0f
		
		PM_ENABLED_MESSAGE :
			pusha
			mov edx , VIDEO_MEMORY 
			pm_enabled_message_loop :
				mov al , [ ebx ]        ; char to a;
				mov ah , WHITE_ON_BLACK ; color to ah
				cmp al , 0 ; check zero
				je pm_enabled_message_done 
					mov [edx], ax ; store it on the screen 80*25
					add ebx , 1 ; char next
					add edx , 2 ; next screen cell
				jmp pm_enabled_message_loop 
			pm_enabled_message_done :
			popa
		ret 
	
;########################################################################################
	
gdt_start:
		gdt_null: 
			dq 0
			
		gdt_code:
			dw 0xffff; limit 0-15
			dw 0x0 ; base 0-15
			db 0x0 ; base 16-23
			db 10011010b ; P-1, DPL(rights) -00, S-1,Code-1,Conform-1,Readable-1,A-0
			db 11001111b ;G-1, 32-bit - 1, 64-bit seg - 0, AVL - 0, limit 16-19
			db 0x0; base 24-31
			
		gdt_data:
			dw 0xffff ; limit
			dw 0x0 ; base
			db 0x0 ;base
			db 10010010b ; flags
			db 11001111b ; flags, limit
			db 0x0 ; base
		
		gdt_rm_c:   
		    dw 0xFFFF
			dw 0			; (base gets set above)
			db 0
			db 0x9A			; present, ring 0, code, non-conforming, readable
			db 0			; byte-granular, 16-bit
			db 0
			
		gdt_rm_d:   
		    dw 0xFFFF
			dw 0			; (base gets set above)
			db 0
			db 0x92			; present, ring 0, data, expand-up, writable
			db 0			; byte-granular, 16-bit
			db 0
		gdt_end:
		
	gdt_descriptor: ; table descriptor to pass to system
		dw gdt_end - gdt_start - 1 ;  always so
		dd gdt_start ;table start
		
	P_MODE_ENABLED_MESSAGE db '                           Protected mode enabled!                              ',0
	
	CODE_SEGMENT        equ 	gdt_code - gdt_start
	DATA_SEGMENT        equ 	gdt_data - gdt_start
	RM_CODE_SELECTOR	equ		gdt_rm_c-gdt_start
	RM_DATA_SELECTOR	equ		gdt_rm_d-gdt_start
	
	
	R_MODE_SP          dw 		0h
	R_MODE_STACK_S     dw 		0h
	R_MODE_DS          dw 		0h
	R_MODE_EXTRA_S     dw 		0hs
	
	R_MODE_FS          dw 		0h
	R_MODE_GS          dw 		0h
	R_MODE_CS          dw 		0h	
	R_MODE_OFFSET      dw 		0h
	
times 2046 - ($-$$) db 0

dw 0xaa55