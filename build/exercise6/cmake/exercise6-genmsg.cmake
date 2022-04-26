# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "exercise6: 1 messages, 0 services")

set(MSG_I_FLAGS "-Iexercise6:/home/jan/Rins/src/exercise6/msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Iexercise6:/home/jan/Rins/src/exercise6/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(exercise6_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" NAME_WE)
add_custom_target(_exercise6_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exercise6" "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" "std_msgs/Header:std_msgs/ColorRGBA:geometry_msgs/PointStamped:geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(exercise6
  "/home/jan/Rins/src/exercise6/msg/Cylinder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/ColorRGBA.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exercise6
)

### Generating Services

### Generating Module File
_generate_module_cpp(exercise6
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exercise6
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(exercise6_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(exercise6_generate_messages exercise6_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" NAME_WE)
add_dependencies(exercise6_generate_messages_cpp _exercise6_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exercise6_gencpp)
add_dependencies(exercise6_gencpp exercise6_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exercise6_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(exercise6
  "/home/jan/Rins/src/exercise6/msg/Cylinder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/ColorRGBA.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exercise6
)

### Generating Services

### Generating Module File
_generate_module_eus(exercise6
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exercise6
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(exercise6_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(exercise6_generate_messages exercise6_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" NAME_WE)
add_dependencies(exercise6_generate_messages_eus _exercise6_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exercise6_geneus)
add_dependencies(exercise6_geneus exercise6_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exercise6_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(exercise6
  "/home/jan/Rins/src/exercise6/msg/Cylinder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/ColorRGBA.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exercise6
)

### Generating Services

### Generating Module File
_generate_module_lisp(exercise6
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exercise6
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(exercise6_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(exercise6_generate_messages exercise6_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" NAME_WE)
add_dependencies(exercise6_generate_messages_lisp _exercise6_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exercise6_genlisp)
add_dependencies(exercise6_genlisp exercise6_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exercise6_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(exercise6
  "/home/jan/Rins/src/exercise6/msg/Cylinder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/ColorRGBA.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exercise6
)

### Generating Services

### Generating Module File
_generate_module_nodejs(exercise6
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exercise6
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(exercise6_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(exercise6_generate_messages exercise6_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" NAME_WE)
add_dependencies(exercise6_generate_messages_nodejs _exercise6_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exercise6_gennodejs)
add_dependencies(exercise6_gennodejs exercise6_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exercise6_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(exercise6
  "/home/jan/Rins/src/exercise6/msg/Cylinder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/ColorRGBA.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exercise6
)

### Generating Services

### Generating Module File
_generate_module_py(exercise6
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exercise6
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(exercise6_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(exercise6_generate_messages exercise6_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jan/Rins/src/exercise6/msg/Cylinder.msg" NAME_WE)
add_dependencies(exercise6_generate_messages_py _exercise6_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exercise6_genpy)
add_dependencies(exercise6_genpy exercise6_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exercise6_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exercise6)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exercise6
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(exercise6_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(exercise6_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET exercise6_generate_messages_cpp)
  add_dependencies(exercise6_generate_messages_cpp exercise6_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exercise6)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exercise6
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(exercise6_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(exercise6_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET exercise6_generate_messages_eus)
  add_dependencies(exercise6_generate_messages_eus exercise6_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exercise6)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exercise6
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(exercise6_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(exercise6_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET exercise6_generate_messages_lisp)
  add_dependencies(exercise6_generate_messages_lisp exercise6_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exercise6)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exercise6
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(exercise6_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(exercise6_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET exercise6_generate_messages_nodejs)
  add_dependencies(exercise6_generate_messages_nodejs exercise6_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exercise6)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exercise6\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exercise6
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(exercise6_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(exercise6_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET exercise6_generate_messages_py)
  add_dependencies(exercise6_generate_messages_py exercise6_generate_messages_py)
endif()
