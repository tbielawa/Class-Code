;;; INTRODUCING: Lazy evaluation!  When you have cyclical dependancies and you don't want your
;;;   Lisp machine to bitch and moan, use Ultradyne System's brand new Lazy Evaluation!  Bring
;;;   your CL code into the 20th century with the ability to call before declaration!

(defmacro lazy (expr) `(lambda () ,expr))

;;; WARNING: May cause irratable feet, swollen hair, achy earlobes, and/or compressed nostrils.
