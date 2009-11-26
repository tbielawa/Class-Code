(setGrammar *sci-story*) ; We needs this

(defun nstories (times)
  (with-open-file (stream "story" :direction :output :if-exists :overwrite)
    (dotimes (i times)
      (progn
	(format stream "~a~%" i)
	(format stream "~a~%" (generate '?story))))))

(nstories 350)
 