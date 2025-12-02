;; -*- guile -*-
(use-modules
  (ice-9 textual-ports))

(define* (id-invalid? id)
  (if
    (not (equal? 0 (modulo (string-length id) 2)))
    #f
    (let*
      ((str-len  (string-length id))
       (half-len (/ str-len 2))
       (start    (substring id 0 half-len))
       (end      (substring id half-len)))
      (equal? start end))))

(define* (range-to-range range)
  (let*
    ((two-numbers (string-split range #\-))
     (start       (string->number (car  two-numbers)))
     (end         (string->number (cadr  two-numbers)))
     (nb-range    (iota (- end start -1) start))
     (str-range   (map number->string nb-range))
     (invalids    (filter id-invalid? str-range)))
    (map string->number invalids)))

(define* (part-1 filename)
  (fold + 0
    (fold append '()
      (map range-to-range
        (string-split
          (get-string-all (open-input-file filename))
          #\,)))))

(part-1 "./example.txt")
(part-1 "./input.txt")