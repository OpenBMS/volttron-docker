FROM ubuntu:14.04

RUN apt-get install software-properties-common -y

RUN add-apt-repository ppa:xuzhen666/dnscrypt

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install build-essential python-dev openssl libssl-dev libevent-dev -y
RUN apt-get install libsodium-dev -y

ADD volttron-source /volttron
