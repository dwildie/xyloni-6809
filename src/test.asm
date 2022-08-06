; ********************************************
ROMBEG 		equ    $F800    ; ROM START ASSEMBLY ADDRESS
ROMSIZ 		equ    $800
RAMBEG 		equ    $D000
ACIAS  		equ    $E010
STACK  		equ    $DA00
; *********************************************

EOT		equ	$04
LF		equ	$0a
CR		equ	$0d

RDR		equ	1
TBE		equ	2

       		ORG	ROMBEG	; ROM ASSEMBLY/DEFAULT ADDRESS

START		lds	#STACK	;INITIALIZE STACK POINTER

		lbsr	ACINIT	; Initialise the 6850

		ldx	#SIGNON	; Display signon message
		bsr	OUTSTR

1	      	bsr	INCH

		cmpa	#'a'
		blt	2f
		cmpa	#'z'
		bgt	3f
		suba	#$20	; Change to upper case
		bra	3f

2	        cmpa	#'A'
		blt	3f
		cmpa	#'Z'
		bgt	3f
		adda	#$20	; Change to lower case

3		bsr     OUTCH
	        cmpa	#CR
	        bne	1b

	        lda	#LF	; New line
	        bsr	OUTCH
	        lda	#'>'
	        bsr	OUTCH
	        lda	#' '
	        bsr	OUTCH
	        bra     1b

1		bsr	OUTCH
OUTSTR		lda	,x+	; Get char to output
		cmpa	#EOT	; EOT?
		bne	1b	; If not EOT, output it
		rts

INCH		pshs    x
		ldx	#ACIAS	;POINT TO TERMINAL PORT
1		lda	,x	;FETCH PORT STATUS
		bita	#RDR	;TEST READY BIT, RDRF ?
		beq	1b	;IF NOT RDY, THEN TRY AGAIN
		lda	1,x	;FETCH CHAR
		puls	x	;RESTORE IX
		rts

OUTCH		pshs	a,x
		ldx	#ACIAS	;GET ADDR. OF TERMINAL
1		lda	,x	;FETCH PORT STATUS
		bita	#TBE	;TEST TBE, OK TO XMIT ?
		beq	1b	;IF NOT LOOP UNTIL RDY
		puls	a	;GET CHAR. FOR XMIT
		sta	1,x	;XMIT CHAR.
		puls	x	;RESTORE IX
		rts

ACINIT		ldx	#ACIAS	;POINT TO CONTROL PORT ADDRESS
		lda	#3	;RESET ACIA COMMAND
		sta	,x	;STORE IN CONTROL REGISTER
		lda	#$15	;SET 8 DATA, 1 STOP AND No PARITY
		sta	,x	;STORE IN CONTROL REGISTER
		lda	,x
		lda	1,x
		lda	,x
		lda	1,x
		rts

; ********************************************
SIGNON		FCC	"\r\nXyloni M6809 Test, Damian Wildie\r\n> ",EOT

; ********************************************
; Setup Reset Vector
; ********************************************
	        ORG    ROMBEG+ROMSIZ-2
	        FDB    START    ; RESTART

	        END    START
