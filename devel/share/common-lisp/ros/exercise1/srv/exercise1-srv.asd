
(cl:in-package :asdf)

(defsystem "exercise1-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Reverse" :depends-on ("_package_Reverse"))
    (:file "_package_Reverse" :depends-on ("_package"))
    (:file "SumOfArray" :depends-on ("_package_SumOfArray"))
    (:file "_package_SumOfArray" :depends-on ("_package"))
  ))