# MonoCloud CF Buildpack

A simple Cloud Foundry build pack to run OWIN based application using Mono.

## Build Mono Tarball
    cd /tmp
    
    apt-get install git autoconf libtool automake build-essential mono-devel gettext
    
    curl -O http://download.mono-project.com/sources/mono/mono-4.0.3.tar.bz2
    tar xf mono-4.0.3.tar.gz
    
    cd mono-4.0.3
    ./configure --prefix=/app/vendor/mono --with-large-heap=yes
    
    make
    make install
    
    cd /app/vendor/mono
    tar -cvzf mono.tar.gz *



## Build mono from GIT using Docker

### Prequisites:
    
    sudo docker pull dominikhahn/mono-tarball
    

### Compile

    mkdir -p $(pwd)/output
	mkdir -p $(pwd)/artifacts
	
	# Alias to use like a regular git command
	alias run='docker run --rm -m 8g -v $(pwd)/:/mnt/ -v $(pwd)/output/:/app/vendor/mono/ -v $(pwd)/artifacts/:/artifacts/ -e UID=$(id -u) -e GID=$(id -g) dominikhahn/mono-tarball'
	
	run git fetch --tags
	run git checkout tags/$(git describe --tags `git rev-list --tags --max-count=1`)
	run ./autogen.sh --prefix=/app/vendor/mono --with-large-heap=yes
	run make get-monolite-latest
	run make EXTERNAL_MCS="${PWD}/mcs/class/lib/monolite/basic.exe"
	run make install
	run tar -cvzf /artifacts/$(git describe --tags `git rev-list --tags --max-count=1`).tar.gz -C /app/vendor/mono .