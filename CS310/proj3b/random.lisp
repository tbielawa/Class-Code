(defparameter *seed0* 10013)
(defparameter *seed*  *seed0*)

(defun reset-seed () (setf *seed* *seed0*))

; This is the Park-Miller multiplicative congruential randomizer
;  (CACM, October 88, Page 1195). Creates pseudo random floating
;  point numbers in the range 0.0 <= x <= 1.0.
(defun park-miller-randomizer ()
   (let ((multiplier 
	 16807.0d0);16807 is (expt 7 5)
	(modulus 
	 2147483647.0d0)) ;2147483647 is (- (expt 2 31) 1)
    (let ((temp (* multiplier *seed*)))
      (setf *seed* (mod temp modulus))
      (/ *seed* modulus))))

;My-random returns a pseudo random floating-point number
;  in range 0.0 <= number <= n.

 (defun my-random (n)
  (let ((random-number (park-miller-randomizer)))
    (* n (- 1.0d0 random-number))))

;My-random-int returns a pseudo random integer 
;  in range 0 <= number <= n-1.
(defun my-random-int (n)
  (let ((random-number (/ (my-random 1000.0) 1000)))
    (floor (* n random-number))))
