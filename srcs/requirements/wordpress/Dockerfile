FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install wget -y

RUN apt-get install -y php8.2 php-fpm php-mysql mariadb-client

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /usr/local/bin/wp
RUN mkdir -p /var/www/html
RUN chown -R root:root /var/www/html

COPY tools/script.sh /
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN chmod +x /script.sh

EXPOSE 9000

CMD [ "/script.sh" ]

