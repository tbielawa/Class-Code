;;; GenIc: 

;;; Claimee: Drew

(print " - Loading Genic") ;; Output for a pretty log

(defun new-random-center (table &optional (num-needed 1))
  (let ((newclusters nil) (new-center nil) (num-fields (- (length (table-all table)) 1)))
    (dotimes (n num-needed)
      (setf new-center (nth (random num-fields) (table-all table)))
      (setf newclusters (append newclusters (list new-center)))
    )
    (if (equalp 1 (length newclusters))
      (car newclusters)
      newclusters
    )
  )
)

(defun fetch-generation (table gen-size generation)
  (let ((start (* gen-size generation)) (end (* gen-size (+ 1 generation))) (subset nil))
    (if (> end (length (table-all table)))
      (setf end (- (length (table-all table)) 1))
    )
    (loop for n from start to end do
      (setf subset (append (list (nth n (table-all table))) subset))
    )
    subset
  )
)

(defun closest-center (centers new-point)
  (let ((distances (make-list (length centers) :initial-element 0)))
    (dotimes (i (length centers))
      (dotimes (j (length (eg-features new-point)))
        (if (numericp (nth j (eg-features new-point)))
          (setf 
            (nth i distances) 
            (+ 
              (nth i distances) 
              (sqrt (expt (- (nth j (eg-features new-point)) (nth j (eg-features (nth i centers)))) 2))     
            )
          )
          (if (not (equalp (nth j (eg-features new-point)) (nth j (eg-features (nth i centers)))))
            (incf (nth i distances))
          )
        )
      )
    )
    (let ((shortest-dist nil) (shortest-pos nil))
      (dotimes (k (length distances))
        (if (or (null shortest-dist) (< (nth k distances) shortest-dist))
          (setf shortest-dist (nth k distances) shortest-pos k)
        )
      )
      shortest-pos
    )
  )
)

(defun move-center (existing-center new-point weight)
  (let ((existing-features (copy-list (eg-features existing-center))) (new-features (eg-features new-point)))
    (dotimes (i (length existing-features))
      (let ((col-val-old (nth i existing-features)) (col-val-new (nth i new-features)))
        (if (numericp col-val-old)
          (setf
            (nth i existing-features)
            (/ (+ (* weight col-val-old) col-val-new) (+ weight 1))
          )
          (if (and (not (equalp col-val-old col-val-new)) (equalp weight 1))
            (setf (nth i existing-features) col-val-new)
          )
        )
      )
    )
    (make-eg :features existing-features :class (eg-class existing-center))
  )
)

(defun cull-centers (centers weights table)
  (let ((weights-sum 0))
    (dolist (i weights)
      (setf weights-sum (+ i weights-sum))
    )
    (dotimes (i (length centers))
      (if (< (* (/ (nth i weights) weights-sum) 100) (random 100))
        (setf (nth i centers) (new-random-center table))
      )
    )
    centers
  )
)

(defun linear-distance (point-a point-b)
  (let ((distance 0))
    (dotimes (j (length (eg-features point-a)))
      (if (numericp (nth j (eg-features point-a)))
        (setf 
          distance
          (+ 
            distance
            (sqrt (expt (- (nth j (eg-features point-a)) (nth j (eg-features point-b))) 2))     
          )
        )
        (if (not (equalp (nth j (eg-features point-a)) (nth j (eg-features point-b))))
          (incf distance)
        )
      )
    )
    distance
  )
)

(defun merge-centers (centers num-result-centers)
  (let ((shortest-distance-seen nil) (center-a nil) (center-b nil))
    (loop while (> (length centers) num-result-centers) do
      (loop for i from 0 to (- (length centers) 1) do
        (loop for j from 0 to (- (length centers) 1) do
          (if (not (equalp i j))
            (if (or (null shortest-distance-seen) (null center-a) (null center-b) (< (linear-distance (nth i centers) (nth j centers)) shortest-distance-seen))
              (setf
                shortest-distance-seen (linear-distance (nth i centers) (nth j centers))
                center-a i
                center-b j
              )
            )
          )
        )
      )
      (let ((new-centers nil))
        (loop for k from 0 to (- (length centers) 1) do
          (if (and (not (equalp k center-a)) (not (equalp k center-b)))
            (setf new-centers (append new-centers (list (nth k centers))))
          )
        )
        (setf centers (append new-centers (list (move-center (nth center-a centers) (nth center-b centers) 1))))
      )
    )
  )
  centers
)

(defun reset-weights (weights)
  (fill weights 1)
)

(defun genic-clusters (table &optional (generation-size 10) (num-initial-centers 10) (num-result-centers 10))
  (setf num-result-centers num-result-centers)
  (let ((generation nil) (centers nil) (centers-weight (make-list num-initial-centers)) (generations (ceiling (/ (length (table-all table)) generation-size))))
    ;;; (2) Setup random initial centers and fill out their weights.
    (setf centers (new-random-center table num-initial-centers))
    (reset-weights centers-weight)
    (loop for i from 0 to generations do
      (setf generation (fetch-generation table generation-size i))
      ;;; (3) For each individual in the generation, find the nearest center.
      ;;;     Then, reorient that center based on it's weight, and increase it's weight.
      (loop for j from 0 to (- (length generation) 1) do
        (let ((sample (nth j generation)))
          (let ((best-center (closest-center centers sample)))
            (setf 
              (nth best-center centers-weight) 
              (+ 1 (nth best-center centers-weight))
              (nth best-center centers)
              (move-center (nth best-center centers) sample (nth best-center centers-weight))
            )
          )
        )
      )
      ;;; (4) At the end of each generation, do the random culling where
      ;;;     percentage chances of survival are computed.  Reset weights.
      (cull-centers centers centers-weight table)
      (reset-weights centers-weight)
    )
    ;;; (5) Merge the closest centers until the number of returned
    ;;;     centeres is the number desired.
    (merge-centers centers num-result-centers)
  )
)

;;; (1) GENIC Parameters
(defun genic (table &optional (generation-size 10) (num-initial-clusters 10) (num-final-clusters 10))
  (let* ((clusters (genic-clusters table generation-size num-initial-clusters num-final-clusters)) (clustered-tables (make-list (length clusters))))
    (loop for n from 0 to (- num-final-clusters 1) do
      (setf 
        (nth n clustered-tables) (make-table)
        (table-name (nth n clustered-tables)) (table-name table)
        (table-columns (nth n clustered-tables)) (table-columns table)
        (table-class (nth n clustered-tables)) (table-class table)
        (table-cautions (nth n clustered-tables)) (table-cautions table)
        (table-indexed (nth n clustered-tables)) (table-indexed table)
      )
    )
    (dolist (x (table-all table) clustered-tables)
      (let ((target-table (closest-center clusters x)))
        (setf 
          (table-all (nth target-table clustered-tables)) 
          (append (table-all (nth target-table clustered-tables)) (list x)))
      )
    )
  )
)
