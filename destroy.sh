#!/bin/sh

PROJECT="mylocal"
if [ -n "$1" ]; then
    PROJECT=$1
fi

docker stop $PROJECT
docker rm $PROJECT
