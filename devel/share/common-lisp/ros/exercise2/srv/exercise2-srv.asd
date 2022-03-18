
(cl:in-package :asdf)

(defsystem "exercise2-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "MovementType" :depends-on ("_package_MovementType"))
    (:file "_package_MovementType" :depends-on ("_package"))
  ))