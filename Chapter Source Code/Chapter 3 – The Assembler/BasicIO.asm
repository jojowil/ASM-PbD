define  CHROUT  $ffd2
define  CHRIN   $ffcf
define  MAXNAME 32
define  CR      $0d

        ldx #0        ; set index to zero

        ; ask them their name
printQuery:
        lda query,x
        beq endp
        jsr CHROUT
        inx
        bne printQuery
endp:

        ; read in the name
        ldx #0
getName:
        jsr CHRIN
        cmp #0        ; no char returned
        beq getName   ; try again

        ; was is the return key?
        cmp #CR
        beq endg

        ; store the char
        sta name, x
        jsr CHROUT
        inx

        ; stop if there are 32 chars!
        cpx #MAXNAME
        bcc getName
endg:
        ; print a CR and terminate the name
        lda #CR
        jsr CHROUT
        lda #0
        sta name, x

        ldx #0
sayHi:
        lda hello, x
        beq endh
        jsr CHROUT
        inx
        bne sayHi
endh:

        ldx #0
prName:
        lda name, x
        beq endn
        jsr CHROUT
        inx
        bne prName

endn:
        lda end
        jsr CHROUT
        brk

query:
        txt "What is your name? "
        dcb 0
hello:
        txt "Hello, "
        dcb 0
end:
        txt "!"
        dcb 0
name:
        dsb 32
        dcb 0

