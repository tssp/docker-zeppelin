Yet Another Docker Container for Apache Zeppelin.

## Usage

Per default the image starts with the Zeppelin UI interactive analysis with a local Spark context: `docker run -p 8888:8888 -d tssp/apache-zeppelin`. The UI can be accessed at http://localhost:8888 .

A cluster mode is also supported. For convenience this mode can be started by simply executing `docker-compose up`. This spins up a Zeppelin image, a Spark master and one work with one 1 core and 1gb memory. The cluster can be monitored via the Web-UI on the master: http://localhost:8080 .

The number of workers can be increased by executing the scale command, e.g. `docker-compose scale worker-node=5`. 

In case of sharing a persistent directory for notebooks, the container can be started via `docker run -p 8888:8888 -d -v $(pwd)/notebook:/opt/apache-zeppelin/notebook tssp/apache-zeppelin`. Where `notebook` is the hosted directory and `/opt/apache-zeppelin/notebook` is the the notebook directory in the container. Please refer to the [documentation](http://docs.docker.com/engine/userguide/dockervolumes/#mount-a-host-directory-as-a-data-volume) when mounting data volumes. 

## Prerequisites

Follow the instructions on https://docs.docker.com/installation and https://docs.docker.com/compose/install/ to install Docker Engine and Docker Compose.

## Build Docker Container

The container can be built by executing `docker build -t tssp/apache-zeppelin .`.

