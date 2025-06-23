#!/bin/bash

# Initialise les permissions et répertoires si absents
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialise la base de données si vide
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Démarre le serveur MariaDB en arrière-plan
mysqld_safe --user=mysql &
pid="$!"

# Attend que MariaDB soit prêt (socket accessible)
until mariadb -e "SELECT 1" &>/dev/null; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Crée utilisateur et base si définis
if [ -n "$DB_USER" ] && [ -n "$DB_PWD" ] && [ -n "$DB_NAME" ]; then
    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
    mariadb -e "FLUSH PRIVILEGES;"
fi

# Attend le processus MariaDB
wait "$pid"

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
