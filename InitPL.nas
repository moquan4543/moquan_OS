; initial program loader
; TAB=4

CYLS	EQU		10				; 讀十個柱面
		ORG		0x7c00			; 指名程式裝載地址

; 標準FAT12軟碟

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

; 程式碼

entry:
		MOV		AX,0			; 寄存器初始化
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		
		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0
		MOV 	DH,0
		MOV		CL,2
readloop:
		MOV		SI,0
retry:
		MOV		AH,0x02
		MOV		AL,1			; 1個扇區
		MOV 	BX,0
		MOV 	DL,0x00			; A驅動器
		INT		0x13
		JNC		next
		ADD		SI,1
		CMP 	SI,5
		JAE		error			;if SI >= 5, goto error
		MOV		AH,0x00
		MOV		DL,0x00
		INT 	0x13
		JMP		retry	
next:
		MOV		AX,ES			; 內存地址後移0x0200
		ADD		AX,0x0020
		MOV 	ES,AX
		
		ADD		CL,1
		CMP		CL,18
		JBE		readloop
		
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop
		
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop
fin:
		HLT						; 停止，等待指令
		JMP		fin				; 死循環
error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI += 1
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 顯示文字
		MOV		BX,15			; 指定字符顏色
		INT		0x10			; 調用顯卡BIOS
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; 執行兩次
		DB		"load error"
		DB		0x0a			; 換行
		DB		0

		RESB	0x7dfe-$		; 0x7dfe清零

		DB		0x55, 0xaa