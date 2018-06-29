#!/bin/bash

echo "Installing pre-requisites"
sudo apt-get update -q
sudo apt-get install unzip -y -q
sudo apt-get install php-mbstring -y
sudo apt-get install apache2 -y
sudo apt-get install php-mysql -y
sudo service apache2 restart

echo "Creating Mantis database"
sudo mysql -u root -e "CREATE DATABASE mantis;"
sudo mysql -u root -e "CREATE USER 'mantis'@'localhost' IDENTIFIED BY 'm4nt1s';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON mantis.* to 'mantis'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

echo "Downloading Mantis"
wget -q -O mantisbt-${VER}.zip https://sourceforge.net/projects/mantisbt/files/mantis-stable/${VER}/mantisbt-${VER}.zip/download > /dev/null
unzip mantisbt-${VER}.zip > /dev/null
sudo mv ./mantisbt-${VER} /var/www/html/mantis/

ls /var/www/html

echo "Configuring Mantis"
curl --request POST "http://127.0.0.1/mantis/admin/install.php" -d "install=2&db_type=mysqli&hostname=127.0.0.1&db_username=mantis&db_password=m4nt1s&database_name=mantis&admin_username=&admin_password=&db_table_prefix=mantis&db_table_plugin_prefix=plugin&db_table_suffix=_table&timezone=UTC"

echo "<?php" > /var/www/html/mantis/config/config.php
echo '$g_hostname = '"'127.0.0.1';" >> /var/www/html/mantis/config/config.php
echo '$g_db_type = '"'mysqli';" >> /var/www/html/mantis/config/config.php
echo '$g_database_name = '"'mantis';" >> /var/www/html/mantis/config/config.php
echo '$g_db_username = '"'mantis';" >> /var/www/html/mantis/config/config.php
echo '$g_db_password = '"'m4ntis';" >> /var/www/html/mantis/config/config.php
echo '$g_default_timezone = '"'UTC';" >> /var/www/html/mantis/config/config.php
echo '$g_crypto_master_salt = '"'XYtly+fyYaWPnscCvj0PkCFPMuy5hii1VebD2oamyPw=';" >> /var/www/html/mantis/config/config.php

echo "Verifying install"
wget http://127.0.0.1/mantis > mantis_install_test.txt
cat mantis_install_test.txt

