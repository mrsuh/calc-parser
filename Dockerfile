FROM debian:buster-slim

# Bison
RUN apt-get update && apt-get upgrade -y -qq \
    autopoint \
    automake \
    make \
    flex \
    gperf \
    graphviz \
    help2man \
    texinfo \
    m4 \
    gcc \
    git \
    wget \
    xsltproc

RUN wget ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz
RUN tar -xvzf autoconf-2.71.tar.gz
WORKDIR /autoconf-2.71
RUN ./configure
RUN make
RUN make install
WORKDIR /

RUN wget ftp://ftp.gnu.org/gnu/gettext/gettext-0.21.tar.gz
RUN tar -xvzf gettext-0.21.tar.gz
WORKDIR /gettext-0.21
RUN ./configure
RUN make
RUN make install
WORKDIR /

RUN wget ftp://ftp.gnu.org/gnu/bison/bison-3.8.tar.gz
RUN tar -xvzf bison-3.8.tar.gz
WORKDIR /bison-3.8
RUN ./configure
RUN make
RUN make install
WORKDIR /

# PHP
RUN apt -y install lsb-release apt-transport-https ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" |  tee /etc/apt/sources.list.d/php.list
RUN apt update
RUN apt -y install php7.4

# GDB
RUN apt -y install gdb

RUN apt -y install g++
RUN wget https://github.com/skvadrik/re2c/releases/download/3.0/re2c-3.0.tar.xz
RUN tar -xf re2c-3.0.tar.xz
WORKDIR /re2c-3.0
RUN ./configure
RUN make -j$(nproc)
RUN make install
WORKDIR /

RUN mkdir /code
WORKDIR /code
