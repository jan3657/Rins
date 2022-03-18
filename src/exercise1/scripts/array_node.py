#!/usr/bin/env python

#from __future__ import print_function

from exercise1.srv import SumOfArray,SumOfArrayResponse
import rospy

def handle_sum_of_array(req):   
    return SumOfArrayResponse(sum(req.array))

def sum_of_array_server():
    rospy.init_node('sum_of_array_server')
    s = rospy.Service('sum_of_array_service', SumOfArray, handle_sum_of_array)
    print("Ready to sum your array")
    rospy.spin()

if __name__ == "__main__":
    sum_of_array_server()