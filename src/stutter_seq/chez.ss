

;; Takes an iteration count on the command line:
(define N (string->number (car (command-line-arguments))))

(printf "Iterations: ~a\n" N)
(time
(display
 (let loop ([n N])
   (if (zero? n) 1
       (loop
         (call/cc (lambda (k)
           (k (sub1 n)))))))))
