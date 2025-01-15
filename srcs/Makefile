all:
	mkdir -p /home/pitt/data
	mkdir -p /home/pitt/data/mariadb
	mkdir -p /home/pitt/data/wordpress
	@docker compose -f docker-compose.yml up --build -d

down:
	@docker compose -f docker-compose.yml down
	@docker system prune -a -f
	@docker volume prune -f
	@docker network prune -f
	@docker volume rm srcs_mariadb
	@docker volume rm srcs_wordpress

delete:
	@sudo rm -rf /home/pitt/data/mariadb/*
	@sudo rm -rf /home/pitt/data/wordpress/*

stop:
	@docker compose -f docker-compose.yml stop

status:
	@echo "\nDOCKER STATUS:\n"
	# list all containers:
	docker ps
	@echo "\n"
	# list all the containers available locally:
	docker ps -a
	@echo "\n"
	# list images:
	docker images
	@echo "\n"
	# list all volumes:
	docker volume ls
	@echo "\n"
	# list all networks:
	docker network ls