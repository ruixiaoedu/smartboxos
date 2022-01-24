FROM debian:bullseye

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# change to aliyun
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list

# Build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        file \
        wget \
        cpio \ 
        unzip \
        rsync \ 
        bc \
        libncurses5-dev \
        git \
        sudo \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Get buildroot
WORKDIR /build
