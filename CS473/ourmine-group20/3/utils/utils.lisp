(format t " - Loading Grp20 Utils~%") ;; Output for a pretty log

(defun do-over-features (tbl func)
  (dolist (item (table-all tbl)) 
    (setf (eg-features item) (mapcar func (eg-features item)))))

(defun do-over-specific-feature (tbl func column)
  (dolist (item (table-all tbl))
    (setf (nth column (eg-features item))  (funcall func (nth column (eg-features item))))))

(defun gimme-classes (tbl)
  (mapcar #'eg-class (table-all tbl)))

(defun gimme-no-dupe-classes (tbl)
  (remove-duplicates (gimme-classes tbl)))

(defun count-uniques (table opener)
  (let ((item-count (make-hash-table)) (seen nil) (ranks nil))
    (dolist (x (table-all table))
      (if (null (gethash (funcall opener x) item-count))
	  (setf (gethash (funcall opener x) item-count) 1 seen (append seen (list (funcall opener x))))
	  (setf (gethash (funcall opener x) item-count) (+ 1 (gethash (funcall opener x) item-count)))
	  )
      )
    (dolist (x seen)
      (setf ranks (append ranks (list (list x (gethash x item-count)))))
      )
    ranks
    )
  )

(defun count-classes (table)
  (count-uniques table #'eg-class)
  )

(defun list-unique-features (table)
  (let ((uniques nil))
    (dotimes (doer (length (table-columns table)) (reverse uniques))
      (push (count-uniques table #'(lambda (x) (nth doer (eg-features x)))) uniques ))))

(defun count-unique-features (table)
  ;;"Unique features in each column"
  (mapcar #'length (list-unique-features table)))

(defun count-uniques-by-class (table opener klass)
  (let ((item-count (make-hash-table)) (seen nil) (ranks nil))
    (dolist (x (table-all table))
      (if (eql klass (eg-class x)) 
        (if (null (gethash (funcall opener x) item-count))
          (setf (gethash (funcall opener x) item-count) 1 seen (append seen (list (funcall opener x))))
          (setf (gethash (funcall opener x) item-count) (+ 1 (gethash (funcall opener x) item-count)))
          )
        (if (null (gethash (funcall opener x) item-count))
          (setf (gethash (funcall opener x) item-count) 0 seen (append seen (list (funcall opener x))))
          )
        )
    )
    (dolist (x seen)
      (setf ranks (append ranks (list (list x (gethash x item-count)))))
      )
    ranks
    )
  )

(defun list-unique-features-by-class (table klass)
  (let ((uniques nil))
    (dotimes (doer (length (table-columns table)) (reverse uniques))
      (push (count-uniques-by-class table #'(lambda (x) (nth doer (eg-features x))) klass) uniques ))))

(defun count-unique-features-by-class (table klass)
  ;;"Unique features in each column by class"
  (mapcar #'length (list-unique-features-by-class table klass)))

(defun find-testiest (l test)
  (let ((testiest (car l)))
    (dolist (item l testiest)
      (setf testiest (funcall test testiest item)))))

(defun find-testiest-numerics (table test)
  (let ((testiest-numerics nil))
    (let ((uniques (list-unique-features table)))
      (dotimes (doer (length (table-columns table)) (reverse testiest-numerics))
        (if (numeric-p (nth doer (table-columns table)))
	    (push (find-testiest (mapcar #'car (nth doer uniques)) test) testiest-numerics)
	    (push nil testiest-numerics))))))
      
(defun minority-class (table)
  (let ((minority (list nil 0)) (ranks (count-classes table)))
    (dolist (x ranks)
      (if (or (< (second x) (second minority)) (equalp (second minority) 0))
	  (setf minority x)
	  )
      )
    (first minority)
    )
  )

(defun minority-diff (table)
  (let ((ranks (count-classes table)) (minority (minority-class table)) (minimum nil))
    (dolist (x ranks)
      (if (equalp minority (first x))
	  (setf minimum (second x) ranks (remove x ranks))
	  )
      )
    (dolist (x ranks)
      (setf (second x) (- (second x) minimum))
      )
    ranks
    )
  )


(defun tablerows (l)
  ;;"Returns a list of all the feature rows in a given table"
  (let ((allrows '()))
    (dolist (arow (table-all l))
      (push (eg-features arow) allrows))
    allrows))

(defun rowclass (tbl n)
  ;;"Return the class of row n"
  (last (eg-features (nth n (table-all tbl)))))

(defun justclasses (tbl)
  ;;"A list of the classes in tbl"
  (let ((classes '()))
    (dolist (l (first (last (list-unique-features tbl))))
      (push (first l) classes))
    classes))

(defun allvals (tbl)
  ;;"Return a list with all the unique values from each column without count"
  (let ((classes '())) 
    (dolist (l (list-unique-features tbl))
      (let ((subclasses '()))
	(dolist (x l)
	  (push (first x) subclasses))
	(push subclasses classes)))
    (reverse classes)))

(defun testiest-truthiness (r1 r2 test)
  (let ((one 0) (two 0))
    (dolist (r r1)
      (if (third r)
        (setf one (+ one 1))
      )
    )
    (dolist (r r2)
      (if (third r)
        (setf two (+ one 1))
      )
    )
    (setf one (/ one (length r1)))
    (setf two (/ two (length r2)))
    (if (funcall test one two)
      r1
      r2)))

(defun testiest-truthiness-list (tness test)
  (let ((ret (first tness)))
    (dotimes (n (- (length tness) 1))
     (setf ret (testiest-truthiness ret (nth (+ n 1) tness) test))) ret))

(defun unnegitify (possibly-negative)
  (if (or (null possibly-negative) (< possibly-negative 0))
    0
    possibly-negative
  )
)

(defun unoverbound (possibly-toobig table)
  (if (or (null possibly-toobig) (>= possibly-toobig (length (table-all table))))
    (- (length (table-all table)) 1)
    possibly-toobig
  )
)

(defun create-a-single-line-table (n original)
  (let ((abc (copy-table original)))
    (setf (table-all abc) (list (nth n (table-all original)))) abc))

