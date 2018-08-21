FROM nimmis/apache-php5
MAINTAINER Sutrisno Hadi <inoshadi@gmail.com>

ADD docker-mariadb/10.0/bin/mysql_postinit.sh /usr/local/bin/ 
ADD docker-mariadb/10.0/bin/mysql_setrootpassword  /usr/local/bin/
ADD docker-mariadb/10.0/bin/mysql_setup_database.sh  /usr/local/bin/
ADD docker-mariadb/10.0/bin/mysql_user_postinit.sh  /usr/local/bin/
ADD docker-mariadb/10.0/bin/mysql_user_preinit.sh /usr/local/bin/
ADD docker-mariadb/10.0/bin/init.sh /usr/local/bin/
ADD docker-mariadb/10.0/supervisor/mariadb.conf /etc/supervisor/conf.d/

# Override default mirror to http://buaya.klas.or.id/ubuntu/
# comment out this line if you want to use default mirror
ADD trusty/sources.list /etc/apt/sources.list

# Create required directories
RUN mkdir /docker-entrypoint-initdb.d

# Update repositories & install packages
RUN apt-get update && \
    apt-get install software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    add-apt-repository 'deb http://ftp.ddg.lth.se/mariadb/repo/10.0/ubuntu trusty main' && \
    apt-get update && \
    apt-get install -y --no-install-recommends mariadb-server && \
    apt-get clean all && \
    sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf && \
    chown mysql /etc/mysql/debian.cnf && \
    chmod +x /usr/local/bin/* 

VOLUME /var/lib/mysql
    
EXPOSE 3306


# Add webutils & default index.php
ADD www-html /var/www/html

# override virtual host config to enable htaccess
ADD conf/apache2.conf /etc/apache2/apache2.conf
ADD conf/000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable mod_rewrite
RUN a2enmod rewrite

# Restart Apache
RUN service apache2 restart

