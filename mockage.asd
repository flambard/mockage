(defpackage :mockage-system
  (:use :cl))

(in-package :mockage-system)

(asdf:defsystem :mockage
  :description "A mocking library for Common Lisp."
  :author "Markus Flambard <mflambard@common-lisp.net>"
  :version "0.0.1"
  :license "MIT License"
  :depends-on ()
  :components
  ((:module :src
            :components
            ((:file "packages")
             (:file "mockage"
                    :depends-on ("packages"))
             ))))
