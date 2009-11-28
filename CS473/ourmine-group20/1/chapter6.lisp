;;; 6.1 Global Functions

(defun negativate (n)
  "Takes an integer and performs a permutation upon it to mirror it's value across the integer spectrum."
  (* n -1))

(deftest global () 
  (check (equalp
    -8
    (negativate 8))
  )
)

;;; Figure 6.1 Utility Functions [Required]

;;; 6.3 Parameter Lists

(defun makelist (x &rest args)
  (list x args))

(deftest paramlists ()
  (check (equalp
    '(A (B C))
    (makelist 'A 'B 'C))))

;;; 6.3 Parameter Lists (Part 2 - Optional Args)

(defun hasoptionals (a b &optional (c 10))
  (list a b c))

(deftest optionalargs ()
  (check (equalp
    '(1 2 10)
    (hasoptionals 1 2))))

;;; 6.4 Utilities

(deftest appending ()
  (check (equalp
    '(A B C D)
    (append '(A B) (cons 'C '(D))))))

