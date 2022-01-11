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

rb:
	docker-compose exec rails sh

nx:
	docker-compose exec nuxt sh

rerb:
	docker-compose rm -fsv rails
	docker-compose up -d rails

renx:
	docker-compose rm -fsv nuxt
	docker-compose up -d nuxt
	docker-compose logs -f