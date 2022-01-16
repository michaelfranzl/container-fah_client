# image_fah-client

Dockerfile for Folding@home client with AMD and Nvidia GPGPU support

*Note:* The FOSS AMD driver included in Debian 11 provides OpenCL version 1.1 (as reported by
`clinfo`). The [requirements of
FAHClient](https://foldingathome.org/support/faq/installation-guides/linux/requirements) do not
specify the OpenCL version, so only running FAHClient might tell you if the available OpenCL version
is sufficient.

## Building

Build the image `debian-gpgpu` first. See https://github.com/michaelfranzl/image_debian-gpgpu

Then:

```sh
docker build -t fah-client .
```

## Running

The data directory and all its contents need to be read- and writeable to the `fahclient` user of
the container (e.g. user ID 101). Put the client's `config.xml` inside this directory.

```sh
docker run -name fahclient0 -v /path/to/fahclient-data:/var/lib/fahclient fahclient
```

* To expose AMD GPU(s) to the container, add the Docker argument `--device /dev/dri:/dev/dri`.
* To expose Nvidia GPU(s) to the container, add the Docker argument `--gpus all`. You need an
  addition to Docker for the `--gpus` argument. See https://github.com/michaelfranzl/image_debian-gpgpu#exposing-nvidia-gpus-to-containers
