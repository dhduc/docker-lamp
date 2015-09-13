# docker-lamp

This is my personal development LAMP stack.

## build.sh

This script will create a Docker image *tuhoang/web* which has ubuntu 14.04, apache 2, php 5.5 and my typical configurations for local development. The detailed steps are in *web/Dockerfile*. You can skip this step because I published that image to Docker Hub.

## run.sh

This script will create and start 2 containers *web* and *mysql*.

Usage:
```
$ ./run.sh [PROJECT_NAME] [/PATH/TO/HTML] [/PATH/TO/MYSQL/DATA]
```
All arguments are optional. Their default values are:
- *PROJECT_NAME* = "tu"
- */PATH/TO/HTML* = "/home/tuhoang/mydocker/web/public_html"
- */PATH/TO/MYSQL/DATA* = "home/tuhoang/data/mysql"

## mysql.sh

Run this script to connect to MySQL container from host.

Usage:
```
$ ./mysql.sh [PROJECT_NAME] [USERNAME] [PASSWORD]
```
All arguments are optional. Their default values are:
- *PROJECT_NAME* = "tu"
- *USERNAME* = "root"
- *PASSWORD* = "password"

## destroy.sh

This script will stop and remove your containers.

Usage:
```
$ ./destroy.sh [PROJECT_NAME]
```
