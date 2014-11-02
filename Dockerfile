FROM debian:jessie
MAINTAINER Matt McCormick <matt@mmmccormick.com>

RUN apt-get update
RUN apt-get -y --force-yes install x-window-system
RUN apt-get install -y binutils
RUN apt-get install -y mesa-utils
RUN apt-get install -y module-init-tools

ADD nvidia-driver.run /tmp/nvidia-driver.run
RUN sh /tmp/nvidia-driver.run -a -N --ui=none --no-kernel-module
RUN rm /tmp/nvidia-driver.run

CMD /bin/bash
