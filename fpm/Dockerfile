# Base image, official docker PHP image
FROM php:5.6-fpm

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

# default PHP config
RUN if [ -f /usr/local/etc/php/php.ini ]; then rm /usr/local/etc/php/php.ini; fi
COPY ["config/php.ini", "/usr/local/etc/php/"]

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
RUN docker-php-ext-install\
  mcrypt\
  iconv\
  intl\
  pdo_pgsql

# Install redis extension
ADD https://github.com/phpredis/phpredis/archive/master.tar.gz /tmp/phpredis.tar.gz
RUN mkdir -p /usr/src/php/ext/redis\
  && tar xf /tmp/phpredis.tar.gz -C /usr/src/php/ext/redis --strip-components=1

# configure and install
RUN docker-php-ext-configure redis\
  && docker-php-ext-install redis
# cleanup
RUN rm -rd /usr/src/php/ext/redis && rm /tmp/phpredis.tar.gz

# Install imagick extension
ADD https://github.com/mkoppanen/imagick/archive/master.tar.gz /tmp/phpimagick.tar.gz
RUN mkdir -p /usr/src/php/ext/imagick\
  && tar xf /tmp/phpimagick.tar.gz -C /usr/src/php/ext/imagick --strip-components=1

# configure and install
RUN docker-php-ext-configure imagick\
  && docker-php-ext-install imagick
# cleanup
RUN rm -rd /usr/src/php/ext/imagick && rm /tmp/phpimagick.tar.gz

# Install memcached extension
ADD https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz /tmp/phpmemcached.tar.gz
RUN mkdir -p /usr/src/php/ext/memcached\
  && tar xf /tmp/phpmemcached.tar.gz -C /usr/src/php/ext/memcached --strip-components=1

# configure and install
RUN docker-php-ext-configure memcached\
  && docker-php-ext-install memcached
# cleanup
RUN rm -rd /usr/src/php/ext/memcached && rm /tmp/phpmemcached.tar.gz

# Install igbinary extension
ADD https://github.com/igbinary/igbinary/archive/master.tar.gz /tmp/igbinary.tar.gz
RUN mkdir -p /usr/src/php/ext/igbinary\
  && tar xf /tmp/igbinary.tar.gz -C /usr/src/php/ext/igbinary --strip-components=1

# configure and install
RUN docker-php-ext-configure igbinary\
  && docker-php-ext-install igbinary
# cleanup
RUN rm -rd /usr/src/php/ext/igbinary && rm /tmp/igbinary.tar.gz

VOLUME ["/usr/local/etc"]

RUN usermod -u 1000 www-data

EXPOSE 9000
