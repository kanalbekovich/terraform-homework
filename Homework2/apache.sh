#!/bin/bash

apt-get update -y
apt-get install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "Hello, World!" > /var/www/html/index.html
