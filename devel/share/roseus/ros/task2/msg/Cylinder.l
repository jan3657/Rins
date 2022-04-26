;; Auto-generated. Do not edit!


(when (boundp 'task2::Cylinder)
  (if (not (find-package "TASK2"))
    (make-package "TASK2"))
  (shadow 'Cylinder (find-package "TASK2")))
(unless (find-package "TASK2::CYLINDER")
  (make-package "TASK2::CYLINDER"))

(in-package "ROS")
;;//! \htmlinclude Cylinder.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass task2::Cylinder
  :super ros::object
  :slots (_color _point ))

(defmethod task2::Cylinder
  (:init
   (&key
    ((:color __color) (instance std_msgs::ColorRGBA :init))
    ((:point __point) (instance geometry_msgs::PointStamped :init))
    )
   (send-super :init)
   (setq _color __color)
   (setq _point __point)
   self)
  (:color
   (&rest __color)
   (if (keywordp (car __color))
       (send* _color __color)
     (progn
       (if __color (setq _color (car __color)))
       _color)))
  (:point
   (&rest __point)
   (if (keywordp (car __point))
       (send* _point __point)
     (progn
       (if __point (setq _point (car __point)))
       _point)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/ColorRGBA _color
    (send _color :serialization-length)
    ;; geometry_msgs/PointStamped _point
    (send _point :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/ColorRGBA _color
       (send _color :serialize s)
     ;; geometry_msgs/PointStamped _point
       (send _point :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/ColorRGBA _color
     (send _color :deserialize buf ptr-) (incf ptr- (send _color :serialization-length))
   ;; geometry_msgs/PointStamped _point
     (send _point :deserialize buf ptr-) (incf ptr- (send _point :serialization-length))
   ;;
   self)
  )

(setf (get task2::Cylinder :md5sum-) "3e8ee3f2491ff8e55c488b333304dab7")
(setf (get task2::Cylinder :datatype-) "task2/Cylinder")
(setf (get task2::Cylinder :definition-)
      "std_msgs/ColorRGBA color
geometry_msgs/PointStamped point

================================================================================
MSG: std_msgs/ColorRGBA
float32 r
float32 g
float32 b
float32 a

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



(provide :task2/Cylinder "3e8ee3f2491ff8e55c488b333304dab7")


