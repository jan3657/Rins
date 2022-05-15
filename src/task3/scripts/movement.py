#!/usr/bin/python3

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

        self.result_sub = rospy.Subscriber(
            "/move_base/result", MoveBaseActionResult, self.result_sub_callback
        )
            
        self.cancel_goal_publisher = rospy.Publisher(
            "/move_base/cancel", GoalID, queue_size=10
        )
            
        self.ring_sub = rospy.Subscriber(
            "/detected_ring", Ring, self.find_rings_callback
        )
         
        self.cylinder_sub = rospy.Subscriber(
            "/detected_cylinder_color", Cylinder, self.find_cylinders_callback
        )
        """  
        self.odom_sub = rospy.Subscriber(
            "/amcl_pose", PoseWithCovarianceStamped, self.amcl_callback
        )
        """
        
        self.pose_pub = rospy.Publisher(
            "/move_base_simple/goal", PoseStamped, queue_size=10
        )
        
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
        """
        self.markers_pub = rospy.Publisher('face_markers', MarkerArray, queue_size=1000)
        ""
        """
        self.ring_markers_pub = rospy.Publisher('ring_markers', MarkerArray, queue_size=1000)
        self.cylinder_markers_pub = rospy.Publisher('cylinder_markers', MarkerArray, queue_size=1000)    
        
        self.faces = list()
        self.rings = list()
        self.cylinders = list()
        
        self.number_of_rings = 4
        self.number_of_cylinders = 4
        
        self.state = "get_next_waypoint"
        self.botLocationX = 0.0
        self.botLocationY = 0.0
        self.quarternion = [None] * 4
        
        self.objectLocationX = 0.0
        self.objectLocationY = 0.0

    
    def mover(self):
        
        pointsX = [-1.0168464183807373, 0.11480855941772461, 1.2963203191757202, 3.2392728328704834, 1.369457483291626, 2.2871389389038086, -0.9441158771514893] #, 1.3853058815002441, 2.252521276473999, 1.2552205324172974]
        pointsY = [0.43050241470336914, -0.8683590888977051, -0.9171204566955566, -0.06005513668060303, 0.9356169700622559, 1.529862880706787, 1.9161224365234375] #, 0.9824095964431763, 1.2976646423339844, 0.7623564004898071]
        
        i = 0
        next_goal = None
        
        rate = rospy.Rate(1)
        
        while self.pose_pub.get_num_connections() < 1:
            rate.sleep()
        
        while not rospy.is_shutdown():
        
            if self.number_of_rings == len(self.rings) and self.number_of_cylinders == len(self.cylinders) and self.state != "end":
                self.state = "park"
                self.cancel_goal_publisher.publish(GoalID())
                rospy.sleep(1)
                
                parkingX = 2.8864951133728027
                parkingY = -0.19022172689437866
                
                self.move_to_next(parkingX, parkingY, "parking")
               
            elif self.state == "get_next_waypoint":
                   
                if i == len(pointsX):
                    i = 0
                
                self.move_to_next(pointsX[i], pointsY[i], "moving")
                i += 1
            
            elif self.state == "ring_found":
                #print("Numb of rings: ", len(self.rings))
                #self.cancel_goal_publisher.publish(GoalID())
                #rospy.sleep(1)
                #ringy = self.rings[-1]
                #print("Hello", ringy.color, "ring")
                self.state = "get_next_waypoint"       
                
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
            self.state = "ring_found"

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
            cylinder = Cylindy(pose, self.cylinder_marker_num, color)
            print("Hello", color, "cylinder")
            self.cylinder_marker_num += 1
            self.cylinders.append(cylinder)
            self.cylinder_marker_array.markers.append(cylinder.to_marker())
                    
            
        self.cylinder_markers_pub.publish(self.cylinder_marker_array) 
        
               
        
    def move_to_next_waypoint(self, x_goal, y_goal, next_state):
    
        if next_state == "end":
            self.state = "end"
            print(" :) ")
        elif next_state == "moving":
            self.state = "moving"
            print("Moving")
        elif next_state == "approach_face":
            self.state = "approach_face"
            print("Approaching face")
        elif next_state == "parking":
            self.state = "parking"
            print("Parking")
            
        client = actionlib.SimpleActionClient('move_base',MoveBaseAction)
        client.wait_for_server()
        
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = x_goal
        goal.target_pose.pose.position.y = y_goal
        goal.target_pose.pose.orientation.w = 1.0

        client.send_goal(goal)
        
        
    def move_to_next(self, x_goal, y_goal, next_state):
        
        if next_state == "end":
            self.state = "end"
            print(" :) ")
        elif next_state == "moving":
            self.state = "moving"
            print("Moving")
        elif next_state == "approach_face":
            self.state = "approach_face"
            print("Approaching face")
        elif next_state == "parking":
            self.state = "parking"
            print("Parking")
            
                    
        msg = PoseStamped()
        msg.header.frame_id = "map"
        msg.header.seq = self.seq
        msg.header.stamp = rospy.Time.now()
        msg.pose.position.x = x_goal
        msg.pose.position.y = y_goal
        msg.pose.orientation.w = 1.0
        
        self.pose_pub.publish(msg)
        
        
        
    def result_sub_callback(self, data):
    
        res_status = data.status.status
        #print("Res status: ", res_status)
        #print("Self state: ", self.state)
        
        if self.state == "moving":
            if res_status == 3 or res_status == 4:
                self.seq += 1
                self.state = "get_next_waypoint"
        
        elif self.state == "ring_found":
            self.state = "get_next_waypoint"
            
        elif self.state == "parking":
            if res_status == 3:
                self.state = "end"
        
    """    
    def amcl_callback(self, msg):  
      
        try:
            self.botLocationX,self.botLocationY = msg.pose.pose.position.x, msg.pose.pose.position.y
            self.quarternion[0] = msg.pose.pose.orientation.x
            self.quarternion[1] = msg.pose.pose.orientation.y
            self.quarternion[2] = msg.pose.pose.orientation.z
            self.quarternion[3] = msg.pose.pose.orientation.w
        except:
            print("")
    """   
  
"""    
class Face:

    def __init__(self, pose, enc, mId):
        self.pose = pose
        self.enc = copy.deepcopy(enc)
        self.id = mId

    def to_marker(self):
        marker = Marker()
        marker.header.frame_id = "map"
        marker.type = Marker.CUBE
        marker.action = Marker.ADD
        marker.frame_locked = False
        marker.scale = Vector3(0.1, 0.1, 0.1)
        marker.pose = self.pose
        marker.color = ColorRGBA(0, 1, 0, 1)
        marker.id = self.id
        return marker
""" 

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

    def __init__(self, pose, cId, color):
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
        
