;;; 5.1 Control

(deftest dolisting ()
  (check (equalp
    '(A B C)
    (let ((returnme '()))
      (dolist (x '(A B C D E))
        (if (equalp x 'D)
          (return returnme)
          (setf returnme (append returnme `(,x)))))))))

;;; 5.2 Context

(deftest context ()
  (let ((n 1) (firstn nil) (secondn nil))
    (let ((n 2))
      (setf secondn n))
    (setf firstn n)
    (check (not (equalp firstn secondn)))
  )
)

;;; Figure 5.2 Date Arithmetic [Required]

(defconstant month #(0 31 59 90 120 151 181 212 243 273 304 334 365))
(defconstant yzero 2000)

(defun leap? (y)
   (and (zerop (mod y 4))
        (or (zerop (mod y 400))
            (not (zerop (mod y 100))))))

(defun nmon (n)
   (let ((m (position n month :test #'<)))
      (values m (+ 1 (- n (svref month (- m 1)))))))

(defun year-days (y) (if (leap? y) 366 365))

(defun num-year (n)
  (if (< n 0)
    (do* ((y (- yzero 1) (- y 1))
          (d (- (year-days y)) (- d (year-days y))))
         ((<= d n) (values y (- n d))))
    (do* ((y yzero (+ y 1))
          (prev 0 d)
          (d (year-days y) (+ d (year-days y))))
         ((> d n) (values y (- n prev))))))

(defun year-num (y)
   (let ((d 0))
      (if (>= y yzero)
          (dotimes (i (- y yzero) d)
            (incf d (year-days (+ yzero i))))
          (dotimes (i (- yzero y) (- d))
            (incf d (year-days (+ y i)))))))

(defun month-num (m y)
    (+ (svref month (- m 1))
       (if (and (> m 2) (leap? y)) 1 0)))

(defun num-month (n y)
   (if (leap? y)
       (cond ((= n 59) (values 2 29))
             ((> n 59) (nmon (- n 1)))
             (t        (nmon n)))
       (nmon n)))

(defun num->date (n)
  (multiple-value-bind (y left) (num-year n)
     (multiple-value-bind (m d) (num-month left y)
      (values d m y))))

(defun date->num (d m y)
    (+ (- d 1)  (month-num m y) (year-num y)))

(defun date+ (d m y n)
   (num->date (+ (date->num d m y) n)))

(deftest inttodate () 
  (check (equalp 
    '(19 5 2012) 
    (multiple-value-bind (x y z) (date+ 1 1 2009 1234) (list x y z)))))

;;; 5.3 Conditionals

(deftest conditionals ()
  (let ((wannapass t))
    (check (if wannapass
      t
      nil))))

;;; 5.4 Iteration

(deftest multiplyfive ()
  (check (equalp
    '(5 10 15)
    (let ((x '(1 2 3)))
      (mapcar #'(lambda (y) (setf y (* y 5))) x)))))

;;; 5.4 Iteration (Again)

(deftest fivefactorial ()
  (check (equalp
    120
    (let ((result 1))
      (dotimes (x 5 result)
        (setf result (* result (+ x 1))))))))
