FROM debian:bullseye

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

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
