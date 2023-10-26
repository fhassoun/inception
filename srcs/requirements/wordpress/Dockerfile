FROM debian:buster

ARG WP_DOMAIN=${WP_DOMAIN}
ARG WP_ADMIN_USERNAME=${WP_ADMIN_USERNAME}
ARG WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ARG WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}

RUN apt-get update && apt-get -y install \
 wget \
 curl \
 bash \
 php \
 php-cgi \
 php-mysql \
 php-fpm \
 php-pdo \
 php-gd php-cli \
 php-mbstring \
 redis \
 php-redis \
 && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir /run/php

COPY ./tools/user_script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/user_script.sh

COPY ./tools/wp_script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp_script.sh
ENTRYPOINT ["/usr/local/bin/wp_script.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F" && "/usr/local/bin/user_script.sh"]