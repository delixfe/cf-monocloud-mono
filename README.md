# MonoCloud CF Buildpack

A simple Cloud Foundry build pack to run OWIN based application using Mono.

## Build Mono Tarball
    cd /tmp
    
    apt-get install git autoconf libtool automake build-essential mono-devel gettext
    
    curl http://download.mono-project.com/sources/mono/mono-3.12.1.tar.bz2 -o mono.tar.bz2
    tar xvf mono-3.12.1.tar.gz
    
    cd mono-3.12.1
    ./configure --prefix=/app/vendor/mono
    
    make
    make install
    
    cd /app/vendor/mono
    tar -cvzf mono.tar.gz *
