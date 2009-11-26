;(print (sentence))



(dotimes (i 10) (spec->lines (generate '?spec)))

; error checking. non terminal with no rule.
; nonterminal never used 
; nonterminals begin with upper case
; get the nl into the datas
; bug, shuld not get less than 2 datums
; no bottom ticks. brob,e: can have ymin less than ymax. needs a final filter to
; throw away sillies

