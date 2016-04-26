#!/bin/sh

# start nginx
/usr/sbin/nginx -g "daemon off;"

# start php
/usr/local/sbin/php-fpm

# start mysql
/usr/bin/mysqld_safe --data-dir=/var/lib/mysql&
