(defparameter *handlers* nil)

(defun handler (x)
  (let ((what (cdr (assoc (intern (string-upcase x)) *handlers* ))))
    (if what
	(funcall what)
	(error "310 error: no handler for ~a" x))))

(defun register (withThis this)
  (let ((maker (intern  (string-upcase (format nil "make-~a" withThis)))))
    (push (cons this maker) *handlers*)))

(register 'tagwidth   'width)
(register 'tagheight  'height)
(register 'tagrange   'range)
(register 'taglabel   'label)
(register 'tagleft    'left)
(register 'tagbottom  'bottom)
(register 'tagmb      'mb)

; Handle comments
(defmethod linesForAt ((x tagpound) words this line)
  )

; Set the width
(defmethod linesForAt ((x tagwidth) words this line)
  (if words
    (setf (graph-w this) (parse-integer (first words)))
    (error "310 error: ~a) expected 1 argument" line)))

; Set the height
(defmethod linesForAt ((y tagheight) words this line)
  (if words
      (setf (graph-h this) (parse-integer (first words)))
      (error "310 error: ~a) expected 1 argument" line)))

; Set x and y ranges
; xmin ymin xmax ymax
(defmethod linesForAt ((rng tagrange) words this line)
  (if (= (length words) 4)
      (progn ;going to have to use asInteger() on these values
	(setf (range-min (graph-xrange this)) (nth 0 words))
	(setf (range-min (graph-yrange this)) (nth 1 words))
	(setf (range-max (graph-xrange this)) (nth 2 words))
	(setf (range-max (graph-yrange this)) (nth 3 words)))
      (error "fail at getting range on line ~a" line)))

; Can has a label now?
(defmethod linesForAt ((l taglabel) words this line)
  (if (> (length words) 0)
      (setf (graph-label this) (lst2str words))
      (error "your label sucks, check line (~a)" line)))

; Start handling bottom ticks
(defmethod linesForAt ((b tagbottom) words this line)
  (if (> (length words) 1)
      (progn
	(dolist (x (cdr words))
	  (push x (ticks-point (graph-tagbottom this)))))
      (error "failed handling bottom ticks at: ~a" line)))

; Start handling left ticks
(defmethod linesForAt ((b tagleft) words this line)
  (if (> (length words) 1)
      (progn
	(dolist (x (cdr words))
	  (push x (ticks-point (graph-tagleft this)))))
      (error "Failed handling left ticks at: ~a" line)))

; mb stuff
(defmethod linesForAt ((eqn tagmb) words this line)
  )
		       
