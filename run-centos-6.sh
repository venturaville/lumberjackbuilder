#!/bin/bash -x 
sudo docker build -f Dockerfile-centos-6 -t lumberjackbuilder_centos6 .
sudo docker run -i -t -v ${PWD}/pkg/centos-6:/pkg lumberjackbuilder_centos6
