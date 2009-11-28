;; Naive bays basically breaks the data set into groups basd on each column and the outcome. So, for each column, it breaks the data into classes and then finds the class ratios - so determines how often a particular value for a class occurs for each outcome... multiply the ratios and then output which is more likely.

;; Claimee: Elijah -- Completed

(print " - Loading Naive-Bayes") ;; Output for a pretty log

(defun freq-given-class-and-feature-number (learned fnum klass)
  (dolist (cklass learned)
    (if (not (eql klass (car cklass)))
        nil
        (return (nth fnum (third cklass))))))

(defun compute-prob-for-class (learned features klass)
  (let ((prob 1))
    (dotimes (n (length features))
      (let ((lfeat (freq-given-class-and-feature-number learned n klass)))
        (dolist (clfeat lfeat)
          (if (eql (car clfeat) (nth n features))
            (setf prob (* prob (second clfeat)))))))
  prob ))

(defun predict-outcome-given-features (learned features)
  (let ((prob 0) (klass nil) (temp 0))
  (dolist (cklass learned)
    (setf temp (compute-prob-for-class learned features (car cklass)))
    (if (< prob temp)
        (progn (setf prob temp) (setf klass (car cklass))))) klass))

(defun predict-all-outcomes-given-table (learned table)
  (let ((predictions nil))
    (dolist (row (tablerows table))
       (push (predict-outcome-given-features learned row) predictions)) (reverse predictions)))

(defun refine-frequency-counts (learned total &optional (k 1) (m 2))
  (mapcar 
    #'(lambda (klass) 
         (let ((numClass (second klass)))
         (setf (second klass) (/ (+ (second klass) k) (+ total (* k 2))))
         (mapcar 
          #'(lambda (l) 
              (mapcar 
                #'(lambda (feat) (setf (second feat) (/ (+ (second feat) (* m (second klass))) (+ m numClass))))
                l))
          (third klass)))) 
    learned))

(defun naivebayes (train table)
  (let ((learned (count-classes train))
        (total-rows (length (table-all train )))
        (predictions nil)
        (emperical nil)
        (result nil))
    (setf learned (mapcar #'(lambda (klass) (setf klass (append klass (list (list-unique-features-by-class train (car klass)))))) learned))
    (refine-frequency-counts learned total-rows)
    (setf predictions (predict-all-outcomes-given-table learned table))
    (setf emperical (dolist (row (table-all table) (reverse emperical))
                      (push (eg-class row) emperical)))
    (setf result (dotimes (n (length predictions) (reverse result))
                      (push (list (nth n predictions) (nth n emperical) (equalp (nth n predictions) (nth n emperical))) result)))
))
