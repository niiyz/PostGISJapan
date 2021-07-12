psql:
	docker-compose exec postgis psql -U postgis
cleanup:
	docker system prune --volumes -f && docker-compose build --no-cache && docker-compose up
up:
	docker system prune --volumes -f && docker-compose up --build
japan:
	docker-compose exec postgis psql -U postgis -c "\d japan"
	docker-compose exec postgis psql -U postgis -c "select count(*) from japan;"
	docker-compose exec postgis psql -U postgis -c "select count(*) from japan where city2 = '大垣市';"

