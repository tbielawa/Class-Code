;;; Subsample: Poll data for a tally on all the classes.  Find the smallest class, and randomly delete
;;;   lines until they are all equal in prevelence.  Once the classes are all the same size, the data
;;;   is now ready for the discretizer.

;;; Claimee: Drew - COMPLETED

(print " - Loading Subsample") ;;; Logging for a pretty run.

(defun subsample (srctable)
  (let ((diffs (minority-diff srctable)) (table (copy-table srctable)))
    (dolist (x diffs)
      (loop while (not (equalp (second x) 0)) do
        (let ((random-row-num (random (length (table-all table)))))
          (if (equalp (first x) (eg-class (nth random-row-num (table-all table))))
            (setf 
              (table-all table) (remove (nth random-row-num (table-all table)) (table-all table))
              (second x) (- (second x) 1)
            )
          )
        )
      )
    )
    table
  )
)
