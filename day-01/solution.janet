(var input (slurp "./day-01/example.txt"))

(defn to-move [line]
  (let [direction (string/slice line 0 1)
        distance (parse (string/slice line 1 -1))]
    {:direction direction
     :distance distance}))

(var start 50)
(var size 100)

(defn pp-debug [x] (pp x) x)

(defn part-1 [input]
  (let [lines (string/split "\n" input)
        moves (map to-move lines)]
    (reduce
      (fn [ctx move]
        (let [{:direction direction
               :distance distance} move
              {:position position :hits hits} ctx
              new-position
              (cond
                (= direction "L") (mod (- position distance) size)
                (= direction "R") (mod (+ position distance) size)
                :else position)]
          {:position new-position
           :hits (if (= new-position 0) (inc hits) hits)}))
      {:position start :hits 0} moves)))

(defn get-new-position [direction distance position hits]
  (var new-position
    (cond
      (= direction "L") (mod (- position distance) size)
      (= direction "R") (mod (+ position distance) size)))
  (var new-hits hits)
  (var where position)
  (loop [_ :range [0 distance]]
    (set where (cond (= direction "L") (dec where) (= direction "R") (inc where)))
    (if (= 0 (mod where size)) (set new-hits (inc new-hits))))
  {:position new-position :hits new-hits})

(defn part-2 [input]
  (let [lines (string/split "\n" input)
        moves (map to-move lines)]
    (reduce
      (fn [ctx move]
        (pp move)
        (let [{:direction direction
               :distance distance} move
              {:position position :hits hits} ctx]
          (pp-debug (get-new-position direction distance position hits))))
      {:position start :hits 0} moves)))
