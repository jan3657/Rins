#!/usr/bin/python3
from cgitb import grey
import cv2
import sys
import rospy
import actionlib
import numpy as np
import tf2_geometry_msgs
import tf2_ros
import copy
import math
import time
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
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from tf.transformations import euler_from_quaternion, quaternion_from_euler



class mover:
    def __init__(self):
        rospy.init_node('mover', anonymous=True)

        self.result_sub = rospy.Subscriber("/move_base/result", MoveBaseActionResult, self.result_sub_callback)
        self.ring_sub = rospy.Subscriber("/detected_ring", Ring, self.detected_ring_callback)
        self.arm_movement_pub = rospy.Publisher('/turtlebot_arm/arm_controller/command', JointTrajectory, queue_size=1)

        self.cancel_goal_publisher = rospy.Publisher("/move_base/cancel", GoalID, queue_size=10)
        self.rings = list()
        
        self.marker_array = MarkerArray()
        self.marker_num = 0   
        self.markers_pub = rospy.Publisher('markers', MarkerArray, queue_size=1000)

        self.tf_buf = tf2_ros.Buffer()
        self.tf2_listener = tf2_ros.TransformListener(self.tf_buf)

        self.state = "found_all_rings"

        self.position = Pose
        #twisted mover~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        self.moveBindings = {
        'i':(1,0),
        'o':(1,-1),
        'j':(0,1),
        'l':(0,-1),
        'u':(1,1),
        ',':(-1,0),
        '.':(-1,1),
        'm':(-1,-1),
        }

        self.speed = 2
        self.turn = 2

        self.x = 0
        self.th = 0
        self.status = 0
        self.count = 0
        self.acc = 0.1
        self.target_speed = 0
        self.target_turn = 0
        self.control_speed = 0
        self.control_turn = 0

        self.twist_pub = rospy.Publisher('/cmd_vel_mux/input/navi', Twist, queue_size=5)
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        

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
            print(self.state,"Num of detected rings: ", len(self.rings))
            if(self.state == "get_next_waypoint"):
                self.state = "moving"
                self.move_to_next_waypoint(pointsX[i], pointsY[i])
                i = (i % 7) +1

            elif(self.state == "found_all_rings"):
                self.cancel_goal_publisher.publish(GoalID())
                try:
                    rgb_image_message = rospy.wait_for_message("/arm_camera/rgb/image_raw", Image)
                    bridge = CvBridge()
                    rgb_image = bridge.imgmsg_to_cv2(rgb_image_message, "bgr8")

                except Exception as e:
                    print(e)

                hsv = cv2.cvtColor(rgb_image, cv2.COLOR_BGR2HSV)
                lower_range = np.array([0,50,50])
                upper_range = np.array([50,255,255])
                mask = cv2.inRange(hsv, lower_range,upper_range)
                
                circles = cv2.HoughCircles(mask,cv2.HOUGH_GRADIENT,1,20,param1=10,param2=15,minRadius=5,maxRadius=90)

                cv2.imshow("mask",mask)

                cv2.imshow("image",rgb_image)
                cv2.waitKey(1)
                
                
                if circles is None:
                    self.twisted_mover("l")
                else:
                    for cnt in circles:
                        print(cnt)
                        if(cnt[0][0] > 200 ):
                            self.twisted_mover("l")  
                        
                        #elif(cnt[0][1] > 370):
                            #self.twisted_mover("j") 

                        else:
                            self.twisted_mover("i") 
                    


                #self.state = "parking"
                #print("Found all ",len(self.rings)," rings")
                
                
                #self.arm_movement_pub.publish("extend")
                
                




            elif(self.state == "park"):
                pass

            else:
                pass
                
    def result_sub_callback(self, data):
        
        print("Sub resoult callback")
        res_status = data.status.status

        if self.state == "moving" and res_status == 3 or self.state == "moving" and res_status == 4:
            self.state = "get_next_waypoint"

        #elif self.state == "moving_to_parking" and res_status == 4:
        #    self.state = "park"
        else:
            pass
        
        

    def detected_cylinder_callback(self, data):
        pass    

    def detected_ring_callback(self, data):
        if(self.marker_num >= 2):
            self.state="found_all_rings"
        place_marker = True
        if self.rings:
            for ring in self.rings:
                if not(abs(data.position.pose.position.x - ring.pose.position.x) > 1 or abs(data.position.pose.position.y - ring.pose.position.y) > 1):
                    place_marker = False
                   
        if place_marker:
            x = Ringy(data.position, self.marker_num,data.color,)
            self.rings.append(x)
            self.marker_num += 1
            self.marker_array.markers.append(x.put_a_marker())

        self.markers_pub.publish(self.marker_array)
        
    
    def calculate_goal(self,fromCoordinates,toCoordiantes):

        x1 = fromCoordinates.position.x
        y1 = fromCoordinates.position.y
        x2 = toCoordiantes.position.x
        y2 = toCoordiantes.position.y
        value = 0.5
        print("x1: ",x1," x2: ",x2," y1: ",y1," y2: ",y2)
        if x2 > x1 and y2 > y1:
            x2 -= value
            y2 -= value
        elif x2 < x1 and y2 > y1:
            x2 += value
            y2 -= value
        elif x2 < x1 and y2 < y1:
            x2 += value
            y2 += value
        elif x2 > x1 and y2 < y1:
            x2 -= value
            y2 += value

        return toCoordiantes

    def get_current_pose(self):
    
        pose_translation = None
        
        while pose_translation is None:
            try:
                pose_translation = self.tf_buf.lookup_transform(
                    "map", "base_link", rospy.Time.now(), rospy.Duration(5)
                )
            except Exception as e:
                print(e)

        pose = PoseStamped()
        pose.header.seq = 0
        pose.header.stamp = rospy.Time.now()
        pose.header.frame_id = "map"
        pose.pose.position = Point(pose_translation.transform.translation.x,pose_translation.transform.translation.y,0,)
        pose.pose.orientation = pose_translation.transform.rotation
        
        return pose

    def twisted_mover(self,key):
        print("Twisted moving :", key)
        try:
            print("currently:\tspeed %s\tturn %s " % (self.speed,self.turn))
            for i in range(30):
                key 
                if key in self.moveBindings.keys():
                    self.x = self.moveBindings[key][0]
                    self.th = self.moveBindings[key][1]
                    self.count = 0

                elif key == ' ' or key == 'k' :
                    self.x = 0
                    self.th = 0
                    self.control_speed = 0
                    self.control_turn = 0
                else:
                    self.count = self.count + 1
                    if self.count > 4:
                        self.x = 0
                        self.th = 0
                    if (self.key == '\x03'):
                        break

                self.target_speed = self.speed * self.x
                self.target_turn = self.turn * self.th

                if self.target_speed > self.control_speed:
                    self.control_speed = min( self.target_speed, self.control_speed + 0.02 )
                elif self.target_speed < self.control_speed:
                    self.control_speed = max( self.target_speed, self.control_speed - 0.02 )
                else:
                    self.control_speed = self.target_speed

                if self.target_turn > self.control_turn:
                    self.control_turn = min( self.target_turn, self.control_turn + 0.1 )
                elif self.target_turn < self.control_turn:
                    self.control_turn = max( self.target_turn, self.control_turn - 0.1 )
                else:
                    self.control_turn = self.target_turn

                twist = Twist()
                twist.linear.x = self.control_speed; twist.linear.y = 0; twist.linear.z = 0
                twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = self.control_turn
                self.twist_pub.publish(twist)

                #print("loop: {0}".format(self.count))
                #print("target: vx: {0}, wz: {1}".format(target_speed, target_turn))
                #print("publihsed: vx: {0}, wz: {1}".format(twist.linear.x, twist.angular.z))

        except Exception as e:
            print(e)

        finally:
            twist = Twist()
            twist.linear.x = 0; twist.linear.y = 0; twist.linear.z = 0
            twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = 0
            self.twist_pub.publish(twist)


class Ringy:
    def __init__(self, pose_stamped,rId, colour):
        self.pose = pose_stamped.pose
        self.id = rId
        self.colour = colour
        print(self.colour)

        if self.colour == "red":
            self.rgba = [1,0,0,1]
        elif self.colour == "green":
            self.rgba = [0,1,0,1]
        elif self.colour == "blue":
            self.rgba = [0,0,1,1]
        elif self.colour == "cyan":
            self.rgba = [0,1,1,1]
        elif self.colour == "magenta":
            self.rgba = [1,0,1,1]
        elif self.colour == "yellow":
            self.rgba = [1,1,0,1]
        elif self.colour == "black":
            self.rgba = [0,0,0,1]
        elif self.colour == "grey":
            self.rgba = [0,0,0,1]
        
        
    def put_a_marker(self):
        
        marker = Marker()
        marker.header.frame_id = "map"
        marker.type = Marker.CUBE
        marker.action = Marker.ADD
        marker.frame_locked = False
        marker.scale = Vector3(0.1, 0.1, 0.1)
        marker.pose = self.pose
        marker.color = ColorRGBA(self.rgba[0],self.rgba[1],self.rgba[2],self.rgba[3])
        marker.id = self.id

        return marker
  

class Cilindy:
    def __init__(self, pose, rId):
        self.pose = pose.pose
        self.id = rId    

def main():         
    objekt = mover()
    objekt.move()


if __name__ == '__main__':
    main()

