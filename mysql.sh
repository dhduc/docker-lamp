#!/bin/sh

MYDB="mysql"
if [ -n "$1" ]; then
    MYDB=$1
fi

USER="root"
if [ -n "$2" ]; then
    USER=$2
fi

PASSWORD="password"
if [ -n "$3" ]; then
    PASSWORD=$3
fi

docker exec -it $MYDB mysql -u$USER -p$PASSWORD