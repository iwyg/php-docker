FROM php:7.0-fpm

RUN if [ -f /usr/local/etc/php/php.ini ]; then rm /usr/local/etc/php/php.ini; fi
ADD config/php.ini /usr/local/etc/php/php.ini

RUN if [ -f /usr/local/etc/php/php-fpm.d/www.conf ]; then rm /usr/local/etc/php/php-fpm.d/www.conf; fi
ADD config/fpm.conf /usr/local/etc/php/php-fpm.d/www.conf

RUN apt-get update
RUN apt-get install -my --no-install-recommends\
  zlib1g-dev libicu-dev g++\
  openssl\
  libmcrypt-dev

RUN docker-php-ext-install sockets mcrypt iconv
RUN docker-php-ext-configure pdo_mysql && docker-php-ext-install pdo_mysql

RUN usermod -u 1000 www-data

EXPOSE 9000
