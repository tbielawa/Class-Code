;;; Binlogging: Observe the number of distinct rows.  Take this number and do the log() of it.  This is N.
;;;   Iterate over each of the numeric columns, row by row.  Take the numeric value, and we replace it with
;;;   the value defined by the function newX = round(N * (oldX - min)/(max - min)), where oldX is the value of the
;;;   the present row's value for the selected column.  Min and Max are the minimum and maximum values of
;;;   the selected column.  Repeat this for all numeric columns, the structure of the data should remain unaltered,
;;;   but the meaning of the column has changed.  There should be a key on the function for the precision of the
;;;   rounding function.

;;; Claimee: Elijah -- Completed

(format t " - Loading Bin-Logging~%") ;; Output for a pretty log

(defun binlogging (table)
  (let ((maxes (find-testiest-numerics table #'max)) 
       (mins (find-testiest-numerics table #'min)) 
       (n (mapcar #'log (count-unique-features table))))

    (dotimes (doer (length maxes))
      (unless
	  (discrete-p (nth doer (table-columns table)))
	(let
	    ((range (- (nth doer maxes) (nth doer mins))))
	  (unless
	      (zerop range)
	    (if (nth doer maxes)
		(do-over-specific-feature table #'(lambda (x) (round (* (nth doer n) (/ (- x (nth doer mins)) range)))) doer))))))) table)
