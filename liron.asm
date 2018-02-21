; Apple UniDisk 3.5 (Liron, A2M2053) disk drive firmware
; includes support for unreleased DuoDisk 3.5
; Firmware P/N 341-????
; Copyright 1985 Apple Computer, Inc.
; Disassembly copyright 2018 Eric Smith <spacewar@gmail.com>

	cpu	65c02

fillto	macro	addr, val
	while	* < addr
size	set	addr-*
	if	size > 256
size	set	256
	endif
	fcb	[size] val
	endm
	endm


; error codes
err_noerr	equ	$00	; no error
err_badcmd	equ	$01	; bad command number
err_badpcnt	equ	$04	; bad parameter count
err_buserr	equ	$06	; communications error
err_badunit	equ	$11	; invalid unit number
err_noint	equ	$1f	; interrupt devices are not supported
err_badctl	equ	$21	; invalid control or status code
err_badctlparam	equ	$22	; invalid parameter list
err_ioerror	equ	$27	; I/O error
err_nodrive	equ	$28	; no device connected
err_nowrite	equ	$2b	; disk write protected
err_badblock	equ	$2d	; invalid block number
err_disksw	equ	$2e	; media has been swapped (exended calls only)
err_offline	equ	$2f	; device offline or no disk in drive
; $30..$3f are device-specific errors
; $50..$5f are device-specific soft errors (considered successful)
; $60..$6f are equivalent to $20..$2f with soft error (considered successful)



cr	equ	$0d


warmstart_ram		equ	$00
Z08			equ	$08
ga_shadow_wr_reg0	equ	$09
ga_shadow_wr_reg1	equ	$0a

spb_drive_address	equ	$0b	; indexed by current_drive_index
cur_cyl			equ	$0d	; indexed by current_drive_index
Z0f			equ	$0f	; indexed by current_drive_index
Z11			equ	$11	; indexed by current_drive_index

current_drive_index	equ	$13	; 0 or 1

cyl			equ	$14
Z15			equ	$15
Z16			equ	$16
Z17			equ	$17
spb_group_count		equ	$18
spb_packet_type		equ	$19
Z1a			equ	$1a
Z1b			equ	$1b
Z1c			equ	$1c
Z1d			equ	$1d
cksum			equ	$1e
Z1f			equ	$1f
Z20			equ	$20
Z21			equ	$21
Z22			equ	$22
Z23			equ	$23
Z24			equ	$24
Z25			equ	$25
Z26			equ	$26

; address field buffer
Z27			equ	$27
Z28			equ	$28
Z29			equ	$29
Z2a			equ	$2a
Z2b			equ	$2b

spb_odd_byte_count	equ	$2c

Z2d			equ	$2d
Z39			equ	$39
Z3b			equ	$3b
Z3d			equ	$3d
Z3e			equ	$3e
Z3f			equ	$3f
Z40			equ	$40
Z41			equ	$41
Z42			equ	$42
Z43			equ	$43
Z4a			equ	$4a
Z4b			equ	$4b

; CmdTab $4c..$54: command from SmartPort
sp_cmd			equ	$4c	; command
sp_param_count		equ	$4d	; param count
sp_param		equ	$4e	; up to 7 bytes of parameters
sp_ctl_code		equ	sp_param+2	; control code
sp_stat_code		equ	sp_param+2	; status code
sp_block		equ	sp_param+2	; three-byte block number



spb_dest_id		equ	$55

; StatusTab
Z56			equ	$56
Z57			equ	$57	; status
Z58			equ	$58
Z59			equ	$59
Z5a			equ	$5a
Z5b			equ	$5b

Z5c			equ	$5c
Z5e			equ	$5e	; StatByte
Z5f			equ	$5f
Z60			equ	$60
Z61			equ	$61
Z62			equ	$62
form_sides		equ	$63	; $00 for single-sided, $80 for double-sided
Z64			equ	$64
Z65			equ	$65
Z66			equ	$66
Z67			equ	$67
Z68			equ	$68
Z69			equ	$69
Z6a			equ	$6a
Z6b			equ	$6b
Z6c			equ	$6c
Z6d			equ	$6d
Z6e			equ	$6e
Z6f			equ	$6f

vector_ram		equ	$70	; first two bytes unused?
v_read_addr		equ	$72
v_read_data		equ	$75
v_write_data		equ	$78
v_seek			equ	$7b
v_format		equ	$7e
v_write_trk		equ	$81
v_verify		equ	$84
v_vector		equ	$87
; there is an unused vector at $8a


; mark table
Z8d			equ	$8d
mt_data			equ	$8e
mt_sync			equ	$92	; manual says 6 bytes starting at $91,
					; but firmware doesn't appear to use
					; the byte at $91
mt_slip			equ	$97
mt_addr			equ	$9f

; zero page $00c0..$00ff left free for use by downloaded code

; $0100..?: firmware RW buffer #1

D0100	equ	$0100
D01af	equ	$01af

; ?..$01ff: stack

; $0200..$03ff: host comm buffer, format sector buffer I
D0200	equ	$0200

execute_reg_a	equ	$0200
execute_reg_x	equ	$0201
execute_reg_y	equ	$0202
execute_reg_p	equ	$0203
execute_reg_pc	equ	$0204

D0300	equ	$0300
S0340	equ	$0340

; $0400..$04ff: format sector buffer II

D0400	equ	$0400
D04c2	equ	$04c2
D04cf	equ	$04cf
D04d0	equ	$04d0
D04d1	equ	$04d1
D04d2	equ	$04d2
D04d3	equ	$04d3
D04d8	equ	$04d8

; $0500..$05ff: left free for use by downloaded code

; $0600..$06ff: firmware RW buffer #2

D0640	equ	$0640
D06ef	equ	$06ef

; $0700..$07ff: firmware RW buffer #2

D0740	equ	$0740
D0741	equ	$0741
D07ef	equ	$07ef

; gate array		;	d4       d3       d2       d1       d0
ga_reg0	equ	$0800	; read  LASTONE/ BUSEN/   WRREQ    /GATENBL HDSEL
			; write TRIGGER  ENBUS    PH3EN    IWMDIR   HDSEL
ga_reg1	equ	$0801	; read  SENSE    BLATCH1  BLATCH2  LIRONEN  CAO
			; write /RSTIWM  /BLATCH  /BLATCH  DRIVE1   DRIVE2
			;                CLR1     CLR2

; IWMDIR = 0, IWM is connected to 3.5" drive mechanism
; IWMDIR = 1, IWM is connected to SmartPort (ph_0 used for /BSY handshake)

iwm_ph_0_off	equ	$0a00
iwm_ph_0_on	equ	$0a01
iwm_ph_1_off	equ	$0a02
iwm_ph_1_on	equ	$0a03
iwm_ph_2_off	equ	$0a04
iwm_ph_2_on	equ	$0a05
iwm_ph_3_off	equ	$0a06
iwm_ph_3_on	equ	$0a07
iwm_motor_off	equ	$0a08
iwm_motor_on	equ	$0a09
iwm_sel_drive_1	equ	$0a0a	; not used
iwm_sel_drive_2	equ	$0a0b	; not used
iwm_q6l		equ	$0a0c
iwm_q6h		equ	$0a0d
iwm_q7l		equ	$0a0e
iwm_q7h		equ	$0a0f
	
	org	$e000
	
De000:	fcb	$00,$00,$00,$00,$00,$00,$00,$00
	fcb	$00,$00,$00,$00,$00,$00,$00,$00
	fcb	$40,$40,$40,$40,$40,$40,$40,$40
	fcb	$40,$40,$40,$40,$40,$40,$40,$40
	fcb	$80,$80,$80,$80,$80,$80,$80,$80
	fcb	$80,$80,$80,$80,$80,$80,$80,$80
	fcb	$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
	fcb	$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
De040:	fcb	$00,$00,$00,$00,$40,$40,$40,$40
	fcb	$80,$80,$80,$80,$c0,$c0,$c0,$c0
	fcb	$00,$00,$00,$00,$40,$40,$40,$40
	fcb	$80,$80,$80,$80,$c0,$c0,$c0,$c0
	fcb	$00,$00,$00,$00,$40,$40,$40,$40
	fcb	$80,$80,$80,$80,$c0,$c0,$c0,$c0
	fcb	$00,$00,$00,$00,$40,$40,$40,$40
	fcb	$80,$80,$80,$80,$c0,$c0,$c0,$c0
De080:	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$00,$40,$80,$c0,$00,$40,$80,$c0
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	fcb	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

De100:	fcb	$ff,$ff,$ff


read_addr:
	jmp	v_read_addr

read_addr_actual:
	jsr	Se56a
	jsr	Se162
	lda	#$05
	sta	Z17
	ldy	#$dc
Le112:	ldx	#$02
Le114:	dey
	bne	Le11b
	dec	Z17
	bmi	Le15c
Le11b:	lda	iwm_q7l
	bpl	Le11b
	cmp	mt_addr,x
	bne	Le112
	dex
	bpl	Le114
	ldx	#$04
	stz	cksum
Le12b:	ldy	iwm_q7l
	bpl	Le12b
	lda	De100,y
	sta	Z27,x
	eor	cksum
	sta	cksum
	dex
	bpl	Le12b
	tay
	bne	Le15c
Le13f:	lda	iwm_q7l
	bpl	Le13f
	cmp	mt_slip+2
	bne	Le15c
Le148:	lda	iwm_q7l
	bpl	Le148
	cmp	mt_slip+1
	bne	Le15c
	ldx	current_drive_index
	lda	Z28
	asl
	asl
	asl
	ror	Z0f,x
	clc
	rts
Le15c:	lda	#$20
	tsb	Z57
	sec
	rts

Se162:	lda	#$01
	bit	Z16
	bpl	Le16a
	lda	#$03
Le16a:	jsr	Se640
	lda	iwm_q6l
	lda	iwm_q7l
	rts

	fillto	$e196,$00
denib_tab	equ	*-$96
; denibblizing table
	fcb	$00,$01
	fcb	$98,$99,$02,$03,$9c,$04,$05,$06
	fcb	$a0,$a1,$a2,$a3,$a4,$a5,$07,$08
	fcb	$a8,$a9,$aa,$09,$0a,$0b,$0c,$0d
	fcb	$b0,$b1,$0e,$0f,$10,$11,$12,$13
	fcb	$b8,$14,$15,$16,$17,$18,$19,$1a
	fcb	$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7
	fcb	$c8,$c9,$ca,$1b,$cc,$1c,$1d,$1e
	fcb	$d0,$d1,$d2,$1f,$d4,$d5,$20,$21
	fcb	$d8,$22,$23,$24,$25,$26,$27,$28
	fcb	$e0,$e1,$e2,$e3,$e4,$29,$2a,$2b
	fcb	$e8,$2c,$2d,$2e,$2f,$30,$31,$32
	fcb	$f0,$f1,$33,$34,$35,$36,$37,$38
	fcb	$f8,$39,$3a,$3b,$3c,$3d,$3e,$3f


read_data:
	jmp	v_read_data

read_data_actual:
	stz	Z21
	stz	Z20
	stz	Z1f
	ldy	#$19
Le20b:	ldx	#$02
Le20d:	dey
	beq	Le228
Le210:	lda	iwm_q7l
	bpl	Le210
	cmp	mt_data,x
	bne	Le20b
	dex
	bpl	Le20d
Le21c:	ldx	iwm_q7l
	bpl	Le21c
	lda	denib_tab,x
	cmp	Z2a
	beq	Le22b
Le228:	jmp	Le2ca
Le22b:	ldy	#$af
	jmp	Le244
Le230:	ldx	iwm_q6l
	lda	denib_tab,x
	ldx	Z23
	ora	De080,x
	eor	Z20
	sta	D0741,y
	adc	Z1f
	sta	Z1f
Le244:	ldx	iwm_q6l
	bpl	Le244
	lda	denib_tab,x
	sta	Z23
	asl	Z1f
	bcc	Le254
	inc	Z1f
Le254:	ldx	iwm_q6l
	bpl	Le254
	lda	denib_tab,x
	ldx	Z23
	ora	De000,x
	eor	Z1f
	sta	D0100,y
	adc	Z21
Le268:	ldx	iwm_q6l
	bpl	Le268
	sta	Z21
	lda	denib_tab,x
	ldx	Z23
	ora	De040,x
	eor	Z21
	sta	D0640,y
	adc	Z20
	sta	Z20
	dey
	bne	Le230
Le283:	ldx	iwm_q6l
	bpl	Le283
	ldy	denib_tab,x
	lda	De080,y
	sta	Z23
	lda	De040,y
	sta	Z24
	lda	De000,y
	ldy	#$02
Le29a:	ldx	iwm_q6l
	bpl	Le29a
	and	#$c0
	ora	denib_tab,x
	cmp	Z1f,y
	bne	Le2c0
	lda	Z22,y
	dey
	bpl	Le29a
	ldy	#$02
Le2b1:	lda	iwm_q6l
	bpl	Le2b1
	cmp	mt_slip,y
	bne	Le2c4
	dey
	bne	Le2b1
	clc
	rts
Le2c0:	lda	#$10
	bne	Le2c6
Le2c4:	lda	#$08
Le2c6:	ora	Z57
	sta	Z57
Le2ca:	sec
	rts


cmd_format:
	jmp	v_format

cmd_format_actual:
	sec
	jsr	Se5f0
	bcs	Le313
	jsr	Se3b9
	jsr	Le4f7
	bcs	Le30c
	stz	Z16
	stz	cyl
Le2e1:	lda	#$0a
	sta	spb_packet_type
Le2e5:	jsr	write_trk
	bcs	Le30c
	jsr	verify
	bcc	Le2f6
	dec	spb_packet_type
	bne	Le2e5
	jmp	Le30c
Le2f6:	bit	form_sides
	bpl	Le302
	lda	#$80
	eor	Z16
	sta	Z16
	bne	Le2e1
Le302:	inc	cyl
	lda	cyl
	cmp	#$50
	bcc	Le2e1
	clc
	rts
Le30c:	jsr	Se51b
	lda	#$a7
	sta	Z5e
Le313:	rts


write_trk:
	jmp	v_write_trk

write_trk_actual:
	jsr	seek
	jsr	Se3f0
	jsr	Se56a
	lda	Z16
	bne	Le337
	lda	cyl
	and	#$0f
	bne	Le337
	lda	cyl
	lsr
	lsr
	lsr
	lsr
	tax
	lda	De3b4,x
	jsr	delay2
Le337:	jsr	Se162
	stz	Z17
	stz	Z25
	lda	#$04
	sta	Z26
	bit	iwm_q6h
	sta	iwm_q7h
	lda	#$00
	ldx	#$c8
	sta	spb_group_count
Le34e:	ldy	#$04
Le350:	lda	mt_sync,y
Le353:	bit	iwm_q6l
	bpl	Le353
	sta	iwm_q6h
	dey
	bpl	Le350
	dex
	bne	Le34e
	dec	spb_group_count
	bpl	Le34e
Le365:	ldy	#$fa
Le367:	lda	(Z25),y
Le369:	bit	iwm_q6l
	bpl	Le369
	sta	iwm_q6h
	dey
	cpy	#$ff
	bne	Le367
	dec	Z26
	lda	Z26
	cmp	#$02
	bcs	Le367
	inc	Z17
	ldx	Z17
	cpx	Z1a
	bcs	Le3ac
	lda	#$ff
	sta	iwm_q6h
	ldy	Z2d,x
	lda	nib_tab,y
	sta	D04d2
	sta	D04c2
	tya
	eor	cksum
	tay
	lda	nib_tab,y
	sta	D04cf
	lda	#$04
	sta	Z26
	lda	#$ff
	sta	iwm_q6h
	jmp	Le365
Le3ac:	lda	iwm_q7l
	lda	iwm_q6l
	clc
	rts


De3b4:	fcb	$96,$19,$19,$19,$19


Se3b9:	lda	#$96
	ldx	#$00
Le3bd:	sta	D0200,x
	sta	D0300,x
	sta	D0400,x
	dex
	bne	Le3bd
	ldx	#$15
Le3cb:	lda	Z8d,x
	sta	D04c2,x
	dex
	bpl	Le3cb
	ldx	#$22
Le3d5:	ldy	#$04
Le3d7:	lda	mt_sync,y
	sta	D04d8,x
	dex
	bmi	Le3e5
	dey
	bpl	Le3d7
	bmi	Le3d5
Le3e5:	ldx	#$02
Le3e7:	lda	mt_slip,x
	sta	D0200,x
	dex
	bpl	Le3e7
	rts

Se3f0:	lda	#$ff
	ldx	#$0b
Le3f4:	sta	Z2d,x
	dex
	bpl	Le3f4
	inx
	ldy	#$00
Le3fc:	sty	Z2d,x
	iny
	cpy	Z1a
	bcs	Le417
	txa
	clc
	adc	Z62
	tax
Le408:	cpx	Z1a
	bcc	Le410
	txa
	sbc	Z1a
	tax
Le410:	bit	Z2d,x
	bmi	Le3fc
	inx
	bra	Le408
Le417:	lda	cyl
	and	#$3f
	sta	cksum
	tay
	lda	nib_tab,y
	sta	D04d3
	lda	cyl
	asl
	asl
	lda	#$00
	rol
	bit	Z16
	bpl	Le431
	eor	#$20
Le431:	tay
	eor	cksum
	sta	cksum
	lda	nib_tab,y
	sta	D04d1
	lda	Z62
	bit	form_sides
	bpl	Le444
	ora	#$20
Le444:	tay
	eor	cksum
	sta	cksum
	pha
	lda	nib_tab,y
	sta	D04d0
	pla
	tay
	lda	nib_tab,y
	sta	D04cf
	lda	#$96
	sta	D04d2
	sta	D04c2
	rts


verify:	jmp	v_verify

verify_actual:
	lda	#$02
	jsr	delay
	lda	Z1a
	sta	spb_group_count
Le46d:	jsr	read_addr
	bcs	Le48b
	ldx	Z2a
	cpx	Z1a
	bcs	Le48b
	lda	Z2d,x
	bmi	Le48b
	lda	#$ff
	sta	Z2d,x
	jsr	read_data
	bcs	Le48b
	dec	spb_group_count
	bne	Le46d
	clc
	rts
Le48b:	sec
	rts


Le48d:	sta	cyl

seek:	jmp	v_seek

seek_actual:
	ldx	current_drive_index
	bit	cur_cyl,x
	bpl	Le49d
	jsr	Le4f7
	bcs	Le4c8
Le49d:	jsr	Se614
	sec
	ldx	current_drive_index
	lda	cur_cyl,x
	sbc	cyl
	beq	Le4bb
	ldy	#$01
	bcs	Le4b3
	ldy	#$00
	eor	#$ff
	adc	#$01
Le4b3:	tax
	tya
	jsr	Se64a
	jsr	Se4cf
Le4bb:	ldx	current_drive_index
	lda	cyl
	sta	cur_cyl,x
	jsr	Se6e6
	sta	Z1a
	clc
	rts

Le4c8:	lda	#$02
	ora	Z57
	sta	Z57
	rts

Se4cf:	lda	#$04
	jsr	Se64a
Le4d4:	jsr	Se643
	bpl	Le4d4
	dex
	bne	Se4cf
	ldx	#$3c
Le4de:	dex
	bne	Le4de
	rts


delay2:	pha
	jsr	delay
	pla
; fall into delay

delay:	sta	spb_group_count
Le4e9:	lda	#$c8
	sta	Z17
Le4ed:	dec	Z17
	nop
	bne	Le4ed
	dec	spb_group_count
	bne	Le4e9
	rts


Le4f7:	lda	#$01
	jsr	Se64a
	ldx	#$50
	jsr	Se4cf
	ldx	#$50
Le503:	lda	#$07
	jsr	delay
	lda	#$0a
	jsr	Se640
	bpl	Le515
	dex
	bne	Le503
	sec
	bra	Le516
Le515:	clc
Le516:	ldx	current_drive_index
	stz	cur_cyl,x
	rts

Se51b:	lda	#$02
	jsr	Se640
	bmi	Le568
	lda	#$09
	jsr	Se64a
	lda	#$c8
	jsr	delay
	lda	#$03
	sta	Z39
	ldx	current_drive_index
	stx	Z6f
Le534:	lda	#$0d
	jsr	Se64a
	lda	#$96
	sta	Z3b
Le53d:	lda	#$0a
	jsr	delay
	lda	#$02
	jsr	Se640
	bmi	Le557
	dec	Z3b
	bne	Le53d
	dec	Z39
	bne	Le534
	lda	#$a7
	sta	Z5e
	sec
	rts
Le557:	ldx	current_drive_index
	sec
	ror	Z6f
	sec
	ror	cur_cyl,x
	lda	#$fa
	sta	Z11,x
	lda	#$01
	jsr	delay
Le568:	clc
	rts

Se56a:	lda	#$0b
	jsr	Se640
Le56f:	bit	iwm_q7l
	bmi	Le56f

	lda	ga_shadow_wr_reg0	; pulse TRIGGER
	and	#$ef
	sta	ga_reg0
	lda	ga_shadow_wr_reg0
	sta	ga_reg0
	rts

Le581:	jsr	Se640
Le584:	bit	iwm_q7l
	bpl	Le584
	rts

Le58a:	lda	#$1f

Se58c:	tay
	lda	iwm_motor_off
	lda	iwm_q6h
Le593:	sty	iwm_q7h
	tya
	eor	iwm_q7l
	and	#$1f
	bne	Le593
	lda	iwm_q6l
	lda	iwm_motor_on
	rts


warmstart_check:
	ldx	#warmstart_tab_len-1
	stx	Z08
Le5a9:	lda	warmstart_tab,x
	cmp	warmstart_ram,x
	beq	Le5b5
	sta	warmstart_ram,x
	sec
	ror	Z08
Le5b5:	dex
	bpl	Le5a9
	bit	Z08
	rts


warmstart_tab:
	fcb	"LIRONMSA"
warmstart_tab_len	equ	*-warmstart_tab


Se5c3:	lda	ga_reg1		; check BLATCH1 and 2
	and	#$0c
	beq	Le5ed

	ldx	#$00
	cmp	#$08
	beq	Le5d1
	inx
Le5d1:	stx	current_drive_index
	lda	spb_drive_address,x
	beq	Le5dd
	jsr	Se9d0
	jsr	Se51b
Le5dd:	ldx	current_drive_index
	lda	De5ee,x
	jsr	Se681
	lda	#$cf
	jsr	Se681
	jsr	Sebfd
Le5ed:	rts


De5ee:	fcb	$08,$04


Se5f0:	php
	ldx	#$01
Le5f3:	lda	De612,x
	jsr	Se640
	asl
	ror	Z17
	dex
	bpl	Le5f3
	plp
	lda	#$af
	bit	Z17
	bvs	Le60c
	bcc	Le60f
	bmi	Le610
	lda	#$ab
Le60c:	sta	Z5e
	sec
Le60f:	rts
Le610:	clc
	rts


De612:	fcb	$06,$02


Se614:	lda	#$00
	sta	Z6a
	lda	#$5d
	sta	Z6b
	lda	#$08
	jsr	Se640
	bpl	Le634
	jsr	Se64d
	ldx	current_drive_index
	lda	Z11,x
	jsr	delay2
	lda	#$19
	sta	Z11,x
	jsr	delay2
Le634:	rts

Le635:	lda	#$01
	bit	Z16
	bpl	Le63d
	lda	#$11
Le63d:	jmp	Se67c

Se640:	jsr	Se654

Se643:	bit	iwm_q6h
	lda	iwm_q7l
	rts

Se64a:	jsr	Se654

Se64d:	bit	iwm_ph_3_on
	bit	iwm_ph_3_off
	rts

Se654:	bit	iwm_ph_0_on
	bit	iwm_ph_1_on
	bit	iwm_ph_2_off
	lsr
	bcc	Le663
	bit	iwm_ph_2_on
Le663:	lsr
	pha
	lda	#$01
	bcc	Le66b
	lda	#$11
Le66b:	jsr	Se67c
	pla
	lsr
	bcs	Le675
	bit	iwm_ph_0_off
Le675:	lsr
	bcs	Le67b
	bit	iwm_ph_1_off
Le67b:	rts

Se67c:	phx
	ldx	#$00
	bra	Le684

Se681:	phx
	ldx	#$01
Le684:	pha
	eor	#$0f
	ora	#$f0
	and	ga_shadow_wr_reg0,x
	sta	ga_shadow_wr_reg0,x
	pla
	lsr
	lsr
	lsr
	lsr
	ora	ga_shadow_wr_reg0,x
	sta	ga_shadow_wr_reg0,x
	sta	ga_reg0,x
	plx
	rts

Le69b:	lda	sp_param+2
	and	#$3f
	sta	Z15
	lda	sp_param+2
	ldx	#$06
Le6a5:	lsr	sp_param+3
	ror
	dex
	bne	Le6a5
	ldx	current_drive_index
	bit	Z0f,x
	bpl	Le6b4
	clc
	adc	#$0d
Le6b4:	tay
	ldx	De718,y
	lda	De6f2,y
	tay
	txa
	clc
	ldx	current_drive_index
	adc	Z15
Le6c2:	pha
	jsr	Se6e0
	sta	Z17
	pla
	cmp	Z17
	bcc	Le6d3
	iny
	sbc	Z17
	jmp	Le6c2
Le6d3:	sty	cyl
	sta	Z15
	bit	Z0f,x
	bpl	Le6dd
	lsr	cyl
Le6dd:	ror	Z16
	rts

Se6e0:	tya
	bit	Z0f,x
	bpl	Se6e6
	lsr

Se6e6:	lsr
	lsr
	lsr
	lsr
	sec
	sta	Z1b
	lda	#$0c
	sbc	Z1b
	rts


De6f2:	fcb	$00,$05,$0a,$10,$15,$1b,$21,$28
	fcb	$2e,$35,$3c,$44,$4c,$00,$05,$0a
	fcb	$10,$15,$1a,$20,$25,$2b,$31,$37
	fcb	$3d,$43,$49,$50,$56,$5c,$63,$6a
	fcb	$71,$78,$80,$88,$90,$98

De718:	fcb	$00,$04,$08,$00,$09,$07,$06,$00
	fcb	$04,$03,$04,$00,$00,$00,$04,$08
	fcb	$00,$04,$08,$00,$09,$07,$05,$03
	fcb	$01,$02,$06,$00,$04,$08,$05,$06
	fcb	$07,$08,$00,$00,$00,$00


Le73e:	lda	#$00
	ldx	current_drive_index
	bit	Z0f,x
	bpl	Le747
	inc
Le747:	tax
	lda	sp_block+0
	cmp	block_count_low_tab,x
	lda	sp_block+1
	sbc	block_count_high_tab,x
	lda	sp_block+2
	sbc	#$00
	bcc	Le75c
	lda	#$ad
	sta	Z5e
Le75c:	rts


block_count_low_tab:
	fcb	800 & $ff, 1600 & $ff
block_count_high_tab:
	fcb	800 >> 8, 1600 >> 8

	
reset:	sei		; disable interrupts, clear decimal, init stack
	cld
	ldx	#$ff
	txs

	jsr	ga_init
	jsr	Se7bc
	stz	Z6a
	stz	Z6b

	jsr	warmstart_check
	bpl	Le78b

	sec
	ror	Z6f
	stz	Z6e
	lda	#$fa
	sta	Z11
	sta	Z11+1
	jsr	vector_init
	lda	#$e6
	jsr	delay
	jsr	Se9ef

Le78b:	bit	Z6f
	bmi	Le799
	ldx	Z6f
	stx	current_drive_index
	jsr	Se9d5
	jsr	Se51b
Le799:	jsr	Se9a4
Le79c:	lda	Z3d
	bne	Le7b1
	lda	#$44
	jsr	Se67c
	lda	Z6e
	bmi	Le7b1
	lda	#$08
	jsr	Se67c
	jsr	Se9ef
Le7b1:	jsr	Sea1d
	jsr	vector
	jsr	spb_send_status_packet
	bra	Le79c


Se7bc:	lda	#$04
	sta	Z62
	lda	#$80
	sta	form_sides
	rts


ga_init:
	lda	#$10
	sta	ga_shadow_wr_reg0
	sta	ga_reg0

	lda	#$00		; reset IWM, clear BLATCH1, BLATCH2
	sta	ga_reg1

	lda	#$1c
	sta	ga_shadow_wr_reg1
	sta	ga_reg1
	rts


vector_init:
	ldx	#ram_vec_tab_len - 1
Le7db:	lda	ram_vec_tab,x
	sta	vector_ram,x
	dex
	bpl	Le7db
	ldx	#ram_data_tab_len - 1
Le7e5:	lda	ram_data_tab,x
	sta	Z8d,x
	dex
	bpl	Le7e5
	rts


	fcb	$60


ram_vec_tab:
	fcb	$1b,$00
	jmp	read_addr_actual	; rd_addr
	jmp	read_data_actual	; read_data
	jmp	write_data_actual	; write_data
	jmp	seek_actual		; seek
	jmp	cmd_format_actual	; format
	jmp	write_trk_actual	; write_trk
	jmp	verify_actual		; verify
	jmp	vector_actual		; vector
	rts				; spare vector
	nop
	nop
ram_vec_tab_len	equ	*-ram_vec_tab


ram_data_tab:
	fcb	$ff
	fcb	$ad,$aa,$d5		; mt_data: data mark
	fcb	$ff
	fcb	$fc,$f3,$cf,$3f,$ff	; mt_sync: data sync
	fcb	$ff,$aa,$de		; mt_slip: bit slip
	fcb	$ff,$ff,$ff,$ff,$ff
	fcb	$96,$aa,$d5		; mt_addr: address mark
	fcb	$ff
ram_data_tab_len	equ	*-ram_data_tab


vector:	jmp	v_vector

vector_actual:
	lda	Z3d
	bne	Le837
	ldx	#$00
	lda	spb_dest_id
	cmp	spb_drive_address
	beq	Le832
	inx
Le832:	stx	current_drive_index
	jsr	Se9d0
Le837:	lda	sp_cmd
	beq	Le844
	ldx	#$06
	lda	#$00
Le83f:	sta	Z56,x
	dex
	bpl	Le83f
Le844:	stz	Z3f
	stz	Z40
	lda	#$80
	sta	Z5e

	lda	sp_cmd		; get command
	cmp	#$0a		; out of range
	bcc	Le857		;   no

cmd_bad:
	lda	#$81
	sta	Z5e
	rts

Le857:	tax			; get expected arg count
	lda	expected_param_count_tab,x
	and	#$7f
	cmp	sp_param_count	; does it match what we've received from host?
	beq	Le872

; arg count different than expected
	lda	expected_param_count_tab,x
	bpl	Le86d
	lda	#$00
	ldx	#$e0
	jsr	Sed01

Le86d:	lda	#$84
	sta	Z5e
	rts

; dispatch command
Le872:	txa
	asl
	tax
	lda	cmd_tab+1,x
	pha
	lda	cmd_tab,x
	pha
Le87d:	rts


cmd_tab:
	fdb	cmd_status-1		; Status
	fdb	cmd_read_block-1	; ReadBlock
	fdb	cmd_write_block-1	; WriteBlock
	fdb	cmd_format-1		; Format
	fdb	cmd_control-1		; Control
	fdb	cmd_init-1		; Init
	fdb	cmd_bad-1		; Open
	fdb	cmd_bad-1		; Close
	fdb	cmd_read-1		; Read
	fdb	cmd_write-1		; Write


; expected parameter count by command
; MSB indicates whether host sends data to drive
expected_param_count_tab:
	fcb	$03	; Status
	fcb	$03	; ReadBlock
	fcb	$83	; WriteBlock
	fcb	$01	; Format
	fcb	$83	; Control
	fcb	$02	; Init
	fcb	$01	; Open
	fcb	$01	; Close
	fcb	$04	; Read
	fcb	$84	; Write


cmd_read_block:
	clc
	bra	Le8b2

cmd_write_block:
	ldx	#$0b
Le8a1:	stz	D0200,x
	dex
	bpl	Le8a1
	lda	#$0c
	ldx	#$02
	jsr	Sed01
Le8ae:	jsr	Lef9e
	sec
Le8b2:	jsr	Se5f0
	bcs	Le87d
	jsr	Le73e
	bcs	Le93a
	jsr	Le69b
	lda	#$04
	sta	Z39
	lda	#$96
	sta	Z3b
Le8c7:	lda	Z39
	cmp	#$02
	bne	Le8d0
Le8cd:	jsr	Le4f7
Le8d0:	jsr	seek
	bcc	Le8e7
Le8d5:	dec	Z39
	bne	Le8c7
	beq	Le93c
Le8db:	inc	Z58
	dec	Z3b
	beq	Le93c
	lda	Z3b
	cmp	#$4b
	beq	Le8cd
Le8e7:	jsr	read_addr
	bcs	Le8db
	lda	Z29
	sta	Z17
	lda	Z2b
	asl
	asl
	lsr	Z17
	ror
	lsr
	cmp	cyl
	beq	Le907
	ldx	current_drive_index
	sta	cur_cyl,x
	lda	#$04
	tsb	Z57
	jmp	Le8d5
Le907:	lda	Z17
	asl
	asl
	asl
	eor	Z16
	bmi	Le8db
	lda	Z2a
	cmp	Z15
	bne	Le8db
	lda	sp_cmd
	cmp	#$01
	bne	Le942
	jsr	read_data
	bcs	Le8db
	jsr	Lf0cf
	lda	#$0c
	sta	Z25
	lda	#$02
	sta	Z26
	lda	#$02
	sta	Z40
	stz	Z3f
	lda	#$e7
	ldy	Z57
	beq	Le93a
	sta	Z5e
Le93a:	clc
	rts
Le93c:	lda	#$a7
	sta	Z5e
	sec
	rts
Le942:	jsr	write_data
	clc
	rts


cmd_init:
	lda	Z3d
	bne	Le94c
	rts

Le94c:	stz	current_drive_index
	ldy	spb_dest_id
	lda	spb_drive_address
	beq	Le95a
	bmi	Le95a
	sty	spb_drive_address
	bra	Le95e
Le95a:	sty	spb_drive_address+1
	inc	current_drive_index
Le95e:	dec	Z3d
	bne	Le96d

	lda	#$10		; check LASTONE/
	bit	ga_reg0
	beq	Le96d

	lda	#$c0
	sta	Z5e
Le96d:	rts


; read command can be used to read entire block, i.e., including tag bytes
cmd_read:
	jsr	Se998
	lda	#$01		; do a read block command
	sta	sp_cmd
	jsr	cmd_read_block
	bcs	Le986

	lda	#$00
	sta	Z25
	lda	#$02
	sta	Z26
	lda	#$0c
	sta	Z3f

Le986:	rts


; write command can be used to read entire block, i.e., including tag bytes
cmd_write:
	lda	#$00
	ldx	#$02
	jsr	Sed01
	jsr	Se998
	lda	#$02
	sta	sp_cmd
	jmp	Le8ae

Se998:	ldx	#$00
Le99a:	lda	sp_param+4,x
	sta	sp_param+2,x
	inx
	cpx	#$03
	bcc	Le99a
	rts


Se9a4:	lda	#$80
	sta	Z0f
	sta	Z0f+1
	stz	spb_drive_address
	stz	spb_drive_address+1
	stz	Z3d
	ldx	#$01
	stx	current_drive_index
Le9b4:	jsr	Se9d5
	lda	#$0d
	jsr	Se640
	bmi	Le9c4
	inc	Z3d
	lda	#$40
	sta	spb_drive_address,x
Le9c4:	dex
	stx	current_drive_index
	bpl	Le9b4
	jmp	Se9ea


	fcb	$23,$22


Se9ce:	ldx	current_drive_index

Se9d0:	sec
	lda	spb_drive_address,x
	beq	Le9e9

Se9d5:	txa
	ror
	lda	#$23
	bcc	Le9dd
	lda	#$13
Le9dd:	jsr	Se681
	lda	#$02
	jsr	Se67c
	jsr	Le58a
	clc
Le9e9:	rts

Se9ea:	lda	#$03
	jmp	Se681


Se9ef:	stz	current_drive_index
Le9f1:	ldx	current_drive_index
	jsr	Se9d5
	lda	#$0d
	jsr	Se640
	bmi	Lea11
	lda	#$02
	jsr	Se640
	bmi	Lea11
	jsr	Se614
	jsr	read_addr
	bit	Z17
	bpl	Lea11
	jsr	Se51b
Lea11:	inc	current_drive_index
	lda	current_drive_index
	cmp	#$02
	bcc	Le9f1
	sec
	ror	Z6e
	rts


Sea1d:	lda	#$80
	sta	spb_packet_type
	lda	#$4c
	sta	Z25
	lda	#$00
	sta	Z26

Sea29:	lda	Z25
	sta	Z6c
	lda	Z26
	sta	Z6d
	jsr	Sebfd
	lda	#$08
	jsr	Se67c
Lea39:	jsr	Sec08

; get SmartPort Bus sync byte
Lea3c:	jsr	spb_read_nib_timeout
	bcs	Lea69
	cmp	#$c3
	bne	Lea3c

	stz	cksum

	jsr	spb_read_nib_upd_cksum	; get SmartPort destination ID
	sta	spb_dest_id

	cmp	spb_drive_address+0	; does the dest ID match ours?
	beq	Lea5f
	cmp	spb_drive_address+1
	beq	Lea5f

	lda	Z3d
	bne	Lea5f

	lda	#$03
	jsr	Se681
	bra	Lea69

Lea5f:	jsr	spb_read_nib_upd_cksum	; get source ID and ignore

	jsr	spb_read_nib_upd_cksum	; get packet type
	cmp	spb_packet_type			; is it the type we expected?
	beq	Lea74

Lea69:	lda	iwm_q6h
Lea6c:	lda	iwm_q7l
	bmi	Lea6c
	jmp	Lea39

Lea74:	jsr	spb_read_nib_upd_cksum	; get aux type and ignroe
	jsr	spb_read_nib_upd_cksum	; get data status byte and ignore

	jsr	spb_read_nib_upd_cksum	; get odd byte count
	and	#$7f
	sta	spb_odd_byte_count

	jsr	spb_read_nib_upd_cksum	; get group count
	and	#$7f
	sta	spb_group_count

	ldy	#$00
	inc	spb_group_count
	ldx	spb_odd_byte_count
	bne	Lea96
	dec	spb_group_count
	beq	Leabb
Lea94:	ldx	#$07
Lea96:	lda	iwm_q6l
	bpl	Lea96
	asl
	sta	Z17
Lea9e:	lda	iwm_q6l
	bpl	Lea9e
	asl	Z17
	bcs	Leaa9
	eor	#$80
Leaa9:	sta	(Z25),y
	eor	cksum
	sta	cksum
	iny
	bne	Leab4
	inc	Z26
Leab4:	dex
	bne	Lea9e
	dec	spb_group_count
	bne	Lea94
Leabb:	jsr	spb_read_nib_timeout
	sta	Z17
	jsr	spb_read_nib_timeout
	sec
	rol
	and	Z17
	cmp	cksum
	bne	Leafd
	jsr	spb_read_nib_timeout
	cmp	#$c8
	bne	Leafd
	lda	iwm_ph_0_off
	lda	#$88
	jsr	Se67c
	lda	iwm_q6h
Leadd:	lda	iwm_q7l
	bmi	Leadd
	clc
	rts

spb_read_nib_upd_cksum:
	lda	iwm_q6l
	bpl	spb_read_nib_upd_cksum
	pha
	eor	cksum
	sta	cksum
	pla
	rts


spb_read_nib_timeout:
	ldy	#$14
	clc
Leaf3:	lda	iwm_q6l
	bmi	Leafc
	dey
	bne	Leaf3
	sec
Leafc:	rts


Leafd:	lda	Z6c
	sta	Z25
	lda	Z6d
	sta	Z26
	jmp	Lea69


spb_send_status_packet:
	lda	#$81		; packet type, $81 = status
	sta	spb_packet_type

spb_send_packet:
	jsr	Sec3a
	jsr	Sec84
	jsr	Seca4
	jsr	Sebfd
	lda	iwm_ph_0_on
	jsr	Sec25
	bcs	Leafc
	lda	#$ff
	bit	iwm_q6h
	sta	iwm_q7h

	ldy	#spb_sync_pattern_len-1
Leb2a:	lda	spb_sync_pattern,y
	jsr	spb_wr_nib
	dey
	bpl	Leb2a

	stz	cksum

	lda	#$80			; send destination ID, $80 = host
	jsr	spb_wr_nib_upd_cksum

	ldx	current_drive_index	; send source ID, current drive
	lda	spb_drive_address,x
	jsr	spb_wr_nib_upd_cksum

	lda	spb_packet_type			; send packet type
	jsr	spb_wr_nib_upd_cksum
	
	lda	#$80			; send aux type
	jsr	spb_wr_nib_upd_cksum

	lda	Z5e			; send data status byte
	jsr	spb_wr_nib_upd_cksum

	lda	spb_odd_byte_count		; send count of odd bytes (0-6)
	jsr	spb_wr_nib_upd_cksum

	lda	spb_group_count		; send count of seven-byte groups
	jsr	spb_wr_nib_upd_cksum

	lda	spb_odd_byte_count		; any odd bytes?
	beq	Leb6f			;   no, skip

	ldy	#$00			; send odd bytes

	lda	Z3e			; write MSBs of odd bytes
	jsr	spb_wr_nib

Leb65:	lda	(Z25),y
	jsr	spb_wr_nib_upd_cksum
	iny
	cpy	spb_odd_byte_count
	bcc	Leb65

Leb6f:	lda	spb_group_count		; any groups?
	beq	Leba8			;   no, skip

	ldy	#$00
Leb75:	lda	Z17
	ora	#$80
Leb79:	bit	iwm_q6l
	bpl	Leb79
	sta	iwm_q6h
	ldx	#$06
Leb83:	lda	Z43,x
	eor	cksum
	sta	cksum
	lda	Z43,x
	ora	#$80
Leb8d:	bit	iwm_q6l
	bpl	Leb8d
	sta	iwm_q6h
	lda	(Z41),y
	sta	Z43,x
	asl
	rol	Z17
	iny
	bne	Leba1
	inc	Z42
Leba1:	dex
	bpl	Leb83

	dec	spb_group_count	; any more groups?
	bne	Leb75		;   yes, loop

Leba8:	lda	cksum		; send checksum even bits, don't update checksum
	ora	#$aa
	jsr	spb_wr_nib

	lda	cksum		; send checksum odd bits
	lsr
	ora	#$aa
	jsr	spb_wr_nib

	lda	#$c8		; send packet end mark
	jsr	spb_wr_nib

Lebbc:	lda	iwm_q6l
	and	#$40
	bne	Lebbc
	lda	iwm_ph_0_off
	lda	iwm_q7l
	lda	iwm_q6h
	clc
	ldx	#$64
Lebcf:	dex
	bne	Lebd3
	sec
Lebd3:	lda	iwm_q7l
	bmi	Lebcf
	lda	iwm_q6l
	bcc	Lebe0
	jmp	spb_send_packet
Lebe0:	rts


spb_sync_pattern:
	fcb	$c3,$ff,$fc,$f3,$cf,$3f,$ff,$fc
	fcb	$f3,$cf,$3f
spb_sync_pattern_len	equ	*-spb_sync_pattern


spb_wr_nib_upd_cksum:
	pha
	eor	cksum
	sta	cksum
	pla

spb_wr_nib:	ora	#$80
Lebf4:	bit	iwm_q6l
	bpl	Lebf4
	sta	iwm_q6h
	rts


Sebfd:	lda	#$22
	jsr	Se67c
	lda	#$17
	jsr	Se58c
	rts

Sec08:	lda	Z6a
	ora	Z6b
	bne	Lec13
	jsr	Se9ea
	bra	Lec19
Lec13:	inc	Z6a
	bne	Lec19
	inc	Z6b
Lec19:	jsr	Se5c3
	lda	iwm_q6h
	lda	iwm_q7l
	bpl	Sec08
	rts

Sec25:	ldx	#$00
	ldy	#$14
Lec29:	clc
	lda	iwm_q6h
	lda	iwm_q7l
	bmi	Lec39
	sec
	inx
	bne	Lec29
	iny
	bne	Lec29
Lec39:	rts

Sec3a:	ldx	Z40
	lda	Dec72,x
	sta	spb_group_count
	lda	Dec75,x
	sta	spb_odd_byte_count
	ldx	#$05
	lda	Z3f
	sta	Z17
	and	#$07
	tay
Lec4f:	asl	Z17
	bcc	Lec68
	lda	Dec7e,x
Lec56:	clc
	adc	spb_odd_byte_count
	cmp	#$07
	bcc	Lec5f
	sbc	#$07
Lec5f:	sta	spb_odd_byte_count
	lda	Dec78,x
	adc	spb_group_count
	sta	spb_group_count
Lec68:	dex
	bmi	Lec71
	bne	Lec4f
	tya
	jmp	Lec56
Lec71:	rts


Dec72:	fcb	$00,$24,$49
Dec75:	fcb	$00,$04,$01
Dec78:	fcb	$00,$01,$02,$04,$09,$12
Dec7e:	fcb	$00,$01,$02,$04,$01,$02


Sec84:	ldy	spb_odd_byte_count
	dey
	lda	#$00
	sta	Z3e
Lec8b:	lda	(Z25),y
	asl
	ror	Z3e
	dey
	bpl	Lec8b
	sec
	ror	Z3e
	lda	spb_odd_byte_count
	clc
	adc	Z25
	sta	Z41
	lda	Z26
	adc	#$00
	sta	Z42
	rts

Seca4:	ldy	#$06
	ldx	#$00
Leca8:	sec
	lda	(Z41),y
	sta	Z43,x
	bmi	Lecb0
	clc
Lecb0:	ror	Z17
	inx
	dey
	bpl	Leca8
	sec
	ror	Z17
	lda	Z41
	clc
	adc	#$07
	sta	Z41
	bcc	Lecc4
	inc	Z42
Lecc4:	rts


cmd_control:
	lda	sp_ctl_code
	cmp	#max_control
	bcc	Lecd0

Leccb:	lda	#$80 + err_badctl	; control code out of range
	sta	Z5e
	rts

Lecd0:	asl
	tax
	lda	control_tab+1,x
	pha
	lda	control_tab,x
	pha
	rts


; control function dispatch table
control_tab:
	fdb	control_reset-1		; Reset device
	fdb	control_bad-1		; set device control block
	fdb	control_bad-1		; set newline status
	fdb	control_bad-1		; service device interrupt
	fdb	control_eject-1		; Eject
	fdb	control_execute-1	; Execute
	fdb	control_set_address-1	; SetAddress
	fdb	control_download-1	; Download
max_control	equ	(*-control_tab)/2


control_bad:
	jsr	Secfd
	jmp	Leccb

control_reset:
	jmp	vector_init

	jmp	Secfd

control_eject:
	jsr	Secfd
	jmp	Se51b


Secfd:	lda	#$00
	ldx	#$02

Sed01:	sta	Z25
	stx	Z26
	lda	#$82
	sta	spb_packet_type
	jsr	Sea29
	jmp	Se9ce

control_execute:
	jsr	Secfd
	lda	execute_reg_p
	pha
	lda	execute_reg_a
	ldx	execute_reg_x
	ldy	execute_reg_y
	plp
	jsr	Sed2e
	php
	sta	Z59
	stx	Z5a
	sty	Z5b
	pla
	sta	Z5c
	rts

Sed2e:	jmp	(execute_reg_pc)


control_download:
	lda	Z64
	ldx	Z65
	jmp	Sed01


control_set_address:
	jsr	Secfd
	lda	execute_reg_a
	sta	Z64
	lda	execute_reg_x
	sta	Z65
	rts


cmd_status:
	lda	#$00
	sta	Z25
	lda	#$02
	sta	Z26

	lda	sp_stat_code
	cmp	#max_status
	bcc	Led57
	jmp	Leccb


Led57:	asl
	tax
	lda	status_tab+1,x
	pha
	lda	status_tab,x
	pha
	rts


status_tab:
	fdb	Leda3-1		; device status
	fdb	Leccb-1		; device control block
	fdb	Leccb-1		; newline status
	fdb	Led6e-1		; device information block
	fdb	Leccb-1
	fdb	Led96-1		; UniDiskStat
max_status	equ	(*-status_tab)/2


Led6e:	jsr	Leda3
	ldx	#$14
Led73:	lda	Ded81,x
	sta	execute_reg_pc,x
	dex
	bpl	Led73
	lda	#$19
	sta	Z3f
	rts


Ded81:	fcb	8, "DISK 3.5"

	fcb	$20,$20,$20,$20,$20,$20,$20,$20

	fcb	$01,$00,$00,$10


Led96:	lda	#$56
	sta	Z25
	lda	#$00
	sta	Z26
	lda	#$08
	sta	Z3f
	rts

Leda3:	sec
	jsr	Se5f0
	ldx	Z5e
	lda	#$80
	sta	Z5e
	lda	#$e8
	cpx	#$af
	beq	Ledbb
	eor	#$10
	cpx	#$ab
	bne	Ledbb
	eor	#$04
Ledbb:	sta	D0200
	lda	#$40
	ldy	#$06
	ldx	current_drive_index
	bit	Z0f,x
	bmi	Ledcc
	lda	#$20
	ldy	#$03
Ledcc:	sta	execute_reg_x
	sty	execute_reg_y
	stz	execute_reg_p
	lda	#$04
	sta	Z3f
	rts


	fillto	$ee00,$ff

nib_tab:
	rept	4
	fcb	$96,$97,$9a,$9b,$9d,$9e,$9f,$a6
	fcb	$a7,$ab,$ac,$ad,$ae,$af,$b2,$b3
	fcb	$b4,$b5,$b6,$b7,$b9,$ba,$bb,$bc
	fcb	$bd,$be,$bf,$cb,$cd,$ce,$cf,$d3
	fcb	$d6,$d7,$d9,$da,$db,$dc,$dd,$de
	fcb	$df,$e5,$e6,$e7,$e9,$ea,$eb,$ec
	fcb	$ed,$ee,$ef,$f2,$f3,$f4,$f5,$f6
	fcb	$f7,$f9,$fa,$fb,$fc,$fd,$fe,$ff
	endm


write_data:
	jmp	v_write_data

write_data_actual:
	bit	iwm_q6h
	lda	#$ff
	sta	iwm_q7h
	ldx	#$07
Lef0d:	lda	mt_data,x
Lef0f:	bit	iwm_q6l
	bpl	Lef0f
	sta	iwm_q6h
	dex
	bpl	Lef0d
	ldy	Z2a
	lda	nib_tab,y
	jsr	spb_wr_nib
	ldx	#$ae
	bra	Lef39
Lef26:	ldy	Z69
	lda	D0741,x
	sta	Z69
	asl
	rol	Z66
	asl
	rol	Z66
	lda	nib_tab,y
	sta	iwm_q6h
Lef39:	ldy	Z66
	lda	nib_tab,y
Lef3e:	bit	iwm_q6l
	bpl	Lef3e
	sta	iwm_q6h
	ldy	Z67
	lda	D0100,x
	sta	Z67
	asl
	rol	Z66
	asl
	rol	Z66
	lda	nib_tab,y
	sta	iwm_q6h
	ldy	Z68
	lda	D0640,x
	sta	Z68
	asl
	rol	Z66
	asl
	rol	Z66
	lda	nib_tab,y
	sta	iwm_q6h
	dex
	cpx	#$ff
	bne	Lef26
	ldx	#$03
Lef73:	lda	Z1f,x
	and	#$3f
	tay
	lda	nib_tab,y
Lef7b:	bit	iwm_q6l
	bpl	Lef7b
	sta	iwm_q6h
	dex
	bpl	Lef73
	ldx	#$02
Lef88:	lda	mt_slip,x
Lef8a:	bit	iwm_q6l
	bpl	Lef8a
	sta	iwm_q6h
	dex
	bpl	Lef88
Lef95:	bit	iwm_q6l
	bvs	Lef95
	bit	iwm_q7l
	rts

Lef9e:	stz	Z21
	stz	Z20
	stz	Z1f
	stz	Z25
	lda	#$02
	sta	Z26
	ldx	#$af
	ldy	#$00
	bra	Lefc2
Lefb0:	lda	(Z25),y
	adc	Z1f
	sta	Z1f
	lda	(Z25),y
	eor	Z20
	sta	D0741,x
	iny
	bne	Lefc2
	inc	Z26
Lefc2:	asl	Z1f
	bcc	Lefc8
	inc	Z1f
Lefc8:	lda	(Z25),y
	adc	Z21
	sta	Z21
	lda	(Z25),y
	eor	Z1f
	sta	D0100,x
	iny
	bne	Lefda
	inc	Z26
Lefda:	lda	(Z25),y
	adc	Z20
	sta	Z20
	lda	(Z25),y
	eor	Z21
	sta	D0640,x
	iny
	bne	Lefec
	inc	Z26
Lefec:	dex
	bne	Lefb0
	lda	Z1f
	lsr
	lsr
	eor	Z20
	and	#$3f
	eor	Z20
	lsr
	lsr
	eor	Z21
	and	#$3f
	eor	Z21
	lsr
	lsr
	sta	Z22
	lda	D01af
	sta	Z67
	asl
	rol	Z66
	asl
	rol	Z66
	lda	D06ef
	sta	Z68
	asl
	rol	Z66
	asl
	rol	Z66
	lda	D07ef
	sta	Z69
	asl
	rol	Z66
	asl
	rol	Z66
	rts

Lf027:	jsr	Se9ce
	jsr	seek
	jsr	Se56a
	jsr	Se162
	lda	#$02
	sta	Z26
	stz	Z25
	ldy	#$00
Lf03b:	lda	iwm_q6l
	bpl	Lf03b
	sta	(Z25),y
	inc	Z25
	bne	Lf03b
	inc	Z26
	lda	Z26
	cmp	#$05
	bcc	Lf03b
	rts

Lf04f:	jsr	Sf0ab
	jsr	Sf0c2
Lf055:	jsr	Sf0a6
	cmp	Z5f
	beq	Lf063
Lf05c:	jsr	Sf09b
	bcs	Lf09a
	bra	Lf055
Lf063:	ldy	#$00
	lda	Z25
	sta	(Z17),y
	iny
	lda	Z26
	sta	(Z17),y
Lf06e:	jsr	Sf09b
	bcs	Lf09a
	cmp	Z5f
	beq	Lf06e
	lda	Z25
	sec
	sbc	(Z17),y
	iny
	iny
	sta	(Z17),y
	dey
	lda	Z26
	sbc	(Z17),y
	iny
	iny
	sta	(Z17),y
	lda	Z17
	clc
	adc	#$04
	sta	Z17
	bcc	Lf094
	inc	spb_group_count
Lf094:	lda	spb_group_count
	cmp	Z61
	bne	Lf05c
Lf09a:	rts

Sf09b:	inc	Z25
	clc
	bne	Sf0a6
	inc	Z26
	lda	Z26
	cmp	#$e0

Sf0a6:	ldy	#$00
	lda	(Z25),y
	rts

Sf0ab:	stz	Z25
	lda	Z60
	sta	Z26
	lda	#$00
	tay
Lf0b4:	sta	(Z25),y
	dey
	bne	Lf0b4
	inc	Z26
	ldx	Z26
	cpx	Z61
	bcc	Lf0b4
	rts

Sf0c2:	stz	Z25
	stz	Z17
	lda	#$a0
	sta	Z26
	lda	Z60
	sta	spb_group_count
	rts

Lf0cf:	ldy	#$00
	ldx	#$af
	lda	#$00
	sta	Z25
	lda	#$02
	sta	Z26
Lf0db:	lda	D0100,x
	sta	(Z25),y
	iny
	bne	Lf0e5
	inc	Z26
Lf0e5:	lda	D0640,x
	sta	(Z25),y
	iny
	bne	Lf0ef
	inc	Z26
Lf0ef:	lda	D0740,x
	sta	(Z25),y
	iny
	dex
	bne	Lf0db
	rts

Lf0f9:	sta	Z4a
	jsr	seek
	jsr	Se56a
	lda	#$0e
	jsr	Se640
	lda	#$02
	jsr	Sf10f
	bvs	Lf143
	lda	Z4a

Sf10f:	sta	Z1d
	ldx	#$02
	ldy	#$00
	sty	Z1c
Lf117:	sta	Z17
	jsr	Sf142
	bcc	Lf11e
Lf11e:	inx
	bne	Lf124
	iny
	bne	Lf126
Lf124:	nop
	nop
Lf126:	dec	Z1c
	beq	Lf143
	bit	iwm_q7l
	bcc	Lf133
	bmi	Lf135
	bpl	Lf117
Lf133:	bmi	Lf117
Lf135:	lda	#$00
	sta	Z1c
	ror
	eor	#$80
	rol
	dec	Z1d
	bne	Lf11e
	clv
Sf142:	rts

Lf143:	lda	#$7f
	adc	#$01
	rts

Lf148:	jsr	Se9ce
	jsr	Le4f7
	stz	Z16
	stz	cyl
Lf152:	jsr	seek
Lf155:	jsr	Sf169
	lda	#$80
	eor	Z16
	sta	Z16
	bmi	Lf155
	inc	cyl
	lda	cyl
	cmp	#$50
	bcc	Lf152
	rts

Sf169:	jsr	Se56a
	jsr	Le635
	ldy	#$27
	ldx	#$10
	lda	Z4b
	sta	iwm_q7h
Lf178:	bit	iwm_q6l
	bpl	Lf178
	sta	iwm_q6h
	dex
	bne	Lf178
	dey
	bne	Lf178
	bit	iwm_q6l
	bit	iwm_q7l
	rts

Lf18d:	jsr	Le4f7
	lda	#79
	sta	cyl
	jsr	seek
	jsr	Se56a
	jmp	Lf18d

	fillto	$fea0,$ff

	fcb	"(C) 1985 Apple Computer, Inc.",cr,cr
	fcb	"The firmware was written by Michael Askins.",cr,cr
	fcb	"The Liron design team was:",cr
	fcb	" Josef Friedman, manager",cr
	fcb	" Cheng Lin, hardware",cr
	fcb	" Michael Askins, software",cr
	fcb	" Cecilia Arboleya, tech support",cr
	fcb	" Cameron Birse, tech support",cr,cr
	fcb	$00

	fillto	$ffa0,$ff

	jmp	Lf0f9
	jmp	Le48d
	jmp	Le69b
	jmp	Se6e0
	jmp	cmd_read_block
	jmp	cmd_write_block
	jmp	Se9ce
	jmp	Se9ea
	jmp	Lf148
	jmp	Sf169

	fillto	$ffe9,$ff

	fcb	$00,$10,$00,$00
	fcb	$00,$00,$00,$00,$00,$00,$00,$00
	fcb	$00,$00,$00,$00,$00

	fdb	reset	; reset vector
	fdb	reset	; IRQ vector
	fdb	reset	; NMI vector
