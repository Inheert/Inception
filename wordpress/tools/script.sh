#!/bin/bash

mkdir -p /run/php

# 📥 Téléchargement de WordPress s'il manque index.php
if [ ! -f "$WP_PATH/index.php" ]; then
    echo "⬇️  Téléchargement de WordPress dans $WP_PATH..."
    wp core download --path="$WP_PATH" --allow-root
fi

cd "$WP_PATH" || exit 1

# 🛑 Attendre que MariaDB soit dispo
until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PWD" -e "SELECT 1;" > /dev/null 2>&1; do
    echo "⏳ Waiting MariaDB on $DB_HOST..."
    sleep 2
done

# ⚙️ Configuration de WordPress
if [ -f wp-config.php ]; then
    echo "✅ WordPress already configured."
else
    echo "⚙️ Configuration of WordPress..."

    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PWD" \
        --dbhost="mariadb:3306" \
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

# 🚀 Lancer PHP-FPM
php-fpm7.4 -F
