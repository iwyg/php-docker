#!/bin/bash

/usr/bin/mysqld_safe --data-dir=/var/lib/mysql&

/usr/local/sbin/php-fpm

/usr/sbin/nginx -g "daemon off;"
