; c.f printOn: aStream
(defmethod print-object ((x range) aStream)
  (format aStream "~a .. ~a" (range-min x) (range-max x)))

(defmethod add ((x range) aNumber)
  (rmin x aNumber)
  (rmax x aNumber))

(defmethod rmin ((x range) aNumber)
  (setf (range-min x) (min (range-min x) aNumber)))

(defmethod rmax ((x range) aNumber)
  (setf (range-max x) (max (range-max x) aNumber)))

(defmethod scale ((x range) aNumber)
  (float 
   (/ (- aNumber (range-min x))
      (- (range-max x) (range-min x)))))

