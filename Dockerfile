FROM progrium/busybox
MAINTAINER Frank Macreery <frank@macreery.com>

# Install Git and Bash
RUN opkg-install git bash

# Install Bats
RUN git clone git://github.com/sstephenson/bats.git /tmp/bats && \
    cd /tmp/bats && ./install.sh /usr/local && rm -rf /tmp/bats

# Integration tests
ADD test /tmp/test
RUN bats /tmp/test

CMD /bin/bash
