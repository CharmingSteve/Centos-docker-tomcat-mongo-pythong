FROM centsysv


ADD mongodb-org-4.0.repo /etc/yum.repos.d

RUN yum install python2  mongodb-org tomcat -y

RUN yum clean all
ADD ROOT /var/lib/tomcat/webapps/ROOT
RUN systemctl enable mongod.service
RUN systemctl enable tomcat.service

EXPOSE 80
EXPOSE 27017
CMD ["/usr/sbin/init"]
