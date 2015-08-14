FROM debian:jessie
MAINTAINER dsheyp

RUN apt-get update && \
    apt-get install -y --force-yes dar && \
    apt-get clean

RUN mkdir /backup && mkdir /homes && mkdir /video && mkdir /music && mkdir /photo

VOLUME /backup
VOLUME /homes
VOLUME /video
VOLUME /music
VOLUME /photo
