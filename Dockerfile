FROM ubuntu:16.10
# These environment variables are passed from Galaxy to the container
# and help you enable connectivity to Galaxy from within the container.
# This means your user can import/export data from/to Galaxy.


USER root
ENV DEBIAN_FRONTEND=noninteractive \
    API_KEY=none \
    DEBUG=false \
    PROXY_PREFIX=none \
    GALAXY_URL=none \
    GALAXY_WEB_PORT=10000 \
    HISTORY_ID=none \
    REMOTE_HOST=none
	
RUN apt-get update &&\
    apt-get install -y wget


RUN apt-get install --no-install-recommends -y \
    wget procps nginx python python-pip net-tools nginx	

RUN apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV PATH="/usr/lib/jvm/java-8-openjdk-amd64/bin:${PATH}"


# download and "mount" OpenRefine
RUN wget -O - --no-check-certificate https://github.com/OpenRefine/OpenRefine/archive/master.tar.gz | tar -xz
RUN mv OpenRefine-master OpenRefine; cd ./OpenRefine ;
RUN apt-get install unzip;

# Our very important scripts. Make sure you've run `chmod +x startup.sh
# monitor_traffic.sh` outside of the container!
ADD ./startup.sh /startup.sh
ADD ./monitor_traffic.sh /monitor_traffic.sh

# /import will be the universal mount-point for Jupyter
# The Galaxy instance can copy in data that needs to be present to the
# container
RUN mkdir /import

# Nginx configuration
#COPY ./proxy.conf /proxy.conf

VOLUME ["/import"]
WORKDIR /import/

# EXTREMELY IMPORTANT! You must expose a SINGLE port on your container.
#EXPOSE 80
CMD /startup.sh
