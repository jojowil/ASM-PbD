define bmaplo $10
define bmaphi $11
define scolor $13
define temp   $14

        lda #$00     ; set bitmap address to $0200
        sta bmaplo
        sta scolor   ; starting color (black)
        lda #$02
        sta bmaphi

        ldx #$06     ; max value for bmaphi

        ldy #$00     ; index - this value is added to the pointer

        lda #$00     ; colour code to be used to fill the display

loop:   sta (bmaplo),y  ; store color at bmaplo + y
        clc
        adc #$01     ; add one to the color

        sta temp     ; safely store
        tya          ; test y
        and #31      ; cheap mod 32
        cmp #31      ; 32 blocks filled?
        bne no       ; nope
        inc scolor   ; yup, increment start color
        lda scolor   ; get new color
        sta temp     ; ready for next row
no:
        lda temp     ; restore or new
        iny          ; increment index
        bne loop     ; branch until page done - stops when Y==0

        inc bmaphi   ; increment high byte of pointer
        cpx bmaphi   ; compare with max value
        bne loop     ; continue if not done

        brk          ; done - return to debugger
