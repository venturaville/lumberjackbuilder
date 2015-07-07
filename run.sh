sudo docker build -t lumberjackbuilder .
sudo docker run -i -t -v ${PWD}/pkg:/pkg lumberjackbuilder
