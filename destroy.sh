#!/bin/sh

MYWEB="myweb"
if [ -n "$1" ]; then
    MYWEB=$1
fi

MYDB="mydb"
if [ -n "$2" ]; then
    MYDB=$2
fi

docker stop $MYDB $MYWEB
docker rm $MYDB $MYWEB
