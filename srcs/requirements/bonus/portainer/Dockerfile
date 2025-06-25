FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install -y curl ca-certificates

RUN mkdir -p /tmp /data /opt/portainer && chmod -R 777 /data /tmp

WORKDIR /opt/portainer

RUN curl -L https://github.com/portainer/portainer/releases/download/2.27.8/portainer-2.27.8-linux-amd64.tar.gz \
	-o portainer.tar.gz && tar zxvf portainer.tar.gz --strip-components=1 && \
	rm portainer.tar.gz && chmod +x portainer

RUN mkdir -p /etc/ssl/private /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout /etc/ssl/private/portainer.key \
      -out /etc/ssl/certs/portainer.crt \
      -subj "/C=FR/ST=IDF/L=Paris/O=Portainer/OU=Dev/CN=portainer.local"

COPY tools/script.sh /
RUN chmod +x /script.sh

EXPOSE 9443 9000

CMD [ "/script.sh" ]

