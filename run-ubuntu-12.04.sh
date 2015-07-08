#!/bin/bash -x
sudo docker build -f Dockerfile-ubuntu-12.04 -t lumberjackbuilder_ubuntu_1204 .
sudo docker run -i -t -v ${PWD}/pkg/ubuntu-12.04:/pkg lumberjackbuilder_ubuntu_1204
