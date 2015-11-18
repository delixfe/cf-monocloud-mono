# Pull base image.
FROM ubuntu

MAINTAINER Dominik Hahn <dominik@monostream.com>

# Define working directory.
WORKDIR /mnt

# Set locale
RUN sudo locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Add mono sources
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN sudo echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
RUN sudo echo "deb http://download.mono-project.com/repo/debian alpha main" | sudo tee /etc/apt/sources.list.d/mono-xamarin-alpha.list
RUN sudo apt-get update

# Install prerequisites
RUN sudo apt-get install -y git autoconf libtool automake build-essential mono-devel gettext

# Cleanup image
RUN sudo apt-get autoremove -y
RUN sudo apt-get clean
RUN sudo rm -rf /var/lib/apt/lists/* /var/tmp/*
