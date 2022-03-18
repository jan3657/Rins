#!/usr/bin/env python
import rospy
from exercise1.msg import stringInt

def talker():
    pub = rospy.Publisher('custom_chatter', stringInt,queue_size=1000)
    rospy.init_node('custom_talker', anonymous=True)
    r = rospy.Rate(2) #2hz
    msg = stringInt()
    msg.content = "Zdravo"
    msg.sequenceID = 4

    while not rospy.is_shutdown():
        rospy.loginfo(msg)
        pub.publish(msg)
        r.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException: pass