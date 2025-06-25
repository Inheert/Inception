FROM debian:bullseye

# Installer PHP et les extensions nécessaires
RUN apt-get update && apt-get install -y && \
	apt-get install -y wget php7.4 php-fpm php-mysql && \
	mkdir -p /var/www/html && \
	chown -R www-data:www-data /var/www/html

# Créer le dossier pour Adminer
WORKDIR /var/www/html

# Script d'entrée
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh

CMD ["/script.sh"]
