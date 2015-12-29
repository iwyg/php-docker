# dockerized web environment
> Dockerized web environemnt using NGINX, PHP7, POSTGRES, MEMCACHED, and REDIS.

[![Author](http://img.shields.io/badge/author-iwyg-blue.svg?style=flat-square)](https://github.com/iwyg)
[![Source Code](http://img.shields.io/badge/source-iwyg/php_docker-blue.svg?style=flat-square)](https://github.com/iwyg/php-docker/tree/master)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](https://github.com/iwyg/php-docker/blob/master/LICENSE.md)

[![Build Status](https://img.shields.io/travis/iwyg/php-docker/master.svg?style=flat-square)](https://travis-ci.org/iwyg/php-docker)

This repository uses the official [php docker container](https://hub.docker.com/_/php/).

## Contents
- [NGINX](http://nginx.org/)
- [Postres](http://www.postgresql.org)
- [PHP-FPM](http://php-fpm.org/)
- [Redis](http://redis.io/)
- [Memcached](http://memcached.org/)

Additional PHP extensions are:
- mcrypt
- pdo_pgsql
- imagick
- memcached
- redis

## Requirements
- [Docker Engine](https://docs.docker.com/installation/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Docker Machine](https://docs.docker.com/machine/) (OS X and Windows)

## Containers
- [Nginx](https://hub.docker.com/_/nginx/)
- [php-fpm](https://hub.docker.com/_/php/)
- [Redis](https://hub.docker.com/_/redis/)
- [Memcached](https://hub.docker.com/_/memcached/)
- [Postgres](https://hub.docker.com/_/postgres/)

## Usage

Assuming you have a running docker machine:

```bash
$ docker-compose up
```
