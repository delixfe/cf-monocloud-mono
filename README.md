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



## Build mono from GIT

### Prequisites:
    configure apt get sources (add mono xamarin)

    apt-get install git autoconf libtool automake build-essential mono-devel gettext
    


### Compile

    aptget update

    git clone https://github.com/mono/mono.git

    git pull
    git tags -l
    git checkout tags/4.2.xxx

    ./autogen.sh --prefix=/app/vendor/mono --with-large-heap=yes
 
    make
    make install
 
    cd /app/vendor/mono
    tar -cvzf mono.tar.gz *
