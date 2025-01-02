; 16-bit unsigned multiply
; multiplicand in $e0/e1
; multiplier in $e2/e3
; result in $e0/e1/e2/e3
; scratch in $e4/e5
; load 65535 in e0/e1 and e2/e3
    lda #255
    sta $e1
    sta $e3
    lda #255
    sta $e0
    sta $e2

    lda $e0
    sta $e4
    lda $e1
    sta $e5

    ldx #0
    stx $e0
    stx $e1

    ldy #16
umultloop:
    asl $e0
    rol $e1
    rol $e2
    rol $e3
    bcc umnoadd
    clc
    lda $e4
    adc $e0
    sta $e0
    lda $e5
    adc $e1
    sta $e1
    lda #0
    adc $e2
    sta $e2

umnoadd:
    dey
    bne umultloop
    rts
