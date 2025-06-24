#!/bin/bash

mkdir -p /run/php

if [ ! -f "$WP_PATH/index.php" ]; then
    echo "⬇️  Downloading wordpress $WP_PATH..."
    wp core download --path="$WP_PATH" --allow-root
fi

cd "$WP_PATH" || exit 1

until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PWD" -e "SELECT 1;" > /dev/null 2>&1; do
    echo "⏳ Waiting MariaDB on $DB_HOST..."
    sleep 2
done

if [ -f wp-config.php ]; then
    echo "✅ WordPress already configured."
else
    echo "⚙️ Configuration of WordPress..."

    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PWD" \
        --dbhost="$DB_HOST" \
        --path="$WP_PATH"

    wp config shuffle-salts --allow-root --path="$WP_PATH"

    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path="$WP_PATH"

    wp plugin update --allow-root --all --path="$WP_PATH"

    wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PWD" --role=author --porcelain \
        --path="$WP_PATH"
fi

php-fpm7.4 -F
