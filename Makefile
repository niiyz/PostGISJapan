psql:
	docker-compose exec postgis psql -U postgis
cleanup:
	docker system prune --volumes -f && docker-compose build --no-cache && docker-compose up
up:
	docker system prune --volumes -f && docker-compose up --build
