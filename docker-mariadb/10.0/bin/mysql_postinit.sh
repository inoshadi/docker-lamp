#!/bin/sh
#
# Docker mysql processscript
#
# (c) 2015 nimmis <kjell.havneskold@gmail.com>
#
# The script does the following:
# 1. sets root password for mysql
# 2. runs application preinit code
# 3. create user and database
# 4. runs application postinit code
#

if [ ! -f /var/lib/mysql/configured ]; then
   /usr/local/bin/mysql_setrootpassword >> /var/log/startup.log 2>&1
   if [ -f /usr/local/bin/mysql_user_preinit.sh ]; then
      /usr/local/bin/mysql_user_preinit.sh >> /var/log/startup.log 2>&1
   fi
   /usr/local/bin/mysql_setup_database.sh >> /var/log/startup.log 2>&1
   if [ -f /usr/local/bin/mysql_user_postinit.sh ]; then
      /usr/local/bin/mysql_user_postinit.sh >> /var/log/startup.log 2>&1
   fi

   # remove information of variables used 
   rm /tmp/source
   # mark that the init has been run
   touch /var/lib/mysql/configured

fi

/usr/local/bin/init.sh