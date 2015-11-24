# MonoCloud CF Buildpack

A simple Cloud Foundry build pack to run OWIN based application using Mono.

## Build Mono Tarball
    
Add mono sources (inkl. alpha channel)

	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	sudo echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
	sudo echo "deb http://download.mono-project.com/repo/debian alpha main" | sudo tee /etc/apt/sources.list.d/mono-xamarin-alpha.list    
	sudo apt-get update
    
Install prerequisites
    
    sudo apt-get install -y git autoconf libtool automake build-essential mono-devel gettext
    
Download and extract the desired mono version  

    sudo curl -O http://download.mono-project.com/sources/mono/mono-4.2.1.102.tar.bz2
    sudo tar xf mono-4.2.1.102.tar.gz

Compile mono

    sudo cd mono-4.2.1.102
    sudo ./autogen.sh --prefix=/app/vendor/mono --with-large-heap=yes
	sudo make get-monolite-latest
	sudo make EXTERNAL_MCS="${PWD}/mcs/class/lib/monolite/basic.exe"
	sudo make install
	
Compress mono

    sudo cd /app/vendor/mono
    sudo tar -cvzf mono.tar.gz *


## Build mono using Docker

### Prequisites

    sudo docker pull monostream/mono-runtime

### Compile

	mkdir -p ${WORKSPACE}/output
	mkdir -p ${WORKSPACE}/artifacts
	
	alias run='docker run --rm -m 8g -v ${WORKSPACE}/:/mnt/ -v ${WORKSPACE}/output/:/app/vendor/mono/ -v ${WORKSPACE}/artifacts/:/artifacts/ -e UID=$(id -u) -e GID=$(id -g) monostream/mono-tarball'
	
	run git fetch --tags
	run git checkout tags/$(git describe --tags `git rev-list --tags --max-count=1`)
	run ./autogen.sh --prefix=/app/vendor/mono --with-large-heap=yes
	run make get-monolite-latest
	run make EXTERNAL_MCS="${PWD}/mcs/class/lib/monolite/basic.exe"
	run make install
	run tar -cvzf /artifacts/$(git describe --tags `git rev-list --tags --max-count=1`).tar.gz -C /app/vendor/mono .
