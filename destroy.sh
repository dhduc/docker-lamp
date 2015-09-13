#!/bin/sh

PROJECT="mylocal"
if [ -n "$1" ]; then
    PROJECT=$1
fi
MYWEB="${PROJECT}web"
MYDB="${PROJECT}db"

docker stop $MYDB $MYWEB
docker rm $MYDB $MYWEB
