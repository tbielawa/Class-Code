;;; Claimee: Tim
;; Classifiers make decisions. 

(format t " - Loading TwoR~%") ;; Output for a pretty log

(load "../../../lib/lisp/tricks/string.lisp")
(load "../../../lib/lisp/table/xindex.lisp")
(load "../../../lib/lisp/tricks/hash.lisp")
(load "../../../lib/lisp/tricks/list.lisp")
(load "../../../lib/lisp/tricks/macros.lisp")
(load "../../../lib/lisp/tricks/normal.lisp")
(load "../../../lib/lisp/tricks/number.lisp")
(load "../../../lib/lisp/tricks/random.lisp")


(defun majority-class(tbl)
  "Names the majority class of a dataset"
  (let ((classes (count-classes tbl))
	(greatest '()))
    (dolist (class classes (car greatest))
      (if
       (null greatest)
       (setf greatest class)
       (progn
	 (if
	  (< (nth 1 greatest) (nth 1 class))
	  (setf greatest class)))))))

(defun majority-class-list (tbl)
  "Return a list containing features of instances in the majority class"
  (mapcar 'eg-features ((lambda (x) (let ((y '()))
				      (dolist 
					  (l (egs x) y)
					(if 
					 (eql (majority-class x) (eg-class l))
					 (push l y))))) tbl)
)) 

(defun oner(tbl &optional (test nil))
  (let* 
      ((cols (columns-header (table-columns tbl)))
       (major-features (majority-class-list tbl))
       (counts-all '())
       (i 0)
       (accuracy '())
       (predictors (make-hash-table)))
    (dolist (col (reverse (cdr (reverse cols)))) ;for each column
      (let ((counts '()))
	(dolist (l major-features) ; for each instance
	  (let ((this (nth i l)))
	    (if (null counts) ; is it a new list? then put in first value w/ '1'
		(push (cons this 1) counts)
		(if (null (assoc this counts)) ;this isn't in the list yet
		    (push (cons this 1) counts) ; add it
		    (incf (cdr (assoc this counts)))))))
	(incf i)
	(push (cons col counts) counts-all)))
    (reverse counts-all)
    (let 
	((j 0) ; j allows us to iterate over list in 'feats'  
	  ; feats represents all observed features.
	  ; feats contains a list for each column (attribute)
	  ; each list stores an assoc list of the attr values and
	  ; how many times each one appeared.
	 (feats (list-unique-features tbl))
	 (cols (columns-header (table-columns tbl))))
      ; col is the column we are classifying 
      (dolist (col (reverse (cdr (reverse cols)))) ; drop the classes column, put back in order...
	; the jist of this method is to iterate over each column of attributes
	; Find out how many times an attribute value appeared over all
	; Find out how many tmes an attribute value appeared in the target class
	; This dolist will loop for each column
	(let*
	; select the present working column, j, from the full set
	    ((subaccuracy '())
	     (these-tokens-tuples (nth j feats))
	     (these-tokens (mapcar 'car these-tokens-tuples)) ; list of observed attr values in this column
	     (class-count-list (cdr (assoc col counts-all)))) ; list of the counts of class intances in this column
	  ;(print these-tokens-tuples)    ; like this: ((RAINY 5) (OVERCAST 4) (SUNNY 5))
	  ;(print (cdr (assoc col counts-all))) ; like this: ((SUNNY . 2) (RAINY . 3) (OVERCAST . 4))
	  (dolist (this-token these-tokens)
	    (let*
		((full-count (nth 1 (assoc this-token these-tokens-tuples)))
		 (class-count (cdr (assoc this-token class-count-list)))
		 (rating nil))
	      (if
	       (numberp class-count)
	       (progn
		 (setf rating (cons this-token (float (/ class-count full-count))))
		 (push rating subaccuracy)))))
	    (push subaccuracy accuracy)
	    (push (best-predictor subaccuracy) (gethash col predictors)))
	  (incf j)))
    ;(format t "Analysis complete. Printing ratings for your review.~%")

    (review-predictors predictors)
  predictors))
;;     (if
;;      (not (null test))
;;      (predict (gen-sorted-predictor-list predictors) predictors test)
;;      predictors)))


(defun predict (plist predictors test)
  "Give me the prediction list and a table to use"
  (let
      ((lastresort (majority-class test))
       (rows (mapcar #'(lambda (l) (all-but-last-col (eg-features l))) (egs test)))
       (correct 0)
       (incorrect 0)
       (column-index (gen-column-indexer test)))
    ;go down each row
    ;go across the best predictors (plist)
    ;; compare the value of the predictor to
    ;; the value of that column for the present working row
    ;; if they're a match then classify as the target class
    ;;; check your work! if that was correct marking, increment correct
    ;; if they're a miss then try the next best predictor
    ;; continue until out of predictors
    ;; if nothing matches, set it to 'last resort', the most common class
    ;; 
    (dolist (r rows)
      (format t "## Next Row ##~%")
      (dolist (p plist)
	(let*
	    ((i (gethash p column-index))
	     (inst-val (nth i r))
	     (pval (first (first (gethash p predictors)))))
;	  (format t "Checking Predictor ~A:~A against Instance Value ~A~%" p pval inst-val
	  (if
	   (equal pval inst-val)
	   (progn
	     (format t "Match!~%") (return t)))
	   (format t "No predictors matched~%"))))))
	
	   

;	  (progn
;	    )))))))

(defun gen-column-indexer (table)
  "Creates a hash table that maps column names to their index"
  (let ((column-index (make-hash-table))
	(cols (columns-header (table-columns table))))
    (dotimes (n (table-width table) column-index)
      (setf (gethash (pop cols) column-index) n))))

(defun best-predictor (l)
  (first (sort (copy-list l) '> :key 'cdr)))

(defun review-predictors (h)
  "Runs over the hash table, h, and displays each predicting column's accuracy"
  (maphash #'(lambda (x y) (format t "Key: ~A~%     Value: ~A~%     Accuracy: ~A~%~%" x (first (first y)) (cdr (first y)))) h))

(defun all-but-last-col (row)
  "Input a row, returns all but the last item in the list"
  (reverse (cdr (reverse row))))

(defun paired-strings-to-symbol (l r)
  "Input two strings. Returns their concatenation as a symbol"
  (intern (remove #\$ (concatenate 'string (write-to-string l) (string '-) (write-to-string r)))))

(defun pair-row (row)
  "Pair all elements with every other element"
  (let ((cols (all-but-last-col row)) (pair-columns '()))
    (dotimes (n (length cols))
      (let ((col (pop cols)))
	;(push col pair-columns)
	(dolist (r cols)
	  (push (paired-strings-to-symbol col r) pair-columns))))
    (push (first (reverse row)) pair-columns) ; tack the class on the end
    (reverse pair-columns)))

(defun gen-paired-col-headers (tbl)
  "Give me a table, and I'll give you a list of all the column names paired together"
  (pair-row (mapcar #'(lambda (l) (header-name l)) (table-columns tbl))))

(defun gen-paired-feature-list (tbl)
  "Give me a table, and I'll give you a list of lists. Each one is the result of pairing every column"
  (mapcar #'(lambda (x) (pair-row (eg-features x))) (egs tbl)))

(defun twoR (tbl &optional (test nil))
  "Give me a table and I'll give you a bigger one!"
					;  (let ((new-table (xindex (data :name (table-name tbl) :columns (gen-paired-col-headers tbl) :egs (gen-paired-feature-list tbl)))))
  (let ((new-table (pair-table tbl)))
    (if
     (not (null test))
     (oner new-table (pair-table test))
     (oner new-table))))

(defmacro pair-table (tbl)
  `(xindex (data :name (table-name ,tbl) :columns (gen-paired-col-headers ,tbl) :egs (gen-paired-feature-list ,tbl))))

(defun gen-sorted-predictor-list (hash)
  "Give me a hash table and I'll give you a sorted list of the best predictors"
  (let ((keys '()))
    (maphash #'(lambda (x y) (push x keys)) hash)
    (reverse (sort keys '< :key #'(lambda (x) (cdr (first (gethash x hash))))))))

(defmacro printhash (hash)
  "Prints KEY: VALUE, over a hash table"
  `(maphash #'(lambda (x y) (format t "~A: ~A~%" x y)) ,hash))

(defun make-column-rules (n tbl)
  (let*
      ((col-count-table (make-hash-table))
       (column-name (header-name (nth n (table-columns tbl)))))
    (dolist (l (table-all tbl) (cons column-name col-count-table))
      (let*
	  ((attribute-value (nth n (eg-features l)))
	   (attribute-class (eg-class l))
	   (appearances (nth 1 (assoc attribute-value (nth n (list-unique-features tbl))))))
	(if
	 (null (gethash attribute-value col-count-table))
	 (setf (gethash attribute-value col-count-table) (make-hash-table)))
	(let
	    ((attribute-table (gethash attribute-value col-count-table)))
	  (incf (gethash attribute-class attribute-table 0) (/ 1 appearances)))))))

 (defun hashlist (hash)
  (let ((retlist '()))
    (maphash #'(lambda (x y) (push (cons x y) retlist)) hash)
    retlist))

(defun seq (size &optional without)
  (let ((seq '()))
    (dotimes (n size)
      (push n seq))
    (delete without (reverse seq))))

(defun gen-prediction-rules (tbl)
  "Generates prediction rules on a table"
  (mapcar #'(lambda (n) (make-column-rules n tbl)) (seq (table-width tbl) (table-class tbl))))



(dolist 
	     (column (gen-prediction-rules w2))
	   (let
	       ((col-name (car column))
		(col-attrs (cdr column)))
	     (format t "~%~%Column: ~A~%" col-name)
	     (dolist
		 (attrs (hashlist col-attrs))
	       (let
		   ((attr-name (car attrs))
		    (attr-hash (cdr attrs)))
		 (format t "Attribute: ~A~%" attr-name)
		 (print (first (sort (hashlist attr-hash) '> :key 'cdr)))))))