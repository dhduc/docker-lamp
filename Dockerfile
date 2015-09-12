FROM tuhoang/lamp:0.1-ubuntu1404

RUN apt-get install -y apache2
RUN a2enmod rewrite

EXPOSE 80