; hello-os
; TAB=4

		ORG		0x7c00			; w¼ö®åäÚn¬

; WFAT12î?

		JMP		entry
		DB		0x90
		DB		"HELLOIPL"
		DW		512
		DB		1
		DW		1
		DB		2
		DW		224
		DW		2880
		DB		0xf0
		DW		9
		DW		18
		DW		2
		DD		0
		DD		2880
		DB		0,0,0x29
		DD		0xffffffff
		DB		"HELLO-OS   "
		DB		"FAT12   "
		RESB	18

; ö®áù

entry:
		MOV		AX,0			; ñ¶ín»
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI += 1
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; èû¦¶
		MOV		BX,15			; wèèøF
		INT		0x10			; ²pèû?BIOS
		JMP		putloop
fin:
		HLT						; â~CÒwß
		JMP		fin				; zÂ

msg:
		DB		0x0a, 0x0a		; ·s_
		DB		"hello, world"
		DB		0x0a			; ·s
		DB		0

		RESB	0x7dfe-$		; 0x7dfe´ë

		DB		0x55, 0xaa


		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432
