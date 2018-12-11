; Main.asm
; Name:
; UTEid: 
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000


; initialize the stack pointer

	LD R6, fourthousand




; set up the keyboard interrupt vector table entry


	LD R1, TWOKSIX     ; puts x2600 in x0180
	LD R2, ONEEIGHT  
	STR R1, R2, #0



; enable keyboard interrupts
	
	AND R1, R1, #0                 ;clear registers
	AND R2, R2, #0




	LD R1, ENABLE                  ;enable KBSR (allows interrupts?)
	LD R2, KBSR	
	STR R1, R2, #0
	
	

	


; start of actual program

	







BRnzp Loop
UULoop  ADD R4, R4, #4
Loop	LDI R0, character
	BRz Loop
	TRAP x21
	AND R1, R1, 0
	STI R1, character
	
	
	ADD R4, R4, #-1       ;if R4 is 1 >AU
	BRz AU
	ADD R4, R4, #-1       ;if R4 is 2 >AUG
	BRz AUG
	ADD R4, R4, #-1       ;if R4 is 3 >start
	BRz start
	ADD R4, R4, #-1       ;if R4 is 4 >U
	BRz U
	ADD R5, R5, #-1       ;if R5 is 1 >UG
	BRz UG
	ADD R5, R5, #-1       ;if R5 is 2 >UA
	BRz UA
	
	
	



A
	ADD R3, R0, 0
	JSR CHECKA
	ADD R2, R2, #0    ;R2=0 if its A
	BRnp Loop
	AND R4, R4, 0
	ADD R4, R4, #1
	BRnzp Loop		

AU	
	ADD R3, R0, 0
	JSR CHECKU
	ADD R2, R2, #0
	BRnp A
	AND R4, R4, 0
	ADD R4, R4, #2
	BRnzp Loop
AUG
	ADD R3, R0, 0
	JSR CHECKG
	ADD R2, R2, #0
	BRnp Loop
	AND R4, R4, 0
	LD R4, startsign
	ADD R0, R4, 0
	TRAP x21
	AND R4, R4, 0
	ADD R4, R4, #3
	BRnzp Loop
	


start
	

	
	ADD R3, R0, 0
	AND R4, R4, 0
	ADD R4, R4, #3
	JSR CHECKU
	ADD R2, R2, #0
	BRnp Loop	
	ADD R4, R4, #1
	BRnzp Loop
U
	ADD R3, R0, 0
	JSR CHECKA
	ADD R2, R2, #0
	BRnp checkg
	AND R5, R5, 0      ; UA COUNTER
	ADD R5, R5, #2
	BRnzp Loop
	
	
checkg	JSR CHECKG
	ADD R2, R2, #0
	BRnp UULoop
	AND R5 R5, 0      ; UG COUNTER
	ADD R5, R5, #1
	BRnzp Loop

UA	
	AND R3, R3, 0
	ADD R3, R0, 0
	JSR CHECKA
	ADD R2, R2, #0
	BRz done
	
	AND R3, R3, 0
	ADD R3, R0, 0
	JSR CHECKG
	ADD R2, R2, #0
	BRz done
	BRnp start
	

UG
	ADD R3, R0, 0
	JSR CHECKA
	ADD R2, R2, #0
	BRz done   
	BRnp start
done
	TRAP x25
	
	
	
	
	

	

	


CHECKA	
	AND R2, R2, 0
	LD R2, letterA
	NOT R2, R2
	ADD R2, R2, #1
	ADD R2, R2, R3
	RET

CHECKC
	AND R2, R2, 0
	LD R2, letterC
	NOT R2, R2
	ADD R2, R2, #1
	ADD R2, R2, R3
	RET
CHECKG
	AND R2, R2, 0
	LD R2, letterG
	NOT R2, R2
	ADD R2, R2, #1
	ADD R2, R2, R3
	RET
	


CHECKU
	AND R2, R2, 0
	LD R2, letterU
	NOT R2, R2
	ADD R2, R2, #1
	ADD R2, R2, R3
 	RET
	


	
	
	
	
	
	
	

                   
DSR    .FILL xFE04
DDR    .FILL xFE06
KBSR   .FILL xFE00
KBDR   .FILL xFE02
THREETHOUSAND  .FILL x3000
TWOKSIX        .FILL x2600
ONEEIGHT       .FILL x0180
ENABLE         .FILL x4000
character .FILL  x4600
fourthousand .FILL x4000
storechar  .BLKW 1
letterA .FILL x0041
letterU .FILL x0055
letterG .FILL x0047
letterC .FILL x0043
startsign .FILL x007C

		.END

