FROM php:rc-fpm-alpine

ARG build_env=dev
ARG with_v8=true
ARG with_imagick=true
ARG with_libsodium=true

ENV APP_ENV ${build_env}

# default PHP config
RUN if [ -f /usr/local/etc/php/php.ini ]; then rm /usr/local/etc/php/php.ini; fi

# Copy configs
COPY ["config/${APP_ENV}/php.ini", "/usr/local/etc/php/"]
COPY ["config/${APP_ENV}/php-fpm.conf", "/usr/local/etc/php/"]
COPY ["config/${APP_ENV}/php-fpm.d/*.conf", "/usr/local/etc/php/php-fpm.d/"]

RUN apk add --no-cache \
  g++ \
  zlib-dev \
  icu-dev \
  postgresql-dev \
  sqlite-libs \
  sqlite-dev \
  imagemagick-dev \
  libmemcached-dev \
  cyrus-sasl-dev \
  libev-dev \
  #v8 \
  #shadow \
  openssl
  #shadow


# Install xdebug if in dev environment
#RUN if [ ${APP_ENV} == 'dev' ]; then docker-php-ext-install xdebug; fi

# Install basic extensions
RUN docker-php-ext-install \
  sockets \
  iconv \
  intl \
  pdo_pgsql
  #imagick \

# -----------------------------------------------------------------
# Install xdebug extension
# -----------------------------------------------------------------

ADD https://github.com/xdebug/xdebug/archive/XDEBUG_2_5_0RC1.tar.gz /tmp/xdebug.tar.gz

RUN if [ ${APP_ENV} == 'dev' ]; then echo "installing xdebug" \
  && mkdir -p /usr/src/php/ext/xdebug\
  && tar xf /tmp/xdebug.tar.gz -C /usr/src/php/ext/xdebug --strip-components=1 \
  && docker-php-ext-configure xdebug\
  && docker-php-ext-install xdebug; fi

RUN rm -rf /usr/src/php/ext/xdebug && rm /tmp/xdebug.tar.gz

# -----------------------------------------------------------------
# Install redis extension
# -----------------------------------------------------------------
ADD https://github.com/phpredis/phpredis/archive/php7.tar.gz /tmp/phpredis.tar.gz
RUN mkdir -p /usr/src/php/ext/redis\
  && tar xf /tmp/phpredis.tar.gz -C /usr/src/php/ext/redis --strip-components=1

RUN docker-php-ext-configure redis\
  && docker-php-ext-install redis

RUN rm -rf /usr/src/php/ext/redis && rm /tmp/phpredis.tar.gz

# -----------------------------------------------------------------
# Install ev extension
# -----------------------------------------------------------------
ADD https://pecl.php.net/get/ev-1.0.3.tgz /tmp/ev.tar.gz
RUN mkdir -p /usr/src/php/ext/ev\
  && tar xf /tmp/ev.tar.gz -C /usr/src/php/ext/ev --strip-components=1

RUN docker-php-ext-configure ev\
  && docker-php-ext-install ev

RUN rm -rf /usr/src/php/ext/ev && rm /tmp/ev.tar.gz

# -----------------------------------------------------------------
# Install memcached extension
# -----------------------------------------------------------------
ADD https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz /tmp/phpmemcached.tar.gz
RUN mkdir -p /usr/src/php/ext/memcached\
  && tar xf /tmp/phpmemcached.tar.gz -C /usr/src/php/ext/memcached --strip-components=1

RUN docker-php-ext-configure memcached\
  && docker-php-ext-install memcached

RUN rm -rf /usr/src/php/ext/memcached && rm /tmp/phpmemcached.tar.gz

# -----------------------------------------------------------------
# Install imagick extension
# -----------------------------------------------------------------
ADD https://pecl.php.net/get/imagick-3.4.3RC1.tgz /tmp/imagick.tar.gz
RUN if [ ${with_imagick} == 'true' ]; then mkdir -p /usr/src/php/ext/imagick\
  && tar xf /tmp/imagick.tar.gz -C /usr/src/php/ext/imagick --strip-components=1\
  && docker-php-ext-configure imagick\
  && docker-php-ext-install imagick; fi

RUN rm -rf /usr/src/php/ext/imagick && rm /tmp/imagick.tar.gz

# -----------------------------------------------------------------
# Install v8js extension
# -----------------------------------------------------------------
ADD https://pecl.php.net/get/v8js-1.3.3.tgz /tmp/v8.tar.gz

RUN if [ ${with_v8} == 'true' ]; then mkdir -p /usr/src/php/ext/v8js\
  && tar xf /tmp/v8.tar.gz -C /usr/src/php/ext/v8js --strip-components=1\
  && docker-php-ext-configure v8js\
  && docker-php-ext-install v8js; fi

RUN rm -rf /usr/src/php/ext/v8js && rm /tmp/v8.tar.gz

# -----------------------------------------------------------------
# Install libsodium extension
# -----------------------------------------------------------------
ADD https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz /tmp/libsodium.tar.gz
RUN if [ ${with_libsodium} == 'true' ]; then mkdir -p /usr/src/php/ext/libsodium\
  && tar xf /tmp/libsodium.tar.gz -C /usr/src/php/ext/libsodium --strip-components=1\
  && docker-php-ext-configure libsodium\
  && docker-php-ext-install libsodium; fi

RUN rm -rf /usr/src/php/ext/libsodium && rm /tmp/libsodium.tar.gz

# -----------------------------------------------------------------
# expost volumes
# -----------------------------------------------------------------
VOLUME ["/usr/local/etc"]

#@TODO cleanup
#@TODO add dev alpine archive to install shadow
#RUN usermod -u 1000 www-data

EXPOSE 9000
