(defun datap (words)
  (isNumber (first words)))

(defun lineFor (reader words graph)
  (if (isInteger (first words))
      (lineForData reader words graph)
      (lineForNonData reader words graph)))

(defun lineForNonData (reader words graph)
  (let* ((thing       (first words))
	 (otherWords  (rest words))
	 (klass       (handler thing)))
    (linesForAt klass otherWords graph (graphreader-line reader))))

(defun lineForData (reader words graph)
  ;not implemented yet
  t)

; kinda kike linesFor in GraphReader
(defun file->graph (file &optional 
		    (graphreader (make-graphreader))
		    (graph       (make-graph)))
  (setf (graphreader-line graphreader) 0)
  (dolist (line (file->lines file))
    (incf (graphreader-line graphreader))
    (let ((words (string-split line)) (firstChar #\#))
      (if (> (length words) 0)
	  (lineFor graphreader words graph))))
  graph
)

(defun checkLeft (gram)
  (dolist (one (mapcar #'first gram))
    (if (eql (countr one (mapcar #'cddr gram) 0))
	(print "~a not found" one)
	t)
     ))
