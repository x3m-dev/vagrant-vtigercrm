#!/bin/bash

sudo apt update

sudo apt install -y dirmngr --install-recommends
sudo apt install -y apt-transport-https lsb-release ca-certificates 
sudo apt install -y curl vim mc net-tools

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo debconf-set-selections <<< 'mysql-server-8.0 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-8.0 mysql-server/root_password_again password root'

sudo debconf-set-selections <<< 'mysql-community-server  mysql-community-server/re-root-pass password root'
sudo debconf-set-selections <<< 'mysql-community-server  mysql-community-server/root-pass password root'

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y mysql-server mysql-client apache2 php-mysql libapache2-mod-php php-xml php-curl php-gd php-imap php-mbstring

#echo "sql_mode = ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" | sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl enable mysql
#sudo systemctl restart mysql

sudo sed -i 's/display_errors.*=.*Off/display_errors = On/g' /etc/php/7.4/apache2/php.ini
sudo sed -i 's/log_errors.*=.*On/log_errors = Off/g' /etc/php/7.4/apache2/php.ini
sudo systemctl restart apache2

cd /tmp
wget https://jztkft.dl.sourceforge.net/project/vtigercrm/vtiger%20CRM%207.3.0/Core%20Product/vtigercrm7.3.0.tar.gz  &>/dev/null
tar xfz vtigercrm7.3.0.tar.gz
sudo mv vtigercrm /var/www/html
sudo chmod -R 777 /var/www/html/
