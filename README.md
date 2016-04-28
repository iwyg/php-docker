# dockerized web environment
> minimal dockerized web environemnt using NGINX, PHP56, MARIADB.

[![Author](http://img.shields.io/badge/author-iwyg-blue.svg?style=flat-square)](https://github.com/iwyg)
[![Source Code](http://img.shields.io/badge/source-iwyg/php_docker-blue.svg?style=flat-square)](https://github.com/iwyg/php-docker/tree/minimal-compose)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](https://github.com/iwyg/php-docker/blob/minimal-compose/LICENSE.md)

[![Build Status](https://img.shields.io/travis/iwyg/php-docker/minimal-compose.svg?style=flat-square)](https://travis-ci.org/iwyg/php-docker)

## install

```sh
> git clone https://github.com/iwyg/php-docker 
> cd php-docker
> git checkout minimal-compose
```

## build

```sh
> docker-compose build 
```

## run

```sh
> docker-compose up
```
<!--
```sh
> docker run -d -v $(pwd)/app:/var/www/app -p 8080:80 -p 3306:3306 --name=devbox1 dev/php
```
-->
## Application path

The default application path is located at `./app/public/index.php`. You'll need
to alter the application path depending on your specific needs, e.g. if using
Symfony2 Applications, use `./app/web/app.php`.


## License
This repository is licensed under the MIT open source license. 
For more details see the license file that's distributed with this package.
