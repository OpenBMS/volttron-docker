FROM ubuntu:14.04

RUN apt-get install software-properties-common -y

RUN add-apt-repository ppa:xuzhen666/dnscrypt

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install build-essential python-dev openssl libssl-dev libevent-dev -y
RUN apt-get install libsodium-dev -y

RUN useradd -ms /bin/bash volttron

ADD volttron-source /home/volttron/volttron-source
RUN chown -R volttron:volttron /home/volttron/volttron-source

RUN adduser volttron sudo

# Enable passwordless sudo for users under the "sudo" group
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

USER volttron
ENV HOME /home/volttron
WORKDIR /home/volttron

RUN python2.7 /home/volttron/volttron-source/bootstrap.py

ENV BASH_ENV /home/volttron/volttron-source/env/bin/activate
RUN echo "source /home/volttron/volttron-source/env/bin/activate" >> /home/volttron/.bashrc

USER root
