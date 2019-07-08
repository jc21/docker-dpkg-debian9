FROM debian:stretch

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

# Apt
RUN apt-get update \
  && apt-get install -y wget make devscripts build-essential curl automake autoconf expect sudo apt-utils reprepro apt-transport-https jq zip \
  && wget https://dpkg.jc21.com/DPKG-GPG-KEY -O /tmp/jc21-dpkg-key \
  && apt-key add /tmp/jc21-dpkg-key \
  && echo "deb https://dpkg.jc21.com/os/debian stretch main" > /etc/apt/sources.list.d/jc21.list

RUN apt-get update \
  && apt-get install -y git \
  && apt-get clean

# Remove requiretty from sudoers main file
RUN sed -i '/Defaults    requiretty/c\#Defaults    requiretty' /etc/sudoers

# Rpm User
RUN useradd -G sudo builder \
    && mkdir -p /home/builder \
    && chmod -R 777 /home/builder

# Sudo
ADD etc/sudoers.d/builder /etc/sudoers.d/
RUN chown root:root /etc/sudoers.d/*

USER builder

ENV GOROOT=/usr/local/go
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR /home/builder
