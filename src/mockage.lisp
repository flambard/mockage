(in-package :mockage)

(defvar *mocked-functions* (make-hash-table))

(defun mock-function (function-name replacement)
  (when (fboundp function-name)
    (setf (gethash function-name *mocked-functions*)
          (symbol-function function-name))
    (setf (symbol-function function-name)
          (lambda (&rest ignored-mock-args)
            (declare (ignore ignored-mock-args))
            (funcall replacement)))
    function-name))

(defun unmock-function (function-name)
  (when (fboundp function-name)
    (multiple-value-bind (original-function mocked-p)
        (gethash function-name *mocked-functions*)
      (when mocked-p
        (setf (symbol-function function-name) original-function)
        (remhash function-name *mocked-functions*)
        function-name))))


(defun original-function (function-name)
  (gethash function-name *mocked-functions*))

(defun mocked-p (symbol)
  (multiple-value-bind (value value-p) (gethash symbol *mocked-functions*)
    (declare (ignore value))
    value-p))

(defun all-mocked ()
  (let ((syms (list)))
    (maphash #'(lambda (sym fn)
                 (declare (ignore fn))
                 (push sym syms))
             *mocked-functions*)
    (nreverse syms)))

(defun unmock-all ()
  (maphash #'(lambda (sym fn) (setf (symbol-function sym) fn))
           *mocked-functions*)
  (clrhash *mocked-functions*)
  t)
