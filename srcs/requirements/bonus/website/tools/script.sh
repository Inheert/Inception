#!/bin/bash

cp -r /tmp/www/ /var/
lighttpd -D -f /etc/lighttpd/lighttpd.conf
