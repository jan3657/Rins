#!/usr/bin/python3

import sys
import rospy
import actionlib
import numpy as np
import tf2_geometry_msgs
import tf2_ros
import copy
import math
from matplotlib import pyplot as plt

from os.path import dirname, join
from task2.msg import Ring
from geometry_msgs.msg import PoseStamped, Quaternion, Point, PoseWithCovarianceStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal, MoveBaseActionResult
from sensor_msgs.msg import Image
from geometry_msgs.msg import PointStamped, Vector3, Pose, Twist
from cv_bridge import CvBridge, CvBridgeError
from visualization_msgs.msg import Marker, MarkerArray
from std_msgs.msg import ColorRGBA
from actionlib_msgs.msg import GoalID
from nav_msgs.msg import Odometry
from tf.transformations import euler_from_quaternion, quaternion_from_euler


class mover:
    def __init__(self):
        rospy.init_node('mover', anonymous=True)

        self.result_sub = rospy.Subscriber("/move_base/result", MoveBaseActionResult, self.result_sub_callback)
        self.ring_sub = rospy.Subscriber("/detected_ring", Ring, self.detected_ring_callback)

        self.cancel_goal_publisher = rospy.Publisher("/move_base/cancel", GoalID, queue_size=10)

        self.markers_pub = rospy.Publisher('markers', MarkerArray, queue_size=1000)

        self.marker_array = MarkerArray()
        self.marker_num = 0

        self.state = "get_next_waypoint"

        

    def move_to_next_waypoint(self, x_goal, y_goal):

        client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        client.wait_for_server()
        msg = PoseStamped()

        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = x_goal
        goal.target_pose.pose.position.y = y_goal
        goal.target_pose.pose.orientation.w = 1.0

        client.send_goal(goal)

    


    def move(self):
        pointsX = [-1.0939724445343018, -0.1617065668106079, 1.1553516387939453, -0.06641178578138351,
                   2.8884198665618896, 1.2774776220321655, 1.9491162300109863, -0.47786661982536316]
        pointsY = [0.3391437530517578, 0.3451138436794281, -1.0127415657043457, -0.995416522026062,
                   0.04714234545826912, 0.9301703572273254, 2.9044089317321777, 2.689185857772827]
        i = 0

        while not rospy.is_shutdown() and i < len(pointsX):
            if(self.state == "get_next_waypoint"):
                self.state = "moving"
                #print("true")
                
                self.move_to_next_waypoint(pointsX[i], pointsY[i])
                i += 1
            else:
                pass
                
    def result_sub_callback(self, data):
        print("Sub resoult callback")
        res_status = data.status.status

        if res_status == 3 or res_status == 4:
            self.state = "get_next_waypoint"

    def detected_ring_callback(self, data):
        print("Ring deteceted")
        weener = data.position.pose
        self.put_a_marker(weener)

    def detected_cylinder_callback(self, data):
        pass    

    def put_a_marker(self, wasabi):
        self.marker_num += 1
        marker = Marker()
        marker.header.frame_id = "map"
        marker.type = Marker.CUBE
        marker.action = Marker.ADD
        marker.frame_locked = False
        marker.scale = Vector3(0.1, 0.1, 0.1)
        marker.pose = wasabi
        marker.color = ColorRGBA(1, 0, 0, 1)
        marker.id = self.marker_num + 1

        self.marker_array.markers.append(marker)
        self.markers_pub.publish(self.marker_array)   



def main():         
    objekt = mover()
    objekt.move()


if __name__ == '__main__':
    main()
