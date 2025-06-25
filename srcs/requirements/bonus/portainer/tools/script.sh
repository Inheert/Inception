#!/bin/bash

/opt/portainer/portainer \
  --data /data \
  --bind 0.0.0.0:9443 \
  --http-disabled \
  --sslcert /etc/ssl/certs/portainer.crt \
  --sslkey /etc/ssl/private/portainer.key
