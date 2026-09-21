#!/bin/bash
apt-get update -y
apt-get install -y nginx
rm -f /var/www/html/index.nginx-debian.html
echo "dato-servido-desde-la-maquina-privada-1152315-1152490" > /var/www/html/dato.txt
