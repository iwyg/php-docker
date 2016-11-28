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

#@TODO add dev alpine archive to install shadow
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

# -----------------------------------------------------------------
# Install v8js extension
# -----------------------------------------------------------------
ADD https://pecl.php.net/get/v8js-1.3.3.tgz /tmp/v8.tar.gz

RUN if [ ${with_v8} == 'true' ]; then \
  # install depot_tools
  #apk add --no-cache git make bash wget \
  apk add --no-cache git make bash wget curl python \
  && mkdir -p /usr/src \
  && cd /usr/src \
  #&& curl -O https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tar.xz \
  #&& tar xvf Python-2.7.12.tar.xz && cd Python-2.7.12 \
  #&& ./configure --prefix=/usr         \
  #               --enable-shared       \
  #               --with-system-expat   \
  #               --with-system-ffi     \
  #               --enable-unicode=ucs4 \
  && make && make install \
  && echo `which python` \
  && cd /usr/src \
  && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git \
  && export PATH="/usr/src/depot_tools:$PATH" \
  # install V8
  && echo "fetching v8"\
  && cd /usr/src && gclient config --spec 'solutions = [    \
    {                                                       \
      "url": "https://chromium.googlesource.com/v8/v8.git", \
      "managed": False,                                     \
      "name": "v8",                                         \
      "deps_file": "DEPS",                                  \
      "custom_deps": {},                                    \
    },                                                      \
  ]'                                                        \
  && gclient sync --verbose --with_branch_heads \
  #&& fetch v8\
  && echo "done fetching v8"\
  && echo "building v8"\
  && cd /usr/src/v8 && make native library=shared snapshot=off -j 2 \
  && echo "done building v8"\
  && cp -R /usr/src/v8/out/native/lib.target/lib* /lib64/ \
  && cp /usr/src/v8/out/native/obj.target/tools/gyp/libv8_libplatform.a /usr/lib64/ \
  && cp -R /usr/src/v8/include /usr/local \
  # install V8js extension
  && mkdir -p /usr/src/php/ext/v8js\
  && tar xf /tmp/v8.tar.gz -C /usr/src/php/ext/v8js --strip-components=1\
  && docker-php-ext-configure v8js\
  && docker-php-ext-install v8js\
  # cleanup
  && cd /usr/src/Python-2.7.12 && make uninstall && make clean \
  && apk del git make bash wget curl python \
  && rm -rf Python-2.7.12 \
  && rm -rf /usr/src/depot_tools; fi

RUN rm -rf /usr/src/php/ext/v8js && rm /tmp/v8.tar.gz

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
# Install libsodium extension
# -----------------------------------------------------------------
ADD https://github.com/jedisct1/libsodium-php/archive/1.0.6.tar.gz /tmp/libsodium.tar.gz
RUN if [ ${with_libsodium} == 'true' ]; then\
  apk add --no-cache libsodium-dev \
  && mkdir -p /usr/src/php/ext/libsodium\
  && tar xf /tmp/libsodium.tar.gz -C /usr/src/php/ext/libsodium --strip-components=1\
  && docker-php-ext-configure libsodium\
  && docker-php-ext-install libsodium\
  && apk del libsodium-dev; fi

RUN rm -rf /usr/src/php/ext/libsodium && rm /tmp/libsodium.tar.gz

# -----------------------------------------------------------------
# expost volumes
# -----------------------------------------------------------------
VOLUME ["/usr/local/etc"]

#@TODO cleanup
RUN apk del \
  g++ \
  zlib-dev \
  icu-dev \
  postgresql-dev \
  sqlite-libs \
  sqlite-dev \
  imagemagick-dev \
  libmemcached-dev \
  cyrus-sasl-dev \
  libev-dev

#RUN usermod -u 1000 www-data

EXPOSE 9000
