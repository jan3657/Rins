;; Auto-generated. Do not edit!


(when (boundp 'exercise2::Movement)
  (if (not (find-package "EXERCISE2"))
    (make-package "EXERCISE2"))
  (shadow 'Movement (find-package "EXERCISE2")))
(unless (find-package "EXERCISE2::MOVEMENT")
  (make-package "EXERCISE2::MOVEMENT"))

(in-package "ROS")
;;//! \htmlinclude Movement.msg.html


(defclass exercise2::Movement
  :super ros::object
  :slots ())

(defmethod exercise2::Movement
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(setf (get exercise2::Movement :md5sum-) "d41d8cd98f00b204e9800998ecf8427e")
(setf (get exercise2::Movement :datatype-) "exercise2/Movement")
(setf (get exercise2::Movement :definition-)
      "
")



(provide :exercise2/Movement "d41d8cd98f00b204e9800998ecf8427e")


