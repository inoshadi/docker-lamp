## Apache2 with php5 and MariaDB 10.0 on Ubuntu 14.04 LTS

[![Docker Hub; inoshadi/docker-lamp](https://img.shields.io/badge/Docker%20Hub-inoshadi%2Fdocker--lamp-blue.svg)](https://hub.docker.com/r/inoshadi/docker-lamp/)

This is a docker images mixed of [nimmis/apache-php5](https://hub.docker.com/r/nimmis/apache-php5/) and [nimmis/mariadb](https://hub.docker.com/r/nimmis/mariadb)
with a little modification

### What's inside
- Linux: Ubuntu 14.04 LTS 
- Apache Web Server: Apache2 2.24
- MariaDB: MariaDB 10.0
- PHP: PHP 5.5.9
- Adminer: 4.6.3

### Features
- `mod_rewrite` enable
- `composer`
- `bash` access to the container

### Examples
- Basic usage, using port `8080`:
  ```
  docker run -d -p 8080:80 inoshadi/docker-lamp
  ```
- To access the site contents from outside the container you should map `/var/www/html` with your local files in `/home/inoshadi/html`: 
  ```
  docker run -d -p 8080:80 -v /home/inoshadi/html:/var/www/html inoshadi/docker-lamp
  ```
- set mysql root password to `myrootpass` use this command:
  ```
  docker run -d -p 8080:80 -v /home/inoshadi/html:/var/www/html -e DB_ROOT_PASSWORD=myrootpass inoshadi/docker-lamp
  ``` 
- open your browser then point to [`http://localhost:8080`](http://localhost:8080)

### 
- The docker container is started with the `-d` flag so it will run in the background.
- To get the list of containers, run :
  ```
  docker ps
  ```
- To run commands or edit settings inside the container with id `f3d960a8b31f` run:
  ```
  docker exec -ti f3d960a8b31f /bin/bash
  ```
- Expected result is terminal prompt similiar to `root@f3d960a8b31f:~#` _

### Default Configuration
- `conf/000-default.conf`
    ```
    ServerName localhost

    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/html/>
            Options Indexes FollowSymLinks
            DirectoryIndex index.php index.html
            AllowOverride All
            Require all granted
        </Directory>

    </VirtualHost>

    ```
- `trusty/source.list` # Override default mirror to http://buaya.klas.or.id/ubuntu/