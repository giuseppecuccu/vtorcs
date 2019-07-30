FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
LABEL maintainer="Oliver Wannenwetsch"

# fix apt-dependies from lxde-vnc docker image
RUN sudo sed -i 's|http://tw.|http://|g' /etc/apt/sources.list \
        && sudo sed -i 's|https://tw.|https://|g' /etc/apt/sources.list

# install vtorc build dependencies
RUN apt-get update \
        && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
        && DEBIAN_FRONTEND=noninteractive apt-get install -y \
            libglib2.0-dev \
            libgl1-mesa-dev \
            libglu1-mesa-dev \
            freeglut3-dev \
            libplib-dev \
            libopenal-dev \
            libalut-dev \
            libxi-dev \
            libxmu-dev \
            libxrender-dev \
            libxrandr-dev \
            libpng-dev \
        && rm -rf /var/lib/apt/lists/*

# set vtorc as autorun and desktop entry
RUN mkdir -p /root/.config/autostart \
        && mkdir -p /root/Desktop \
        && echo "[Desktop Entry]" >> /root/.config/autostart/vtorc.desktop \
        && echo "Type=Application" >> /root/.config/autostart/vtorc.desktop \
        && echo "Exec=torcs" >> /root/.config/autostart/vtorc.desktop \
        && cp /root/.config/autostart/vtorc.desktop /root/Desktop

# vtorc build process
ADD . /opt/vtorcs
WORKDIR /opt/vtorcs
ENV CFLAGS "-fPIC"
ENV CPPFLAGS "-fPIC"
ENV export CXXFLAGS "-fPIC"
RUN ./configure
RUN make
RUN make install
RUN make datainstall

# Expose vtorcs server port
expose 3101
