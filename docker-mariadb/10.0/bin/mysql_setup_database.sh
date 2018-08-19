#!/bin/bash
#
# Docker mysql processscript 
#
# creates a mysql user by the name DB_USER with the password DB_USER_PASSWORD
# if DB_USER is defined but not DB_USER_PASSWORD a random password is created
#
# if DB_DATABASE is defined a database i created and if the user DB_USER is defined
# that user i given full access to that dababase
#
# The resultning password is stored in /tmp/source so that other scripts can
# get variables created during the process
#
# (c) 2015 nimmis <kjell.havneskold@gmail.com>
#

if [ -f /tmp/source ]; then
  source /tmp/source
fi

#
# create user if defined by DB_USER
#

if [ $DB_USER ]; then 
  if [ ! $DB_USER_PASSWORD ]; then
    DB_USER_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 2>/dev/null | head -c${1:-12} 2>/dev/null)
  fi

  echo "Setting password for user $DB_USER to $DB_USER_PASSWORD" 
  echo "Mysql create user $DB_USER"

  echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" | /usr/bin/mysql -u root --password=$DB_ROOT_PASSWORD
  
  if [ $? -ne 0 ]; then
     print "Could not create user $DB_USER exiting"
     exit 1
  fi
  echo "DB_USER=$DB_USER" >> /tmp/source
  echo "DB_USER_PASSWORD=$DB_USER_PASSWORD" >> /tmp/source
else
  echo "No mysql user was created because DB_USER and DB_USER_PASSWORD was not defined"
fi

#
# create database if DB_DATABASE is defined
#

if [ $DB_DATABASE ]; then
  echo "Mysql create database $DB_DATABASE"
  echo "CREATE DATABASE $DB_DATABASE;" | /usr/bin/mysql -u root --password=$DB_ROOT_PASSWORD
  if [ $? -ne 0 ]; then
     print "Could not create database $DB_DATABASE exiting"
     exit 1
  fi
  echo "DB_DATABASE=$DB_DATABASE" >> /tmp/source

  # if we have a user, grant user access to database

  if [ $DB_USER ]; then
     echo "Grating user $DB_USER access to database $DB_DATABASE"
     echo "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%'  WITH GRANT OPTION;" | /usr/bin/mysql -u root --password=$DB_ROOT_PASSWORD
     if [ $? -ne 0 ]; then
       print "Could not grant user $DB_USER access to database $DB_DATABASE;"
       exit 1
     fi
  else
    echo "No user was given privileges to database $DB_DATABASE because DB_USER was not defined"
  fi
else
  echo "No mysql database was created because DB_DATABASE was not defined"
fi

