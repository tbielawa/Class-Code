; This is the caller of the sanity checker


(dotimes (i 20)
  (let ((spec (generate '?spec)))
    (if (checkSpec spec)
	(spec->lines spec))))
