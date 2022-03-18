#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/jan/ROS/src/Turtlebot_packs_part2/yujin_ocs/yocs_navigator"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/jan/ROS/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/jan/ROS/install/lib/python3/dist-packages:/home/jan/ROS/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/jan/ROS/build" \
    "/usr/bin/python3" \
    "/home/jan/ROS/src/Turtlebot_packs_part2/yujin_ocs/yocs_navigator/setup.py" \
     \
    build --build-base "/home/jan/ROS/build/Turtlebot_packs_part2/yujin_ocs/yocs_navigator" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/jan/ROS/install" --install-scripts="/home/jan/ROS/install/bin"
