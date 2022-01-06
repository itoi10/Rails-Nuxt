setup:
	docker-compose build
	docker-compose up -d
	docker-compose exec rails rails db:create
	docker-compose exec rails rails db:migrate:reset
	docker-compose exec rails rails db:seed

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose down
	docker-compose up -d

pg:
	docker-compose exec postgres sh

back:
	docker-compose exec rails sh

front:
	docker-compose exec nuxt sh

