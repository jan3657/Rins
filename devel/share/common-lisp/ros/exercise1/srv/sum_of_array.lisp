; Auto-generated. Do not edit!


(cl:in-package exercise1-srv)


;//! \htmlinclude sum_of_array-request.msg.html

(cl:defclass <sum_of_array-request> (roslisp-msg-protocol:ros-message)
  ((array
    :reader array
    :initarg :array
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass sum_of_array-request (<sum_of_array-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sum_of_array-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sum_of_array-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise1-srv:<sum_of_array-request> is deprecated: use exercise1-srv:sum_of_array-request instead.")))

(cl:ensure-generic-function 'array-val :lambda-list '(m))
(cl:defmethod array-val ((m <sum_of_array-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise1-srv:array-val is deprecated.  Use exercise1-srv:array instead.")
  (array m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sum_of_array-request>) ostream)
  "Serializes a message object of type '<sum_of_array-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'array))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    ))
   (cl:slot-value msg 'array))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sum_of_array-request>) istream)
  "Deserializes a message object of type '<sum_of_array-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'array) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'array)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sum_of_array-request>)))
  "Returns string type for a service object of type '<sum_of_array-request>"
  "exercise1/sum_of_arrayRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sum_of_array-request)))
  "Returns string type for a service object of type 'sum_of_array-request"
  "exercise1/sum_of_arrayRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sum_of_array-request>)))
  "Returns md5sum for a message object of type '<sum_of_array-request>"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sum_of_array-request)))
  "Returns md5sum for a message object of type 'sum_of_array-request"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sum_of_array-request>)))
  "Returns full string definition for message of type '<sum_of_array-request>"
  (cl:format cl:nil "int8[] array~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sum_of_array-request)))
  "Returns full string definition for message of type 'sum_of_array-request"
  (cl:format cl:nil "int8[] array~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sum_of_array-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'array) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sum_of_array-request>))
  "Converts a ROS message object to a list"
  (cl:list 'sum_of_array-request
    (cl:cons ':array (array msg))
))
;//! \htmlinclude sum_of_array-response.msg.html

(cl:defclass <sum_of_array-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass sum_of_array-response (<sum_of_array-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sum_of_array-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sum_of_array-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise1-srv:<sum_of_array-response> is deprecated: use exercise1-srv:sum_of_array-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <sum_of_array-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise1-srv:result-val is deprecated.  Use exercise1-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sum_of_array-response>) ostream)
  "Serializes a message object of type '<sum_of_array-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sum_of_array-response>) istream)
  "Deserializes a message object of type '<sum_of_array-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sum_of_array-response>)))
  "Returns string type for a service object of type '<sum_of_array-response>"
  "exercise1/sum_of_arrayResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sum_of_array-response)))
  "Returns string type for a service object of type 'sum_of_array-response"
  "exercise1/sum_of_arrayResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sum_of_array-response>)))
  "Returns md5sum for a message object of type '<sum_of_array-response>"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sum_of_array-response)))
  "Returns md5sum for a message object of type 'sum_of_array-response"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sum_of_array-response>)))
  "Returns full string definition for message of type '<sum_of_array-response>"
  (cl:format cl:nil "int32 result~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sum_of_array-response)))
  "Returns full string definition for message of type 'sum_of_array-response"
  (cl:format cl:nil "int32 result~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sum_of_array-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sum_of_array-response>))
  "Converts a ROS message object to a list"
  (cl:list 'sum_of_array-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'sum_of_array)))
  'sum_of_array-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'sum_of_array)))
  'sum_of_array-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sum_of_array)))
  "Returns string type for a service object of type '<sum_of_array>"
  "exercise1/sum_of_array")