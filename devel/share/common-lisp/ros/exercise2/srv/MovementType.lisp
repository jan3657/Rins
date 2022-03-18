; Auto-generated. Do not edit!


(cl:in-package exercise2-srv)


;//! \htmlinclude MovementType-request.msg.html

(cl:defclass <MovementType-request> (roslisp-msg-protocol:ros-message)
  ((shape
    :reader shape
    :initarg :shape
    :type cl:string
    :initform "")
   (duration
    :reader duration
    :initarg :duration
    :type cl:integer
    :initform 0))
)

(cl:defclass MovementType-request (<MovementType-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MovementType-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MovementType-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise2-srv:<MovementType-request> is deprecated: use exercise2-srv:MovementType-request instead.")))

(cl:ensure-generic-function 'shape-val :lambda-list '(m))
(cl:defmethod shape-val ((m <MovementType-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise2-srv:shape-val is deprecated.  Use exercise2-srv:shape instead.")
  (shape m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <MovementType-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise2-srv:duration-val is deprecated.  Use exercise2-srv:duration instead.")
  (duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MovementType-request>) ostream)
  "Serializes a message object of type '<MovementType-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'shape))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'shape))
  (cl:let* ((signed (cl:slot-value msg 'duration)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MovementType-request>) istream)
  "Deserializes a message object of type '<MovementType-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'shape) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'shape) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'duration) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MovementType-request>)))
  "Returns string type for a service object of type '<MovementType-request>"
  "exercise2/MovementTypeRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MovementType-request)))
  "Returns string type for a service object of type 'MovementType-request"
  "exercise2/MovementTypeRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MovementType-request>)))
  "Returns md5sum for a message object of type '<MovementType-request>"
  "f747a6d49b629ea3b92ea322ab71d841")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MovementType-request)))
  "Returns md5sum for a message object of type 'MovementType-request"
  "f747a6d49b629ea3b92ea322ab71d841")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MovementType-request>)))
  "Returns full string definition for message of type '<MovementType-request>"
  (cl:format cl:nil "string shape~%int32 duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MovementType-request)))
  "Returns full string definition for message of type 'MovementType-request"
  (cl:format cl:nil "string shape~%int32 duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MovementType-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'shape))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MovementType-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MovementType-request
    (cl:cons ':shape (shape msg))
    (cl:cons ':duration (duration msg))
))
;//! \htmlinclude MovementType-response.msg.html

(cl:defclass <MovementType-response> (roslisp-msg-protocol:ros-message)
  ((lastDrawnShape
    :reader lastDrawnShape
    :initarg :lastDrawnShape
    :type cl:string
    :initform ""))
)

(cl:defclass MovementType-response (<MovementType-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MovementType-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MovementType-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise2-srv:<MovementType-response> is deprecated: use exercise2-srv:MovementType-response instead.")))

(cl:ensure-generic-function 'lastDrawnShape-val :lambda-list '(m))
(cl:defmethod lastDrawnShape-val ((m <MovementType-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise2-srv:lastDrawnShape-val is deprecated.  Use exercise2-srv:lastDrawnShape instead.")
  (lastDrawnShape m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MovementType-response>) ostream)
  "Serializes a message object of type '<MovementType-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'lastDrawnShape))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'lastDrawnShape))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MovementType-response>) istream)
  "Deserializes a message object of type '<MovementType-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lastDrawnShape) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'lastDrawnShape) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MovementType-response>)))
  "Returns string type for a service object of type '<MovementType-response>"
  "exercise2/MovementTypeResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MovementType-response)))
  "Returns string type for a service object of type 'MovementType-response"
  "exercise2/MovementTypeResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MovementType-response>)))
  "Returns md5sum for a message object of type '<MovementType-response>"
  "f747a6d49b629ea3b92ea322ab71d841")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MovementType-response)))
  "Returns md5sum for a message object of type 'MovementType-response"
  "f747a6d49b629ea3b92ea322ab71d841")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MovementType-response>)))
  "Returns full string definition for message of type '<MovementType-response>"
  (cl:format cl:nil "string lastDrawnShape~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MovementType-response)))
  "Returns full string definition for message of type 'MovementType-response"
  (cl:format cl:nil "string lastDrawnShape~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MovementType-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'lastDrawnShape))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MovementType-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MovementType-response
    (cl:cons ':lastDrawnShape (lastDrawnShape msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MovementType)))
  'MovementType-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MovementType)))
  'MovementType-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MovementType)))
  "Returns string type for a service object of type '<MovementType>"
  "exercise2/MovementType")