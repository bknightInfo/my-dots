#!/bin/bash

echo "[\e[1;35mWARNING\e[0m] - WORK IN PROGRESS"
echo "[\e[1;35mWARNING\e[0m] - USE AT YOUR OWN RISK"

sudo pacman -S nginx --noconfirm --needed
sudo pacman -S php --noconfirm --needed 
sudo pacman -S php-fpm --noconfirm --needed 
sudo pacman -S mariadb --noconfirm --needed
sudo pacman -S phpmyadmin --noconfirm --needed

sudo systemctl enable --now nginx
sudo systemctl enable --now mariadb

echo "removing /var/lib/mysql"
if [ -d /var/lib/mysql ]; then 
  sudo rm -rf /var/lib/mysql
  sudo mkdir /var/lib/mysql
fi
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

echo "enter, n, y, password, password, y, y, y, y"
sudo mysql_secure_installation

sudo cp nginx.conf /etc/nginx/nginx.conf

sudo sed -i 's/^;extension=mysqli/extension=mysqli/' /etc/php/php.ini 
sudo sed -i 's/^;extension=pdo_mysql/extension=pdo_mysql/' /etc/php/php.ini 
sudo sed -i 's/^;extension=iconv/extension=iconv/' /etc/php/php.ini 

sudo systemctl restart nginx 
sudo systemctl restart php-fpm

#php test page
echo "<?php
phpinfo()
?>" | sudo tee /usr/share/nginx/html/info.php

sudo ln -s /usr/share/webapps/phpMyAdmin/ /usr/share/nginx/html/

echo "[\e[1;32mDONE\e[0m] Lemp stack installed successfully"