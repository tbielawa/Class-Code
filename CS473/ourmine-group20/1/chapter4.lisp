;;; 4.1 Arrays

(deftest testarray ()
  (let ((arr (make-array '(4 4) :initial-element 13)))
    (check (equalp (aref arr (random 4) (random 4)) 13))))

;;; 4.2 Binary Search

(defun binsearch (item vector &optional (start 0) (end (length vector)))
  (let ((pivot (round (/ (+ start end) 2))))
    (if (and (listp vector) (> (length vector) 0))
      (if (equalp item (nth pivot vector))
        pivot
        (if (not (zerop (- start end)))
          (if (> item (nth pivot vector))
            (binsearch item vector pivot end)
            (binsearch item vector start pivot)
          )
          nil
        )
      )
      nil
    )
  )
)

(deftest testbinsearch ()
  (check (equalp
    2
    (binsearch 3 '(1 2 3 4 5 6 7 8)))))

;;; Figure 4.2 Identifying Tokens [Required]

(defun tokens (str test start)
  (let ((p1 (position-if test str :start start)))
    (if p1
      (let ((p2 (position-if #'(lambda (c)
                                 (not (funcall test c)))
                             str :start p1)))
        (cons (subseq str p1 p2)
              (if p2
                  (tokens str test p2)
                  nil)))
       nil)))

(deftest testtokens ()
  (check (equalp (tokens "eli123$eli234.eli345&.eli456" #'alphanumericp 0) 
	         '("eli123" "eli234" "eli345" "eli456"))))


;;; 4.3 String Functions

(deftest teststrings ()
  (let ((alph "ZYXWVUTSRQPONMLKJIHGFEDCBA")
       (name nil))
    (setf alph (sort alph #'char<))
    (setf name (concatenate 'string (string (char alph 4))
                                    (string (char alph 11))
                                    (string (char alph 8))))
    (check (equalp name "ELI"))))

;;; 4.5 Parsing Based on Test
(deftest tokenremoval ()
  (defun removenonalpha (str test start)
    (let ((p1 (position-if test str :start start)))
      (if p1
       (let ((p2 (position-if #'(lambda (c)
                                  (not (funcall test c)))
                              str :start p1)))
         (cons (subseq str p1 p2)
               (if p2
                   (removenonalpha str test p2)
                   nil)))
       nil)))

  (check
     (equal (removenonalpha "eli123abc..d" 
		#'alpha-char-p 0) 
		'("eli" "abc" "d"))))

;;; Figure 4.5 Binary Search Trees, Lookup/Insertion [Required]

(defstruct (node (:print-function
                  (lambda (n s d)
                    (setf d d)  ;;; The book's code is bugged.
                    (format s "<~A>" (node-elt n)))))
   elt (l nil) (r nil))

(defun bst-insert (obj bst <)
  (if (null bst)
      (make-node :elt obj)
      (let ((elt (node-elt bst)))
        (if (eql obj elt)
            bst
            (if (funcall < obj elt)
                (make-node
                  :elt elt
                  :l (bst-insert obj (node-l bst) <)
                  :r (node-r bst))
                (make-node
                  :elt elt
                  :r (bst-insert obj (node-r bst) <)
                  :l (node-l bst)))))))

(defun bst-find (obj bst <)
  (if (null bst)
      nil
      (let ((elt (node-elt bst)))
        (if (eql obj elt)
            bst
	      (if (funcall < obj elt)
                (bst-find obj (node-l bst) <)
                (bst-find obj (node-r bst) <)
		)))))

(defun bst-min (bst)
  (and bst
       (or (bst-min (node-l bst)) bst)))

(defun bst-max (bst)
  (and bst
       (or (bst-max (node-r bst)) bst)))

(deftest testinsertfind ()
  (let ((n nil))
    (check (and (null
      (dolist (i '(9 4 7 8 5 2 3 1 6))
        (setf n (bst-insert i n #'<))))
    (null (bst-find 15 n #'<)))
    ;;(string= (string (bst-find 5 n #'<)) "<5>")
)))
;;; Figure 4.6 Binary Search Trees, Deletion [Required]

(defmacro delay (expr)
  "Graham has this tendancy to write code with circular dependancies, throwing warnings.  This is a stopgap. -Drew" 
  `(lambda () ,expr))

(defun rperc (bst)
 (make-node :elt (node-elt (node-r bst))
            :l (node-l bst)
            :r (delay '(percolate (node-r bst)))))
  
(defun lperc (bst)
  (make-node :elt (node-elt (node-l bst))
             :l (delay '(percolate (node-l bst)))
             :r (node-r bst)))

(defun percolate (bst)
 (cond ((null (node-l bst))
       (if (null (node-r bst))
            nil
            (rperc bst)))
       ((null (node-r bst)) (lperc bst))
       (t (if (zerop (random 2))
          (lperc bst)
          (rperc bst)))))

(defun bst-remove (obj bst <)
 (if (null bst)
     nil
     (let ((elt (node-elt bst)))
       (if (eql obj elt)
           (delay '(percolate bst))
            (if (funcall < obj elt)
                (make-node
                   :elt elt
                   :l (bst-remove obj (node-l bst) <)
                   :r (node-r bst))
                (make-node
                   :elt elt
                   :r (bst-remove obj (node-r bst) <)
                   :l (node-l bst)))))))

(deftest testinsertdelete ()
  (let ((n nil))
    (check (and (null
      (dolist (i '(9 4 7 8 5 2 3 1 6))
        (setf n (bst-insert i n #'<))))
    (bst-remove 9 n #'<))
    ;;(string= (string (bst-find 5 n #'<)) "<5>")
)))


;;; 4.6 Structures [Required]
(defstruct item
  price
  name)

(deftest test-structure ()
   (let ((p nil)) 
     (setf p (make-item :price 5 :name "Chicken"))
       (check
         (equal (item-price p) 5))))
