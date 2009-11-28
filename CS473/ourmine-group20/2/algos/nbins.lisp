;;; N-logging: N is arbitrary.
;;;   Iterate over each of the numeric columns, row by row.  Take the numeric value, and we replace it with
;;;   the value defined by the function newX = round(N * (oldX - min)/(max - min)), where oldX is the value of the
;;;   the present row's value for the selected column.  Min and Max are the minimum and maximum values of
;;;   the selected column.  Repeat this for all numeric columns, the structure of the data should remain unaltered,
;;;   but the meaning of the column has changed.  There should be a key on the function for the precision of the
;;;   rounding function.

;;; Claimee: Elijah -- Completed

(print " - Loading N-Bins") ;; Output for a pretty log

(defun nbins (table &optional (n 5))
  (let ((maxes (find-testiest-numerics table #'max)) 
       (mins (find-testiest-numerics table #'min)))

    (dotimes (doer (length maxes))
      (if (nth doer maxes)
        (do-over-specific-feature table #'(lambda (x) (round (* n (/ (- x (nth doer mins)) (- (nth doer maxes) (nth doer mins)))))) doer))))
  table
)
