(reset-seed)

(let (out)
 (dotimes (i 100 (sort out #'<)
  (push (my-random-int 10) out)))
