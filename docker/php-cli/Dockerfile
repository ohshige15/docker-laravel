FROM php:8.0-cli-buster

# phpコンテナと同じ構築を行う
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

# phpコンテナと同じ設定ファイルを使う
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

WORKDIR /work
