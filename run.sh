#!/bin/sh

PROJECT="tu"
if [ -n "$1" ]; then
    PROJECT=$1
fi
MYWEB="${PROJECT}web"
MYDB="${PROJECT}db"

MYWEBDIR="/home/tuhoang/mydocker/web/public_html"
if [ -n "$2" ]; then
    MYWEBDIR=$2
fi

MYSQLDIR="/home/tuhoang/data/mysql"
if [ -n "$3" ]; then
    MYWEBDIR=$3
fi

echo Starting MySQL ...
docker run -d -p 3306:3306 --name $MYDB -v ${MYSQLDIR}:/var/lib/mysql \
 -e MYSQL_ROOT_PASSWORD=password \
 -e MYSQL_USER=magento \
 -e MYSQL_PASSWORD=password \
 -e MYSQL_DATABASE=db_magento \
 mysql/mysql-server

echo Starting web and mounting $MYWEBDIR ...
docker run -d -p 80:80 -v ${MYWEBDIR}:/var/www/myweb --name $MYWEB --link $MYDB:mysql tuhoang/web
