FROM debian:jessie
MAINTAINER dsheyp

RUN apt-get update && \
    apt-get install -y --force-yes dar-static && \
    apt-get clean

RUN mkdir /filetree

VOLUME /filetree
