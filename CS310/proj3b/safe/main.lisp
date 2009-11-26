#!/usr/bin/env clisp

(load "0lib.lisp")
(load "1classes.lisp")
(load "range.lisp")

(let ((r (make-range)))
  (dolist (i '(1 2 2 4 6 6  2 2 5 2 2 56576 20))
    (add r i))
  (print r)
  (print (scale r 25000)))
