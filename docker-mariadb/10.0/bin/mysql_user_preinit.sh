#!/bin/bash
#
# Docker mysql processscript 
#
# Script to do stuff before the script to create the database
#
# mysql root password is in DB_ROOT_PASSWORD
#
# to generate environmentvariables that survives the init process do
#
# echo "DB_VARIABLE_NAME=value" >> /tmp/source
# for each variable
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

