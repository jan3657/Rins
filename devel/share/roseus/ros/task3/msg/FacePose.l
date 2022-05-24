;; Auto-generated. Do not edit!


(when (boundp 'task3::FacePose)
  (if (not (find-package "TASK3"))
    (make-package "TASK3"))
  (shadow 'FacePose (find-package "TASK3")))
(unless (find-package "TASK3::FACEPOSE")
  (make-package "TASK3::FACEPOSE"))

(in-package "ROS")
;;//! \htmlinclude FacePose.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass task3::FacePose
  :super ros::object
  :slots (_position ))

(defmethod task3::FacePose
  (:init
   (&key
    ((:position __position) (instance geometry_msgs::PoseStamped :init))
    )
   (send-super :init)
   (setq _position __position)
   self)
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
    ;; geometry_msgs/PoseStamped _position
    (send _position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/PoseStamped _position
       (send _position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/PoseStamped _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;;
   self)
  )

(setf (get task3::FacePose :md5sum-) "80642f0dbeee9f13de99f968daa46e52")
(setf (get task3::FacePose :datatype-) "task3/FacePose")
(setf (get task3::FacePose :definition-)
      "geometry_msgs/PoseStamped position

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

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
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :task3/FacePose "80642f0dbeee9f13de99f968daa46e52")


