(use-modules (ice-9 rdelim))
(use-modules (srfi srfi-64))

(define (run-test file)
  (display "Running: ")
  (display file)
  (newline)
  (primitive-load file))

(define (run-all-tests)
  (for-each run-test
            '("src/pop-test/binding.scm")))

(run-all-tests)
