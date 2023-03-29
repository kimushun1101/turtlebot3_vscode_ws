#!/bin/bash
source /opt/ros/$ROS_DISTRO/setup.bash
source $WSDIR/install/setup.bash

# https://emanual.robotis.com/docs/en/platform/turtlebot3/simulation/
export TURTLEBOT3_MODEL=burger
# export TURTLEBOT3_MODEL=waffle_pi
ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py