#!/usr/bin/env racket
#lang cli

(require racket/format)

(define BASE-PATH "output")

(define PREFIX "mod")

(define (create-individual name)
  (with-output-to-file
    (path-add-extension (build-path BASE-PATH name)
                        ".rkt")
    (lambda ()
      (printf
       (~a "#lang racket/base\n"
           "\n"
           "(provide " name ")\n"
           "\n"
           "(require \"../codegen.rkt\")\n"
           "\n"
           "(bigfunction " name ")\n")))))

(define (create-individual-main n)
  (with-output-to-file
    (path-add-extension (build-path BASE-PATH "main-individual")
                        ".rkt")
    (lambda ()
      (printf
       (apply ~a `("#lang racket/base\n"
                   "\n"
                   "(require\n"
                   ,@(for/list ([i n])
                       (~a "\"" PREFIX i ".rkt" "\"" "\n"))
                   ")\n"))))))

(define (create-combined n)
  (with-output-to-file
    (path-add-extension (build-path BASE-PATH "combined")
                        ".rkt")
    (lambda ()
      (printf
       (apply ~a `("#lang racket/base\n"
                   "\n"
                   "(provide\n"
                   ,@(for/list ([i n])
                       (~a PREFIX i "\n"))
                   ")\n"
                   "\n"
                   "(require \"../codegen.rkt\")\n"
                   "\n"
                   ,@(for/list ([i n])
                       (~a "(bigfunction " PREFIX i ")" "\n"))
                   "\n"))))))

(define (create-combined-main n)
  (with-output-to-file
    (path-add-extension (build-path BASE-PATH "main-combined")
                        ".rkt")
    (lambda ()
      (printf
       (~a "#lang racket/base\n"
           "\n"
           "(require \"combined.rkt\")\n")))))

(define (gen-names n)
  (for/list ([i n])
    (~a PREFIX i)))

(program (filecreator [n "number of files to create"])
  (set! n (string->number n))
  (unless (directory-exists? BASE-PATH)
    (make-directory BASE-PATH))
  (for-each create-individual (gen-names n))
  (create-individual-main n)
  (create-combined n)
  (create-combined-main n))

(run filecreator)
