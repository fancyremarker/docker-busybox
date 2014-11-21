FROM progrium/busybox
MAINTAINER Frank Macreery <frank@macreery.com>

# Install Git and libncurses (for Ctrl-L)
RUN opkg-install git libncurses

# Install binaries
ADD files /

# Install Bats
RUN git clone git://github.com/sstephenson/bats.git /tmp/bats && \
    cd /tmp/bats && ./install.sh /usr/local && rm -rf /tmp/bats

ADD templates/bashrc /root/.bashrc

# Hack for older Docker versions, where $HOME is not set
# See https://github.com/docker/docker/issues/2968
ADD templates/bashrc /.bashrc

# Integration tests
ADD test /tmp/test
RUN bats /tmp/test

CMD /bin/bash
