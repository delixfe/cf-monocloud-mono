# Monostream mono runtime builder with all the dependencies needed by MonoCloud
#
# VERSION 0.0.1

FROM ubuntu:latest
MAINTAINER Dominik Hahn <dominik@monostream.com>

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Upgrade Ubuntu
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y

# Install dependencies
RUN apt-get install -y install git autoconf libtool automake build-essential mono-devel gettext

# create monoadmin user
# RUN useradd -m -d /home/monoadmin -p monoadmin monoadmin && adduser monoadmin sudo && chsh -s /bin/bash monoadmin
# ENV MONO_USER monoadmin

# Compile

RUN git clone https://github.com/mono/mono.git

RUN git pull
RUN git tags -l
RUN git checkout tags/4.2.xxx

RUN ./autogen.sh --prefix=/app/vendor/mono --with-large-heap=yes

RUN make
RUN make install

RUN cd /app/vendor/mono
RUN tar -cvzf mono.tar.gz *
