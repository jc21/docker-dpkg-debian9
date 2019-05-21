FROM jc21/dpkg-debian:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

# Rust in `builder` user
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

WORKDIR /home/builder

