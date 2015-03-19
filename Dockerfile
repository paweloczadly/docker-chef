FROM debian:wheezy

ADD https://opscode-omnibus-packages.s3.amazonaws.com/debian/6/x86_64/chefdk_0.3.6-1_amd64.deb /tmp/chefdk.deb
RUN dpkg -i /tmp/chefdk.deb
RUN rm -rf /tmp/chefdk.deb

VOLUME /opt/chefdk
