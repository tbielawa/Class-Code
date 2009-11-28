
;;;; xindex runs over the data and populates the "counts" of each column header.
;; genrate the indexes
(defun xindex (tbl)
  (unless (table-indexed tbl)
    (setf (table-indexed tbl) t)
    (dolist (row (table-all tbl) tbl) ; for al rows do ...
      (xindex1 (eg-class row) 
	       (eg-features row) 
	       (table-columns tbl))))
  tbl)

(defun xindex1 (class datums columns) ; for all datum in a row do ...
  (mapc #'(lambda (column datum) 
	    (unless (ignorep datum)
	      (xindex-datum column class datum)))
	columns
	datums))

(defmethod xindex-datum ((column discrete) class  datum)
  (let* ((key `(,class ,datum))
	 (hash (header-f column)))
    (incf (gethash key hash 0))))

(defmethod xindex-datum ((column numeric) class  datum)
  (let* ((key      class)
	 (hash     (header-f column))
	 (counter  (gethash  key hash (make-normal))))
    (setf (gethash key hash) counter) ; make sure the hash has the counter
    (add counter datum)))

;; e.g. query the structures

(defun f (tbl &optional class index range)
  (cond ((null class) 	 ; return number of instances 
	 (length (table-all tbl)))
	((null index)	 ; return number of a certain class 
	 (f1 (nth (table-class tbl) (table-columns tbl))
	     class
	     class))
	(t      	 ; return frequency of a range in a class
	 (f1 (nth index (table-columns tbl))
	     class
	     range))))

(defmethod f1 ((column discrete) class range)
  (gethash `(,class ,range) (header-f  column) 0))
