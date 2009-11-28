;;; Figure 14.2 Advanced Loops [Required]

(deftest test-loop-finally ()
  (check (equalp
	  10
	  (loop for x from 0 to 9
	       finally (return x)))))

;;; 14.5 Loop

(deftest loop10 () 
  (check (equalp
    123456789
    (let ((x 0))
      (loop for n from 1 to 9 do
        (setf x (+ n (* x 10))))
      x))))

