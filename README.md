# Rails アプリ

起動

$ docker-compose build

$ docker-compose up -d

セットアップ

$ docker-compose exec web yarn install

$ docker-compose exec web rake db:create

終了

$ docker-compose down

ローカル

http://127.0.0.1:3000/

heroku

https://rails-app-a.herokuapp.com/
