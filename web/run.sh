#!/bin/sh

docker run -d -p 80:80 -p 3306:3306 --name=myweb tuhoang/lamp
