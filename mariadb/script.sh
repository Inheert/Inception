#!/bin/bash

service mariadb start

echo | mariadb
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD' ;" | mariadb
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" | mariadb
echo "FLUSH PRIVILEGES;" | mariadb

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
