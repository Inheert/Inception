#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

mysqld_safe --user=mysql &
pid="$!"

until mariadb -e "SELECT 1" &>/dev/null; do
	echo "Waiting for MariaDB to be ready..."
	sleep 1
done

if [ -n "$DB_ROOT_PWD" ]; then
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';"
	mariadb -e "FLUSH PRIVILEGES;"
fi


if [ -n "$DB_USER" ] && [ -n "$DB_PWD" ] && [ -n "$DB_NAME" ]; then
	mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
	mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';"
	mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
	mariadb -e "FLUSH PRIVILEGES;"
fi

wait "$pid"

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
