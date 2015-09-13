#!/bin/sh

PROJECT="mylocal"
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

echo Starting MySQL
echo Loading $MYSQLDIR
docker run -d --name $MYDB -v ${MYSQLDIR}:/var/lib/mysql \
 -e MYSQL_ROOT_PASSWORD=password \
 -e MYSQL_USER=magento \
 -e MYSQL_PASSWORD=password \
 -e MYSQL_DATABASE=db_magento \
 mysql/mysql-server

echo
echo Starting Web
echo Mounting $MYWEBDIR
docker run -d -v ${MYWEBDIR}:/var/www/myweb --name $MYWEB --link $MYDB:mysql tuhoang/web
CONTAINER_ID=$(docker ps | grep $MYWEB | awk '{print $1}')
IP=$(docker inspect $CONTAINER_ID | python -c 'import json,sys;obj=json.load(sys.stdin);print obj[0]["NetworkSettings"]["IPAddress"]')
echo
echo \"$MYWEB\" loaded at $IP
echo

echo Attempting to update HOSTS file...
condition="grep -q '"$PROJECT"' /etc/hosts"
if eval $condition; then
    cmd="sudo sed -i -r \"s/^ *[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+( +"$PROJECT")/"$IP" "$PROJECT"/\" /etc/hosts";
else
    cmd="sudo sed -i '\$a\\\\n# added automatically by docker-lamp run.sh\n"$IP" "$PROJECT"\n' /etc/hosts";
fi
eval $cmd
echo "All done!"