;; Normalize
;; Normalize numerics from 0...1 
;;; Shaggy

(format t " - Loading Normalize~%") ;;; Logging for a pretty run.

(defun normal (in min max)
  "Normalize a number into the range 0...1"
  (/ (- in min) (- max min)))

(defmacro nth-eg (n this-eg)
  "Returns the nth column in an eg's features"
  `(nth ,n (eg-features ,this-eg)))

(defun findMin (l col)
  "Find the mininum"
  (let
      ((min most-positive-fixnum))
    (dolist (row l min)
      (if
       (< (nth-eg col row) min)
       (setf min (nth-eg col row))))))

(defun findMax (l col)
  "Find the maximum"
  (let
      ((max most-negative-fixnum))
    (dolist (row l max)
      (if
       (> (nth-eg col row) max)
       (setf max (nth-eg col row))))))

(defun normalize (tbl)
  "Normalize each numberic column"
  (let
      ((col -1))
    (dolist
	(l (table-columns tbl))
      (incf col)
      (if (numeric-p l)
	  (let
	      ((max (findMax (table-all tbl) col))
	       (min (findMin (table-all tbl) col)))
	    (dolist (row (table-all tbl))
	      (setf (nth-eg col row) (normal (nth-eg col row) min max))))))))
