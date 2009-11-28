;;; 10.1 Evaluate

(deftest evaluation ()
  (check (equalp
    9
    (eval `(+ 3 3 3)))))

;;; 10.2 Macros

(defmacro truthify (x)
  (list 'setf x T))

(deftest macro ()
  (let ((n nil))
    (truthify n)
    (check n)))

;;; Figure 10.2 Macro Utilities [Required]
(defmacro avg (&rest args)
  `(/ (+ ,@args) ,(length args)))

(deftest utilities()
  (check
    (= 2 (avg 3 2 1))))

;;; 10.3 Backquote

(deftest backquote () 
  (check (equalp
    '(B 2 M)
    `(B ,(+ 1 1) M))))

;;; 10.4 Quicksort
;; Liberally lifted from page 165, Common ANSI Lisp
(defmacro while (test &rest body)
  `(do ()
    ((not ,test))
    ,@body))

(defun quicksort (vec l r)
  (let ((i l)
	(j r)
	(p (svref vec (round (+ l r) 2))))
    (while (<= i j)
      (while (< (svref vec i) p) (incf i))
      (while (> (svref vec j) p) (decf j))
      (when (<= i j)
	(rotatef (svref vec i) (svref vec j))
	(incf i)
	(decf j)))
    (if (>= (- j l) 1) (quicksort vec l j))
    (if (>= (- r i) 1) (quicksort vec i r)))
  vec)

(deftest test-quicksort ()
  (check
    (and
     (= 1 (elt (quicksort (vector 3 2 1) 0 2) 0))
     (= 2 (elt (quicksort (vector 3 2 1) 0 2) 1))
     (= 3 (elt (quicksort (vector 3 2 1) 0 2) 2)))))

;;; 10.5 Macro Design
(defmacro ntimes (n &rest body)
  (let ((g (gensym))
	(h (gensym)))
    `(let ((,h ,n))
      (do ((,g 0 (+ ,g 1)))
	  ((>= ,g ,h))
	,@body))))

(deftest macrodesign ()
  (let ((x 0))
    (ntimes 3
	    (setf x (+ x 1)))
    (check
      (=
       3 x))))


;;; 10.6 Generalized Reference

;;; 10.7 Macro Utilities

