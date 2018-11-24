FROM rocker/r-ver:3.3.3
MAINTAINER Wush Wu <wush978@gmail.com>

RUN apt-get update && \
  apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev && \
  locale-gen zh_TW.UTF-8
ENV LC_ALL=zh_TW.UTF-8
COPY course /tmp/course

  
