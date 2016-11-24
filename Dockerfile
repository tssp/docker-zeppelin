# Yet Another Docker Image for Apache Zeppelin (https://github.com/tssp/docker-zeppelin)
#
# Usage:
#
#  * Standalone: docker pull tssp/apache-zeppelin
#                docker run -d tssp/apache-zeppelin
#
#  * Cluster:    docker-compose up 
#

FROM phusion/baseimage:0.9.19

MAINTAINER tssp <tim@coding-me.com>

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget openjdk-8-jdk && \
    apt-get autoremove -y && \
    apt-get clean

# Set some environment variables
ENV ZEPPELIN_HOME /opt/apache-zeppelin
ENV ZEPPELIN_PORT 8888
ENV PATH          $ZEPPELIN_HOME/bin:$PATH

# Build and Install Zeppelin (this is only one fat command to reduce container size) 


RUN wget http://ftp.halifax.rwth-aachen.de/apache/zeppelin/zeppelin-0.6.2/zeppelin-0.6.2-bin-all.tgz -O /opt/zeppelin-0.6.2-bin-all.tgz && \
    tar -xzf /opt/zeppelin-0.6.2-bin-all.tgz && \
    ln -s /opt/zeppelin-0.6.2-bin-all $ZEPPELIN_HOME && \
    rm -fr /tmp/zeppelin-0.6.2-bin-all.tgz


# Ports for Zeppelin UI and websocket connection
EXPOSE 8888 8889 4040

# Default mode: Execute Zeppelin UI
CMD ["zeppelin.sh"]
