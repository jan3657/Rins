
(cl:in-package :asdf)

(defsystem "exercise2-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Movement" :depends-on ("_package_Movement"))
    (:file "_package_Movement" :depends-on ("_package"))
  ))