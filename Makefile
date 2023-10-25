DC := docker-compose -f ./srcs/docker-compose.yml

all:
	@sudo hostsed add 127.0.0.1 fhassoun.42.fr && echo "successfully added fhassoun.42.fr to /etc/hosts"
	@mkdir -p /home/data/wordpress
	@mkdir -p /home/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

clean:
	@sudo hostsed rm 127.0.0.1 fhassoun.42.fr && echo "successfully removed fhassoun.42.fr from /etc/hosts"
	@$(DC) down -v --remove-orphans     
	@docker rmi -f $$(docker images -q) 

.PHONY: all down re clean