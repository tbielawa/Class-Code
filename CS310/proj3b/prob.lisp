
(defun firstNum (sym)
  ; Extracts the first char from a symbol and convert to an int
  (parse-integer (string (elt (string sym) 0)) :junk-allowed t))

(defun restSym (sym)
  ; Returns the symbol without the first char
  (intern (subseq (string sym) 1)))

(defun probs (list)
  ; Returns a list made up of lists repeated by the number in the 0th index
  ; eg: ((2 test)) -> ((test) (test))
  (let (new i) 
    (dolist (one list)
      (setf i (first one))		 
      (dotimes (j i)
	(push (rest one) new)))
    new))

(defun expGram ()
  (dotimes (i 21)
    (setf (rest (rest (nth i q))) (probs (rest (rest (nth i q)))))))

(defun probExp (gram)
  (let (new) 
    (dolist (one (rhs gram))
      (push (probs one) new))
    new))

(defvar q *sci-prob*)


