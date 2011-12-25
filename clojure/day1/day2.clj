(defn size [v]
  (if (empty? v)
    0
    (inc (size (rest v)))))
;(size [1 2 3])

(defmacro unless [expr body elsebody] `(if ~expr ~body ~elsebody))

(defn exhibits-oddity? [x]
  (unless (even? x)
          (println "It is odd number.")
          (println "It is not odd number.")
   )
  )
(println "is 4 odd number?")
(exhibits-oddity? 4)
(println "is 3 odd number?")
(exhibits-oddity? 3)

