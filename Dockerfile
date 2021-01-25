FROM ubuntu:20.04

#RUN apt-get -y update && apt-get -y upgrade

# Install OpenJDK-11
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt install -y maven && \
    apt-get clean;
    
# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME

ENV CATALINA_HOME /opt/tomcat/
RUN export CATALINA_HOME

ENV MAVEN_HOME /usr/share/maven
RUN export MAVEN_HOME

ENV PATH $PATH:$JAVA_HOME/bin/:$CATALINA_HOME/bin/
RUN export PATH

# Install Maven
#RUN apt-get update && \
 #   apt install -y maven;  

COPY settings.xml /usr/share/maven/conf/.

RUN mkdir /opt/tomcat/


COPY apache-tomcat-8.5.61.tar.gz .
RUN tar xvfz apache-tomcat-8.5.61.tar.gz
RUN mv apache-tomcat-8.5.61/* /opt/tomcat/.

COPY server.xml.j2 /opt/tomcat/conf/server.xml

COPY tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml






#COPY apache-tomcat-8.5.61.tar.gz /usr/share/tomcat/.

#RUN cd /usr/share/tomcat && tar xvfz apache-tomcat-8.5.61.tar.gz

#COPY server.xml.j2 /usr/share/tomcat/apache-tomcat-8.5.61/conf/server.xml

#COPY tomcat-users.xml /usr/share/tomcat/apache-tomcat-8.5.61/conf/tomcat-users.xml

#COPY /tmp/bookstore.war /opt/tomcat/webapps

EXPOSE 8090

CMD ["catalina.sh", "run"]

 
