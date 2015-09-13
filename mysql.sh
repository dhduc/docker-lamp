#!/bin/sh

MYDB="mysql"
if [ -n "$1" ]; then
    MYDB=$1
fi

MYUSER="root"
if [ -n "$2" ]; then
    MYUSER=$2
fi

MYPASS="password"
if [ -n "$3" ]; then
    MYPASS=$3
fi

docker run -it --link ${MYDB}:mysql --rm mysql/mysql-server sh -c "exec mysql -h${MYDB} -u${MYUSER} -p${MYPASS}"
