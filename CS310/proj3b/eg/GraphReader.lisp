(dolist (line (file->lines "eg/1.dat"))
  (print line)
  (let ((words (string-split line)))
    (dolist (word words)
      (if (isInteger word)
	  (print (asInteger word))
	(print word)))))

(print (file->lines "eg/1.dat"))

(print (parse-integer "23" :junk-allowed t))
