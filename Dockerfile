FROM debian:jessie
MAINTAINER dsheyp

RUN apt-get update && \
    apt-get install -y --force-yes dar-static && \
    apt-get clean

RUN mkdir /root && mkdir /backup

VOLUME /root
VOLUME /backup
