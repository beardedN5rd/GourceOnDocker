FROM ubuntu:bionic
USER root



# dependencies for building mesa driver
RUN apt-get update && apt-get install -y wget build-essential scons python-mako flex bison zlib1g-dev libudev-dev pkg-config libx11-dev libxext-dev libxdamage-dev x11proto-gl-dev libx11-xcb-dev

RUN test -f mesa-18.3.2.tar.xz || wget -q https://mesa.freedesktop.org/archive/mesa-18.3.2.tar.xz \
  && test -d mesa-18.3.2.tar.xz || tar xkf mesa-18.3.2.tar.xz \
  && cd mesa-18.3.2 \
  && scons build=release texture_float=yes libgl-xlib \
  && ln -s -f `pwd`/include/GL* /usr/local/include/ \
  && cp `pwd`/build/linux-x86_64/gallium/targets/libgl-xlib/libGL.* /usr/local/lib \
  && ldconfig

RUN apt-get update && apt-get install -y \
     git ffmpeg\
     autoconf clang pkg-config mesa-utils \
     libboost-filesystem-dev libsdl2-dev libsdl2-image-dev libpcre3-dev libfreetype6-dev libglew-dev libglm-dev libpng-dev libtinyxml-dev

ADD ./Gource /Gource
WORKDIR /Gource
RUN ./autogen.sh && ./configure
RUN make -j8 && make install && make clean
