FROM debian:bullseye

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# change to aliyun
RUN sed -i "s@http://deb.debian.org@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

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
        python3 \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Get buildroot
WORKDIR /build
