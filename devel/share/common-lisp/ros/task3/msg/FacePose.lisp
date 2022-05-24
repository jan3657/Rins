; Auto-generated. Do not edit!


(cl:in-package task3-msg)


;//! \htmlinclude FacePose.msg.html

(cl:defclass <FacePose> (roslisp-msg-protocol:ros-message)
  ((position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped)))
)

(cl:defclass FacePose (<FacePose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FacePose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FacePose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name task3-msg:<FacePose> is deprecated: use task3-msg:FacePose instead.")))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <FacePose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader task3-msg:position-val is deprecated.  Use task3-msg:position instead.")
  (position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FacePose>) ostream)
  "Serializes a message object of type '<FacePose>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FacePose>) istream)
  "Deserializes a message object of type '<FacePose>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FacePose>)))
  "Returns string type for a message object of type '<FacePose>"
  "task3/FacePose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FacePose)))
  "Returns string type for a message object of type 'FacePose"
  "task3/FacePose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FacePose>)))
  "Returns md5sum for a message object of type '<FacePose>"
  "80642f0dbeee9f13de99f968daa46e52")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FacePose)))
  "Returns md5sum for a message object of type 'FacePose"
  "80642f0dbeee9f13de99f968daa46e52")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FacePose>)))
  "Returns full string definition for message of type '<FacePose>"
  (cl:format cl:nil "geometry_msgs/PoseStamped position~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FacePose)))
  "Returns full string definition for message of type 'FacePose"
  (cl:format cl:nil "geometry_msgs/PoseStamped position~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FacePose>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FacePose>))
  "Converts a ROS message object to a list"
  (cl:list 'FacePose
    (cl:cons ':position (position msg))
))
