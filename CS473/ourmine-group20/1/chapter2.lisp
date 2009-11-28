;;; 2.2 Order of Operations

(deftest test-order-operations ()
  (check
   (equal (/ (- 6 4) (- 8 6)) 1)))

;;; 2.2 Evaluation
(deftest test-evaluation ()
  (check
   (=
    3
    (/ (- 7 1) (- 4 2)))))

;;; 2.3 Data

(deftest listbuilder ()
  (check (equalp
    '(A B C)
    (list 'A 'B 'C))))

(deftest nillist ()
  (check
    (null ())))

;;; 2.4 List Operations

(deftest listops () 
  (check (equalp
    '(A B C)
    (cons (car '(A nil)) (cdr '(nil B C))))))

;;; 2.5 List Truth

(deftest islist ()
  (check (listp '(a b c))))

;;; 2.5 If Statements

(deftest test-if ()
	(let ((x nil) (y nil) (z nil))        

	(if nil
                (setf x 1)
                (setf x 0))

        (if t
                (setf y 0)
                (setf y 1))

        (if 50
                (setf z 0)
                (setf z 1))
        (check (equal (+ x y z) 0))))


;;; 2.7 Recursion 

(defun fibonacci (N)
  (if (or (zerop N) (= N 1))
    1
    (+ (fibonacci (- N 1)) (fibonacci (- N 2)))))

(deftest examlerecursion ()
  (check (equalp (fibonacci 5) 8)))

;;; 2.11 Assignment
(deftest test-assignment ()
  (let ((x 0))
    (setf x 1)
    (check
      (= x 1))))

;;; 2.13 Iteration

(defun addup (n)
  (let (( p 0 ))
  (do ((i 1 (+ i 1)))
      ((> i n) p)
    (setf p (+ p i))
	p)))
(deftest exampleiteration ()
  (check (equalp (addup 5) 15)))
     
