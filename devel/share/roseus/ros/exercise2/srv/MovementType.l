;; Auto-generated. Do not edit!


(when (boundp 'exercise2::MovementType)
  (if (not (find-package "EXERCISE2"))
    (make-package "EXERCISE2"))
  (shadow 'MovementType (find-package "EXERCISE2")))
(unless (find-package "EXERCISE2::MOVEMENTTYPE")
  (make-package "EXERCISE2::MOVEMENTTYPE"))
(unless (find-package "EXERCISE2::MOVEMENTTYPEREQUEST")
  (make-package "EXERCISE2::MOVEMENTTYPEREQUEST"))
(unless (find-package "EXERCISE2::MOVEMENTTYPERESPONSE")
  (make-package "EXERCISE2::MOVEMENTTYPERESPONSE"))

(in-package "ROS")





(defclass exercise2::MovementTypeRequest
  :super ros::object
  :slots (_shape _duration ))

(defmethod exercise2::MovementTypeRequest
  (:init
   (&key
    ((:shape __shape) "")
    ((:duration __duration) 0)
    )
   (send-super :init)
   (setq _shape (string __shape))
   (setq _duration (round __duration))
   self)
  (:shape
   (&optional __shape)
   (if __shape (setq _shape __shape)) _shape)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:serialization-length
   ()
   (+
    ;; string _shape
    4 (length _shape)
    ;; int32 _duration
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _shape
       (write-long (length _shape) s) (princ _shape s)
     ;; int32 _duration
       (write-long _duration s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _shape
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _shape (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _duration
     (setq _duration (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass exercise2::MovementTypeResponse
  :super ros::object
  :slots (_lastDrawnShape ))

(defmethod exercise2::MovementTypeResponse
  (:init
   (&key
    ((:lastDrawnShape __lastDrawnShape) "")
    )
   (send-super :init)
   (setq _lastDrawnShape (string __lastDrawnShape))
   self)
  (:lastDrawnShape
   (&optional __lastDrawnShape)
   (if __lastDrawnShape (setq _lastDrawnShape __lastDrawnShape)) _lastDrawnShape)
  (:serialization-length
   ()
   (+
    ;; string _lastDrawnShape
    4 (length _lastDrawnShape)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _lastDrawnShape
       (write-long (length _lastDrawnShape) s) (princ _lastDrawnShape s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _lastDrawnShape
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _lastDrawnShape (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass exercise2::MovementType
  :super ros::object
  :slots ())

(setf (get exercise2::MovementType :md5sum-) "f747a6d49b629ea3b92ea322ab71d841")
(setf (get exercise2::MovementType :datatype-) "exercise2/MovementType")
(setf (get exercise2::MovementType :request) exercise2::MovementTypeRequest)
(setf (get exercise2::MovementType :response) exercise2::MovementTypeResponse)

(defmethod exercise2::MovementTypeRequest
  (:response () (instance exercise2::MovementTypeResponse :init)))

(setf (get exercise2::MovementTypeRequest :md5sum-) "f747a6d49b629ea3b92ea322ab71d841")
(setf (get exercise2::MovementTypeRequest :datatype-) "exercise2/MovementTypeRequest")
(setf (get exercise2::MovementTypeRequest :definition-)
      "string shape
int32 duration
---
string lastDrawnShape


")

(setf (get exercise2::MovementTypeResponse :md5sum-) "f747a6d49b629ea3b92ea322ab71d841")
(setf (get exercise2::MovementTypeResponse :datatype-) "exercise2/MovementTypeResponse")
(setf (get exercise2::MovementTypeResponse :definition-)
      "string shape
int32 duration
---
string lastDrawnShape


")



(provide :exercise2/MovementType "f747a6d49b629ea3b92ea322ab71d841")


