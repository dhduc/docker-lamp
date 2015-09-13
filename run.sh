#!/bin/sh

echo Starting MySQL ...
docker run -d -p 3306:3306 --name mydb -v /home/tuhoang/data/mysql:/var/lib/mysql \
 -e MYSQL_ROOT_PASSWORD=password \
 -e MYSQL_USER=magento \
 -e MYSQL_PASSWORD=password \
 -e MYSQL_DATABASE=db_magento \
 mysql/mysql-server

MYWEBDIR="/home/tuhoang/mydocker/web/public_html"

if [ -n "$1" ]; then
    MYWEBDIR=$1
fi

echo Starting web and mounting $MYWEBDIR ...
docker run -d -p 80:80 -v ${MYWEBDIR}:/var/www/myweb --name=myweb --link mydb:mysql tuhoang/web
