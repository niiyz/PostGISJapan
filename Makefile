PSQL := docker-compose exec postgis psql -U postgis
PSQL_COMMAND := $(PSQL) -c

psql:
	$(PSQL)
cleanup:
	docker volume rm postgisjapan_db-data -f && docker-compose build --no-cache && docker-compose up
up:
	docker-compose down && docker volume rm postgisjapan_db-data -f && docker-compose up --build
japan:
	$(PSQL_COMMAND) "\d japan"
count:
	$(PSQL_COMMAND) "select count(*) from japan;"
ogaki:
	$(PSQL_COMMAND) "select pref, regional, city1, city2, GeometryType(geom) from japan where city2 = '大垣市';"



