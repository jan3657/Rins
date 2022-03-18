#!/usr/bin/env python

from __future__ import print_function
from unittest import result

import numpy as np
import sys
import rospy
from exercise1.srv import SumOfArray

def sum_of_array_client(arryOfNumbers):
    rospy.wait_for_service('sum_of_array_service')
    try:
        sum_of_num = rospy.ServiceProxy('sum_of_array_service', SumOfArray)
        resp1 = sum_of_num(arryOfNumbers)
        print(arryOfNumbers)
        print(resp1.result)
        return resp1.result
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)


if __name__ == "__main__":
    randnums= np.random.randint(1,26,10)
    sum_of_array_client(randnums)