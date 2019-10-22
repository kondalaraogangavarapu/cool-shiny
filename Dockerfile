FROM ubuntu:16.04

USER root

RUN apt-get update && apt-get install -y software-properties-common apt-transport-https

RUN apt-get update && add-apt-repository \
    "deb https://cloud.r-project.org/bin/linux/ubuntu xenial/" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    apt-get update && apt-get install  -y r-base r-base-dev && \
    R -e "install.packages(c('shiny'))"


COPY src /root

CMD  R -e 'library(shiny);shiny::runApp("/root/", port=8080, host= "0.0.0.0")'
