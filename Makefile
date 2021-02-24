.PHONY: help
help: ## ヘルプを表示します。
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: build
build: ## docker-composeのサービスをキャッシュを使用せずにビルドします。
	docker-compose build --no-cache --force-rm

.PHONY: up
up: ## コンテナをバックグラウンドで立ち上げます。
	docker-compose up -d php nginx

.PHONY: down
down: ## コンテナを停止して削除します。
	docker-compose down

.PHONY: ps
ps: ## コンテナの一覧を表示します。
	docker-compose ps

.PHONY: logs
logs: ## コンテナのログを逐次表示します。
	docker-compose logs -f


.PHONY: composer-install
composer-install: ## `composer install` を実行します。
	docker-compose run --rm php-cli composer install

.PHONY: composer-dev
composer-dev: ## `composer dev` を実行します。
	docker-compose run --rm php-cli composer dev

.PHONY: composer-update
composer-update: ## `composer update` を実行します。
	docker-compose run --rm php-cli composer update


.PHONY: npm-install
npm-install: ## `npm install` を実行します。
	docker-compose run --rm node npm install

.PHONY: npm-dev
npm-dev: ## `npm run dev` を実行します。
	docker-compose run --rm node npm run dev


.PHONY: init
init: ## プロジェクトの初期設定を行います。
	@make build
	@make composer-install
	@make composer-dev
	@make npm-install
	@make npm-dev


.PHONY: test
test: ## phpunitを実行します。テスト対象を `TARGET=xxx` で指定できます。 `DEBUG=debug` と指定することでXDebugで実行できます。
	$(eval DEBUG_MODE := $(if ${DEBUG}, -dxdebug.mode=${DEBUG}, ))
	docker-compose run --rm php-cli php $(DEBUG_MODE) vendor/bin/phpunit ${TARGET}

.PHONY: cs
qa-cs: ## QAとして、コーディング規約に則っているか判定します。
	docker-compose run --rm php-cli composer cs

.PHONY: cs-fix
qa-fix: ## QAとして、コーディング規約に則っていない箇所で自動修正できる場合は修正します。
	docker-compose run --rm php-cli composer cs-fix

.PHONY: analyse
qa-analyse: ## QAとして、静的解析を行います。
	docker-compose run --rm php-cli composer analyse

.PHONY: qa
qa: ## QAとして、コーディング規約判定や静的解析をまとめて行います。
	docker-compose run --rm php-cli composer qa
