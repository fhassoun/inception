FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/initial_db.sql /var/www/

#RUN service mysql start && mysql < /var/www/initial_db.sql && rm -f /var/www/initial_db.sql;
#RUN service mysql start 

COPY tools/create_user.sh /
RUN chmod +x ./create_user.sh
RUN bash ./create_user.sh
RUN rm -rf create_user.sh

CMD ["mysqld_safe"]

# test if you can connect to maridb database
# sudo docker exec -it mariadb mariadb --user fhassoun -p1234
# SHOW DATABASES;
# USE wordpress;
# SHOW TABLES