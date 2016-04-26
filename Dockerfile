FROM php:5.6-fpm

RUN if [ -f /usr/local/etc/php/php.ini ]; then rm /usr/local/etc/php/php.ini; fi

ADD config/php.ini /usr/local/etc/php/php.ini

RUN apt-get update

ADD scripts/configure_mysql_install configure_mysql_install
RUN chmod +x configure_mysql_install && bash -c ./configure_mysql_install && rm configure_mysql_install

RUN apt-get install -my --no-install-recommends\
  zlib1g-dev libicu-dev g++\
  openssl\
  libmcrypt-dev\
  nginx\
  mariadb-server

#RUN mysql -uroot -pPASS -e "SET PASSWORD = PASSWORD('');"

#RUN mysql_install_db --basedir=/usr --datadir=/var/lib/mysql

RUN docker-php-ext-install sockets mcrypt iconv
RUN docker-php-ext-configure pdo_mysql && docker-php-ext-install pdo_mysql

# Remove default nginx configs.
RUN rm /etc/nginx/nginx.conf
RUN if [ -d /etc/nginx/conf.d ]; then rm -rf /etc/nginx/conf.d/*; fi
RUN if [ -d /etc/nginx/sites-enabled ]; then rm -rf /etc/nginx/sites-enabled; fi

COPY ./config/nginx.conf /etc/nginx/
COPY ./config/sites-enabled /etc/nginx/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN ln -sf /dev/stdout /var/log/mysql.log \
	&& ln -sf /dev/stderr /var/log/mysql.error\
	&& ln -sf /dev/stderr /var/log/mysql/error.log

VOLUME ["/var/www/app", "./app"]

RUN usermod -u 1000 www-data

ADD ./scripts/start.sh /usr/sbin/start-servers
RUN chmod +x /usr/sbin/start-servers

#EXPOSE 80 443 3306


EXPOSE 80 443 3306

CMD ["start-servers"]
