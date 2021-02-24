# docker-laravel

Docker + Laravel + PHP_CodeSniffer (PSR12) + PHPStan (Run Level Max)

## 準備
```shell
$ git clone git@github.com:ohshige15/docker-laravel.git
$ cd docker-laravel
$ make init
```

## 開発
```shell
# コンテナ立ち上げ
$ make up
# コンテナ破棄
$ make down
# phpcs+phpstan
$ make qa
# テスト
$ make test
# Makefileのヘルプ表示
$ make help
```

## バージョン
* PHP 8.0
* Composer 2.0
* Laravel 8
* Nginx 1.18
* Node 14.15
