;; 2b
;; Pre-Processor to Naive Bayes.
;;; Shaggy
;; Requires twor.lisp and naivebayes.lisp be loaded.
;; The pair-table macro returns an xindex'd table of all the rows paired.

(format t " - Loading 2b~%") ;; Output for a pretty log

(defun 2b (train test)
  (naivebayes (pair-table train) (pair-table test)))
