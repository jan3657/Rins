#!/usr/bin/python3

import rospy
import random
from geometry_msgs.msg import Twist
from exercise2.srv import MovementType,MovementTypeResponse


#def handle_movement(req):   
#  shape = req.shape
#  duration = int(req.duration)
#  print(type(shape))
#  print(type(duration))
#  #while(duration != 0):
#  #duration -= 1
#  if shape == "rectangle":
#    movement(duration)

#  return MovementTypeResponse(shape)

def movement_type_server():
    rospy.init_node('movement_type_server')
    s = rospy.Service('movement_type_service', MovementType, handle_movement)
    print("Ready to move chief")
    rospy.spin()



def handle_movement(req):
  listOfShapes = ["rectangle" , "circle", "triangle" ]
  shape = req.shape.lower()
  if shape in listOfShapes:
    shape = shape
  else:
    shape = "random"

  duration = int(req.duration)

  pub = rospy.Publisher('cmd_vel', Twist, queue_size = 1000)
  # For the turtle simulation map the topic to /turtle1/cmd_vel
  # For the turtlebot simulation and Turtlebot map the topic to /cmd_vel_mux/input/navi
  #rospy.init_node('movement')

  r = rospy.Rate(1)

  step = 0.0

  while not rospy.is_shutdown() and duration != 0:
    duration -= 1
    twist = eval(shape+ "_movement(step)")
    pub.publish(twist)
    step = step + 1.0
    r.sleep()

def rectangle_movement(step):

  twist = Twist()
  twist.linear.x = 0.1
  step = step % 20

  if step % 5 == 0:
    twist.linear.x = 0
    twist.angular.z = 1.57 #(90 / 360) * 2 * 3.14

  return twist
  
def triangle_movement(step):

  twist = Twist()
  twist.linear.x = 0.1
  step = step % 27

  if step % 9 == 0:
    twist.linear.x = 0
    twist.angular.z = 2.094 #(120 / 360) * 2 * 3.14

  return twist 

def circle_movement(step):

  twist = Twist()
  twist.linear.x = 0.1
  step = step % 12

  if step % 3 == 0:
    twist.linear.x = 0
    twist.angular.z = 0.314 #(3.14) / 10

  return twist  

def random_movement(step):

  twist = Twist()
  twist.linear.x = 0.1
  step = step % 27

  if step % 9 == 0:
    twist.linear.x = 0
    twist.angular.z = random.randrange(-120,120)/360*2*3.14 #(90 / 360) * 2 * 3.14

  return twist
if __name__ == '__main__':
    movement_type_server()
