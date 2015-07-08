#!/bin/bash -x
sudo docker build -f Dockerfile-ubuntu-14.04 -t lumberjackbuilder_ubuntu_1404 .
sudo docker run -i -t -v ${PWD}/pkg/ubuntu-14.04:/pkg lumberjackbuilder_ubuntu_1404
