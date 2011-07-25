(defn size [v]
  (if (empty? v)
    0
    (inc (size (rest v)))))
;(size [1 2 3])

(defn unless [x y z]
  (if (not x) y z))
;; (defn notSize [v]
;;   (unless (empty? v)
;;           #(println "test")
;;           (inc (size (rest v)))))
;; (notSize [1 2 3])
(defn exhibits-oddity? [x]
  (unless (even? x)
          (println "It is odd number.")
          (println "It is not odd number.")
   )
  )
(exhibits-oddity? 4)
(exhibits-oddity? 3)