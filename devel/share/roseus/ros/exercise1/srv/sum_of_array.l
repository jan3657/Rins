;; Auto-generated. Do not edit!


(when (boundp 'exercise1::sum_of_array)
  (if (not (find-package "EXERCISE1"))
    (make-package "EXERCISE1"))
  (shadow 'sum_of_array (find-package "EXERCISE1")))
(unless (find-package "EXERCISE1::SUM_OF_ARRAY")
  (make-package "EXERCISE1::SUM_OF_ARRAY"))
(unless (find-package "EXERCISE1::SUM_OF_ARRAYREQUEST")
  (make-package "EXERCISE1::SUM_OF_ARRAYREQUEST"))
(unless (find-package "EXERCISE1::SUM_OF_ARRAYRESPONSE")
  (make-package "EXERCISE1::SUM_OF_ARRAYRESPONSE"))

(in-package "ROS")





(defclass exercise1::sum_of_arrayRequest
  :super ros::object
  :slots (_array ))

(defmethod exercise1::sum_of_arrayRequest
  (:init
   (&key
    ((:array __array) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _array __array)
   self)
  (:array
   (&optional __array)
   (if __array (setq _array __array)) _array)
  (:serialization-length
   ()
   (+
    ;; int8[] _array
    (* 1    (length _array)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8[] _array
     (write-long (length _array) s)
     (dotimes (i (length _array))
       (write-byte (elt _array i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8[] _array
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _array (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _array i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> (elt _array i) 127) (setf (elt _array i) (- (elt _array i) 256)))
     ))
   ;;
   self)
  )

(defclass exercise1::sum_of_arrayResponse
  :super ros::object
  :slots (_result ))

(defmethod exercise1::sum_of_arrayResponse
  (:init
   (&key
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _result (round __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; int32 _result
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _result
       (write-long _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass exercise1::sum_of_array
  :super ros::object
  :slots ())

(setf (get exercise1::sum_of_array :md5sum-) "65f9c89928d29d739491ad72c448ad4f")
(setf (get exercise1::sum_of_array :datatype-) "exercise1/sum_of_array")
(setf (get exercise1::sum_of_array :request) exercise1::sum_of_arrayRequest)
(setf (get exercise1::sum_of_array :response) exercise1::sum_of_arrayResponse)

(defmethod exercise1::sum_of_arrayRequest
  (:response () (instance exercise1::sum_of_arrayResponse :init)))

(setf (get exercise1::sum_of_arrayRequest :md5sum-) "65f9c89928d29d739491ad72c448ad4f")
(setf (get exercise1::sum_of_arrayRequest :datatype-) "exercise1/sum_of_arrayRequest")
(setf (get exercise1::sum_of_arrayRequest :definition-)
      "int8[] array
---
int32 result


")

(setf (get exercise1::sum_of_arrayResponse :md5sum-) "65f9c89928d29d739491ad72c448ad4f")
(setf (get exercise1::sum_of_arrayResponse :datatype-) "exercise1/sum_of_arrayResponse")
(setf (get exercise1::sum_of_arrayResponse :definition-)
      "int8[] array
---
int32 result


")



(provide :exercise1/sum_of_array "65f9c89928d29d739491ad72c448ad4f")


