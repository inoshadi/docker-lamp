
## Apache2 with php5 and MariaDB 10.0 on Ubuntu 14.04 LTS

This is docker images of [nimmis/apache-php5](https://hub.docker.com/r/nimmis/apache-php5/) and [nimmis/mariadb](https://hub.docker.com/r/nimmis/mariadb) with a little modification

To access site contents from outside the container you should map /var/www/html

Includes composer for easy download of php libraries


### Examples

- plain, accessable on port 8080 `docker run -d -p 8080:80 inoshadi/lamp:v1.0`
- with external contents in /home/inoshadi/html `docker run -d -p 8080:80 -v /home/inoshadi/html:/var/www/html inoshadi/lamp:v1.0`
- with external contents in /home/inoshadi/html and mysql root password `myrootpass` use this command `docker run -d -p 8080:80 -v /home/inoshadi/html:/var/www/html -e DB_ROOT_PASSWORD=myrootpass inoshadi/lamp:v1.0` 

The docker container is started with the -d flag so it will run inte the background. To run commands or edit settings inside
the container run `docker exec -ti <container id> /bin/bash'
