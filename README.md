# Rails アプリ

## バージョン

Ruby 3.0.2

Rails 7.0.0

MySQL 8.0.27

## セットアップ

$ docker-compose build

$ docker-compose run web rails db:create

$ docker-compose run web rails db:migrate

### 起動

$ docker-compose up -d

rails コンテナ入り方

$ docker-compose exec web bash

mysql コンテナ入り方

$ docker-compose exec db bash

### 終了

$ docker-compose down

## 環境

### ローカル

http://127.0.0.1:3000/

### heroku

https://rails-app-a.herokuapp.com/
