# Yet Another Docker Image for Apache Zeppelin (https://github.com/tssp/docker-zeppelin)
#
# Usage:
#
#  * Standalone: docker pull tssp/apache-zeppelin
#                docker run -d tssp/apache-zeppelin
#
#  * Cluster:    docker-compose up 
#

FROM phusion/baseimage:0.9.17

MAINTAINER tssp <tim@coding-me.com>

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget git openjdk-7-jdk libfontconfig && \
    apt-get autoremove -y && \
    apt-get clean

# Install Node.js 4.x
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    apt-get autoremove -y && \
    apt-get clean

# Set some environment variables
ENV ZEPPELIN_HOME /opt/apache-zeppelin
ENV ZEPPELIN_PORT 8888
ENV PATH          $ZEPPELIN_HOME/bin:$PATH

# Build and Install Zeppelin (this is only one fat command to reduce container size) 
RUN wget http://mirror.netcologne.de/apache.org/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz -O /tmp/apache-maven-3.3.3-bin.tar.gz && \
    tar -xzf /tmp/apache-maven-3.3.3-bin.tar.gz -C /tmp && \
    git clone https://github.com/apache/incubator-zeppelin /tmp/apache-zeppelin && \
    cd /tmp/apache-zeppelin && \
    /tmp/apache-maven-3.3.3/bin/mvn clean package -Pspark-1.5 -Dhadoop.version=2.6.0 -Phadoop-2.6 -DskipTests -P build-distr && \
    mv /tmp/apache-zeppelin/zeppelin-distribution/target/zeppelin-0.6.0-incubating-SNAPSHOT/zeppelin-0.6.0-incubating-SNAPSHOT /opt && \
    ln -s /opt/zeppelin-0.6.0-incubating-SNAPSHOT $ZEPPELIN_HOME && \
    rm -fr /tmp/apache* ~/.m2 ~/.node-gyp ~/.npm

# Ports for Zeppelin UI and websocket connection
EXPOSE 8888 8889

# Default mode: Execute Zeppelin UI
CMD ["zeppelin.sh"]
