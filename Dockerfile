FROM debian:jessie
MAINTAINER dsheyp

ENV DAR_PREFIX /usr/local/dar
ENV PATH $PATH:$DAR_PREFIX/bin
RUN mkdir -p "$DAR_PREFIX"
WORKDIR $DAR_PREFIX

# install dar runtime dependencies
# http://dar.linux.free.fr/doc/from_sources.html#requirements
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		zlib1g \
		libgcrypt20 \
		liblzo2-2 \
	&& rm -r /var/lib/apt/lists/*

ENV DAR_VERSION 2.5.5
ENV DAR_URL http://netcologne.dl.sourceforge.net/project/dar/dar/$DAR_VERSION/dar-$DAR_VERSION.tar.gz

RUN buildDeps=' \
		curl \
		gcc \
		g++ \
		binutils \
		make \
	' \
	set -x \
	&& apt-get update \
	&& apt-get install -y $buildDeps \
	&& rm -r /var/lib/apt/lists/* \
	&& curl -SL "$DAR_URL" -o dar.tar.gz \
	&& mkdir -p src/dar \
	&& tar -xvf dar.tar.gz -C src/dar --strip-components=1 \
	&& rm dar.tar.gz* \
	&& cd src/dar \
	&& ./configure --enable-mode=64 \
	&& make -j"$(nproc)" \
	&& make install-strip \
	&& cd ../../ \
	&& rm -r src/dar \
	&& apt-get purge -y --auto-remove $buildDeps

RUN mkdir /backup && mkdir /homes && mkdir /video && mkdir /music && mkdir /photo

VOLUME /backup
VOLUME /homes
VOLUME /video
VOLUME /music
VOLUME /photo
