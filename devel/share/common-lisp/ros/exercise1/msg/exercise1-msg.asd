
(cl:in-package :asdf)

(defsystem "exercise1-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Greeting" :depends-on ("_package_Greeting"))
    (:file "_package_Greeting" :depends-on ("_package"))
    (:file "stringInt" :depends-on ("_package_stringInt"))
    (:file "_package_stringInt" :depends-on ("_package"))
  ))