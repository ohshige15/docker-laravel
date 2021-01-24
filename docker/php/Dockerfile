FROM php:8.0-fpm-buster

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && echo 'Asia/Tokyo' > /etc/timezone \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && pecl install xdebug \
  && docker-php-ext-install \
    bcmath \
    pdo_mysql \
  && docker-php-ext-enable xdebug

COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

WORKDIR /work

# デバックモードオンで起動する
CMD ["php-fpm", "-dxdebug.mode=debug"]
