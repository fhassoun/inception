FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

ARG MYSQL_HOSTNAME=${MYSQL_HOSTNAME}
ARG MYSQL_DATABASE=${MYSQL_DATABASE}
ARG MYSQL_USER=${MYSQL_USER}
ARG MYSQL_PASSWORD=${MYSQL_PASSWORD}
ARG MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ARG WP_DOMAIN=${WP_DOMAIN}
ARG WP_ADMIN_USERNAME=${WP_ADMIN_USERNAME}
ARG WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ARG WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}


EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY tools/create_user.sh /
RUN chmod +x ./create_user.sh
RUN bash ./create_user.sh
RUN rm -rf create_user.sh

CMD ["mysqld_safe"]

# test if you can connect to maridb database
# sudo docker exec -it mariadb mariadb --user fhassoun -proot1234
# SHOW DATABASES;
# USE wordpress;
# SHOW TABLES
