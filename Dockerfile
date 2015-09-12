FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# manually set mirror to JP
COPY sources.list /etc/apt/sources.list

# basic update
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nano

# apache2
RUN apt-get install -y apache2
RUN a2enmod rewrite
RUN service apache2 restart

# supervisor
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
