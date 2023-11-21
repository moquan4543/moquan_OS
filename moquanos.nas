;簡單的作業系統
; TAB = 4
CYLS	EQU		0x0ff0				;設定啟動區
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2				;顏色
SCRNX	EQU		0x0ff4
SCRNY	EQU		0x0ff6
VRAM	EQU		0x0ff8

		ORG		0xc200
		
		MOV		AL,0x13
		MOV 	AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8		;紀錄畫面模式
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000
		
;用BIOS取得鍵盤上各種指示燈的狀態
		MOV		AH,0x02
		INT		0x16
		MOV		[LEDS],AL
fin:
		HLT
		JMP		fin