setup:
	docker-compose build
	docker-compose up -d
	docker-compose exec web rails db:create
	docker-compose exec web rails db:migrate:reset
	docker-compose exec web rails db:seed

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose down
	docker-compose up -d

web:
	docker-compose exec web bash

pg:
	docker-compose exec postgres bash