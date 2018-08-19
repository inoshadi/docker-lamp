#!/bin/bash
#
# Docker mysql processscript 
#
# Script to do stuff after the script to create the database
#
# here you can populate the database
#
# mysql root password is in DB_ROOT_PASSWORD
# mysql user is in DB_USER
# mysql user password is in DB_USER_PASSWORD
# mysql database is in DB_DATABASE
#
#
# (c) 2015 nimmis <kjell.havneskold@gmail.com>
#

if [ -f /tmp/source ]; then
  source /tmp/source
  DB_OLD_ROOT_PASSWORD=$DB_ROOT_PASSWORD
fi

#
# put your code here
#

