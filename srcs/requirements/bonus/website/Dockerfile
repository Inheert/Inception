FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y lighttpd && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    mkdir -p /tmp/www/html && \
    chown -R www-data:www-data /tmp/www/html

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
# COPY site/ /tmp/www/
COPY tools/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
