# Use a lightweight base image with common build tools
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Install required packages
RUN apt-get update && apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python3 python3-pip \
    python3-pexpect xz-utils debianutils iputils-ping lz4 zstd sudo vim \
    locales && \
    locale-gen en_US.UTF-8 && \
    apt-get clean

RUN apt-get install -y qemu-system-arm util-linux fdisk file

RUN apt-get install -y screen
# Set a working directory
WORKDIR /yocto

# Optional: Add a non-root user for builds
ARG USER_ID                                                                    
ARG GROUP_ID                                                                   

RUN if ! getent group $GROUP_ID >/dev/null; then \
         groupadd -g $GROUP_ID yocto; \                                         
     fi && \
     if ! getent passwd $USER_ID >/dev/null; then \
         useradd -u $USER_ID -g $GROUP_ID -ms /bin/bash yocto; \                
     else \
         usermod -g $GROUP_ID $(getent passwd $USER_ID | cut -d: -f1); \        
     fi && \
     echo "Regular user setup complete: $(id yocto || id $USER_ID)" 

USER yocto 

CMD ["/bin/bash"]
