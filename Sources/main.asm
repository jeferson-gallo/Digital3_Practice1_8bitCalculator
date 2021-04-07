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
;****************** Define Variables *********************
; 

c_start:			DS.B	1            
v_operand_1:		DS.B	1
v_operand_2:		DS.B	1
c_cap_operand_1:	DS.B	1
c_cap_operand_2:	DS.B	1
c_op_name: 			DS.B	1

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
			CLR		c_cap_operand_1
			CLR		c_cap_operand_2
			CLR		c_op_name
	;			
	; *********** Initializing Input Ports ***********
	;
	
			MOV		#$FF,	PTAD			; Control signals enter this port 			
			MOV		#$00,	PTADD			
			
			MOV		#$00,	PTBD			; Operands enter this port
			MOV		#$00,	PTBDD			;
	
	;	
	; *********** Run Code ***********
	;
	
	Capture_Data:	BRCLR	1,	PTAD,	Debounce			; Capture first operand					
					BRCLR	2,	PTAD,	Debounce			; Capture second operand
					BRCLR	0,	PTAD,	Debounce		; Capture second operand
					
					BRA		Capture_Data	
			
	; ********** Subrutines or Functions ***********
	
	
	; ***** Wait debounce *****
	Debounce:		LDHX	#5000							; Charge HX Register
	
		Delay:			AIX		#-1							; to subtract 1 from the hx register
						CPHX	#0							; Compare hx register to zero
						BNE		Delay						; Branch if Z=0 -> not Equal
						
						BRCLR	1, 	PTAD,	Capture_Op_1
						BRCLR	2, 	PTAD,	Capture_Op_2
						BRCLR	0,	PTAD,	Start_Operation
						
						BRA 	Capture_Data
						
						
	; ***** Capture operands *****				
	Capture_Op_1:		MOV		PTBD,	v_operand_1 	; first operand is captured
						BRA		Capture_Data
					
	Capture_Op_2:		MOV		PTBD,	v_operand_2 	; second operand is captured
						BRA		Capture_Data

	; ***** Start Operation *****
	Start_Operation:		CLRA
							LDA		#$90
							STA		$100	
							BRA		Capture_Data
	
Here:		BRA		Here
						
