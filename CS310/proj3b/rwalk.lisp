(defun countr (x l)
  (cond ((null l)  0)
	((atom l)  (if (eql x l) 1 0))
	(t         
	 (let ((n 0))
	   (dolist (one l n)
	     (incf n 
		   (countr x one)))))))