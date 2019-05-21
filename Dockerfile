FROM jc21/dpkg-debian:latest

MAINTAINER Jamie Curnow <jc@jc21.com>
LABEL maintainer="Jamie Curnow <jc@jc21.com>"

USER root

RUN wget "http://ftp.us.debian.org/debian/pool/main/g/golang-1.12/golang-1.12_1.12.5-1_all.deb" -O /tmp/golang-1.12_1.12.5-1_all.deb \
 && wget "http://ftp.us.debian.org/debian/pool/main/g/golang-1.12/golang-1.12-src_1.12.5-1_amd64.deb" -O /tmp/golang-1.12-src_1.12.5-1_amd64.deb \
 && wget "http://ftp.us.debian.org/debian/pool/main/g/golang-1.12/golang-1.12-go_1.12.5-1_amd64.deb" -O /tmp/golang-1.12-go_1.12.5-1_amd64.deb \
 && wget "http://ftp.us.debian.org/debian/pool/main/g/golang-1.12/golang-1.12-doc_1.12.5-1_all.deb" -O /tmp/golang-1.12-doc_1.12.5-1_all.deb \
 && dpkg -i /tmp/golang-1.12_1.12.5-1_all.deb /tmp/golang-1.12-src_1.12.5-1_amd64.deb /tmp/golang-1.12-go_1.12.5-1_amd64.deb /tmp/golang-1.12-doc_1.12.5-1_all.deb \
 && rm -f /tmp/*.deb

USER builder

# installed in /usr/lib/go-1.12
ENV GOROOT=/usr/lib/go-1.12
ENV GOPATH=/home/builder/go
ENV PATH="/usr/lib/go-1.12/bin:/home/builder/go/bin:${PATH}"

