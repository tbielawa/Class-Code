;;; 7.1 Streams

(deftest inputstream () 
  (check (equalp
    "Hello, world!"
    (read-line (open (make-pathname :name "streamtester.txt") :direction :input)))
  )
)

;;; Figure 7.1 Ring Buffers [Required]
