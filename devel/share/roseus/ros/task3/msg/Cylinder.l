;; Auto-generated. Do not edit!


(when (boundp 'task3::Cylinder)
  (if (not (find-package "TASK3"))
    (make-package "TASK3"))
  (shadow 'Cylinder (find-package "TASK3")))
(unless (find-package "TASK3::CYLINDER")
  (make-package "TASK3::CYLINDER"))

(in-package "ROS")
;;//! \htmlinclude Cylinder.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass task3::Cylinder
  :super ros::object
  :slots (_color _position ))

(defmethod task3::Cylinder
  (:init
   (&key
    ((:color __color) "")
    ((:position __position) (instance geometry_msgs::PointStamped :init))
    )
   (send-super :init)
   (setq _color (string __color))
   (setq _position __position)
   self)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:serialization-length
   ()
   (+
    ;; string _color
    4 (length _color)
    ;; geometry_msgs/PointStamped _position
    (send _position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _color
       (write-long (length _color) s) (princ _color s)
     ;; geometry_msgs/PointStamped _position
       (send _position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _color
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _color (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/PointStamped _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;;
   self)
  )

(setf (get task3::Cylinder :md5sum-) "79e9171f8aab1d9f862baaaf0114ad4a")
(setf (get task3::Cylinder :datatype-) "task3/Cylinder")
(setf (get task3::Cylinder :definition-)
      "string color
geometry_msgs/PointStamped position

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :task3/Cylinder "79e9171f8aab1d9f862baaaf0114ad4a")


