FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# manually set mirror to JP
COPY conf/sources.list /etc/apt/sources.list

# base update
RUN apt-get update && apt-get upgrade -y

# apache2
RUN apt-get install -y apache2
RUN a2enmod rewrite
RUN sed -i '/ServerRoot "\/etc\/apache2"/ a ServerName localhost' /etc/apache2/apache2.conf

# php5
RUN apt-get install -y php5
# necessary modules for Magento
RUN apt-get install -y php5-gd php5-intl php5-mcrypt curl php5-curl
RUN php5enmod mcrypt

# public_html
VOLUME /var/www/myweb
COPY conf/vhost-myweb.conf /etc/apache2/sites-enabled/000-default.conf

# I need it to restart once before supervisor to work. Harmless anyway.
RUN service apache2 restart

# supervisor - we will need it for multi-process docker in future, eg: apache+ssh
#RUN apt-get install -y supervisor
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

#CMD ["/usr/bin/supervisord"]
CMD /usr/sbin/apache2ctl -D FOREGROUND