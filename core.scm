(define (spp)
  ())

(define (eval:: exp env)
  (cond ((self-eval? exp)
         exp)
        ((variable? exp)
         (look-up exp env))
        ((quote? exp)
         (eval-quote exp))
        ((assignment? exp)
         (eval-assignment exp env))
        ((definition? exp)
         (eval-definition exp env))
        ((class-definition? exp)
         (eval-class-definition exp env))
        ((control-flow? exp)
         (eval-control-flow exp env))
        ((lambda? exp)
         (make-proc (proc-params exp)
                    (proc-body exp)
                    env))
        ((eval_s? exp)
         (eval_s exp env))
        ((application? exp)
         (apply:: (eval (operator exp) env)
                (eval (list-of-values (operands exp) env) env)))
        (else (printf "UNKNOWN EXPRESSION TYPE: "~a"" exp))))

(define (apply:: proc args)
  (cond ((primitive? proc) 
         (apply-primitive proc args))
        ((compound? proc) 
         (eval-seq (proc-body proc)
                   (extend-env (proc-params proc)
                               args
                               (proc-env proc))))
        (else (printf "UNKNOWN PROCEDURE TYPE: "~a"" proc))))
