; Apple II Liron Disk Controller Card firmware
; Firmware P/N 341-????
; Copyright 2017 Eric Smith <spacewar@gmail.com>

	cpu	6502

fillto	macro	addr, val
	while	* < addr
size	set	addr-*
	if	size > 256
size	set	256
	endif
	fcb	[size] val
	endm
	endm

fcchz	macro	string
	irpc	char,string
	fcb	$80+'char'
	endm
	fcb	$00
	endm


; SmartPort bus commands
sp_cmd_status	equ	$00
sp_cmd_readblk	equ	$01	; block device only
sp_cmd_writeblk	equ	$02	; block device only
sp_cmd_format	equ	$03	; block device only
sp_cmd_control	equ	$04
sp_cmd_init	equ	$05	; used to assign unit number
sp_cmd_open	equ	$06	; character device only
sp_cmd_close	equ	$07	; character device only
sp_cmd_read	equ	$08	; character device only
sp_cmd_write	equ	$09	; character device only


Z00		equ	$00
Z01		equ	$01

mon_ch		equ	$24
mon_cv		equ	$25

checksum	equ	$40
Z40		equ	$40
Z41		equ	$41


prodos_cmd_blk	equ	$42

prodos_command	equ	$42	; Smartport command is also copied here
prodos_unit_num	equ	$43
prodos_buffer	equ	$44
prodos_block	equ	$46

Z48		equ	$48
Z4b		equ	$4b
Z4c		equ	$4c
Z4d		equ	$4d
Z4e		equ	$4e
Z4f		equ	$4f
Z50		equ	$50
Z51		equ	$51
Z52		equ	$52
Z53		equ	$53
Z54		equ	$54
Z55		equ	$55
Z56		equ	$56
Z57		equ	$57
slot		equ	$58
Z59		equ	$59
Z5a		equ	$5a
Z5b		equ	$5b


; per-slot screen holes (index by slot)
sh_prodos_flag	equ	$0478	; MSB = 1 for ProDOS, 0 for SmartPort
sh_04f8		equ	$04f8
sh_0578		equ	$0578
sh_05f8		equ	$05f8
sh_0678		equ	$0678
sh_magic1	equ	$06f8	; $a5 if firmware initialized
sh_magic2	equ	$0778	; $5a if firmware initialized
unit_count		equ	$07f8


; global screen holes - undocumented
; these seem to be used as temporaries
gh_06f8		equ	$06f8
; note - 06f8 is used by Apple DOS RWTS for RECLBCNT (recal counter),
;        not needed between RWTS calls

gh_0778		equ	$0778

; global screen holes - documented
gh_shared_slot	equ	$07f8	; $Cn if card in slot n $c800 ROM active
				; needed for interrupt handling


D0800		equ	$0800
L0801		equ	$0801


basic_cold	equ	$e000


mon_sloop	equ	$faba
mon_vtab	equ	$fc22
mon_cout	equ	$fded
mon_setkbd	equ	$fe89
mon_setvid	equ	$fe93


iwm_ph_0_off	equ   $c080
iwm_ph_0_on	equ   $c081
iwm_ph_1_off	equ   $c082
iwm_ph_1_on	equ   $c083
iwm_ph_2_off	equ   $c084
iwm_ph_2_on	equ   $c085
iwm_ph_3_off	equ   $c086
iwm_ph_3_on	equ   $c087
iwm_motor_off	equ   $c088
iwm_motor_on	equ   $c089
iwm_sel_drive_1	equ   $c08a
iwm_sel_drive_2	equ   $c08b
iwm_q6l		equ   $c08c
iwm_q6h		equ   $c08d
iwm_q7l		equ   $c08e
iwm_q7h		equ   $c08f


rom_dis	equ	$cfff


	org	$c000

; unknown data, not visible in Apple II address space, possibly garbage
	fcb	$c6,$e9,$f2,$ed,$f7,$e1,$f2,$e5
	fcb	$a0,$f7,$f2,$e9,$f4,$f4,$e5,$ee
	fcb	$a0,$e2,$f9,$a0,$cd,$e9,$e3,$e8
	fcb	$e1,$e5,$ec,$a0,$c1,$f3,$eb,$e9
	fcb	$ee,$f3,$00
	fillto	$c100,$ff

; Cnxx slot ROM is replicated for all seven slots, and is identical
; other than slot number references and slot I/O references
	irp	slotnum, 1, 2, 3, 4, 5, 6, 7

	org	$c000 + (slotnum << 8)

; firmware boot entry point
	ldx	#$20
	ldx	#$00
	ldx	#$03
	cmp	#$00
	bcs	Lcn14

prodos_entry:
	sec
	bcs	Lcn0e

smartport_entry:
	clc

; combined ProDOS/SmartPort dispatch
; save ProDOS/SmartPort flag (1 = ProDOS) in MSB of sh_prodos_flag
Lcn0e:	ldx	#slotnum
	ror	sh_prodos_flag,x
	clc

; combined ProDOS/SmartPort/boot dispatch
; carry = 1 for boot, 0 for ProDOS/SmartPort
Lcn14:	ldx	#$c0 + slotnum
	stx	gh_shared_slot
	ldx	#slotnum
	lda	rom_dis
	jmp	shared_rom_entry


; shared ROM space jumps here
Lcn21:	ldy	#$00
	lda	Z4b
	pha
	bne	Lcn2b
	jmp	Lcnb8

Lcn2b:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn2b
	sta	Z59
	lsr
	lsr
	lsr
	and	#$0f
	tax
	lda	Z59
	and	#$07
	sta	Z59

Lcn3e:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn3e
	eor	Dca27,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny
	bne	Lcn51
	inc	Z57

Lcn51:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn51
	eor	Dca37,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny

Lcn60:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn60
	eor	Dca47,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny

Lcn6f:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn6f
	eor	Dca57,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny
	bne	Lcn82
	inc	Z57

Lcn82:	ldx	Z59
Lcn84:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn84
	eor	Dca37,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny

Lcn93:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcn93
	eor	Dca47,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny

Lcna2:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcna2
	eor	Dca57,x
	sta	(Z56),y
	eor	checksum
	sta	checksum
	iny
	dec	Z4b
	beq	Lcnb8
	jmp	Lcn2b

Lcnb8:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcnb8
	sta	Z59
	pla
	sta	Z4b

Lcnc2:	lda	iwm_q6l + (slotnum << 4)
	bpl	Lcnc2
	sec
	rol
	and	Z59
	eor	checksum

Lcncd:	ldy	iwm_q6l + (slotnum << 4)
	bpl	Lcncd
	cpy	#$c8
	bne	Lcnf2
	ldx	Z4c
	beq	Lcne2

	ldy	#$00
Lcndc:	eor	(Z54),y
	iny
	dex
	bne	Lcndc

Lcne2:	tax
	bne	Lcnf6
	lda	iwm_q6h + (slotnum << 4)

Lcne8:	lda	iwm_q7l + (slotnum << 4)
	bmi	Lcne8

	lda	iwm_ph_0_off + (slotnum << 4)

	clc
	rts

Lcnf2:	lda	#$20
	bne	Lcnf8		; always taken

Lcnf6:	lda	#$10
Lcnf8:	sec
	rts


;	fillto	slot_fw + $fb, $ff
	fcb	$ff		; unused

	fcb	$00		; SmartPort type

	fdb	$0000		; ProDOS block count (status call required)

	fcb	$bf		; ProDOS characteristics
	
	fcb	prodos_entry & $0ff

	endm

Sc800:	jsr	Scaee
	jsr	smartport_bus_enable
	ldy	#$07
	jsr	Scba9

	lda	iwm_sel_drive_2,x
	lda	iwm_motor_on,x
	ldy	#$32
Lc813:	lda	iwm_q7l,x
	bmi	Lc81f
	dey
	bne	Lc813
	sec
	jmp	Lc949


; send packet sync sequence
Lc81f:	lda	iwm_ph_0_on,x	; turn on REQ

	ldy	#packet_sync_sequence_len - 1
	lda	#$ff
	sta	iwm_q7h,x	; set write mode
Lc829:	lda	packet_sync_sequence,y
Lc82c:	asl	iwm_q6l,x
	bcc	Lc82c
	sta	iwm_q6h,x
	dey
	bpl	Lc829

	lda	Z5a		; destination ID
	ora	#$80
	jsr	send_nib7

	jsr	send_80		; source address, always $80 (host)

	lda	Z5b		; packet type
	jsr	send_nib7

	jsr	send_80		; aux type

	jsr	send_80		; data statys byte

	lda	Z4c		; length of packet "odd bytes", 0-6
	ora	#$80
	jsr	send_nib7

	lda	Z4b		; number of encoded 7-byte groups
	ora	#$80
	jsr	send_nib7

	lda	Z4c		; any "odd bytes"?
	beq	Lc873		;   no, skip

; send "odd bytes"
	ldy	#$ff
	lda	Z59
Lc862:	asl	iwm_q6l,x
	bcc	Lc862
	sta	iwm_q6h,x
	iny
	lda	(Z54),y
	ora	#$80
	cpy	Z4c
	bcc	Lc862

; send groups
Lc873:	lda	Z4b		; any groups to send?
	bne	Lc87a		;   yes

	jmp	send_checksum	;   no

Lc87a:	nop
	ldy	#$00

; send a group
Lc87d:	lda	Z41
	sta	iwm_q6h,x
	lda	Z4d
	ora	#$80
	sty	Z59
Lc888:	ldy	iwm_q6l,x
	bpl	Lc888
	sta	iwm_q6h,x
	ldy	Z59
	lda	(Z56),y
	sta	Z4d
	asl
	rol	Z41
	iny
	bne	Lc8a1
	inc	Z57
	jmp	Lc8a3

Lc8a1:	pha
	pla
Lc8a3:	lda	#$02
	ora	Z41
	sta	Z41
	lda	Z4e
	ora	#$80
	sta	iwm_q6h,x
	lda	(Z56),y
	sta	Z4e
	asl
	rol	Z41
	iny
	lda	Z4f
	ora	#$80
	sta	iwm_q6h,x
	lda	(Z56),y
	sta	Z4f
	asl
	rol	Z41
	iny
	lda	Z50
	ora	#$80
	sta	iwm_q6h,x
	lda	(Z56),y
	sta	Z50
	asl
	rol	Z41
	iny
	bne	Lc8dd
	inc	Z57
	jmp	Lc8df
Lc8dd:	pha
	pla
Lc8df:	lda	Z51
	ora	#$80
	sta	iwm_q6h,x
	lda	(Z56),y
	sta	Z51
	asl
	rol	Z41
	iny
	lda	Z52
	ora	#$80
	sta	iwm_q6h,x
	lda	(Z56),y
	sta	Z52
	asl
	rol	Z41
	iny
	lda	Z53
	ora	#$80
	sta	iwm_q6h,x
	lda	(Z56),y
	sta	Z53
	asl
	rol	Z41
	iny

	dec	Z4b		; sent last group?
	beq	send_checksum	;   yes

	jmp	Lc87d		;   no, send another group


; send checksum in FM
send_checksum:
; send checksum even bits (bit 6, 4, 2, 0)
	lda	checksum
	ora	#$aa

; can't call send_nib7 to send the first part of the checksum, because
; it would modify the checksum in the process

Lc917:	ldy	iwm_q6l,x	; wait for write buffer ready
	bpl	Lc917

	sta	iwm_q6h,x	; write data

; send checksum odd bits (bit 7, 5, 3, 1, shifted right one bit)
	lda	checksum
	lsr
	ora	#$aa
	jsr	send_nib7

	lda	#$c8		; send packet end mark
	jsr	send_nib7

; wait for write underrun; IWM write state will clear when
; done writing and no data presented
Lc92c:	lda	iwm_q6l,x	; read IWM handshake register
	and	#$40		; in write state?
	bne	Lc92c		;   yes, loop

	sta	iwm_q6h,x	; prepare to read status register

	ldy	#$0a		; counter to wait for ACK
Lc938:	dey			; timeout?
	bne	Lc943		; no, go check status

	lda	#$01
Sc93d:	jsr	get_slot_x
	sec			; indicate error
	bcs	Lc949		; always taken

Lc943:	lda	iwm_q7l,x	; read status
	bmi	Lc938		; ACK (write protect)? no, keep waiting

	clc			; yes, so no error
	
Lc949:	lda	iwm_ph_0_off,x	; turn off REQ
	lda	iwm_q6l,x
	rts


; packet sync byte sequence, in reverse order
packet_sync_sequence:
	fcb	$c3,$ff,$fc,$f3,$cf,$3f
packet_sync_sequence_len equ *-packet_sync_sequence


	jsr	Sc95b
	nop
	nop
Sc95b:	nop
	rts

Lc95d:	jmp	Sc93d

Sc960:	lda	#$00
	sta	checksum
	lda	Z54
	sta	Z56
	lda	Z55
	sta	Z57

	lda	#$21	; point Z52 at LCn21 for later continuation of execution
	sta	Z52
	lda	slot
	clc
	adc	#$c0
	sta	Z53

	jsr	smartport_bus_enable

	lda	iwm_q6h,x
Lc97d:	lda	iwm_q7l,x
	bpl	Lc97d
	lda	iwm_ph_0_on,x
	ldy	#$1e
Lc987:	lda	iwm_q6l,x
	bpl	Lc987
	dey
	bmi	Lc95d
	cmp	#$c3
	bne	Lc987
	ldy	#$06
Lc995:	lda	iwm_q6l,x
	bpl	Lc995
	and	#$7f
	sta	Z4b,y
	eor	#$80
	eor	checksum
	sta	checksum
	dey
	bpl	Lc995
	lda	Z4c
	beq	Lc9d3
	clc
	adc	Z54
	sta	Z56
	lda	Z55
	adc	#$00
	sta	Z57
	ldy	#$00
Lc9b9:	lda	iwm_q6l,x
	bpl	Lc9b9
	asl
	sta	Z41
Lc9c1:	lda	iwm_q6l,x
	bpl	Lc9c1
	asl	Z41
	bcs	Lc9cc
	eor	#$80
Lc9cc:	sta	(Z54),y
	iny
	cpy	Z4c
	bcc	Lc9c1
Lc9d3:	jmp	(Z52)		; continue from slot ROM space


send_80:
	lda	#$80

send_nib7:
	ldy	iwm_q6l,x
	bpl	send_nib7
	sta	iwm_q6h,x
	eor	checksum
	sta	checksum
	rts


reset_smartport_bus:
	jsr	smartport_bus_disable
	lda	iwm_ph_0_on,x
	lda	iwm_ph_2_on,x

	ldy	#80		; delay 80ms
	jsr	delay_y_ms

	jsr	smartport_bus_disable
	ldy	#10		; delay 10ms and return

delay_y_ms:
	jsr	delay_1ms
	dey
	bne	delay_y_ms
	rts

delay_1ms:
	ldx	#200
delay_1ms_loop:
	dex
	bne	delay_1ms_loop
	rts


smartport_bus_enable:
	jsr	get_slot_x
	lda	iwm_ph_1_on,x
	lda	iwm_ph_3_on,x
	rts


smartport_bus_disable:
	jsr	get_slot_x
	lda	iwm_ph_0_off,x
	lda	iwm_ph_1_off,x
	lda	iwm_ph_2_off,x
	lda	iwm_ph_3_off,x
	rts


get_slot_x:
	lda	slot
	asl
	asl
	asl
	asl
	tax
	rts


Dca27:	fcb	$80,$80,$80,$80,$80,$80,$80,$80
	fcb	$00,$00,$00,$00,$00,$00,$00,$00

Dca37:	fcb	$80,$80,$80,$80,$00,$00,$00,$00
	fcb	$80,$80,$80,$80,$00,$00,$00,$00

Dca47:	fcb	$80,$80,$00,$00,$80,$80,$00,$00
	fcb	$80,$80,$00,$00,$80,$80,$00,$00

Dca57:	fcb	$80,$00,$80,$00,$80,$00,$80,$00
	fcb	$80,$00,$80,$00,$80,$00,$80,$00


Sca67:	lda	#$05
	ldy	#$00
	jsr	Sca8a
	bcc	Lca75
	lda	#$80
	jsr	Scded
Lca75:	rts

Sca76:	jsr	Sca8a
	bcc	Lca75
	lda	#$80
	jsr	Scded

	lda	gh_06f8
	sta	Z4d
	lda	gh_0778
	sta	Z4e

Sca8a:	lda	#3000 & $ff	; retry 3000 times!
	ldy	#3000 >> 8
	ldx	slot
	sta	sh_04f8,x
	tya
	sta	sh_0578,x

Lca97:	lda	Z4d
	sta	gh_06f8
	lda	Z4e
	sta	gh_0778

	jsr	Sc800

	lda	gh_06f8
	sta	Z4d
	lda	gh_0778
	sta	Z4e

	bcc	Lcabc		; if no error, done

	ldx	slot		; decrement retry count
	dec	sh_04f8,x
	bne	Lca97
	dec	sh_0578,x
	bpl	Lca97

Lcabc:	rts


Scabd:	ldy	slot
	lda	#$05
	sta	sh_04f8,y
Lcac4:	jsr	Sc960
	bcc	Lcad8

	ldy	#1
	jsr	delay_y_ms

	jsr	Sc93d
	ldx	slot
	dec	sh_04f8,x
	bne	Lcac4
Lcad8:	rts


Dcad9:	fcb	$00,$24,$49
Dcadc:	fcb	$00,$04,$01
Dcadf:	fcb	$00,$01,$02,$04,$09,$12
Dcae5:	fcb	$00,$01,$02,$04,$01,$02
Dcaeb:	fcb	$00,$7f,$ff


Scaee:	ldx	Z4e
	beq	Lcb05
	lda	Z55
	sta	Z57
	lda	#$80
	cpx	#$01
	beq	Lcb00
	inc	Z57
	lda	#$00
Lcb00:	clc
	adc	Z54
	sta	Z56
Lcb05:	lda	Dcad9,x
	sta	Z4b
	lda	Dcadc,x
	sta	Z4c
	ldx	#$05
	lda	Z4d
	sta	Z59
	and	#$07
	tay
Lcb18:	asl	Z59
	bcc	Lcb31
	lda	Dcae5,x
Lcb1f:	clc
	adc	Z4c
	cmp	#$07
	bcc	Lcb28
	sbc	#$07
Lcb28:	sta	Z4c
	lda	Dcadf,x
	adc	Z4b
	sta	Z4b
Lcb31:	dex
	bmi	Lcb3a
	bne	Lcb18
	tya
	jmp	Lcb1f
Lcb3a:	lda	Z55
	pha
	lda	#$00
	ldx	Z4e
	beq	Lcb59
	ldy	Dcaeb,x
Lcb46:	eor	(Z54),y
	eor	(Z56),y
	dey
	bne	Lcb46
	eor	(Z54),y
	eor	(Z56),y
	cpx	#$01
	beq	Lcb57
	inc	Z55
Lcb57:	inc	Z55
Lcb59:	ldy	Z4d
	beq	Lcb66
	eor	(Z54),y
Lcb5f:	eor	(Z54),y
	dey
	bne	Lcb5f
	eor	(Z54),y
Lcb66:	sta	checksum
	pla
	sta	Z55
	ldy	Z4c
	dey
	lda	#$00
	sta	Z59
Lcb72:	lda	(Z54),y
	asl
	ror	Z59
	dey
	bpl	Lcb72
	sec
	ror	Z59
	lda	Z4c
	clc
	adc	Z54
	sta	Z56
	lda	Z55
	adc	#$00
	sta	Z57
	ldy	#$06
Lcb8c:	sec
	lda	(Z56),y
	sta	Z4d,y
	bmi	Lcb95
	clc
Lcb95:	ror	Z41
	dey
	bpl	Lcb8c
	sec
	ror	Z41
	lda	Z56
	clc
	adc	#$07
	sta	Z56
	bcc	Lcba8
	inc	Z57
Lcba8:	rts

Scba9:	lda	iwm_motor_off,x
	lda	iwm_q6h,x
	jmp	Lcbb6
Lcbb2:	tya
	sta	iwm_q7h,x
Lcbb6:	tya
	eor	iwm_q7l,x
	and	#$1f
	bne	Lcbb2
	rts

Scbbf:	lda	Z4b
	tay
	ldx	#$00
	stx	Z4b
	ldx	#$03
Lcbc8:	asl
	rol	Z4b
	dex
	bne	Lcbc8
	clc
	adc	Z4c
	bcc	Lcbd5
	inc	Z4b
Lcbd5:	sty	Z4c
	sec
	sbc	Z4c
	bcs	Lcbde
	dec	Z4b
Lcbde:	ldy	Z4b
	rts


shared_rom_entry:
	bcc	execute_command
	jmp	boot

execute_command:
	cld
	txa
	tay

	lda	sh_prodos_flag,y		; ProDOS or SmartPort?
	bmi	Lcbff

; SmartPort only
	pla			; save ptr to SmartPort cmd num (offset 1)
	sta	sh_05f8,y

	clc			; advance past cmd num and parm list ptr (low byte)
	adc	#$03
	tax

	pla			; save ptr to SmartPort cmd num (offset 1)
	sta	sh_0678,y

	adc	#$00		; advance past cmd num and parm list ptr (high byte)

	pha			; push advanced return address back onto stack
	txa
	pha

; continue here whether SmartPort or ProDOS
Lcbff:	php
	sei

; save zero page $40..$5b onto stack
	ldx	#$1b
Lcc03:	lda	Z40,x
	pha
	dex
	bpl	Lcc03

	sty	slot

	lda	sh_magic1,y	; has card been initialized?
	cmp	#$a5
	bne	Lcc19
	eor	#$ff
	eor	sh_magic2,y
	beq	Lcc1e

Lcc19:	lda	#$00
	jsr	Scded

Lcc1e:	lda	prodos_unit_num
	rol
	php
	rol
	rol
	plp
	rol
	and	#$03
	eor	#$02
	cpy	#$04
	bcs	Lcc30
	eor	#$02
Lcc30:	tax
	inx
	stx	prodos_unit_num
	lda	sh_prodos_flag,y	; ProDOS or SmartPort?
	bpl	Lcc3c

	jmp	Lcccf

; SmartPort command, convert it into a ProDOS command
Lcc3c:	lda	sh_05f8,y	; set Z54 to point to cmd num -1
	sta	Z54
	lda	sh_0678,y
	sta	Z55

	ldy	#$01		; copy SmartPort command
	lda	(Z54),y
	sta	prodos_command
	iny

	lda	(Z54),y		; copy SmartPort arg list pointer to Z54
	tax
	iny
	lda	(Z54),y
	sta	Z55
	stx	Z54

	lda	#$01

	ldx	prodos_command		; SmartPort command in range ($00 to $09)?
	cpx	#$0a
	bcc	Lcc62

Lcc5f:	jmp	Lcd9f

Lcc62:	ldy	#$00
	lda	(Z54),y
	sta	Z5a

	ldy	#$08
Lcc6a:	lda	(Z54),y
	sta	prodos_cmd_blk,y
	dey
	bne	Lcc6a

	lda	prodos_unit_num
	bne	Lcccf
	ldx	prodos_command
	lda	Dcde3,x
	and	#$7f
	tay
	lda	#$04
	cpy	Z5a
	bne	Lcc5f
	cpx	#$05
	bne	Lcc92
	lda	#$00
	jsr	Scded
Lcc8d:	lda	#$00
	jmp	Lcdc1
Lcc92:	txa
	bne	Lccb8
	lda	#$21
	ldx	prodos_block
	bne	Lcc5f
	txa
	ldx	slot
	ldy	#$07
Lcca0:	sta	(prodos_buffer),y
	dey
	bne	Lcca0
	lda	unit_count,x
	sta	(prodos_buffer),y
	iny
	lda	#$00
	sta	(prodos_buffer),y
	lda	#$08
	dey
	jsr	Sce4f
	jmp	Lcc8d
Lccb8:	cmp	#$04
	bne	Lccc7
	ldx	prodos_block
	beq	Lcccb
	dex
	beq	Lcccb
	lda	#$21
Lccc5:	bne	Lcc5f
Lccc7:	lda	#$11
	bne	Lcc5f
Lcccb:	lda	#$1f
	bne	Lcc5f

; ProDOS
Lcccf:	lda	#$28
	ldy	slot
	ldx	unit_count,y
	cpx	prodos_unit_num
	bcc	Lccc5

	lda	#$09
	sta	Z4d
	lda	#$00
	sta	Z4e

	sta	Z55
	lda	#$42
	sta	Z54

	ldx	slot
	lda	sh_prodos_flag,x	; ProDOS or SmartPort?
	bpl	Lcd02

	ldx	prodos_command
	lda	Dcde3,x
	and	#$7f
	sta	Z5a
	lda	#$00
	sta	Z48
	lda	prodos_command
	bne	Lcd02
	sta	prodos_block
Lcd02:	lda	Z5a
	ldx	prodos_unit_num
	stx	Z5a
	sta	prodos_unit_num
	lda	#$80
	sta	Z5b
	jsr	smartport_bus_disable
	jsr	Sca76
	bcs	Lcd5c

	lda	prodos_buffer
	sta	Z54
	lda	prodos_buffer+1
	sta	Z55

	ldx	prodos_command
	lda	Dcde3,x
	bpl	Lcd60
	cpx	#$04
	bne	Lcd41
	ldy	#$01
	lda	(Z54),y
	tax
	dey
	lda	(Z54),y
	pha
	clc
	lda	#$02
	adc	Z54
	sta	Z54
	pla
	bcc	Lcd4f
	inc	Z55
	jmp	Lcd4f
Lcd41:	cpx	#$02
	bne	Lcd4b
	lda	#$00
	ldx	#$02
	bne	Lcd4f
Lcd4b:	ldx	prodos_block+1
	lda	prodos_block
Lcd4f:	stx	Z4e
	sta	Z4d
	lda	#$82
	sta	Z5b
	jsr	Sca67
	bcc	Lcd60
Lcd5c:	lda	#$06
	bne	Lcd9f

Lcd60:	ldy	slot
	lda	sh_prodos_flag,y	; ProDOS or SmartPort?
	bpl	Lcd73

	lda	prodos_command
	bne	Lcd73
	lda	#$45
	ldx	#$00
	sta	Z54
	stx	Z55
Lcd73:	jsr	Scabd
	bcs	Lcd5c
	jsr	Scbbf
	jsr	Sce4f
	lda	prodos_command
	bne	Lcd9d
	ldx	slot
	lda	sh_prodos_flag,x	; ProDOS or SmartPort?
	bpl	Lcd9d

; ProDOS
	lda	prodos_block
	sta	sh_05f8,x
	lda	prodos_block+1
	sta	sh_0678,x

	lda	prodos_buffer+1
	and	#$10
	bne	Lcd9d

	lda	#$2f
	bne	Lcd9f

Lcd9d:	lda	Z4d
Lcd9f:	ldy	slot
	sta	sh_04f8,y
	tax
	beq	Lcdc1

	ldx	sh_prodos_flag,y	; ProDOS or SmartPort?
	bpl	Lcdc1

	ldx	#$00
	cmp	#$40
	bcs	Lcdc0

	ldx	#$27
	cmp	#$2b
	beq	Lcdc1

	cmp	#$28
	beq	Lcdc1

	cmp	#$2f
	beq	Lcdc1

Lcdc0:	txa
Lcdc1:	ldy	slot
	sta	sh_0578,y

; restore zero page $40..$5b from stack
	ldx	#$00
Lcdc8:	pla
	sta	Z40,x
	inx
	cpx	#$1c
	bcc	Lcdc8

	plp
	lda	sh_05f8,y
	tax
	lda	sh_0578,y
	pha
	lda	sh_0678,y
	tay
	clc
	pla
	beq	Lcde2
	sec
Lcde2:	rts


Dcde3:	fcb	$03,$03,$83,$01,$83,$01,$01,$01
	fcb	$03,$83


Scded:	pha
	jsr	reset_smartport_bus
	pla
	tax

	lda	prodos_command
	pha
	lda	prodos_unit_num
	pha
	lda	prodos_block
	pha

	stx	prodos_block

	lda	#sp_cmd_init
	sta	prodos_command
	lda	#$00
	sta	Z5a
	lda	#$02
	sta	prodos_unit_num
	lda	#$42
	sta	Z54
	lda	#$00
	sta	Z55
	lda	#$80
	sta	Z5b
	jsr	smartport_bus_disable

Lce19:	inc	Z5a
	lda	#$09
	sta	Z4d
	lda	#$00
	sta	Z4e
	jsr	Sc800	; send init command
	bcc	Lce2d

	dec	Z5a
	jmp	Lce34

Lce2d:	jsr	Sc960
	lda	Z4d
	beq	Lce19

Lce34:	lda	Z5a
	ldy	slot
	sta	unit_count,y

	pla
	sta	prodos_block
	pla
	sta	prodos_unit_num
	pla
	sta	prodos_command

	lda	#$a5		; mark firmware as initialized
	sta	sh_magic1,y
	eor	#$ff
	sta	sh_magic2,y

	rts


Sce4f:	ldx	slot
	sta	sh_05f8,x
	tya
	sta	sh_0678,x
	rts


boot:	stx	slot
	lda	#$aa
	sta	sh_prodos_flag,x	; sets MSB, to indicate use of ProDOS protocol
	sta	sh_magic1,x		; mark firmware not initialized

; copy boot_prodos_command_block into zero page for use
	ldy	#boot_prodos_command_block_len - 1
Lce65:	lda	boot_prodos_command_block,y
	sta	prodos_cmd_blk,y
	dey
	bpl	Lce65

	lda	slot
	asl
	asl
	asl
	asl
	sta	prodos_unit_num

	jsr	execute_command		; read the boot block
	bcs	boot_error

	ldx	D0800			; first byte of boot block must be 1
	dex
	bne	boot_error
	
	ldx	L0801			; second byte of boot block must be non-zero
	beq	boot_error

	lda	slot			; jump to boot block entry point
	asl				; with slot * 16 in X
	asl
	asl
	asl
	tax
	jmp	L0801

boot_error:
	jsr	mon_setvid
	jsr	mon_setkbd
	ldx	Z00
	bne	Lcea4
	ldx	Z01
	cpx	gh_shared_slot
	bne	Lcea4
	jmp	mon_sloop

Lcea4:	ldx	#23		; bottom line of display
	stx	mon_cv
	jsr	mon_vtab

	lda	#$00
	sta	mon_ch
	ldx	#$00
	ldy	slot
	lda	sh_04f8,y
	bne	Lceba
	ldx	#msg_not_bootable - msg_tab
Lceba:	cmp	#$28
	bne	Lcec0
	ldx	#msg_no_dev - msg_tab
Lcec0:	cmp	#$2f
	bne	Lcec6
	ldx	#msg_no_disk - msg_tab

; output error message with starting index in X
Lcec6:	lda	msg_tab,x
	beq	Lced1
	jsr	mon_cout
	inx
	bne	Lcec6
Lced1:	jmp	basic_cold


msg_tab:
	fcchz	"I/O ERROR"

msg_not_bootable:
	fcchz	"NOT A BOOTABLE DISK"

msg_no_dev:
	fcchz	"NO DEVICE CONNECTED"

msg_no_disk:
	fcchz	"NO DISK TO BOOT"


boot_prodos_command_block:
	fcb	$01 	; command
	fcb	$50	; unit
	fdb	D0800	; buffer
	fdb	0	; block number
boot_prodos_command_block_len equ *-boot_prodos_command_block


	fillto	$cfdb,$ff

	fcb	$a8,$c3,$a9
	fcb	$a0,$b1,$b9,$b8,$b5,$a0,$c1,$f0
	fcb	$f0,$ec,$e5,$a0,$c3,$ef,$ed,$f0
	fcb	$f5,$f4,$e5,$f2,$ac,$a0,$c9,$ee
	fcb	$e3,$ae,$a0,$cd,$d3,$c1,$00,$10

	fillto	$d000,$ff
