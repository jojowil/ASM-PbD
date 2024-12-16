define CHROUT $ffd2

        ldx #0        ; set index to zero
print:
        lda words,x   ; load a letter from words
        beq done      ; if it's the zero, we're done
        jsr CHROUT    ; print the character
        inx           ; increment the index
        bne print     ; keep printing
done:
        brk           ; end!

; data below this line

words:
        txt "The quick brown\nfox jumps over\n"
        txt "the lazy dog.\n"
        dcb 0
