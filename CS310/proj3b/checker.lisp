(defun variable-p (x)
  "Is x a variable (a symbol beginning with `?')?"
  (and (symbolp x)
       (eql 
	(elt (symbol-name x) 0)       
	#\?)))

(defun checkLeft (gram)
  ; LHF check for nonterminals not appearing in RHS
  (dolist (one (rest (lhs gram)))
    (if (eql (countr one (rhs gram)) 0)
	(format t "~a not found on RHS ~%" one))))

(defun checkRight (gram)
  ; RHS check for any undfined non terminals
  (dolist (one (lister(rhs gram)))
    (if (eql (countr one (lhs gram)) 0)
	(format t "~a not found on LHS ~%" one))))

(defvar *foundList* ())

(defun listerB (inlist)
  ; Converts a list of lists to one big list
  (dolist (one inlist)                    
    (if (listp one)                      
	(lister one)
	(if (and 
	     (variable-p one)
	     (not (member one *foundList*)))
	    (push one *foundList*))))
  *foundList*)

(defun lister (inlist)
  ; Calls listerB after reseting global to nil to avoid appending
  (setf *foundList* nil)
  (listerB inlist)
  *foundList*)

(defun rhs (gram)
  ; Returns RHS of a grammar
  (mapcar #'cddr gram))

(defun lhs (gram)
  ; Returns LHS of a grammar
  (mapcar #'first gram))
