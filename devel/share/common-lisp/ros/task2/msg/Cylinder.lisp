; Auto-generated. Do not edit!


(cl:in-package task2-msg)


;//! \htmlinclude Cylinder.msg.html

(cl:defclass <Cylinder> (roslisp-msg-protocol:ros-message)
  ((color
    :reader color
    :initarg :color
    :type std_msgs-msg:ColorRGBA
    :initform (cl:make-instance 'std_msgs-msg:ColorRGBA))
   (point
    :reader point
    :initarg :point
    :type geometry_msgs-msg:PointStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PointStamped)))
)

(cl:defclass Cylinder (<Cylinder>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Cylinder>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Cylinder)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name task2-msg:<Cylinder> is deprecated: use task2-msg:Cylinder instead.")))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <Cylinder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader task2-msg:color-val is deprecated.  Use task2-msg:color instead.")
  (color m))

(cl:ensure-generic-function 'point-val :lambda-list '(m))
(cl:defmethod point-val ((m <Cylinder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader task2-msg:point-val is deprecated.  Use task2-msg:point instead.")
  (point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Cylinder>) ostream)
  "Serializes a message object of type '<Cylinder>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'color) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'point) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Cylinder>) istream)
  "Deserializes a message object of type '<Cylinder>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'color) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'point) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Cylinder>)))
  "Returns string type for a message object of type '<Cylinder>"
  "task2/Cylinder")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Cylinder)))
  "Returns string type for a message object of type 'Cylinder"
  "task2/Cylinder")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Cylinder>)))
  "Returns md5sum for a message object of type '<Cylinder>"
  "3e8ee3f2491ff8e55c488b333304dab7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Cylinder)))
  "Returns md5sum for a message object of type 'Cylinder"
  "3e8ee3f2491ff8e55c488b333304dab7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Cylinder>)))
  "Returns full string definition for message of type '<Cylinder>"
  (cl:format cl:nil "std_msgs/ColorRGBA color~%geometry_msgs/PointStamped point~%~%================================================================================~%MSG: std_msgs/ColorRGBA~%float32 r~%float32 g~%float32 b~%float32 a~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Cylinder)))
  "Returns full string definition for message of type 'Cylinder"
  (cl:format cl:nil "std_msgs/ColorRGBA color~%geometry_msgs/PointStamped point~%~%================================================================================~%MSG: std_msgs/ColorRGBA~%float32 r~%float32 g~%float32 b~%float32 a~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Cylinder>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'color))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'point))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Cylinder>))
  "Converts a ROS message object to a list"
  (cl:list 'Cylinder
    (cl:cons ':color (color msg))
    (cl:cons ':point (point msg))
))
