reset:
	docker system prune --volumes -f && docker-compose up --build