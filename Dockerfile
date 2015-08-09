FROM debian:jessie
MAINTAINER dsheyp

RUN apt-get update && \
    apt-get install -y --force-yes dar-static && \
    apt-get clean

RUN mkdir /backup && mkdir /volume1 && mkdir /volume2

VOLUME /volume1
VOLUME /volume2
VOLUME /backup
