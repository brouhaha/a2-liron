; Apple II Liron Disk Drive firmware
; Firmware P/N 341-????
; Copyright 2017 Eric Smith <spacewar@gmail.com>

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

L00	equ	$00
Z08	equ	$08
Z09	equ	$09
Z0a	equ	$0a
Z0b	equ	$0b
Z0c	equ	$0c
Z0d	equ	$0d
Z0f	equ	$0f
Z10	equ	$10
Z11	equ	$11
Z12	equ	$12
Z13	equ	$13
Z14	equ	$14
Z15	equ	$15
Z16	equ	$16
Z17	equ	$17
Z18	equ	$18
Z19	equ	$19
Z1a	equ	$1a
Z1b	equ	$1b
Z1c	equ	$1c
Z1d	equ	$1d
Z1e	equ	$1e
Z1f	equ	$1f
Z20	equ	$20
Z21	equ	$21
Z22	equ	$22
Z23	equ	$23
Z24	equ	$24
Z25	equ	$25
Z26	equ	$26
Z27	equ	$27
Z28	equ	$28
Z29	equ	$29
Z2a	equ	$2a
Z2b	equ	$2b
Z2c	equ	$2c
Z2d	equ	$2d
Z39	equ	$39
Z3b	equ	$3b
Z3d	equ	$3d
Z3e	equ	$3e
Z3f	equ	$3f
Z40	equ	$40
Z41	equ	$41
Z42	equ	$42
Z43	equ	$43
Z4a	equ	$4a
Z4b	equ	$4b
Z4c	equ	$4c
Z4d	equ	$4d
Z50	equ	$50
Z51	equ	$51
Z52	equ	$52
Z55	equ	$55
Z56	equ	$56
Z57	equ	$57
Z58	equ	$58
Z59	equ	$59
Z5a	equ	$5a
Z5b	equ	$5b
Z5c	equ	$5c
Z5e	equ	$5e
Z5f	equ	$5f
Z60	equ	$60
Z61	equ	$61
Z62	equ	$62
Z63	equ	$63
Z64	equ	$64
Z65	equ	$65
Z66	equ	$66
Z67	equ	$67
Z68	equ	$68
Z69	equ	$69
Z6a	equ	$6a
Z6b	equ	$6b
Z6c	equ	$6c
Z6d	equ	$6d
Z6e	equ	$6e
Z6f	equ	$6f
Z70	equ	$70
L72	equ	$72
L75	equ	$75
L78	equ	$78
L7b	equ	$7b
L7e	equ	$7e
L81	equ	$81
L84	equ	$84
L87	equ	$87
Z8d	equ	$8d
Z8e	equ	$8e
Z92	equ	$92
Z97	equ	$97
Z98	equ	$98
Z99	equ	$99
Z9f	equ	$9f
D0100	equ	$0100
D01af	equ	$01af
D0200	equ	$0200
D0201	equ	$0201
D0202	equ	$0202
D0203	equ	$0203
D0204	equ	$0204
D0300	equ	$0300
S0340	equ	$0340
D0400	equ	$0400
D04c2	equ	$04c2
D04cf	equ	$04cf
D04d0	equ	$04d0
D04d1	equ	$04d1
D04d2	equ	$04d2
D04d3	equ	$04d3
D04d8	equ	$04d8
D0640	equ	$0640
D06ef	equ	$06ef
D0740	equ	$0740
D0741	equ	$0741
D07ef	equ	$07ef
D0800	equ	$0800
D0801	equ	$0801
D0a00	equ	$0a00
D0a01	equ	$0a01
D0a02	equ	$0a02
D0a03	equ	$0a03
D0a04	equ	$0a04
D0a05	equ	$0a05
D0a06	equ	$0a06
D0a07	equ	$0a07
D0a08	equ	$0a08
D0a09	equ	$0a09
D0a0c	equ	$0a0c
D0a0d	equ	$0a0d
D0a0e	equ	$0a0e
D0a0f	equ	$0a0f
	
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

Le103:	jmp	L72

Le106:	jsr	Se56a
	jsr	Se162
	lda	#$05
	sta	Z17
	ldy	#$dc
Le112:	ldx	#$02
Le114:	dey
	bne	Le11b
	dec	Z17
	bmi	Le15c
Le11b:	lda	D0a0e
	bpl	Le11b
	cmp	Z9f,x
	bne	Le112
	dex
	bpl	Le114
	ldx	#$04
	stz	Z1e
Le12b:	ldy	D0a0e
	bpl	Le12b
	lda	De100,y
	sta	Z27,x
	eor	Z1e
	sta	Z1e
	dex
	bpl	Le12b
	tay
	bne	Le15c
Le13f:	lda	D0a0e
	bpl	Le13f
	cmp	Z99
	bne	Le15c
Le148:	lda	D0a0e
	bpl	Le148
	cmp	Z98
	bne	Le15c
	ldx	Z13
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
	lda	D0a0c
	lda	D0a0e
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

Se200:	jmp	L75

Le203:	stz	Z21
	stz	Z20
	stz	Z1f
	ldy	#$19
Le20b:	ldx	#$02
Le20d:	dey
	beq	Le228
Le210:	lda	D0a0e
	bpl	Le210
	cmp	Z8e,x
	bne	Le20b
	dex
	bpl	Le20d
Le21c:	ldx	D0a0e
	bpl	Le21c
	lda	denib_tab,x
	cmp	Z2a
	beq	Le22b
Le228:	jmp	Le2ca
Le22b:	ldy	#$af
	jmp	Le244
Le230:	ldx	D0a0c
	lda	denib_tab,x
	ldx	Z23
	ora	De080,x
	eor	Z20
	sta	D0741,y
	adc	Z1f
	sta	Z1f
Le244:	ldx	D0a0c
	bpl	Le244
	lda	denib_tab,x
	sta	Z23
	asl	Z1f
	bcc	Le254
	inc	Z1f
Le254:	ldx	D0a0c
	bpl	Le254
	lda	denib_tab,x
	ldx	Z23
	ora	De000,x
	eor	Z1f
	sta	D0100,y
	adc	Z21
Le268:	ldx	D0a0c
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
Le283:	ldx	D0a0c
	bpl	Le283
	ldy	denib_tab,x
	lda	De080,y
	sta	Z23
	lda	De040,y
	sta	Z24
	lda	De000,y
	ldy	#$02
Le29a:	ldx	D0a0c
	bpl	Le29a
	and	#$c0
	ora	denib_tab,x
	cmp	Z1f,y
	bne	Le2c0
	lda	Z22,y
	dey
	bpl	Le29a
	ldy	#$02
Le2b1:	lda	D0a0c
	bpl	Le2b1
	cmp	Z97,y
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

Le2cc:	jmp	L7e

Le2cf:	sec
	jsr	Se5f0
	bcs	Le313
	jsr	Se3b9
	jsr	Le4f7
	bcs	Le30c
	stz	Z16
	stz	Z14
Le2e1:	lda	#$0a
	sta	Z19
Le2e5:	jsr	Se314
	bcs	Le30c
	jsr	Se461
	bcc	Le2f6
	dec	Z19
	bne	Le2e5
	jmp	Le30c
Le2f6:	bit	Z63
	bpl	Le302
	lda	#$80
	eor	Z16
	sta	Z16
	bne	Le2e1
Le302:	inc	Z14
	lda	Z14
	cmp	#$50
	bcc	Le2e1
	clc
	rts
Le30c:	jsr	Se51b
	lda	#$a7
	sta	Z5e
Le313:	rts

Se314:	jmp	L81

Le317:	jsr	Se48f
	jsr	Se3f0
	jsr	Se56a
	lda	Z16
	bne	Le337
	lda	Z14
	and	#$0f
	bne	Le337
	lda	Z14
	lsr
	lsr
	lsr
	lsr
	tax
	lda	De3b4,x
	jsr	Se4e2
Le337:	jsr	Se162
	stz	Z17
	stz	Z25
	lda	#$04
	sta	Z26
	bit	D0a0d
	sta	D0a0f
	lda	#$00
	ldx	#$c8
	sta	Z18
Le34e:	ldy	#$04
Le350:	lda	Z92,y
Le353:	bit	D0a0c
	bpl	Le353
	sta	D0a0d
	dey
	bpl	Le350
	dex
	bne	Le34e
	dec	Z18
	bpl	Le34e
Le365:	ldy	#$fa
Le367:	lda	(Z25),y
Le369:	bit	D0a0c
	bpl	Le369
	sta	D0a0d
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
	sta	D0a0d
	ldy	Z2d,x
	lda	nib_tab,y
	sta	D04d2
	sta	D04c2
	tya
	eor	Z1e
	tay
	lda	nib_tab,y
	sta	D04cf
	lda	#$04
	sta	Z26
	lda	#$ff
	sta	D0a0d
	jmp	Le365
Le3ac:	lda	D0a0e
	lda	D0a0c
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
Le3d7:	lda	Z92,y
	sta	D04d8,x
	dex
	bmi	Le3e5
	dey
	bpl	Le3d7
	bmi	Le3d5
Le3e5:	ldx	#$02
Le3e7:	lda	Z97,x
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
Le417:	lda	Z14
	and	#$3f
	sta	Z1e
	tay
	lda	nib_tab,y
	sta	D04d3
	lda	Z14
	asl
	asl
	lda	#$00
	rol
	bit	Z16
	bpl	Le431
	eor	#$20
Le431:	tay
	eor	Z1e
	sta	Z1e
	lda	nib_tab,y
	sta	D04d1
	lda	Z62
	bit	Z63
	bpl	Le444
	ora	#$20
Le444:	tay
	eor	Z1e
	sta	Z1e
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

Se461:	jmp	L84

Le464:	lda	#$02
	jsr	Se4e7
	lda	Z1a
	sta	Z18
Le46d:	jsr	Le103
	bcs	Le48b
	ldx	Z2a
	cpx	Z1a
	bcs	Le48b
	lda	Z2d,x
	bmi	Le48b
	lda	#$ff
	sta	Z2d,x
	jsr	Se200
	bcs	Le48b
	dec	Z18
	bne	Le46d
	clc
	rts
Le48b:	sec
	rts

Le48d:	sta	Z14

Se48f:	jmp	L7b

Le492:	ldx	Z13
	bit	Z0d,x
	bpl	Le49d
	jsr	Le4f7
	bcs	Le4c8
Le49d:	jsr	Se614
	sec
	ldx	Z13
	lda	Z0d,x
	sbc	Z14
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
Le4bb:	ldx	Z13
	lda	Z14
	sta	Z0d,x
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

Se4e2:	pha
	jsr	Se4e7
	pla

Se4e7:	sta	Z18
Le4e9:	lda	#$c8
	sta	Z17
Le4ed:	dec	Z17
	nop
	bne	Le4ed
	dec	Z18
	bne	Le4e9
	rts

Le4f7:	lda	#$01
	jsr	Se64a
	ldx	#$50
	jsr	Se4cf
	ldx	#$50
Le503:	lda	#$07
	jsr	Se4e7
	lda	#$0a
	jsr	Se640
	bpl	Le515
	dex
	bne	Le503
	sec
	bra	Le516
Le515:	clc
Le516:	ldx	Z13
	stz	Z0d,x
	rts

Se51b:	lda	#$02
	jsr	Se640
	bmi	Le568
	lda	#$09
	jsr	Se64a
	lda	#$c8
	jsr	Se4e7
	lda	#$03
	sta	Z39
	ldx	Z13
	stx	Z6f
Le534:	lda	#$0d
	jsr	Se64a
	lda	#$96
	sta	Z3b
Le53d:	lda	#$0a
	jsr	Se4e7
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
Le557:	ldx	Z13
	sec
	ror	Z6f
	sec
	ror	Z0d,x
	lda	#$fa
	sta	Z11,x
	lda	#$01
	jsr	Se4e7
Le568:	clc
	rts

Se56a:	lda	#$0b
	jsr	Se640
Le56f:	bit	D0a0e
	bmi	Le56f
	lda	Z09
	and	#$ef
	sta	D0800
	lda	Z09
	sta	D0800
	rts

Le581:	jsr	Se640
Le584:	bit	D0a0e
	bpl	Le584
	rts

Le58a:	lda	#$1f

Se58c:	tay
	lda	D0a08
	lda	D0a0d
Le593:	sty	D0a0f
	tya
	eor	D0a0e
	and	#$1f
	bne	Le593
	lda	D0a0c
	lda	D0a09
	rts

Se5a5:	ldx	#$07
	stx	Z08
Le5a9:	lda	De5bb,x
	cmp	L00,x
	beq	Le5b5
	sta	L00,x
	sec
	ror	Z08
Le5b5:	dex
	bpl	Le5a9
	bit	Z08
	rts


De5bb:	fcb	$4c,$49,$52,$4f,$4e,$4d,$53,$41	; "LIRONMSA"


Se5c3:	lda	D0801
	and	#$0c
	beq	Le5ed
	ldx	#$00
	cmp	#$08
	beq	Le5d1
	inx
Le5d1:	stx	Z13
	lda	Z0b,x
	beq	Le5dd
	jsr	Se9d0
	jsr	Se51b
Le5dd:	ldx	Z13
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
	ldx	Z13
	lda	Z11,x
	jsr	Se4e2
	lda	#$19
	sta	Z11,x
	jsr	Se4e2
Le634:	rts

Le635:	lda	#$01
	bit	Z16
	bpl	Le63d
	lda	#$11
Le63d:	jmp	Se67c

Se640:	jsr	Se654

Se643:	bit	D0a0d
	lda	D0a0e
	rts

Se64a:	jsr	Se654

Se64d:	bit	D0a07
	bit	D0a06
	rts

Se654:	bit	D0a01
	bit	D0a03
	bit	D0a04
	lsr
	bcc	Le663
	bit	D0a05
Le663:	lsr
	pha
	lda	#$01
	bcc	Le66b
	lda	#$11
Le66b:	jsr	Se67c
	pla
	lsr
	bcs	Le675
	bit	D0a00
Le675:	lsr
	bcs	Le67b
	bit	D0a02
Le67b:	rts

Se67c:	phx
	ldx	#$00
	bra	Le684

Se681:	phx
	ldx	#$01
Le684:	pha
	eor	#$0f
	ora	#$f0
	and	Z09,x
	sta	Z09,x
	pla
	lsr
	lsr
	lsr
	lsr
	ora	Z09,x
	sta	Z09,x
	sta	D0800,x
	plx
	rts

Le69b:	lda	Z50
	and	#$3f
	sta	Z15
	lda	Z50
	ldx	#$06
Le6a5:	lsr	Z51
	ror
	dex
	bne	Le6a5
	ldx	Z13
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
	ldx	Z13
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
Le6d3:	sty	Z14
	sta	Z15
	bit	Z0f,x
	bpl	Le6dd
	lsr	Z14
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
	ldx	Z13
	bit	Z0f,x
	bpl	Le747
	inc
Le747:	tax
	lda	Z50
	cmp	De75d,x
	lda	Z51
	sbc	De75d+2,x
	lda	Z52
	sbc	#$00
	bcc	Le75c
	lda	#$ad
	sta	Z5e
Le75c:	rts


De75d:	jsr	S0340
	fcb	$06	; ASL opcode

	
reset:	sei
	cld
	ldx	#$ff
	txs
	jsr	Se7c5
	jsr	Se7bc
	stz	Z6a
	stz	Z6b
	jsr	Se5a5
	bpl	Le78b
	sec
	ror	Z6f
	stz	Z6e
	lda	#$fa
	sta	Z11
	sta	Z12
	jsr	Se7d9
	lda	#$e6
	jsr	Se4e7
	jsr	Se9ef
Le78b:	bit	Z6f
	bmi	Le799
	ldx	Z6f
	stx	Z13
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
	jsr	Se822
	jsr	Seb08
	bra	Le79c

Se7bc:	lda	#$04
	sta	Z62
	lda	#$80
	sta	Z63
	rts

Se7c5:	lda	#$10
	sta	Z09
	sta	D0800
	lda	#$00
	sta	D0801
	lda	#$1c
	sta	Z0a
	sta	D0801
	rts

Se7d9:	ldx	#ram_vec_tab_len - 1
Le7db:	lda	ram_vec_tab,x
	sta	Z70,x
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
	jmp	Le106
	jmp	Le203
	jmp	Lef03
	jmp	Le492
	jmp	Le2cf
	jmp	Le317
	jmp	Le464
	jmp	Le825
	rts
	nop
	nop
ram_vec_tab_len	equ	*-ram_vec_tab


ram_data_tab:
	fcb	$ff,$ad,$aa,$d5,$ff,$fc,$f3,$cf
	fcb	$3f,$ff,$ff,$aa,$de,$ff,$ff,$ff
	fcb	$ff,$ff,$96,$aa,$d5,$ff
ram_data_tab_len	equ	*-ram_data_tab


Se822:	jmp	L87

Le825:	lda	Z3d
	bne	Le837
	ldx	#$00
	lda	Z55
	cmp	Z0b
	beq	Le832
	inx
Le832:	stx	Z13
	jsr	Se9d0
Le837:	lda	Z4c
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
	lda	Z4c
	cmp	#$0a
	bcc	Le857
Le852:	lda	#$81
	sta	Z5e
	rts
Le857:	tax
	lda	De892,x
	and	#$7f
	cmp	Z4d
	beq	Le872
	lda	De892,x
	bpl	Le86d
	lda	#$00
	ldx	#$e0
	jsr	Sed01
Le86d:	lda	#$84
	sta	Z5e
	rts

Le872:	txa
	asl
	tax
	lda	De87e+1,x
	pha
	lda	De87e,x
	pha
Le87d:	rts


De87e:	fdb	Led46-1
	fdb	Le89c-1
	fdb	Le89f-1
	fdb	Le2cc-1
	fdb	Lecc5-1
	fdb	Le947-1
	fdb	Le852-1
	fdb	Le852-1
	fdb	Le96e-1
	fdb	Le987-1


De892:	fcb	$03,$03,$83,$01,$83,$02,$01,$01
	fcb	$04,$84


Le89c:	clc
	bra	Le8b2

Le89f:	ldx	#$0b
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
Le8d0:	jsr	Se48f
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
Le8e7:	jsr	Le103
	bcs	Le8db
	lda	Z29
	sta	Z17
	lda	Z2b
	asl
	asl
	lsr	Z17
	ror
	lsr
	cmp	Z14
	beq	Le907
	ldx	Z13
	sta	Z0d,x
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
	lda	Z4c
	cmp	#$01
	bne	Le942
	jsr	Se200
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
Le942:	jsr	Sef00
	clc
	rts

Le947:	lda	Z3d
	bne	Le94c
	rts
Le94c:	stz	Z13
	ldy	Z55
	lda	Z0b
	beq	Le95a
	bmi	Le95a
	sty	Z0b
	bra	Le95e
Le95a:	sty	Z0c
	inc	Z13
Le95e:	dec	Z3d
	bne	Le96d
	lda	#$10
	bit	D0800
	beq	Le96d
	lda	#$c0
	sta	Z5e
Le96d:	rts

Le96e:	jsr	Se998
	lda	#$01
	sta	Z4c
	jsr	Le89c
	bcs	Le986
	lda	#$00
	sta	Z25
	lda	#$02
	sta	Z26
	lda	#$0c
	sta	Z3f
Le986:	rts

Le987:	lda	#$00
	ldx	#$02
	jsr	Sed01
	jsr	Se998
	lda	#$02
	sta	Z4c
	jmp	Le8ae

Se998:	ldx	#$00
Le99a:	lda	Z52,x
	sta	Z50,x
	inx
	cpx	#$03
	bcc	Le99a
	rts

Se9a4:	lda	#$80
	sta	Z0f
	sta	Z10
	stz	Z0b
	stz	Z0c
	stz	Z3d
	ldx	#$01
	stx	Z13
Le9b4:	jsr	Se9d5
	lda	#$0d
	jsr	Se640
	bmi	Le9c4
	inc	Z3d
	lda	#$40
	sta	Z0b,x
Le9c4:	dex
	stx	Z13
	bpl	Le9b4
	jmp	Se9ea


	fcb	$23,$22


Se9ce:	ldx	Z13

Se9d0:	sec
	lda	Z0b,x
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

Se9ef:	stz	Z13
Le9f1:	ldx	Z13
	jsr	Se9d5
	lda	#$0d
	jsr	Se640
	bmi	Lea11
	lda	#$02
	jsr	Se640
	bmi	Lea11
	jsr	Se614
	jsr	Le103
	bit	Z17
	bpl	Lea11
	jsr	Se51b
Lea11:	inc	Z13
	lda	Z13
	cmp	#$02
	bcc	Le9f1
	sec
	ror	Z6e
	rts

Sea1d:	lda	#$80
	sta	Z19
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
Lea3c:	jsr	Seaf0
	bcs	Lea69
	cmp	#$c3
	bne	Lea3c
	stz	Z1e
	jsr	Seae4
	sta	Z55
	cmp	Z0b
	beq	Lea5f
	cmp	Z0c
	beq	Lea5f
	lda	Z3d
	bne	Lea5f
	lda	#$03
	jsr	Se681
	bra	Lea69
Lea5f:	jsr	Seae4
	jsr	Seae4
	cmp	Z19
	beq	Lea74
Lea69:	lda	D0a0d
Lea6c:	lda	D0a0e
	bmi	Lea6c
	jmp	Lea39
Lea74:	jsr	Seae4
	jsr	Seae4
	jsr	Seae4
	and	#$7f
	sta	Z2c
	jsr	Seae4
	and	#$7f
	sta	Z18
	ldy	#$00
	inc	Z18
	ldx	Z2c
	bne	Lea96
	dec	Z18
	beq	Leabb
Lea94:	ldx	#$07
Lea96:	lda	D0a0c
	bpl	Lea96
	asl
	sta	Z17
Lea9e:	lda	D0a0c
	bpl	Lea9e
	asl	Z17
	bcs	Leaa9
	eor	#$80
Leaa9:	sta	(Z25),y
	eor	Z1e
	sta	Z1e
	iny
	bne	Leab4
	inc	Z26
Leab4:	dex
	bne	Lea9e
	dec	Z18
	bne	Lea94
Leabb:	jsr	Seaf0
	sta	Z17
	jsr	Seaf0
	sec
	rol
	and	Z17
	cmp	Z1e
	bne	Leafd
	jsr	Seaf0
	cmp	#$c8
	bne	Leafd
	lda	D0a00
	lda	#$88
	jsr	Se67c
	lda	D0a0d
Leadd:	lda	D0a0e
	bmi	Leadd
	clc
	rts

Seae4:	lda	D0a0c
	bpl	Seae4
	pha
	eor	Z1e
	sta	Z1e
	pla
	rts

Seaf0:	ldy	#$14
	clc
Leaf3:	lda	D0a0c
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

Seb08:	lda	#$81
	sta	Z19
Leb0c:	jsr	Sec3a
	jsr	Sec84
	jsr	Seca4
	jsr	Sebfd
	lda	D0a01
	jsr	Sec25
	bcs	Leafc
	lda	#$ff
	bit	D0a0d
	sta	D0a0f
	ldy	#$0a
Leb2a:	lda	Debe1,y
	jsr	Sebf2
	dey
	bpl	Leb2a
	stz	Z1e
	lda	#$80
	jsr	Sebec
	ldx	Z13
	lda	Z0b,x
	jsr	Sebec
	lda	Z19
	jsr	Sebec
	lda	#$80
	jsr	Sebec
	lda	Z5e
	jsr	Sebec
	lda	Z2c
	jsr	Sebec
	lda	Z18
	jsr	Sebec
	lda	Z2c
	beq	Leb6f
	ldy	#$00
	lda	Z3e
	jsr	Sebf2
Leb65:	lda	(Z25),y
	jsr	Sebec
	iny
	cpy	Z2c
	bcc	Leb65
Leb6f:	lda	Z18
	beq	Leba8
	ldy	#$00
Leb75:	lda	Z17
	ora	#$80
Leb79:	bit	D0a0c
	bpl	Leb79
	sta	D0a0d
	ldx	#$06
Leb83:	lda	Z43,x
	eor	Z1e
	sta	Z1e
	lda	Z43,x
	ora	#$80
Leb8d:	bit	D0a0c
	bpl	Leb8d
	sta	D0a0d
	lda	(Z41),y
	sta	Z43,x
	asl
	rol	Z17
	iny
	bne	Leba1
	inc	Z42
Leba1:	dex
	bpl	Leb83
	dec	Z18
	bne	Leb75
Leba8:	lda	Z1e
	ora	#$aa
	jsr	Sebf2
	lda	Z1e
	lsr
	ora	#$aa
	jsr	Sebf2
	lda	#$c8
	jsr	Sebf2
Lebbc:	lda	D0a0c
	and	#$40
	bne	Lebbc
	lda	D0a00
	lda	D0a0e
	lda	D0a0d
	clc
	ldx	#$64
Lebcf:	dex
	bne	Lebd3
	sec
Lebd3:	lda	D0a0e
	bmi	Lebcf
	lda	D0a0c
	bcc	Lebe0
	jmp	Leb0c
Lebe0:	rts


Debe1:	fcb	$c3,$ff,$fc,$f3,$cf,$3f,$ff,$fc
	fcb	$f3,$cf,$3f


Sebec:	pha
	eor	Z1e
	sta	Z1e
	pla

Sebf2:	ora	#$80
Lebf4:	bit	D0a0c
	bpl	Lebf4
	sta	D0a0d
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
	lda	D0a0d
	lda	D0a0e
	bpl	Sec08
	rts

Sec25:	ldx	#$00
	ldy	#$14
Lec29:	clc
	lda	D0a0d
	lda	D0a0e
	bmi	Lec39
	sec
	inx
	bne	Lec29
	iny
	bne	Lec29
Lec39:	rts

Sec3a:	ldx	Z40
	lda	Dec72,x
	sta	Z18
	lda	Dec75,x
	sta	Z2c
	ldx	#$05
	lda	Z3f
	sta	Z17
	and	#$07
	tay
Lec4f:	asl	Z17
	bcc	Lec68
	lda	Dec7e,x
Lec56:	clc
	adc	Z2c
	cmp	#$07
	bcc	Lec5f
	sbc	#$07
Lec5f:	sta	Z2c
	lda	Dec78,x
	adc	Z18
	sta	Z18
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


Sec84:	ldy	Z2c
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
	lda	Z2c
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

Lecc5:	lda	Z50
	cmp	#$08
	bcc	Lecd0

Leccb:	lda	#$a1
	sta	Z5e
	rts
Lecd0:	asl
	tax
	lda	Decdb+1,x
	pha
	lda	Decdb,x
	pha
	rts


Decdb:	fdb	Lecf1-1
	fdb	Leceb-1
	fdb	Leceb-1
	fdb	Leceb-1
	fdb	Lecf7-1
	fdb	Led0f-1
	fdb	Led38-1
	fdb	Led31-1


Leceb:	jsr	Secfd
	jmp	Leccb
Lecf1:	jmp	Se7d9
	jmp	Secfd
Lecf7:	jsr	Secfd
	jmp	Se51b


Secfd:	lda	#$00
	ldx	#$02

Sed01:	sta	Z25
	stx	Z26
	lda	#$82
	sta	Z19
	jsr	Sea29
	jmp	Se9ce

Led0f:	jsr	Secfd
	lda	D0203
	pha
	lda	D0200
	ldx	D0201
	ldy	D0202
	plp
	jsr	Sed2e
	php
	sta	Z59
	stx	Z5a
	sty	Z5b
	pla
	sta	Z5c
	rts

Sed2e:	jmp	(D0204)

Led31:	lda	Z64
	ldx	Z65
	jmp	Sed01

Led38:	jsr	Secfd
	lda	D0200
	sta	Z64
	lda	D0201
	sta	Z65
	rts

Led46:	lda	#$00
	sta	Z25
	lda	#$02
	sta	Z26
	lda	Z50
	cmp	#$06
	bcc	Led57
	jmp	Leccb

Led57:	asl
	tax
	lda	Ded62+1,x
	pha
	lda	Ded62,x
	pha
	rts


Ded62:	fdb	Leda3-1
	fdb	Leccb-1
	fdb	Leccb-1
	fdb	Led6e-1
	fdb	Leccb-1
	fdb	Led96-1


Led6e:	jsr	Leda3
	ldx	#$14
Led73:	lda	Ded81,x
	sta	D0204,x
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
	ldx	Z13
	bit	Z0f,x
	bmi	Ledcc
	lda	#$20
	ldy	#$03
Ledcc:	sta	D0201
	sty	D0202
	stz	D0203
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

Sef00:	jmp	L78

Lef03:	bit	D0a0d
	lda	#$ff
	sta	D0a0f
	ldx	#$07
Lef0d:	lda	Z8e,x
Lef0f:	bit	D0a0c
	bpl	Lef0f
	sta	D0a0d
	dex
	bpl	Lef0d
	ldy	Z2a
	lda	nib_tab,y
	jsr	Sebf2
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
	sta	D0a0d
Lef39:	ldy	Z66
	lda	nib_tab,y
Lef3e:	bit	D0a0c
	bpl	Lef3e
	sta	D0a0d
	ldy	Z67
	lda	D0100,x
	sta	Z67
	asl
	rol	Z66
	asl
	rol	Z66
	lda	nib_tab,y
	sta	D0a0d
	ldy	Z68
	lda	D0640,x
	sta	Z68
	asl
	rol	Z66
	asl
	rol	Z66
	lda	nib_tab,y
	sta	D0a0d
	dex
	cpx	#$ff
	bne	Lef26
	ldx	#$03
Lef73:	lda	Z1f,x
	and	#$3f
	tay
	lda	nib_tab,y
Lef7b:	bit	D0a0c
	bpl	Lef7b
	sta	D0a0d
	dex
	bpl	Lef73
	ldx	#$02
Lef88:	lda	Z97,x
Lef8a:	bit	D0a0c
	bpl	Lef8a
	sta	D0a0d
	dex
	bpl	Lef88
Lef95:	bit	D0a0c
	bvs	Lef95
	bit	D0a0e
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
	jsr	Se48f
	jsr	Se56a
	jsr	Se162
	lda	#$02
	sta	Z26
	stz	Z25
	ldy	#$00
Lf03b:	lda	D0a0c
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
	inc	Z18
Lf094:	lda	Z18
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
	sta	Z18
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
	jsr	Se48f
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
	bit	D0a0e
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
	stz	Z14
Lf152:	jsr	Se48f
Lf155:	jsr	Sf169
	lda	#$80
	eor	Z16
	sta	Z16
	bmi	Lf155
	inc	Z14
	lda	Z14
	cmp	#$50
	bcc	Lf152
	rts

Sf169:	jsr	Se56a
	jsr	Le635
	ldy	#$27
	ldx	#$10
	lda	Z4b
	sta	D0a0f
Lf178:	bit	D0a0c
	bpl	Lf178
	sta	D0a0d
	dex
	bne	Lf178
	dey
	bne	Lf178
	bit	D0a0c
	bit	D0a0e
	rts

Lf18d:	jsr	Le4f7
	lda	#$4f
	sta	Z14
	jsr	Se48f
	jsr	Se56a
	jmp	Lf18d

	fillto	$fea0,$ff

	fcb	"(C) 1985 Apple Computer, Inc.",$0d,$0d
	fcb	"The firmware was written by Michael Askins.",$0d,$0d
	fcb	"The Liron design team was:",$0d
	fcb	" Josef Friedman, manager",$0d
	fcb	" Cheng Lin, hardware",$0d
	fcb	" Michael Askins, software",$0d
	fcb	" Cecilia Arboleya, tech support",$0d
	fcb	" Cameron Birse, tech support",$0d,$0d
	fcb	$00

	fillto	$ffa0,$ff

	jmp	Lf0f9
	jmp	Le48d
	jmp	Le69b
	jmp	Se6e0
	jmp	Le89c
	jmp	Le89f
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
