
import cv2
from matplotlib.pyplot import contour
import rospy
import math
import numpy as np
import tf2_geometry_msgs
import tf2_ros
import tf

from cv_bridge import CvBridge, CvBridgeError
import copy

from visualization_msgs.msg import Marker, MarkerArray
from geometry_msgs.msg import (
    PoseArray,
    PoseStamped,
    Point,
    Quaternion,
    Pose,
    Twist,
)
from move_base_msgs.msg import MoveBaseActionResult
from nav_msgs.srv import GetPlan
from actionlib_msgs.msg import GoalID
from sensor_msgs.msg import Image
from std_msgs.msg import String
from kobuki_msgs.msg import BumperEvent
from task3.msg import Cylinder

import requests
import io



class Mover:
    def __init__(self):  
        self.node = rospy.init_node("mover")
        self.bridge = CvBridge()
        self.cylinder = Cylinder()
        self.state = "look_for_cylinder"

        #publishers    
        self.pose_pub = rospy.Publisher("/move_base_simple/goal", PoseStamped, queue_size=10)
        self.cancel_goal_pub = rospy.Publisher("/move_base/cancel", GoalID, queue_size=10)
        self.twist_pub = rospy.Publisher("/cmd_vel_mux/input/teleop", Twist, queue_size=10)
        self.fine_navigation_img_pub = rospy.Publisher(
            "/fine_navigation_image", Image, queue_size=10
        )

        #subscirbers
        self.cylinder_sub = rospy.Subscriber(
            "/detected_cylinder_color", Cylinder, self.find_cylinders_callback
        )
        self.params = {
            "distance_to_cylinder": rospy.get_param("~distance_to_cylinder", default=7),
            "distance_to_ring": rospy.get_param("~distance_to_ring", default=10),
            "horizontal_space": rospy.get_param("~horizontal_space", default=100),
            "vertical_space": rospy.get_param("~vertical_space", default=170),
            "cylinder_detection_min_dis": rospy.get_param(
                "~cylinder_detection_min_dis", default=0.6
            ),
        }
        # Ring and cylinder approach
        self.forward_counter = 0
        self.back_counter = None
        self.move_forward = False
        self.last_turn = None
        self.goal_reached = False


    def find_cylinders_callback(self, data):      
        self.state = "cylinder_approach"   
        self.cylinder = data
        print(self.cylinder.color)

    def move(self):
        while not rospy.is_shutdown():
            rospy.Rate(1).sleep
            if (self.state == "cylinder_approach") :
                self.cylinder_approach()


            


    def cylinder_approach(self):
        
        color = self.cylinder.color
        try:
            image = self.bridge.imgmsg_to_cv2(
                rospy.wait_for_message("/camera/rgb/image_raw", Image), "bgr8"
            )
        except CvBridgeError as e:
            print(e)

        limits = {
            "red": (np.array([0, 10, 65]), np.array([20, 255, 255])),
            "yellow": (np.array([20, 10, 65]), np.array([40, 255, 255])),
            "green": (np.array([40, 10, 65]), np.array([70, 255, 255])),
            "blue": (np.array([70, 10, 65]), np.array([110, 255, 255])),
        }

        hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
        mask = cv2.inRange(
            hsv,
            *limits.get(color, (np.array([0, 0, 0]), np.array([110, 255, 255]))),
        )
        countour, hierarchy = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
        
        if len(countour) > 0:
            depth_image = rospy.wait_for_message("/camera/depth/image_raw", Image)
            depth_image = self.bridge.imgmsg_to_cv2(depth_image, "32FC1")

            y = int(image.shape[0] / 2)
            x = int(image.shape[1] / 2)

            yd = int(depth_image.shape[0] / 2)
            xd = int(depth_image.shape[1] / 2)
            dist = np.nanmean(depth_image[yd - 5 : yd + 5, xd - 5 : xd + 5])

            cont = max(countour, key=cv2.contourArea)
            m = cv2.moments(cont)
            cx = int(m["m10"] / m["m00"])
            cy = int(m["m01"] / m["m00"])

            c_dist = depth_image[cy, cx]

            cv2.circle(image, (cx, cy), 3, (0, 255, 0))
            cv2.drawContours(image, [cont], -1, (0, 255, 0), 2)

            image[
                self.params["vertical_space"] : -self.params["vertical_space"],
                0 : self.params["horizontal_space"],
            ] = (0, 0, 255)

            image[
                self.params["vertical_space"] : -self.params["vertical_space"],
                image.shape[1] - self.params["horizontal_space"] :,
            ] = (0, 0, 255)

            # Compute the distance to the left and right side while ignoring the detected cylinder
            temp_left = list()
            for i in range(
                self.params["vertical_space"],
                depth_image.shape[0] - self.params["vertical_space"],
            ):
                for j in range(self.params["horizontal_space"]):
                    if mask[i, j] != 255:
                        temp_left.append(depth_image[i, j])
            temp_left = np.array(temp_left)

            temp_right = list()
            for i in range(
                self.params["vertical_space"],
                depth_image.shape[0] - self.params["vertical_space"],
            ):
                for j in range(
                    depth_image.shape[1] - self.params["horizontal_space"],
                    depth_image.shape[1],
                ):
                    if mask[i, j] != 255:
                        temp_right.append(depth_image[i, j])
            temp_right = np.array(temp_right)

            left = np.nanmean(temp_left)
            right = np.nanmean(temp_right)

            msg = Twist()

            #print(
            #    f"Distance to image center: {dist:.4}, Distance to cylinder center: {c_dist:.4}, image center: {x}, cylinder center: {cx}, left: {left:.4}, right: {right:.4}"
            #)

            if not self.goal_reached:
                if self.last_turn != None and cy < 100:
                    if self.last_turn == "left":
                        msg.angular.z = -0.5
                    else:
                        msg.angular.z = 0.5

                if (np.isnan(left) or left < 0.5) and c_dist > self.params[
                    "cylinder_detection_min_dis"
                ]:
                    msg.angular.z = -0.5
                    self.last_turn = "right"
                    self.move_forward = 1
                    print("Avoid, turn right (speed: 0.5)")
                elif (np.isnan(right) or right < 0.5) and c_dist > self.params[
                    "cylinder_detection_min_dis"
                ]:
                    msg.angular.z = 0.5
                    self.last_turn = "left"
                    self.move_forward = 1
                    print("Avoid, turn left (speed: 0.5)")
                elif self.move_forward > 0:
                    self.move_forward -= 1
                    if c_dist > self.params["cylinder_detection_min_dis"]:
                        msg.linear.x = 0.2
                        print("Avoid, forward (speed: 0.2)")
                    elif c_dist > 0.5:
                        msg.linear.x = 0.05
                        print("Avoid, forward (speed: 0.5)")
                    elif c_dist > 0.4:
                        msg.linear.x = 0.01
                        print("Avoid, forward (speed: 0.01)")
                    else:
                        self.move_forward = 0
                elif self.last_turn != None:
                    self.last_turn = None
                    if c_dist > self.params["cylinder_detection_min_dis"]:
                        if self.last_turn == "left":
                            msg.angular.z = -0.5
                            print("Avoid, rotate back right (speed: 0.5)")
                        else:
                            msg.angular.z = 0.5
                            print("Avoid, rotate back left (speed: 0.5)")
                else:
                    # Set rotation step
                    step = 0.15
                    if abs(cx - x) < 5:
                        step = 0.005
                    elif abs(cx - x) < 20:
                        step = 0.01
                    elif abs(cx - x) < 30:
                        step = 0.03
                    elif abs(cx - x) < 50:
                        step = 0.1

                    if abs(cx - x) < 2:
                        if not np.isnan(dist):
                            if dist > 0.55:
                                msg.linear.x = 0.3
                                print("Move forward (speed: 0.3)")
                            elif dist > 0.46:
                                msg.linear.x = 0.1
                                print("Move forward (speed: 0.1)")
                            else:
                                msg.linear.x = 0.01
                                print("Move forward (speed: 0.01)")
                        elif self.forward_counter < 12:
                            msg.linear.x = 0.01
                            self.forward_counter += 1
                            print("Move forward manual", self.forward_counter)
                        elif self.forward_counter < 17:
                            msg.linear.x = 0.005
                            self.forward_counter += 1
                            print("Move forward manual", self.forward_counter)
                        else:
                            self.arm_control_pub.publish("extend")
                            print(f"Extending arm over the {color.upper()} cylinder")
                            self.speak(f"Im near the {color} cylinder.")
                            rospy.sleep(5)
                            self.arm_control_pub.publish("retract")
                            self.goal_reached = True
                            self.back_counter = 2
                    else:
                        if cx > x:
                            print(f"Turn right (speed: {step})")
                            msg.angular.z = -step
                        elif cy < x:
                            print(f"Turn left (speed: {step})")
                            msg.angular.z = step
            else:
                if self.back_counter > 0:
                    msg.linear.x = -0.2
                    self.back_counter -= 1
                    print("Move back", self.back_counter)
                else:
                    self.forward_counter = 0
                    self.move_forward = 0
                    self.last_turn = None
                    self.goal_reached = False
                    self.back_counter = None
                    self.state = "return_to_stored_pose"
                    print("Return to stored pose")

            self.twist_pub.publish(msg)

        self.fine_navigation_img_pub.publish(
            self.bridge.cv2_to_imgmsg(cv2.bitwise_and(image, image, mask=cv2.bitwise_not(mask)))
        )
        print()

        
            

if __name__ == "__main__":
    ms = Mover()
    ms.move()
