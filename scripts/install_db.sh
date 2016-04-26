#!/bin/sh

set -e
echo -ne '\n' | mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
