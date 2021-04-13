;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'			 
            
;
; export symbols
;
            XDEF _Startup
            ABSENTRY _Startup

;
; variable/data section
;
            ORG    Z_RAMStart         ; $00B0 -> Para declarar las variables dentro de la pagina cero

;

;****************** Define Constants *********************

MASK_OP:		EQU %00011000
MASK_V:			EQU %10000000

;****************** Define Variables *********************
; 

c_start:			DS.B	1            
v_operand_1:		DS.B	1
v_operand_2:		DS.B	1
result:				DS.B	1


show_message:		DS.B	1


			ORG    RAMStart         ; $0100 -> Para declarar las variables fuera



message_overflow:	DC.B	"Oveflow"
message_correct:	DC.B	"Correct"


;
;******************* code section ******************
;

            ORG    ROMStart			; Direction $1960

_Startup:
	
	;
	; ********** Configure Watchdog and Memory Stack **********
	;
	
	; Power off WatchDog
			LDA		#$20
			STA		SOPT1
			
	; Define Stack Beging
            LDHX   	#RAMEnd+1        ; initialize the stack pointer in $01B0
            TXS
    
    ;      
	; *********** Clear variables **********
	;
			CLRA
			CLRX
			CLRH
			CLR		c_start
			CLR		v_operand_1
			CLR		v_operand_1
			CLR		result
			
			
	;			
	; *********** Initializing Input Ports ***********
	;
	; *********** Definition Input Port A ******************
	;
	; Bit 0 for the start control signal
	; Bit 1 for the capture signal of the first operand
	; Bit 2 for the capture signal of the second operand
	; Bit 3 and 4 for the operation type signal
	;
	;******************************************************
	
			MOV		#$FF,	PTAD			; Control signals enter this port 			
			MOV		#$00,	PTADD			
			
			MOV		#$00,	PTBD			; Operands enter this port
			MOV		#$00,	PTBDD			;
			
			MOV		#$FF,	v_operand_1
			MOV		#$01,	v_operand_2
			
	;	
	; *********** Main loop ***********
	;
	
	Capture_Data:	BRCLR	0,	PTAD,	Debounce			; Capture second operand
					BRCLR	1,	PTAD,	Debounce			; Capture first operand					
					BRCLR	2,	PTAD,	Debounce			; Capture second operand
					
					BRA		Capture_Data	
			
	; ********** Subrutines or Functions ***********						
						
	; ***** Capture operands *****				
	Capture_Op_1:		MOV		PTBD,	v_operand_1 	; first operand is captured
						BRA		Capture_Data
					
	Capture_Op_2:		MOV		PTBD,	v_operand_2 	; second operand is captured
						BRA		Capture_Data

	; ***** Select Operation *****
	Select_Operation:		CLRA
							LDA		PTAD
							AND		#MASK_OP
							
							CBEQA	#$00,	Sum					;Realize conditionals 
							CBEQA	#$08,	Subtraction
							CBEQA	#$10,	Multiplication
							CBEQA	#$18,	Division
							
							BRA		Capture_Data				; for the moment
	
	; ***** Sum Operation *****
	Sum:		CLRA
				LDA		v_operand_1
				ADD		v_operand_2
				
				STA		result
				
				TPA
				AND		#MASK_V
				CBEQA	#$80,	Overflow_Message
				CBEQA	#$00,	Correct_Message	
				
				BRA		Capture_Data		
				
	; ***** Subtraction Operation *****
	Subtraction:		CLRA
						LDA		v_operand_1
						SUB		v_operand_2
				
						BRA		Capture_Data
						
	; ***** Multiplication Operation *****
	Multiplication:		BRA		Capture_Data
	
	; ***** Division Operation *****
	Division:		BRA		Capture_Data
	
							
	; ***** Wait debounce *****
	Debounce:		LDHX	#5000							; Charge HX Register
	
		Delay:		AIX		#-1								; to subtract 1 from the hx register
					CPHX	#0								; Compare hx register to zero
					BNE		Delay							; Branch if Z=0 -> not Equal
						
						
					BRCLR	0,	PTAD,	Select_Operation	; Confirm inputs
					BRCLR	1, 	PTAD,	Capture_Op_1    
					BRCLR	2, 	PTAD,	Capture_Op_2
						
						
					BRA 	Capture_Data					; Return main loop (Capture_Data)
					
	; ***************** Mensages ********************
	Overflow_Message:		CLRA
							LDA		message_overflow
							STA		show_message
										
							BRA 	Capture_Data
							
	Correct_Message:		CLRA
							LDA		message_correct
							STA		show_message
								
							BRA 	Capture_Data
	
Here:		BRA		Here
						
