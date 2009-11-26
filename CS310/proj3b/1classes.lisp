(defstruct range 
  (min most-positive-fixnum) 
  (max (* -1 most-positive-fixnum)))

(defstruct graphReader 
  line array handler
  (comment-char #\# )
  )

(let ((h0 10)
      (w0 10)
      (ox0 6)
      (oy0 2))
  (defstruct graph
    (label  " ")
    (xrange (make-range))
    (yrange (make-range))
    (h      h0)
    (w      w0)
    (tagleft        (make-tagleft))
    (tagbottom      (make-tagbottom))
    (matrix (make-array  `(,h0 ,w0) :initial-element #\Space))
    (ox     ox0)
    (oy     oy0)
    )
)


(defstruct ticks point)
(defstruct (tagleft  (:include ticks)))
(defstruct (tagbottom(:include ticks)))

(defstruct tag)
(defstruct (tagWidth (:include tag)))
(defstruct (tagHeight(:include tag)))
(defstruct (tagError (:include tag)))
(defstruct (tagLabel (:include tag)))
(defstruct (tagRange (:include range)))
(defstruct (tagLabel (:include tag)))
(defstruct (tagpound (:include tag)))
(defstruct tagmb m b c)
