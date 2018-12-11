; ISR.asm
; Name: Trajan Schmidt and Ryan Perez
; UTEid: tms3893 and rep2533 
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
	
	LDI R0, KBDR
	LD R1, letterA
	ADD R2, R1, R0
	BRz valid
	AND R1, R1, 0
	LD R1, letterC
	ADD R2, R1, R0
	BRz valid
	AND R2, R2, 0
	LD R1, letterG
	ADD R2, R1, R0
	BRz valid
	AND R2, R2, 0
	LD R1, letterU
	ADD R2, R1, R0
	BRz valid
	RTI

valid
	LD R3, fortysix
	STR R0, R3, 0
	RTI
	
	
letterA .FILL x-41
letterC .FILL x-43
letterG .FILL x-47
letterU .FILL x-55
fortysix .FILL x4600
ENABLE   .FILL x4000

DSR    .FILL xFE04
DDR    .FILL xFE06
KBSR   .FILL xFE00
KBDR   .FILL xFE02
		.END
