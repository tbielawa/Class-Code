;;;; columns isa list of header

(defmacro doitems ((one n list &optional out) &body body )
  `(let ((,n -1))
     (dolist (,one ,list ,out)  (incf ,n) ,@body)))

(defun numericp (x)
  (equal (char (symbol-name x) 0) #\$))

(defun ignorep (x)
  (and (symbolp x)
       (equal (char (symbol-name x) 0) #\?)))

(defun columns-new (cols klass)
  (let (tmp)
    (doitems (col i cols)
      (let ((new  
	     (if (numericp col)
		 (make-numeric :name col :ignorep (ignorep col) :classp  (= i klass))
		 (make-discrete :name col :ignorep (ignorep col) :classp (= i klass)))))
	(push new tmp)))
    (reverse tmp)))

(defun columns-header (cols)
  (mapcar #'header-name cols))

(defun unknownp (x)
  (ignorep x))
