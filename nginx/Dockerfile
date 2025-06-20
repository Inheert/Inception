FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx openssl curl vim

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /var/run/nginx

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tclaereb.42.fr/UID=tclaereb"

# COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 4443

CMD [ "nginx", "-g", "daemon off;" ]
