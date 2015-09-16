# docker-lamp

This is my personal development LAMP stack on Docker. It can help you to quickly run multiple websites on your local environment without conflicts. Instead of using *docker-compose*, reverse proxy or forwarding ports like common Docker practices, I am using shell scripts to update automatically the host's HOSTS files. Then we can access those local websites with different hostnames on the same port 80.

This approach is trying to keep your local setup as light-weight and as simple as possible.

## build.sh

This script will create a Docker image *tuhoang/web* which has ubuntu 14.04, apache 2, php 5.5 and my typical configurations for local development. The detailed steps are in *web/Dockerfile*. You can skip this step because I published that image to Docker Hub.

## run.sh

This script will create and start a new container from image *tuhoang/web*. Our web containers will connect and share only one database container *mysql*. This script will automatically setup or re-use that container if it has been already available.

The database container *mysql* has root password is "password".

Usage:
```
$ ./run.sh [PROJECT_NAME] [/PATH/TO/HTML] [/PATH/TO/MYSQL/DATA]
```
All arguments are optional. Their default values are:
- *PROJECT_NAME* = "mylocal"
- */PATH/TO/HTML* = "/path/to/current/dir/web/public_html"
- */PATH/TO/MYSQL/DATA* = "home/youraccount/data/mysql"

### Notice

After the containers start, this script will automatically grab the new IP of *web* and attempt to update your host's HOSTS file with the new IP address.

Example:
```
$ ./run.sh mysite.loc /home/youraccount/www/mysite

$ ./run.sh myblog.loc /home/youraccount/www/myblog

$ ping mysite.loc

$ ping myblog.loc
```

## mysql.sh

Run this script to connect to MySQL container from host.

Usage:
```
$ ./mysql.sh [MYSQL_CONTAINER_NAME] [USERNAME] [PASSWORD]
```
All arguments are optional. Their default values are:
- *MYSQL_CONTAINER_NAME* = "mysql"
- *USERNAME* = "root"
- *PASSWORD* = "password"

## destroy.sh

This script will stop and remove your containers.

Usage:
```
$ ./destroy.sh [PROJECT_NAME]
```
All arguments are optional. Their default values are:
- *PROJECT_NAME* = "mylocal"
