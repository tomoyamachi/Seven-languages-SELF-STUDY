(defn big [st num]
  (> (count st) num)
  )
(big "test" 3)
(big "te" 4)


(defn collection-type [col]
  (cond (list? col) :list
        (map? col) :map
        (vector? col) :vector)
  )
(collection-type '(1 2 3))
(collection-type {:a 1,:b 2,:c 3})
(collection-type [1 2 3])
