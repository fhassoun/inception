#!bin/bash
cd /var/www/wordpress
if [ -f ./wp-config.php ]
then
	echo "Wordpress already downloaded"
else
	wp core download --allow-root
fi

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

# run php-fpm7.3 listening for CGI request
/usr/sbin/php-fpm7.3 -F
exec "$@"