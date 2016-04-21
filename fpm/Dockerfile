# Base image, official docker PHP image
FROM php:7.0-fpm

############################################################################
#### This installes following extensions:                               ####
############################################################################
#### - pgsql                                                            ####
#### - iconv                                                            ####
#### - intl                                                             ####
#### - redis                                                            ####
#### - memcached                                                        ####
#### - imagick                                                          ####
############################################################################

# Install dependencies
RUN apt-get update\
  && apt-get install -my --no-install-recommends\
  # intl dependencies
  zlib1g-dev libicu-dev g++\
  # mcrypt dependencies
  libmcrypt-dev\
  # Postgres
  libpq-dev\
  # SQLite
  #libsqlite3-dev\
  # ImageMagick
  libmagickwand-dev\
  imagemagick\
  # Memcached
  libmemcached-dev

# Install basic extensions
RUN docker-php-ext-install mcrypt iconv
# Install intl extensions
RUN docker-php-ext-configure intl\
  && docker-php-ext-install intl

# Install postgres extension
RUN docker-php-ext-configure pdo_pgsql\
  && docker-php-ext-install pdo_pgsql

## Install sqlite extension
## SQLite should be preinstalled?
#RUN docker-php-ext-configure pdo_sqlite\
#  && docker-php-ext-install pdo_sqlite

# Install redis extension
ADD https://github.com/phpredis/phpredis/archive/php7.tar.gz /tmp/phpredis.tar.gz
RUN mkdir -p /usr/src/php/ext/redis\
  && tar xf /tmp/phpredis.tar.gz -C /usr/src/php/ext/redis --strip-components=1

# configure and install
RUN docker-php-ext-configure redis\
  && docker-php-ext-install redis
# cleanup
RUN rm -rd /usr/src/php/ext/redis && rm /tmp/phpredis.tar.gz

# Install imagick extension
ADD https://github.com/mkoppanen/imagick/archive/phpseven.tar.gz /tmp/phpimagick.tar.gz
RUN mkdir -p /usr/src/php/ext/imagick\
  && tar xf /tmp/phpimagick.tar.gz -C /usr/src/php/ext/imagick --strip-components=1

# configure and install
RUN docker-php-ext-configure imagick\
  && docker-php-ext-install imagick
# cleanup
RUN rm -rd /usr/src/php/ext/imagick && rm /tmp/phpimagick.tar.gz

# Install memcached extension

ADD https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz /tmp/phpmemcached.tar.gz
RUN mkdir -p /usr/src/php/ext/memcached\
  && tar xf /tmp/phpmemcached.tar.gz -C /usr/src/php/ext/memcached --strip-components=1

# configure and install
RUN docker-php-ext-configure memcached\
  && docker-php-ext-install memcached
# cleanup
RUN rm -rd /usr/src/php/ext/memcached && rm /tmp/phpmemcached.tar.gz

VOLUME ["/usr/local/etc"]

RUN usermod -u 1000 www-data

EXPOSE 9000
