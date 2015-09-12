FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# manually set mirror to JP
COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nano
