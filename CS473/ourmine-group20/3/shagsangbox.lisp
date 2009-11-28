; Infogain + various utility functions
;(load "algos/twor.lisp")
(load "algos/normalize.lisp")
(load "algos/infogain.lisp")
(load "utils/utils.lisp")

; Data sets
(load "d-data/weather.lisp")
(load "d-data/weathernumerics.lisp")
(load "d-data/mushroom.lisp")
(load "d-data/boston-housing.lisp")
(load "d-data/additionalbolts.lisp")

(defparameter daters '(group1bolts boston-housing mushroom weather2 weather-numerics))

; Discretizers
(load "algos/nbins.lisp")
(load "algos/binlogging.lisp")

; Shits and giggles....
(load "main.lisp")
(load "algos/twor.lisp")


(dolist (l (mapcar #'(lambda (x) (infogain (funcall x))) daters))
  (format t "|------------------------------------|~%")
  (print l))
  

;; (dolist (l (mapcar #'(lambda (x) (infogain (binlogging (funcall x)))) daters))
;;  (format t "|------------------------------------|~%")
;;  (printhash l))
