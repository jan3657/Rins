
(cl:in-package :asdf)

(defsystem "task3-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "Cylinder" :depends-on ("_package_Cylinder"))
    (:file "_package_Cylinder" :depends-on ("_package"))
    (:file "FacePose" :depends-on ("_package_FacePose"))
    (:file "_package_FacePose" :depends-on ("_package"))
    (:file "Ring" :depends-on ("_package_Ring"))
    (:file "_package_Ring" :depends-on ("_package"))
  ))