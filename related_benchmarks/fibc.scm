;;; FIBC -- FIB using first-class continuations, written by Kent Dybvig

(import (scheme base) (scheme read) (scheme write) (scheme time))

(define (addc x y k)
  (k (+ x y)))

(define (fibc x c)
  (if (zero? x)
      (c 0)
      (if (zero? (pred x))
          (c 1)
          (addc (call-with-current-continuation
                 (lambda (c) (fibc (sub1 x) c)))
                (call-with-current-continuation
                 (lambda (c) (fibc (- x 2) c)))
                c))))

(define (main)
  (let* ((count (read))
         (input (read))
         (output (read))
         (s2 (number->string count))
         (s1 (number->string input))
         (name "fibc"))
    (run-r7rs-benchmark
     (string-append name ":" s1 ":" s2)
     count
     (lambda () (fibc (hide count input) (hide count (lambda (n) n))))
     (lambda (result) (= result output)))))
