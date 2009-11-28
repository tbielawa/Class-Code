;(load "lib/loaddeps")
;(load "utils/utils")
;(load "d-data/mushroom")
;(load "d-data/boston-housing")
(load "d-data/weather")

;(defparameter mushtable (mushroom))
;(defparameter housetable (boston-housing))
(defparameter weathertable (weather2))

;;; Claimee: Drew

;;; For each class C 
;;;   Initialize E to the instance set 
;;;   While E contains instances in class C 
;;;     Create a rule R with an empty left-hand side that predicts class C 
;;;     Until R is perfect (or there are no more attributes to use) do 
;;;       For each attribute A not mentioned in R, and each value v, 
;;;         Consider adding the condition A = v to the left-hand side of R 
;;;         Select A and v to maximize the accuracy p/t 
;;;           (break ties by choosing the condition with the largest p) 
;;;       Add A = v to R 
;;;     Remove the instances covered by R from E 

;;; (count-classes table)

(defun generate-attribute-value-pairs (table)
  (let ((col-names (table-columns table)) (unique-features (list-unique-features table)) (pairs nil))
    (dotimes (i (length (table-columns table)))		;;; For each column.
      (let ((values nil))
        (dolist (element (nth i unique-features))
          (setf values (append values (list (first element))))
        )
        (if (realp (first values))
          (setf pairs (append pairs (list (list (numeric-name (nth i col-names)) (copy-list values)))))
          (setf pairs (append pairs (list (list (discrete-name (nth i col-names)) (copy-list values)))))
        )
      )
    )
    pairs
  )
)

(defun remove-nth (n in-list)
  (remove (nth n in-list) in-list)
)

(defun unique-table-classes (table)
  (let ((classes nil) (class-count (count-classes table)))
    (dolist (x class-count)
      (setf classes (append classes (list (first x))))
    )
    classes
  )
)

(defun generate-attribute-list (table)
  (let ((attributes nil))
    (dotimes (i (length (eg-features (first (table-all table)))))
      (setf attributes (append attributes (list i)))
    )
    (remove-nth (- (length attributes) 1) attributes)
  )
)

(defun score-attribute (table subset attribute-num class)
  (let ((best-value nil) (best-score nil) (values (second (nth attribute-num (generate-attribute-value-pairs table)))))
    (dotimes (i (length values))
      (let ((passes 0) (fails 0))
        (dolist (row subset)
          (if (and (equalp class (eg-class row)) (equalp (nth attribute-num (eg-features row)) (nth i values)))
            (incf passes)
          )
          (if (and (not (equalp class (eg-class row))) (equalp (nth attribute-num (eg-features row)) (nth i values)))
            (incf fails)
          )
        )
        (if (or (null best-score) (and (zerop fails) (> passes 0)) (> (/ passes (+ passes fails)) best-score))
          (setf best-value (nth i values) best-score (/ passes (+ passes fails)))
        )
      )
    )
    (list best-value best-score)
  )
)

(defun best-attribute (table subset attribute-nums class)
  (let ((best-attribute nil) (best-attribute-score -1))
    (dotimes (i (length attribute-nums))
      (if (< best-attribute-score (second (score-attribute table subset (nth i attribute-nums) class)))
        (setf best-attribute i best-attribute-score (second (score-attribute table subset (nth i attribute-nums) class)))
      )
    )
    best-attribute
  )
)

(defun purge-rule-matches (subset attribute-num attribute-val class)
  (let ((new-subset nil))
    (dotimes (i (length subset))
      (if (not (and (equalp (nth attribute-num (eg-features (nth i subset))) attribute-val) (equalp (eg-class (nth i subset)) class)))
        (setf new-subset (append new-subset (list (nth i subset))))
      )
    )
    new-subset
  )
)

(defun prism (table)
  (let ((rules nil) (temp-rule nil) (class-num -1))
    (dolist (class (unique-table-classes table))
      (incf class-num)
      (setf temp-rule (list class))
      (let ((rule-score 0) (subset (copy-list (table-all table))) (attribute-list (generate-attribute-list table)))
        (loop until (or (equalp rule-score 1) (null attribute-list)) do
          (let ((fittest-attribute nil) (attribute-value nil))
            (setf 
              fittest-attribute (best-attribute table subset attribute-list class)
              rule-score (/
                           (+ rule-score (second (score-attribute table subset (nth fittest-attribute attribute-list) class)))
                           (second (nth class-num (count-classes table)))) 
              attribute-value (first (score-attribute table subset (nth fittest-attribute attribute-list) class))
            )
            (if (realp attribute-value)
              (setf temp-rule (append temp-rule (list (list (numeric-name (nth (nth fittest-attribute attribute-list) (table-columns table))) attribute-value))))
              (setf temp-rule (append temp-rule (list (list (discrete-name (nth (nth fittest-attribute attribute-list) (table-columns table))) attribute-value))))
            )
            (setf attribute-list (remove-nth fittest-attribute attribute-list))
          )
        )
        (setf rules (append rules (list temp-rule)))
      )
    )
    rules
  )
)

