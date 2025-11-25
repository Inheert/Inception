#!/bin/bash

wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php
php8.2 -S 0.0.0.0:8080 -t /var/www/html
