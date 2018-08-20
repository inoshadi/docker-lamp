
## Apache2 with php5 and MariaDB 10.0 on Ubuntu 14.04 LTS

This is docker images of [nimmis/apache-php5](https://hub.docker.com/r/nimmis/apache-php5/) and [nimmis/mariadb](https://hub.docker.com/r/nimmis/mariadb)
with a little modification

To access site contents from outside the container you should map /var/www/html
Includes composer for easy download of php libraries

### What inside
- Linux: Ubuntu 14.04 LTS 
- Apache Web Server: Apache2 2.24
- MariaDB: MariaDB 10.0
- PHP: PHP 5.5.9

- `mod_rewrite` enable
- `AllowOverride` `All` within `/var/www/html`

### Examples

- plain, accessable on port 8080 `docker run -d -p 8080:80 inoshadi/docker-lamp`
- with external contents in /home/inoshadi/html `docker run -d -p 8080:80 -v /home/inoshadi/html:/var/www/html inoshadi/docker-lamp`
- set mysql root password to `myrootpass` use this command `docker run -d -p 8080:80 -v /home/inoshadi/html:/var/www/html -e DB_ROOT_PASSWORD=myrootpass inoshadi/docker-lamp` 

The docker container is started with the -d flag so it will run in the background. To run commands or edit settings inside
the container run `docker exec -ti <container id> /bin/bash`


[![Docker Hub; inoshadi/docker-lamp](https://img.shields.io/badge/Docker%20Hub-inoshadi%2Fdocker--lamp-blue.svg)](https://hub.docker.com/r/inoshadi/docker-lamp/)
