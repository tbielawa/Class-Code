(defstruct point x y)
(defun    @ (x y)  (make-point :x x :y y))
(defmacro x (p)    `(point-x ,p))
(defmacro y (p)    `(point-y ,p))

(defun file->lines (f)
  (with-open-file (str f) 
    (stream->lines  str)))

(defun stream->lines (str)
  (let ((line (read-line str nil)))
    (if line
	(cons line
	      (stream->lines str)))))

(defun string-split (string &optional (on-chars '(#\Newline #\Space #\Return #\Tab #\Vt)))
  (do ((i 0 (1+ i))
       (parts (list (make-array 16 :element-type 'character :fill-pointer 0 :initial-element #\_))))
      ((>= i (length string)) (nreverse parts))
    (if (find (aref string i) on-chars)
	(unless (zerop (length (first parts)))
	  (push (make-array 16 :element-type 'character :fill-pointer 0 :initial-element #\_)
		parts))
	(vector-push-extend (aref string i) (first parts)))))

(defun isInteger (x)
  (parse-integer x :junk-allowed t))

(defun asInteger (x)
  (parse-integer x))

(defun mappend (fn list)
  (apply #'append (mapcar fn list)))

(defun lst2str (lstIn)
  (string-right-trim " " (format nil "~{~A ~}" lstIn)))

