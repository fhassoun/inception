#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "Wordpress already downloaded"
else
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	# mv wordpress/* .
	rm -rf latest.tar.gz
	# rm -rf wordpress

	# sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	# sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	# sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	# sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	# cp /wordpress/wp-config-sample.php wordpress/wp-config.php


fi
cd /var/www/wordpress

wp core config	--dbhost=$MYSQL_HOSTNAME \
				--dbname=$MYSQL_DATABASE \
				--dbuser=$MYSQL_USER \
				--dbpass=$MYSQL_PASSWORD \
				--allow-root

wp core install --title=$WP_TITLE \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_EMAIL \
				--url=$WP_URL \
				--allow-root

wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
cd -
/usr/sbin/php-fpm7.3 -F
exec "$@"