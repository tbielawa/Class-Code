;; Main
;; This file loads the basic function for each of our data mining techniques
;; and defuns the learn function - which executes them based on function passing

(print "Loading Utility Libraries...")
(load "lib/loaddeps")
(load "utils/utils")
(print "Complete.")

(print "Loading Pre-processors...")
(load "algos/subsample")
(print "Complete.")

(print "Loading Discretizers...")
(load "algos/nbins")
(load "algos/binlogging")
(print "Complete.")

(print "Loading Clusterers...")
(load "algos/genic")
(print "Complete.")

(print "Loading Feature Subset Selectors...")
(load "algos/relief")
(print "Complete.")

(print "Loading Classifiers...")
(load "algos/naivebayes")
;;(load "algos/twor")
(print "Complete.")

(print "Loading Data...")
(load "d-data/weathernumerics")
(load "d-data/boston-housing")
(load "d-data/mushroom")
(print "Complete.")

(defun learn (&key 	(k 	3)
			(preprocessor	#'subsample)
			(discretizer	#'binlogging)
			(clusterer	#'genic)
			(fss		#'relief)
			(classifier	#'naivebayes)
			(train		#'boston-housing)
			(test		#'boston-housing))
  (let 
      ((training (funcall train))
       (testing (funcall test))
       (clusters nil)
       (cluster nil)
       (results nil))
    
    (format t "Running Tables through Preprocessor...")
    (setf training (funcall preprocessor training))
    (setf testing (funcall preprocessor testing))
    (format t " - Preprocessor Complete.~%")


    (format t "Running Tables through Discretizer...")
    (setf training (funcall discretizer training))
    (setf testing (funcall discretizer testing))
    (format t " - Discretizer Complete.~%")
    (print training)


    (format t "Running Training Tables through Clusterer...")
    (setf clusters (funcall clusterer training k))
    (format t" - Clustering Complete.~%")


    (if (not (listp clusters))
	(setf clusters (list clusters)))
    (print clusters)


    (format t "Pruning Cluster with FSS...")
    (dolist (cluster clusters)
      (setf cluster (funcall fss cluster)))
    (format t " - Pruning Complete.~%")


    (format t "Running Analysis...")
    (dotimes (n (length (table-all testing)))
      (push results 
	    (first 
	     (funcall clusterer 
		      (nth 
		       (score-clusters (nth n (table-all testing)) (genic-clusters training 4 3) testing) clusters) (create-a-single-line-table n testing))))) 
    (format t " - Analysis Complete.~%")

 
    ;(print "Running FSS...")
    ;(setf training (mapcar fss training))
    ;(setf testing (mapcar fss testing))
    ;(print " - FSS Complete.")
    ; Comment these next two lines when you uncomment the FSS!!!!!!!!!!
    ;(setf training (list training))
    ;(setf testing (list testing))


    (format t "Running Classifier...")
;;     (funcall classifier training)
;;     (setf testing (mapcar #'(lambda (trainn) (funcall classifier trainn testing)) training))
;;     (setf testing (testiest-truthiness-list testing #'max))
;;     (print testing)
;;     (format t "Done.")
    (twor training testing)
    ))
;(learn)
