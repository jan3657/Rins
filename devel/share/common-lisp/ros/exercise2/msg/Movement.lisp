; Auto-generated. Do not edit!


(cl:in-package exercise2-msg)


;//! \htmlinclude Movement.msg.html

(cl:defclass <Movement> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Movement (<Movement>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Movement>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Movement)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exercise2-msg:<Movement> is deprecated: use exercise2-msg:Movement instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Movement>) ostream)
  "Serializes a message object of type '<Movement>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Movement>) istream)
  "Deserializes a message object of type '<Movement>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Movement>)))
  "Returns string type for a message object of type '<Movement>"
  "exercise2/Movement")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Movement)))
  "Returns string type for a message object of type 'Movement"
  "exercise2/Movement")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Movement>)))
  "Returns md5sum for a message object of type '<Movement>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Movement)))
  "Returns md5sum for a message object of type 'Movement"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Movement>)))
  "Returns full string definition for message of type '<Movement>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Movement)))
  "Returns full string definition for message of type 'Movement"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Movement>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Movement>))
  "Converts a ROS message object to a list"
  (cl:list 'Movement
))
