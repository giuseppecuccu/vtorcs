# Visual TORCS server

## Compilation and execution

Two options are available for running vtorcs:

* docker-based with a browser-based vnc-interface
* native

### Docker-based execution of vtorcs

To make the compilation and execution of vtorcs in Docker execute following steps:

Docker will expose following network ports:

* TCP 3101 - for the torcs network clients
* TCP 6080 - for the browser VNC interface

#### Step 1 - use docker

Run following script `run_vtorcs_in_docker.sh`.
It builds the necessary docker image and starts the docker container.

#### Step 2 - start vtorcs

* open a browser and goto the url `http://127.0.0.1:6080/#/`
* connect to the desktop exposed in vnc
* run `vtorcs` by using the desktop icon
* Get to run the _quickrace_  in the menu - you won't be able to though, it will lock expecting a car to connect from the network.
* Connect your car using TCP port 3101

### Native build & installation on Ubuntu 18.04

For Ubuntu 18.04, please proceed as follow:

#### Step 1 - Install all necessary requirements

```
sudo apt-get install libglib2.0-dev  libgl1-mesa-dev libglu1-mesa-dev  freeglut3-dev  libplib-dev  libopenal-dev libalut-dev libxi-dev libxmu-dev libxrender-dev  libxrandr-dev libpng-dev
```

#### Step 2 - Build VTORCS

```
$ export CFLAGS="-fPIC"
$ export CPPFLAGS=$CFLAGS
$ export CXXFLAGS=$CFLAGS
$ ./configure --prefix=$(pwd)/BUILD  # local install dir
$ make
$ make install
$ make datainstall
```

#### Step 3 - Start VTORCS

Start VTORCS with `./torcs` on the commandline

Get to run the _quickrace_  in the menu - you won't be able to though, it will lock expecting a car to connect from the network. It's the sign that everything's good to go!
