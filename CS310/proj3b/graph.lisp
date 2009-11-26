(defun frame (graph)
  (do ((x ox (incf x)))
      ((> x (- (graph-w graph) 1)))
    (plot graph (@ x (graph-oy graph))     #\-)
    (plot graph (@ x (- (graph-h) 1)) #\-))

  (do ((y oy (incf y)))
      ((> y (- (graph-h graph) 1)))
    (plot graph (@ ox y) #\|)
    (plot graph (@ (- (graph-h) 1) y) #\|))
)
(defun heightWidth ( graph &key 
			 (h (graph-h graph))
			 (w (graph-w graph)))
  (setf (graph-h graph) h
	(graph-w graph)  w)
  (resize graph))

(defun resize ()
  (setf (graph-matrix graph) 
	(make-array `(,(graph-h graph) 
		      ,(graph-w  graph)) 
		    :initial-element 0)))

(defun plot (graph point c)
  (setf (aref (graph-matrix graph) (x point) (y point)) c))

(defun splot (graph point string)
  (let ((n 0))
    (map 'string 
	 #'(lambda (c)
	     (plot graph (@ (+ n (x point)) (y point)) c)
	     (incf n)) ; same as (setf n (+ 1 n))
	 string)))
  
(defun xscale (graph aNum)
  (round 
   (* (scale (graph-xrange graph))
      (- (graph-w graph) 1 (graph-ox graph)))))

(defun yscale (graph aNum) x
  (round 
   (* (scale (graph-yrange graph))
      (- (graph-h graph) 1 (graph-ox graph)))))
