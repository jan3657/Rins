; Auto-generated. Do not edit!


(cl:in-package task3-msg)


;//! \htmlinclude Cylinder.msg.html

(cl:defclass <Cylinder> (roslisp-msg-protocol:ros-message)
  ((color
    :reader color
    :initarg :color
    :type cl:string
    :initform "")
   (position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:PointStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PointStamped)))
)

(cl:defclass Cylinder (<Cylinder>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Cylinder>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Cylinder)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name task3-msg:<Cylinder> is deprecated: use task3-msg:Cylinder instead.")))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <Cylinder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader task3-msg:color-val is deprecated.  Use task3-msg:color instead.")
  (color m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <Cylinder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader task3-msg:position-val is deprecated.  Use task3-msg:position instead.")
  (position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Cylinder>) ostream)
  "Serializes a message object of type '<Cylinder>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'color))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'color))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Cylinder>) istream)
  "Deserializes a message object of type '<Cylinder>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'color) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'color) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Cylinder>)))
  "Returns string type for a message object of type '<Cylinder>"
  "task3/Cylinder")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Cylinder)))
  "Returns string type for a message object of type 'Cylinder"
  "task3/Cylinder")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Cylinder>)))
  "Returns md5sum for a message object of type '<Cylinder>"
  "79e9171f8aab1d9f862baaaf0114ad4a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Cylinder)))
  "Returns md5sum for a message object of type 'Cylinder"
  "79e9171f8aab1d9f862baaaf0114ad4a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Cylinder>)))
  "Returns full string definition for message of type '<Cylinder>"
  (cl:format cl:nil "string color~%geometry_msgs/PointStamped position~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Cylinder)))
  "Returns full string definition for message of type 'Cylinder"
  (cl:format cl:nil "string color~%geometry_msgs/PointStamped position~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Cylinder>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'color))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Cylinder>))
  "Converts a ROS message object to a list"
  (cl:list 'Cylinder
    (cl:cons ':color (color msg))
    (cl:cons ':position (position msg))
))
