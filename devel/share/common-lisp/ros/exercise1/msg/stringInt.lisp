; Auto-generated. Do not edit!


(cl:in-package exercise1-msg)


;//! \htmlinclude stringInt.msg.html

(cl:defclass <stringInt> (roslisp-msg-protocol:ros-message)
  ((content
    :reader content
    :initarg :content
    :type cl:string
    :initform "")
   (sequenceID
    :reader sequenceID
    :initarg :sequenceID
    :type cl:fixnum
    :initform 0))
)

(cl:defclass stringInt (<stringInt>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <stringInt>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'stringInt)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise1-msg:<stringInt> is deprecated: use exercise1-msg:stringInt instead.")))

(cl:ensure-generic-function 'content-val :lambda-list '(m))
(cl:defmethod content-val ((m <stringInt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise1-msg:content-val is deprecated.  Use exercise1-msg:content instead.")
  (content m))

(cl:ensure-generic-function 'sequenceID-val :lambda-list '(m))
(cl:defmethod sequenceID-val ((m <stringInt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exercise1-msg:sequenceID-val is deprecated.  Use exercise1-msg:sequenceID instead.")
  (sequenceID m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <stringInt>) ostream)
  "Serializes a message object of type '<stringInt>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'content))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'content))
  (cl:let* ((signed (cl:slot-value msg 'sequenceID)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <stringInt>) istream)
  "Deserializes a message object of type '<stringInt>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'content) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'content) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sequenceID) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<stringInt>)))
  "Returns string type for a message object of type '<stringInt>"
  "exercise1/stringInt")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'stringInt)))
  "Returns string type for a message object of type 'stringInt"
  "exercise1/stringInt")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<stringInt>)))
  "Returns md5sum for a message object of type '<stringInt>"
  "0ea9fbf91a022147e4b89365a664c9cb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'stringInt)))
  "Returns md5sum for a message object of type 'stringInt"
  "0ea9fbf91a022147e4b89365a664c9cb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<stringInt>)))
  "Returns full string definition for message of type '<stringInt>"
  (cl:format cl:nil "string content~%int8 sequenceID~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'stringInt)))
  "Returns full string definition for message of type 'stringInt"
  (cl:format cl:nil "string content~%int8 sequenceID~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <stringInt>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'content))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <stringInt>))
  "Converts a ROS message object to a list"
  (cl:list 'stringInt
    (cl:cons ':content (content msg))
    (cl:cons ':sequenceID (sequenceID msg))
))
