all:
	@if [ -d "/home/$USER/data" ]; then \
		echo "/home/$USER/data already exists"; else \
		mkdir /home/$USER/data; \
		echo "data directory created successfully"; \
	fi

	@if [ -d "/home/$USER/data/wordpress" ]; then \
		echo "/home/$USER/data/wordpress already exists"; else \
		mkdir /home/$USER/data/wordpress; \
		echo "wordpress directory created successfully"; \
	fi

	@if [ -d "/home/$USER/data/mariadb" ]; then \
		echo "/home/$USER/data/mariadb already exists"; else \
		mkdir /home/$USER/data/mariadb; \
		echo "mariadb directory created successfully"; \
	fi
	@sudo hostsed add 127.0.0.1 fhassoun.42.fr && echo "successfully added fhassoun.42.fr to /etc/hosts"
	sudo docker compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v
#	uncomment the following line to remove the images too
#	sudo docker system prune -a

fclean: clean
	@sudo hostsed rm 127.0.0.1 fhassoun.42.fr && echo "successfully removed fhassoun.42.fr from /etc/hosts"
	@if [ -d "/home/fhassoun/data/wordpress" ]; then \
	sudo rm -rf /home/fhassoun/data/wordpress/* && \
	echo "successfully removed all contents from /home/fhassoun/data/wordpress/"; \
	fi;

	@if [ -d "/home/fhassoun/data/mariadb" ]; then \
	sudo rm -rf /home/fhassoun/data/mariadb/* && \
	echo "successfully removed all contents from /home/fhassoun/data/mariadb/"; \
	fi;

re: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls