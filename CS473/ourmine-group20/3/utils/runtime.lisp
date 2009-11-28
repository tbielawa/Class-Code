(format t " - Loading Runtime Utils~%") ;; Output for a pretty log

(defun runtime (runnable)
  (let ((start (get-internal-real-time)))
       (funcall runnable)
       (/ (float (- (get-internal-real-time) start)) 1000.0)))


