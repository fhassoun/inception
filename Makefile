DC := docker-compose -f ./srcs/docker-compose.yml

all:
	@sudo hostsed add 127.0.0.1 fhassoun.42.fr && echo "successfully added fhassoun.42.fr to /etc/hosts"
	@sudo mkdir -p /home/data/wordpress
	@sudo mkdir -p /home/data/mysql
	@sudo $(DC) up -d --build

down:
	@$(DC) down

re: clean all

clean:
	@sudo hostsed rm 127.0.0.1 fhassoun.42.fr && echo "successfully removed fhassoun.42.fr from /etc/hosts"
	@sudo $(DC) down -v --remove-orphans     
	@sudo docker rmi -f $$(docker images -q) 
	@sudo docker system prune -a

.PHONY: all down re clean