(format t " - Loading Warning Suppression Utilities~%") ;; Output for a pretty log

(defmacro suppress-style-warnings (&body body)
  `(handler-bind ((style-warning #'muffle-warning))
  ,@body))

(defmacro suppress-warnings (&body body)
  `(handler-bind ((warning #'muffle-warning))
  ,@body))
