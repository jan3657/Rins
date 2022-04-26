
(cl:in-package :asdf)

(defsystem "task2-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "Cylinder" :depends-on ("_package_Cylinder"))
    (:file "_package_Cylinder" :depends-on ("_package"))
  ))