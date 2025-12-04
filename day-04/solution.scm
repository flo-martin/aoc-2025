;; -*- chicken -*-
;; https://api.call-cc.org/5/doc/
(import
 (chicken io)
 srfi-1
 srfi-69)

(define (list->ilist l)
 (let ((n (length l)))
  (zip (iota n) l)))

(define (iilist->hash-table iil)
 (let ((h (make-hash-table)))
  (map (lambda (r)
    (let ((y  (car r))
          (cs (cdr r)))
     (map (lambda (c)
      (let ((x (car c))
            (s (cadr c)))
       (hash-table-set! h (list x y) s)))
      cs)))
    iil)
  h))

(define (make-grid filename)
 (let*
  ((raw-rows (call-with-input-file filename read-lines))
   (idx-rows (list->ilist raw-rows))
   (list-list-cells
    (map (lambda (r)
     (cons (car r) (list->ilist (string->list (cadr r)))))
     idx-rows)))
  (iilist->hash-table list-list-cells)))

(define (get-near grid pos)

)

(define (part-1 filename)
 (let*
  ((grid (make-grid filename))
   (poss (hash-table->alist grid)))
 )
)

;; linked list are no fun, j'ai mal à tête

(define t (part-1 "./example.txt"))