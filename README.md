# Centos-docker-tomcat-mongo-pythong

We need to make an image that has more than one service, when you need just one service it might be enough to use the official Docker Hub image. In our case we need to pack both Mongodb and Apache Tomcat. The defaults install Apache Tomcat 7. We also need Python 2.7.

Centos added https://hub.docker.com/_/centos/ systemd support to its base image, but it needs a little work in order to be able to build an image that runs services.

We need to first build a base image that will allow our services to work. as stated in the Docker Hub Centos page  https://hub.docker.com/_/centos/ 

so to start run
cd <your dor that has dockerfile>
docker build -f Dockerfile.sysv

If it doesnt build change the name to Dockerfile without the extension then run
docker build . -t <an easy name to remember>

You can run this image if you like
docker run -it <an easy name to remember> bash
  
That will give you a bash inside the container. You can experiment here with what actually work for your next step.

Edit the first like FROM to use your image of  <an easy name to remember>

Now build our real image
docker build -f Dockerfile.buildtomcatetc
 
 again if the -f doesnt accept your file change it name to Dockerfile without an extension and run
 
docker build . -t <a different and easy name to remember>
  
This Dockerfile installs python 2.7, the latest mongodb and tomcat. This build of tomcat didnt install the standard Welcome page, so you can see that it's working so the Dockerfile copies these files. It also sets the mongo and tomcat to launch as services using systemd.

To run your image as a container you need to have it use your systems systemd dir and run dir as VOLUMES. 

We want tomcat to expose a port that is different from its default - 7080 instead of 8080.


Run the following command.

docker run -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro   -v /tmp/$(mktemp -d):/run  -p  7080:8080 -p 27017:27017 <a different and easy name to remember>:latest
  
Now you can see the standard tomcat welcome page at http://YOURDOMAIN:7080 

If you don't need all of this in one container you can run docker-compose and link them together. run:

docker-compose up 
