;; Auto-generated. Do not edit!


(when (boundp 'exercise1::stringInt)
  (if (not (find-package "EXERCISE1"))
    (make-package "EXERCISE1"))
  (shadow 'stringInt (find-package "EXERCISE1")))
(unless (find-package "EXERCISE1::STRINGINT")
  (make-package "EXERCISE1::STRINGINT"))

(in-package "ROS")
;;//! \htmlinclude stringInt.msg.html


(defclass exercise1::stringInt
  :super ros::object
  :slots (_content _sequenceID ))

(defmethod exercise1::stringInt
  (:init
   (&key
    ((:content __content) "")
    ((:sequenceID __sequenceID) 0)
    )
   (send-super :init)
   (setq _content (string __content))
   (setq _sequenceID (round __sequenceID))
   self)
  (:content
   (&optional __content)
   (if __content (setq _content __content)) _content)
  (:sequenceID
   (&optional __sequenceID)
   (if __sequenceID (setq _sequenceID __sequenceID)) _sequenceID)
  (:serialization-length
   ()
   (+
    ;; string _content
    4 (length _content)
    ;; int8 _sequenceID
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _content
       (write-long (length _content) s) (princ _content s)
     ;; int8 _sequenceID
       (write-byte _sequenceID s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _content
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _content (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int8 _sequenceID
     (setq _sequenceID (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _sequenceID 127) (setq _sequenceID (- _sequenceID 256)))
   ;;
   self)
  )

(setf (get exercise1::stringInt :md5sum-) "0ea9fbf91a022147e4b89365a664c9cb")
(setf (get exercise1::stringInt :datatype-) "exercise1/stringInt")
(setf (get exercise1::stringInt :definition-)
      "string content
int8 sequenceID

")



(provide :exercise1/stringInt "0ea9fbf91a022147e4b89365a664c9cb")


