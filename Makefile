reset-no-cache:
	docker system prune --volumes -f && docker-compose build --no-cache && docker-compose up
reset:
	docker system prune --volumes -f && docker-compose up --build
