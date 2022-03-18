; Auto-generated. Do not edit!


(cl:in-package exercise1-srv)


;//! \htmlinclude SumOfArray-request.msg.html

(cl:defclass <SumOfArray-request> (roslisp-msg-protocol:ros-message)
  ((array
    :reader array
    :initarg :array
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass SumOfArray-request (<SumOfArray-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SumOfArray-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SumOfArray-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise1-srv:<SumOfArray-request> is deprecated: use exercise1-srv:SumOfArray-request instead.")))

(cl:ensure-generic-function 'array-val :lambda-list '(m))
(cl:defmethod array-val ((m <SumOfArray-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise1-srv:array-val is deprecated.  Use exercise1-srv:array instead.")
  (array m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SumOfArray-request>) ostream)
  "Serializes a message object of type '<SumOfArray-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SumOfArray-request>) istream)
  "Deserializes a message object of type '<SumOfArray-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SumOfArray-request>)))
  "Returns string type for a service object of type '<SumOfArray-request>"
  "exercise1/SumOfArrayRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SumOfArray-request)))
  "Returns string type for a service object of type 'SumOfArray-request"
  "exercise1/SumOfArrayRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SumOfArray-request>)))
  "Returns md5sum for a message object of type '<SumOfArray-request>"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SumOfArray-request)))
  "Returns md5sum for a message object of type 'SumOfArray-request"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SumOfArray-request>)))
  "Returns full string definition for message of type '<SumOfArray-request>"
  (cl:format cl:nil "int8[] array~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SumOfArray-request)))
  "Returns full string definition for message of type 'SumOfArray-request"
  (cl:format cl:nil "int8[] array~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SumOfArray-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'array) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SumOfArray-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SumOfArray-request
    (cl:cons ':array (array msg))
))
;//! \htmlinclude SumOfArray-response.msg.html

(cl:defclass <SumOfArray-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass SumOfArray-response (<SumOfArray-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SumOfArray-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SumOfArray-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise1-srv:<SumOfArray-response> is deprecated: use exercise1-srv:SumOfArray-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <SumOfArray-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise1-srv:result-val is deprecated.  Use exercise1-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SumOfArray-response>) ostream)
  "Serializes a message object of type '<SumOfArray-response>"
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SumOfArray-response>) istream)
  "Deserializes a message object of type '<SumOfArray-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SumOfArray-response>)))
  "Returns string type for a service object of type '<SumOfArray-response>"
  "exercise1/SumOfArrayResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SumOfArray-response)))
  "Returns string type for a service object of type 'SumOfArray-response"
  "exercise1/SumOfArrayResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SumOfArray-response>)))
  "Returns md5sum for a message object of type '<SumOfArray-response>"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SumOfArray-response)))
  "Returns md5sum for a message object of type 'SumOfArray-response"
  "65f9c89928d29d739491ad72c448ad4f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SumOfArray-response>)))
  "Returns full string definition for message of type '<SumOfArray-response>"
  (cl:format cl:nil "int32 result~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SumOfArray-response)))
  "Returns full string definition for message of type 'SumOfArray-response"
  (cl:format cl:nil "int32 result~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SumOfArray-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SumOfArray-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SumOfArray-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SumOfArray)))
  'SumOfArray-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SumOfArray)))
  'SumOfArray-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SumOfArray)))
  "Returns string type for a service object of type '<SumOfArray>"
  "exercise1/SumOfArray")