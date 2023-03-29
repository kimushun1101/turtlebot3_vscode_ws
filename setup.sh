#!/bin/bash
set -e

vcs import < src/ros2.repos src
sudo apt-get update
rosdep update
rosdep install --from-paths src --ignore-src -y

# https://answers.ros.org/question/396439/setuptoolsdeprecationwarning-setuppy-install-is-deprecated-use-build-and-pip-and-other-standards-based-tools/
pip install setuptools==58.2.0