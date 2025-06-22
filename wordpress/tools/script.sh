#!/bin/bash

cd /var/www/html

wp core download --allow-root
wp config create --allow-root \
            --dbname=$DB_NAME \
            --dbuser=$DB_USER \
            --dbpass=$DB_PWD \
            --dbhost=mariadb:3306 \
            --path='var/www/wordpress'

/usr/sbin/php-fpm7.3 -F
