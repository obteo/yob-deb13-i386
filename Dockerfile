FROM debian:bookworm

# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Legacy Linux Games (i386)
# ----------------------------------

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        bash \
        curl \
        wget \
        ca-certificates \
        tar \
        git \
        libc6:i386 \
        libstdc++6:i386 \
        lib32gcc-s1 && \
    rm -rf /var/lib/apt/lists/*

# Create container user (MANDATORY PTERODACTYL)
RUN useradd -m -d /home/container -s /bin/bash container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

# Copy entrypoint (must be in image root)
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
