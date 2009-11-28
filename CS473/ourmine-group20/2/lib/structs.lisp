(defstruct table 
  name                      ; symbol          : name of the table
  columns                   ; list of header  : one header to describe each column of data
  class                     ; number          : which column is the header column?
  (cautions (make-caution)) ; list of caution : any load-time errors?
  all                       ; list of eg      : all the examples
  indexed
)

(defstruct eg features class)

(defstruct header name classp ignorep 
	   (f (make-hash-table :test #'equal)))
(defstruct (numeric  (:include header)))
(defstruct (discrete  (:include header)) uniques)
