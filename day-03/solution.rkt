(define (find-number str)
  (let* (
    [chars (string->list str)]
    [big-nb (box #\0)]
    [big-ix (box -1)]
    [sec-nb (box #\0)]
    [sec-ix (box -1)])
      ; find biggest
      (for ([i (range (length chars))])
        (let ([char (list-ref chars i)])
          (when (char>? char (unbox big-nb))
            (set-box! big-nb char)
            (set-box! big-ix i))))
      ; find second after biggest
      (for ([i (range (length chars))])
        (let ([char (list-ref chars i)])
          (when (and (> i (unbox big-ix)) (char>? char (unbox sec-nb)))
            (set-box! sec-nb char)
            (set-box! sec-ix i))))
      ; if biggest was last then nothing found so we drop the (> i big-ix) cond
      (when (equal? -1 (unbox sec-ix))
        (for ([i (range (- (length chars) 1))])
          (let ([char (list-ref chars i)])
            (when (char>? char (unbox sec-nb))
              (set-box! sec-nb char)
              (set-box! sec-ix i)))))
      (let (
        [f (if (< (unbox big-ix) (unbox sec-ix)) (unbox big-nb) (unbox sec-nb))]
        [s (if (< (unbox big-ix) (unbox sec-ix)) (unbox sec-nb) (unbox big-nb))])
          (string->number (string f s)))))

(define (part-1 filename)
  (foldl + 0
    (map find-number
      (file->lines filename))))

(part-1 "./example.txt")
