FROM tuhoang/lamp:0.1-ubuntu1404

RUN apt-get install -y apache2
RUN a2enmod rewrite
RUN service apache2 restart
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
