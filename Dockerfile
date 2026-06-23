FROM debian:13-slim

ENV DEBIAN_FRONTEND=noninteractive

# ----------------------------------
# Base + i386 support
# ----------------------------------
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        wget \
        curl \
        ca-certificates \
        tar \
        xz-utils \
        libc6:i386 \
        libstdc++6:i386 \
        lib32gcc-s1 \
        libcurl4:i386 \
        libncurses6:i386 \
        libtinfo6:i386 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY libcxa.so.1 /usr/lib/i386-linux-gnu/libcxa.so.1

# ----------------------------------
# Legacy libstdc++5 (CoD2)
# ----------------------------------
COPY libstdc++5_3.3.6-34_i386.deb /tmp/libstdc++5.deb
RUN dpkg -i /tmp/libstdc++5.deb || apt-get install -f -y && \
    rm -f /tmp/libstdc++5.deb

# ----------------------------------
# Pterodactyl user (MANDATORY)
# ----------------------------------
RUN useradd -m -d /home/container -s /bin/bash container

# ----------------------------------
# Entrypoint
# ----------------------------------
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

CMD ["/bin/bash", "/entrypoint.sh"]
