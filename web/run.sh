#!/bin/sh

MYWEBDIR="/home/tuhoang/mydocker/web/public_html"

if [ -n "$1" ]; then
    MYWEBDIR=$1
fi

echo Mounting $MYWEBDIR ...

docker run -d -p 80:80 -v ${MYWEBDIR}:/var/www/myweb --name=myweb tuhoang/web
