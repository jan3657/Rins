#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>

typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

int main(int argc, char** argv) {

	ros::init(argc, argv, "five_goals");
	
	MoveBaseClient ac("move_base", true);
	
	while(!ac.waitForServer(ros::Duration(5.0))) {
		ROS_INFO("Waiting for the move_base action server to come up");
	}
	
	float x[5] = {0.16038602590560913, 2.887723684310913, 1.5204318761825562, -0.9998968839645386, -0.47734299302101135};
	float y[5] = {-0.8576852679252625, -0.10778795927762985, 0.9536095857620239, 1.993251919746399, 0.4689262807369232};
	
	float prev_x = 0.0;
	float prev_y = 0.0;
	
	move_base_msgs::MoveBaseGoal goal;

	goal.target_pose.header.frame_id = "map";
	goal.target_pose.header.stamp = ros::Time::now();
	
	for (int i = 0; i < 5; i++) {
	
		//ROS_INFO("%f %f", goal.target_pose.pose.position.x, goal.target_pose.pose.position.y);
		
		goal.target_pose.pose.position.x = x[i];
		goal.target_pose.pose.position.y = y[i];
		goal.target_pose.pose.orientation.w = 1.0;
		
		ac.sendGoal(goal);
	
		ac.waitForResult();
		
		if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
			ROS_INFO("YAAY");
		else
			ROS_INFO(":(");
	}
	
	return 0;
}
