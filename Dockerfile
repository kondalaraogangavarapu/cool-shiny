FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt-get update && add-apt-repository \
    "deb https://cloud.r-project.org/bin/linux/ubuntu xenial/" && \
    apt-get update && apt-get install  -y r-base r-base-dev && \
    R -e "install.packages(c('shiny'))"

RUN locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

COPY src /root

CMD cd /root && R -e 'library(shiny);shiny::runApp("./", port=8080)'


