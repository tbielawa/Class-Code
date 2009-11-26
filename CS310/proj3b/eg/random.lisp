(reset-seed)

(let (out)
 (dotimes (i 100)
  (push (my-random-int 10) out))
 (print (sort out #'< )))
