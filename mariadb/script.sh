#!/bin/bash

service mariadb start

echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" | mariadb
echo "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;" | mariadb
echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" | mariadb
echo "FLUSH PRIVILEGES;" | mariadb

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
