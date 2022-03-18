execute_process(COMMAND "/home/jan/ROS/build/Turtlebot_packs_part2/kobuki/kobuki_testsuite/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/jan/ROS/build/Turtlebot_packs_part2/kobuki/kobuki_testsuite/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
