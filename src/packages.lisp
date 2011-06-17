(defpackage :mockage
  (:documentation "A mocking library for Common Lisp.")
  (:use :cl)
  (:export

   #:mock-function
   #:unmock-function
   #:original-function
   #:mocked-p
   #:all-mocked
   #:unmock-all

   ))
