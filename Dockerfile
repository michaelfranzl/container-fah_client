# See https://github.com/michaelfranzl/image_debian-gpgpu
FROM debian-gpgpu

# Install FAHClient
RUN apt install -y curl; \
    curl -fsSL 'https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.6/fahclient_7.6.21_amd64.deb' -o fah.deb; \
    echo "2827f05f1c311ee6c7eca294e4ffb856c81957e8f5bfc3113a0ed27bb463b094 fah.deb" | sha256sum -c --strict -; \
    DEBIAN_FRONTEND=noninteractive dpkg -i fah.deb; \
    rm -rf fah.deb; \
    usermod -a -G render fahclient

# for web control
EXPOSE 7396/tcp

# for fah-control
EXPOSE 36330/tcp

USER fahclient

ENTRYPOINT ["/usr/bin/FAHClient", "--chdir", "/var/lib/fahclient"]

LABEL license="MIT"
LABEL author="Copyright 2022 Michael K. Franzl <michael@franzl.name>"
LABEL description="Folding@home client with AMD and Nvidia GPGPU support"
