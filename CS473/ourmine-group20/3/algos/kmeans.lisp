;;; K-Means:

;;; Claimee: Elijah

(format t " - Loading k-Means~%") ;; Output for a pretty log

(defun deep-copy-clusters (clusters)
  (dolist (cluster clusters clusters)
     (setf cluster (make-eg :features (copy-list (eg-features cluster)) :class (eg-class cluster)))))

(defun new-random-k-means-centroids (table &optional (num-needed 1))
  (if (> num-needed (length (table-all table)))
      (setf num-needed (length (table-all table))))
  (let ((newclusters nil) (num-fields (length (table-all table))))
    (dotimes (n num-needed newclusters)
      (setf newclusters (append (list (nth (random num-fields) (table-all table))) (deep-copy-clusters newclusters)))
    )
  )
)

(defun compute-euclidean-distance (cluster row columns)
  (let ((summ 0) 
        (c (eg-features cluster))
        (r (eg-features row)))
    (dotimes (i (length c))
      (if (numeric-p (nth i columns))
          (setf summ (+ summ (expt (- (nth i c) (nth i r)) 2)))))
    (sqrt summ)))

(defun classify-row (clusters row columns)
  (let ((assignment -1) (temp 0) (distance 0))
    (dotimes (i (length clusters)) 
      (if (or (< (setf temp (compute-euclidean-distance (nth i clusters) row columns)) distance) (= assignment -1))
          (progn (setf assignment i)
                 (setf distance temp)))) assignment))

(defun classify-table (clusters table)
  (let ((assignments NIL))
    (dolist (row (table-all table) assignments)
      (setf assignments (append assignments (list (classify-row clusters row (table-columns table))))))))

;;;(defun adjust-cluster (cluster table assignments)
;;;  (let 

(defun set-cluster-numeric-means (clusters table assignments)
  (let ((counts NIL) (temp NIL))
    (dotimes (i (length clusters) clusters)
     (dotimes (j (length (table-columns table)))
       (if (= i 0)
         (setf temp (append temp (list 0)))
         (setf (nth j temp) 0)))
     (setf counts (append counts (list 0)))
      (dotimes (j (length (table-all table)))
        (if (= i (nth j assignments))
            (progn 
             (dotimes (k (length (eg-features (nth j (table-all table)))))
               (if (numeric-p (nth k (table-columns table)))
                (setf (nth k temp) (+ (nth k temp) (nth k (eg-features (nth j (table-all table))))))))
             (incf (nth i counts)))))
      (if (not (zerop (nth i counts)))
        (dotimes (j (length (eg-features (nth i clusters))))
          (if (numeric-p (nth j (table-columns table)))
            (setf (nth j (eg-features (nth i clusters))) (/ (nth j temp) (nth i counts)))))
        (setf clusters (remove (nth i clusters) clusters)))
)))

(defun k-means (table &optional (num-clusters 3) (repititions 10))
  (let ((clusters (new-random-k-means-centroids table num-clusters)) (assignments NIL) (fin NIL))
    (dotimes (i repititions)
       (setf assignments (classify-table clusters table))
       (set-cluster-numeric-means clusters table assignments))
    (dotimes (i (length clusters))
      (setf fin (append fin (list NIL)))
      (dotimes (j (length (table-all table)))
        (if (= i (nth j assignments))
          (if (null (nth i fin))
            (setf (nth i fin) (create-a-single-line-table j table))
            (setf (table-all (nth i fin)) (append (table-all (nth i fin)) (list (nth j (table-all table))))))))) fin))


