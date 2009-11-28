;;; Claimee: Drew

;;;  (EASY) Normal-chops
;;;    Assume data is Gaussian and divide into -3, -2, -1, 0, 1,2,3 standard 
;;;    deviations away from the mean. Hint: see lisp/tricks/normal.lisp

;;; 1. Compute the mean of a column.

(format t " - Loading N-Chops~%") ;;; Logging for a pretty run.

(defun column-mean (table column-num)
  (if (realp (nth column-num (eg-features (first (table-all table)))))
    (let ((sum 0))
      (dolist (row (table-all table))
        (incf sum (nth column-num (eg-features row)))
      )
      (/ sum (length (table-all table)))
    )
    nil
  )
)

;;; 2. Compute the standard deviation of a column.  StDev is measured as
;;;    the average of the distances of each value from the mean.  Relevant
;;;    equation is: stddev = sqrt(1/n * Summation((member - mean)^2))

(defun square (x)
  (* x x)
)

(defun column-stddev (table column-num)
  (if (realp (nth column-num (eg-features (first (table-all table)))))
    (let ((sum-diffs 0) (col-ave (column-mean table column-num)))
      (dolist (row (table-all table))
        (incf sum-diffs (square (- (nth column-num (eg-features row)) col-ave)))
      )
      (sqrt (/ sum-diffs (length (table-all table))))
    )
    nil
  )
)

;;; 3. Generate bin widths, return a list of staring and ending values
;;;    in the format of ((-20 -10) (-10 0) (0 10)) and so forth.  When
;;;    doing binning, the lower value is inclusive, the upper value
;;;    is not, so >= lower and < upper meets critera for binning.

(defun column-binwidths (average stddev)
  (list
    (list (- average (* stddev 4)) (- average (* stddev 3)))
    (list (- average (* stddev 3)) (- average (* stddev 2)))
    (list (- average (* stddev 2)) (- average stddev))
    (list (- average stddev) (+ average stddev))
    (list (+ average stddev) (+ average (* stddev 2)))
    (list (+ average (* stddev 2)) (+ average (* stddev 3)))
    (list (+ average (* stddev 3)) (+ average (* stddev 2)))
  )
)

(defun identify-bin (value bins)
  (let ((decision nil))
    (dotimes (i (length bins))
      (let ((x (nth i bins)))
        (if (and (>= value (first x)) (< value (second x)))
          (setf decision i)
        )
      )
    )
    (if (null decision)
      (if (> value (second (first (last bins))))
        (setf decision (- (length bins) 1))
        (setf decision 0)
      )
    )
    (- decision 3)
  )
)

;;; 4. For each numeric column in the table, compute average, then
;;;    standard deviation, then compute bin ranges, then overwrite
;;;    column values with their new bin number.  Note, this function
;;;    is destructive.  Will happily exist along side discretes.

(defun normal-bins (table)
  (dotimes (i (length (eg-features (first (table-all table)))) table)
    (if (realp (nth i (eg-features (first (table-all table)))))
      (dotimes (j (length (table-all table)))
        (let ((value (nth i (eg-features (nth j (table-all table))))))
          (setf 
            (nth i (eg-features (nth j (table-all table))))
            (identify-bin value (column-binwidths (column-mean table i) (column-stddev table i)))
          )
        )
      )
    )
  )
)

(defun n-chops (table)
  (normal-bins table))
