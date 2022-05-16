#!/usr/bin/python3

from queue import Empty
import sys
import rospy
import dlib
import cv2
import actionlib
import numpy as np
import face_recognition
import tf2_geometry_msgs
import tf2_ros
import tf
import copy
import math
from matplotlib import pyplot as plt

from os.path import dirname, join

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
from task3.msg import Ring
from task3.msg import Cylinder
from task3.msg import FacePose

class Movement:

    def __init__(self):
        

        rospy.init_node('movement', anonymous=True)

        #subscribers
        self.result_sub = rospy.Subscriber(
            "/move_base/result", MoveBaseActionResult, self.result_sub_callback
        )
        self.ring_sub = rospy.Subscriber(
            "/detected_ring", Ring, self.find_rings_callback
        )
        self.cylinder_sub = rospy.Subscriber(
            "/detected_cylinder_color", Cylinder, self.find_cylinders_callback
        )

        self.odom_sub = rospy.Subscriber(
            "/amcl_pose", PoseWithCovarianceStamped, self.amcl_callback
        )
        
            
        
            
        #publishers

        self.cancel_goal_publisher = rospy.Publisher(
            "/move_base/cancel", GoalID, queue_size=10
        )

        self.pose_pub = rospy.Publisher(
            "/move_base_simple/goal", PoseStamped, queue_size=10
        )
        self.ring_markers_pub = rospy.Publisher(
            'ring_markers', MarkerArray, queue_size=1000
            )
        self.cylinder_markers_pub = rospy.Publisher(
            'cylinder_markers', MarkerArray, queue_size=1000
            )   
        self.cancel_goal_pub = rospy.Publisher(
            "/move_base/cancel", GoalID, queue_size=10
            )
        self.twist_pub = rospy.Publisher(
            "/cmd_vel_mux/input/teleop", Twist, queue_size=10
            )
        self.fine_navigation_img_pub = rospy.Publisher(
            "/fine_navigation_image", Image, queue_size=10
        )

        """  
        
        """

        self.tf_buf = tf2_ros.Buffer()
        self.tf2_listener = tf2_ros.TransformListener(self.tf_buf)
           
        self.bridge = CvBridge()
        
        self.seq = 0
        
        self.face_marker_array = MarkerArray()
        self.face_marker_num = 1
        
        self.ring_marker_array = MarkerArray()
        self.ring_marker_num = 1
        
        self.cylinder_marker_array = MarkerArray()
        self.cylinder_marker_num = 1
         
        
        self.faces = list()
        self.rings = list()
        self.cylinders = list()
        
        self.number_of_rings = 4
        self.number_of_cylinders = 4
        
        self.state = "get_next_waypoint"
        self.robot_pose = Pose()

        
        self.objectLocationX = 0.0
        self.objectLocationY = 0.0

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
        self.cylinder_color = ""
  
    def mover(self):
        
        pointsX = [-1.0168464183807373, 0.11480855941772461, 1.2963203191757202, 3.2392728328704834, 1.369457483291626, 2.2871389389038086, -0.9441158771514893] #, 1.3853058815002441, 2.252521276473999, 1.2552205324172974]
        pointsY = [0.43050241470336914, -0.8683590888977051, -0.9171204566955566, -0.06005513668060303, 0.9356169700622559, 1.529862880706787, 1.9161224365234375] #, 0.9824095964431763, 1.2976646423339844, 0.7623564004898071]
        
        i = 0
        next_goal = None
        
        rate = rospy.Rate(1)
        
        while self.pose_pub.get_num_connections() < 1:
            rate.sleep()
        
        while not rospy.is_shutdown():
            print("status = ",self.state)
            print("Numb of rings : ",len(self.rings), "Numb of Cili", len(self.cylinders))

            if self.number_of_rings == len(self.rings) and self.number_of_cylinders == len(self.cylinders) and self.state == "get_next_waypoint":
                self.state = "parking"
                self.cancel_goal_publisher.publish(GoalID())
                rospy.sleep(1)
                
                parkingX = 2.8864951133728027
                parkingY = -0.19022172689437866
                
                self.move_to(parkingX, parkingY)


            elif self.state == "get_next_waypoint":
                self.move_to(pointsX[i], pointsY[i])
                i = i%6 + 1
                self.state = "moving"
            
            elif self.state == "moving":
                pass

            elif self.state == "end":
                for r in self.cylinders:
                    if(r.color == "red"):
                        print("I'm here")
                        self.state = "move_to_remembered_point"
                        self.cylinder_color = "red"
                        self.move_to(1,1,r.robot_pose)
                        print("Barva: ",r.color,"Cylinder pose: ", r.pose, "Robot pose: ",r.robot_pose)
                print("I'm done :=)")


            elif self.state == "cylinder_approach":
                self.cylinder_approach()

            rate.sleep()
      
    def find_rings_callback(self, data):

        place_marker = True

        if self.rings:
            for ring in self.rings:
                if (np.sqrt((data.position.pose.position.x - ring.pose.pose.position.x) ** 2 + (
                        data.position.pose.position.y - ring.pose.pose.position.y) ** 2) < 1):
                    place_marker = False

        if place_marker and len(self.rings) < self.number_of_rings:
            pose = data.position
            color = data.color
            ring = Ringy(pose, self.ring_marker_num, color)
            self.ring_marker_num += 1
            self.rings.append(ring)
            self.ring_marker_array.markers.append(ring.to_marker())
            self.objectLocationX = data.position.pose.position.x
            self.objectLocationY = data.position.pose.position.y
            print("Hello", color, "ring")
            #self.state = "ring_found"

        self.ring_markers_pub.publish(self.ring_marker_array)
       
    def find_cylinders_callback(self, data):
        
        place_marker = True
        
        if self.cylinders :
            for cylinder in self.cylinders :
                if not(abs(data.position.point.x - cylinder.pose.point.x) > 1 or abs(data.position.point.y - cylinder.pose.point.y) > 1):
                    place_marker = False
                
        if place_marker:
            pose = data.position
            color = data.color
            cylinder = Cylindy(pose, self.cylinder_marker_num, color,self.robot_pose)
            print("Hello", color, "cylinder")
            self.cylinder_marker_num += 1
            self.cylinders.append(cylinder)
            self.cylinder_marker_array.markers.append(cylinder.to_marker())
                    
            
        self.cylinder_markers_pub.publish(self.cylinder_marker_array) 
              
    def move_to(self, x_goal=None, y_goal=None, pose = None):
        msg = PoseStamped()
        msg.header.frame_id = "map"
        msg.header.seq = self.seq
        msg.header.stamp = rospy.Time.now()

        if pose is not None:
            msg.pose = pose         
        else:
            msg.pose.position.x = x_goal
            msg.pose.position.y = y_goal
            msg.pose.orientation.w = 1.0
        
        self.pose_pub.publish(msg)
        
    def result_sub_callback(self, data):
    
        res_status = data.status.status
        #print("Res status: ", res_status)
        #print("Self state: ", self.state)
        #print("Numb of rings : ",len(self.rings), "Numb of Cili", len(self.cylinders))
        
        if self.state == "moving":
            if res_status == 3 or res_status == 4:
                self.seq += 1
                self.state = "get_next_waypoint"
            
        elif self.state == "parking":
            if res_status == 3 or res_status == 4:
                self.state = "end"

        elif self.state == "move_to_remembered_point":
            if res_status == 3 or res_status == 4:
                self.state = "cylinder_approach"
        
    def cylinder_approach(self):
        
        color = self.cylinder_color


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

            print(
                f"Distance to image center: {dist:.4}, Distance to cylinder center: {c_dist:.4}, image center: {x}, cylinder center: {cx}, left: {left:.4}, right: {right:.4}"
            )

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
    def amcl_callback(self,data):
        self.robot_pose = data.pose.pose

class Ringy:

    def __init__(self, pose, rId, color):
        self.pose = pose
        self.id = rId
        self.color = color
        if self.color == "red":             
            self.rgba = [1,0,0,1]         
        elif self.color == "green":             
            self.rgba = [0,1,0,1]         
        elif self.color == "blue":             
            self.rgba = [0,0,1,1]         
        elif self.color == "cyan":             
            self.rgba = [0,1,1,1]         
        elif self.color == "magenta":             
            self.rgba = [1,0,1,1]         
        elif self.color == "yellow":             
            self.rgba = [1,1,0,1]         
        elif self.color == "black":             
            self.rgba = [0,0,0,1]         
        elif self.color == "gray":
            self.rgba = [0,0,0,1]
    
    def to_marker(self):
        marker = Marker()
        #marker.header.stamp = self.pose.header.stamp
        #marker.header.frame_id = self.pose.header.frame_id
        marker.header.frame_id = "map"
        marker.type = Marker.CUBE
        marker.action = Marker.ADD
        marker.frame_locked = False
        marker.scale = Vector3(0.1, 0.1, 0.1)
        #marker.scale = Vector3(1, 1, 1)
        marker.pose = self.pose.pose
        #marker.color = ColorRGBA(0, 1, 0, 1)
        marker.color = ColorRGBA(self.rgba[0],self.rgba[1],self.rgba[2],self.rgba[3])
        marker.id = self.id
        return marker
class Cylindy:

    def __init__(self, pose, cId, color,robot_pose):
        self.robot_pose = robot_pose
        self.pose = pose
        self.id = cId
        self.color = color
        if self.color == "red":             
            self.rgba = [1,0,0,1]         
        elif self.color == "green":             
            self.rgba = [0,1,0,1]         
        elif self.color == "blue":             
            self.rgba = [0,0,1,1]         
        elif self.color == "cyan":             
            self.rgba = [0,1,1,1]         
        elif self.color == "magenta":             
            self.rgba = [1,0,1,1]         
        elif self.color == "yellow":             
            self.rgba = [1,1,0,1]         
        elif self.color == "black":             
            self.rgba = [0,0,0,1]         
        elif self.color == "gray":
            self.rgba = [0,0,0,1]

    def to_marker(self):
    
        marker = Marker()
        #marker.header.stamp = self.point_world.header.stamp
        #marker.header.frame_id = self.point_world.header.frame_id
        marker.header.frame_id = "map"
        marker.type = Marker.CYLINDER
        marker.action = Marker.ADD
        marker.frame_locked = False
        marker.scale = Vector3(0.1, 0.1, 0.1)
        marker.pose.position.x = self.pose.point.x
        marker.pose.position.y = self.pose.point.y
        marker.pose.position.z = self.pose.point.z
        #marker.color = ColorRGBA(0, 1, 0, 1)
        marker.color = ColorRGBA(self.rgba[0],self.rgba[1],self.rgba[2],self.rgba[3])
        marker.id = self.id
        return marker


def main():

    move = Movement()
    rate = rospy.Rate(1)
    move.mover()


if __name__ == '__main__':
    main()
        
