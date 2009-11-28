;; Main
;; This file loads the basic function for each of our data mining techniques
;; and defuns the learn function - which executes them based on function passing

(format t "Loading Utility Libraries...~%")
(load "utils/suppression")
(suppress-style-warnings (load "lib/loaddeps"))
(load "utils/utils")
(format t " - Complete.~%")

(format t "Loading Pre-processors...~%")
(load "algos/subsample")
(load "algos/normalize")
(format t " - Complete.~%")

(format t "Loading Discretizers...~%")
(load "algos/nbins")
(load "algos/binlogging")
(load "algos/nchops")
(format t " - Complete.~%")

(format t "Loading Clusterers...~%")
(load "algos/genic")
(load "algos/kmeans")
(format t " - Complete.~%")

(format t "Loading Feature Subset Selectors...~%")
(load "algos/relief")
(load "algos/infogain")
(format t " - Complete.~%")

(format t "Loading Classifiers...~%")
(load "algos/naivebayes")
(suppress-warnings (load "algos/twor"))
(suppress-style-warnings (load "algos/2b"))
(load "algos/prism")
(format t " - Complete.~%")

(format t "Loading Data Sets...~%")
(load "d-data/weathernumerics")
(load "d-data/boston-housing")
(load "d-data/mushroom")
(load "d-data/weather")
(load "d-data/additionalbolts")
(format t " - Complete.~%")

(format t "Loading Learner Functions...~%")
(defun learn (&key 	(k 	3)
			(preprocessor	#'subsample)
			(discretizer	#'binlogging)
			(clusterer	#'k-means)
			(fss		#'relief)
			(classifier	#'naivebayes)
			(train		#'weather-numerics)
			(test		#'weather-numerics))
  (let 
      ((training (funcall train))
       (testing (funcall test))
       (clusters nil)
       (results nil))
    
    (format t "Running Tables through Preprocessor...")
    (setf training (funcall preprocessor training))
    (setf testing (funcall preprocessor testing))
    (format t " - Preprocessor Complete.~%")
    

    (format t "Running Tables through Discretizer...")
    (setf training (funcall discretizer training))
    (setf testing (funcall discretizer testing))
    (format t " - Discretizer Complete.~%")


    (format t "Running Training Tables through Clusterer...")
    (setf clusters (funcall clusterer training k))
    (format t" - Clustering Complete.~%")


    (if (not (listp clusters))
	(setf clusters (list clusters)))
   
    (setf clusters (remove nil clusters))

    (format t "Pruning Cluster with FSS...")
    (dolist (cluster clusters)
      (setf cluster (funcall fss cluster)))
    (format t " - Pruning Complete.~%")

    (format t "Running Classifier...")
    (cond
      ((equalp classifier #'naivebayes) 
        (setf results (dolist (cluster clusters)
          (format t "~:{~& ~6D ~8@A ~8@A~}" (funcall classifier cluster testing)))))
      ((equalp classifier #'2b) 
        (setf results (dolist (cluster clusters)
          (format t "~:{~& ~6D ~8@A ~8@A~}" (funcall classifier cluster testing)))))
      ((equalp classifier #'prism) 
        (setf results (dolist (cluster clusters)
          (print (funcall classifier cluster)))))    

      ((equalp classifier #'twor) (format t "### TwoR not yet Complete. ###~%")))
    (format t " - Classifier Complete.~%")))    

(defun learn-nb-weather-numerics () (learn))

(defun learn-nb-mushroom () (learn :train #'mushroom :test #'mushroom))

(defun learn-nb-boston-housing () (learn :train #'boston-housing :test #'boston-housing))

(defun learn-prism-weather2 () (learn :classifier #'prism :test #'weather2 :train #'weather2))

(defun learn-2b-weather-numerics () (learn :classifier #'2b))

(defun learn-2b-mushroom () (learn :classifier #'2b :train #'mushroom :test #'mushroom))

(defun learn-2b-boston-housing () (learn :classifier #'2b :train #'boston-housing :test #'boston-housing))

(defun learn-prism-group1bolts () (learn :classifier #'prism :test #'group1bolts :train #'group1bolts))

(format t " - Complete.~%~%~%")

(format t "Established Trials:~%")
(format t " Naive-bayes:~%")
(format t "  (learn-nb-weather-numerics)~%  (learn-nb-mushroom)~%  (learn-nb-boston-housing)~%")
(format t " Prism:~%")
(format t "  (learn-prism-weather2)~%  (learn-prism-group1bolts)~%")
(format t " 2b:~%")
(format t "  (learn-2b-weather-numerics)~%  (learn-2b-mushroom)~%  (learn-2b-boston-housing)~%")

