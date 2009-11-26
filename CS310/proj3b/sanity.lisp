; This is the general purpose sanity checker!

(defvar *tagsToCheck*)
(setf *tagsToCheck* '(range)) ; Add tags to that quoted list as you find fitting

(defun checkSpec (inSpec)
  (let* ((assocList (split-sequence 'NL inSpec :remove-empty-subseqs t)))
    (dolist (ttc *tagsToCheck*) ; Check each item in the checkable list of tags
      (let* ((daList (assoc ttc assocList))) ; get the tag and it's arguments
	(if ; wish I could do this like lineForNonData
	 (eql (first daList) 'RANGE)
	 (progn
	   (if (and
		; "range xmin ymin xmax ymax
		(< (elt daList 1) (elt daList 3))
		(< (elt daList 2) (elt daList 4)))
	       (progn
		 (print "they're good!")
		 t)
	       (print "They're not good. Range is wrong!"))))))))
