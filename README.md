# ![](https://gravatar.com/avatar/11d3bc4c3163e3d238d558d5c9d98efe?s=64) aptible/busybox

[![](https://quay.io/repository/aptible/busybox/status)](https://quay.io/repository/aptible/busybox)

Busybox base image, borrowed from [progrium/busybox](https://github.com/progrium/busybox), with version pinned and common Dockerfile tools installed.

## Installation and Usage

    docker pull quay.io/aptible/busybox
    docker run -i -t quay.io/aptible/busybox

To install packages cleanly, use the `opkg-install` command. This will clean up the locally cached list of OPKG packages. To review the list interactively, run:

    opkg-cl -f /etc/opkg.conf update
    opkg-cl -f /etc/opkg.conf list [...]
    opkg-cl -f /etc/opkg.conf search [...]

## Available Tags

* `latest`: v1.22.1

## Included Tools/Patches

* `bats`: The [Bats](https://github.com/sstephenson/bats) Bash Automated Testing System
* `bash`: The Bourne Again SHell.
* `git`: Git Version Control System.

## Static Binaries

Some binaries must be installed from custom static files, due to bugs in Busybox versions:

### Bash

Busybox's Bash doesn't support `set -o pipefail`, so we steal bash-static from Ubuntu 12.04 (Precise).

```
ID=$(docker run quay.io/aptible/ubuntu:12.04 apt-get -y install bash-static)
docker cp $ID:/bin/bash-static files/bin
mv files/bin/bash-static files/bin/bash
```

## Tests

Tests are run as part of the `Dockerfile` build. To execute them separately within a container, run:

    bats test

## Deployment

To push the Docker image to Quay, run the following command:

    make release

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2014 [Aptible](https://www.aptible.com) and contributors.

[<img src="https://s.gravatar.com/avatar/f7790b867ae619ae0496460aa28c5861?s=60" style="border-radius: 50%;" alt="@fancyremarker" />](https://github.com/fancyremarker)
