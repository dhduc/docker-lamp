#!/bin/sh

MYDB="mysql"

PROJECT="mylocal"
if [ -n "$1" ]; then
    PROJECT=$1
fi

CURRENT_DIR=$(pwd)
MYWEBDIR=$CURRENT_DIR"/web/public_html"
if [ -n "$2" ]; then
    MYWEBDIR=$2
fi

MYSQLDIR=$HOME"/data/mysql"
if [ -n "$3" ]; then
    MYSQLDIR=$3
fi

# find MySQL container
MYSQL_CONTAINER=$(docker ps | grep $MYDB | awk '{print $1}')
if [ -z "$MYSQL_CONTAINER" ]; then
    # maybe it was stopped
    MYSQL_CONTAINER=$(docker ps -a | grep $MYDB | awk '{print $1}')
    if [ -z "$MYSQL_CONTAINER" ]; then
        echo Starting MySQL...
        echo Loading $MYSQLDIR
        docker run -d --name $MYDB -v ${MYSQLDIR}:/var/lib/mysql \
            -e MYSQL_ROOT_PASSWORD=password \
            -e MYSQL_USER=magento \
            -e MYSQL_PASSWORD=password \
            -e MYSQL_DATABASE=db_magento \
            mysql/mysql-server
    else
        echo Stopped MySQL container found. Restarting...
        docker start $MYDB
    fi
else
    echo Running MySQL container found!
fi

# find web container
WEB_CONTAINER=$(docker ps | grep $PROJECT | awk '{print $1}')
if [ -z "$WEB_CONTAINER" ]; then
    # maybe it was stopped
    WEB_CONTAINER=$(docker ps -a | grep $PROJECT | awk '{print $1}')
    if [ -z "$WEB_CONTAINER" ]; then
        echo Starting "$PROJECT" web container...
        echo Mounting $MYWEBDIR
        docker run -d -v ${MYWEBDIR}:/var/www/myweb --name $PROJECT --link $MYDB:mysql tuhoang/web
    else
        echo Found existing web container. Starting \"$PROJECT\" web container...
        docker start $PROJECT
    fi
else
    echo Running \"$PROJECT\" web container found!
fi

# find the new dynamic IP address
CONTAINER_ID=$(docker ps | grep $PROJECT | awk '{print $1}')
if [ -z "$CONTAINER_ID" ]; then
    echo ERROR: Container \"$PROJECT\" could not be started.
    exit 1
fi

IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $PROJECT)
if [ -z "$IP" ]; then
    echo ERROR: Could not find the IP address of container \"$PROJECT\".
    exit 1
fi

echo
echo \"$PROJECT\" loaded at $IP
echo

# update HOSTS file
echo Attempting to update HOSTS file...
CONDITION="grep -q '"$PROJECT"' /etc/hosts"
if eval $CONDITION; then
    CMD="sudo sed -i -r \"s/^ *[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+( +"$PROJECT")/"$IP" "$PROJECT"/\" /etc/hosts";
else
    CMD="sudo sed -i '\$a\\\\n# added automatically by docker-lamp run.sh\n"$IP" "$PROJECT"\n' /etc/hosts";
fi
eval $CMD
echo "All done!"
